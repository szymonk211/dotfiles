import shelve
import subprocess
import time

from argparse import ArgumentParser

MAX_SHORT_SWITCH_SECONDS = 2


def wins_indices_with_class(class_name):
    wmctl_out = subprocess.check_output("wmctrl -x -l".split()).decode("utf-8")
    lines = wmctl_out.splitlines()
    ids = []
    for line in lines:
        splitted = line.split()
        id_, class_ = splitted[0], splitted[2]
        if class_name.lower() in class_.lower():
            ids.append(id_)
    return ids


def current_active_window_id():
    return subprocess.check_output(
        "xprop -root | grep '^_NET_ACTIVE_W' | awk -F'# 0x' '{print $2}'",
        shell=True).decode("utf-8").strip()


def switch_to_window_with_id(win_id):
    subprocess.check_call(f"wmctrl -i -a {win_id}".split())


class PrevWindows:
    def __init__(self, db_path="/tmp/xbinddb.json"):
        self.db = shelve.open(db_path)

    def save(self, class_name, win_id):
        try:
            prev_win_id, prev_time = self.db[class_name]
            if prev_win_id != win_id:
                self.db[f"__prev__{class_name}"] = prev_win_id, prev_time
        except KeyError:
            pass
        self.db[class_name] = win_id, time.time()

    def load(self, class_name):
        return self.db[class_name]

    def load_prev(self, class_name):
        return self.db[f"__prev__{class_name}"]

    def close(self):
        self.db.sync()
        self.db.close()


if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument("class_name")
    parser.add_argument(
        "--autostart",
        help="jezeli sie nie uda przelaczyc to uruchomic program o podanej nazwie")
    args = parser.parse_args()
    class_name_ = args.class_name
    autostart_prog = args.autostart
    win_ids = wins_indices_with_class(class_name_)
    curr_id = current_active_window_id()
    el_idx = next(
        (idx for idx, name in enumerate(win_ids) if name.endswith(curr_id)), -1)
    if win_ids:
        db = PrevWindows()
        print(dict(db.db.items()))
        try:
            next_win_without_db = win_ids[(el_idx + 1) % len(win_ids)]
            try:
                next_win, prev_switch_time = db.load(class_name_)
                if next_win.endswith(curr_id):
                    raise KeyError
                    # next_win, prev_switch_time = db.load_prev(class_name_)
                    # if time.time() < prev_switch_time + MAX_SHORT_SWITCH_SECONDS:
                    #     raise KeyError
                if all(not id_.endswith(next_win) for id_ in win_ids):
                    raise KeyError
            except KeyError:
                next_win = next_win_without_db
            print(f"next_win: {next_win}")
            switch_to_window_with_id(next_win)
            db.save(class_name_, next_win)
        finally:
            db.close()
    elif autostart_prog is not None:
        subprocess.check_call(f"{autostart_prog} &", shell=True)
    print(win_ids)
    print(current_active_window_id())
    print(el_idx)

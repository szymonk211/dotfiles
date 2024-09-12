# dotfiles

https://germano.dev/dotfiles/

#### na nowej maszynie:

```
sudo apt install vcsh
vcsh clone https://github.com/szymonk211/dotfiles.git base
```
#### po aktualizacji jakichś plików dot na maszynie:
```
vcsh base add .ideavimrc
vcsh base add .ideavimrc
vcsh commit
vcsh push
```

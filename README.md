## hello! these are my dots

(this readme is straight stolen from alphatechnolog lol)

also if you like this shit, gimme a star please

![showcase](/showcase.png)
![showcase](/showcase.mp4)

## some info
- os: endeavouros/arch (endeavouros installed as arch lol)
- wm: bspwm
- terminal: suckless st 
- shell: zsh
- nvim config: nvchad
- compositor: picom
- app launcher: rofi
- bar: polybar

## setup
# clone the repo
```bash
git clone https://github.com/radstevee/dotfiles.git -b bspwm
cd dotfiles
```

or using the github cli

```bash
gh repo clone radstevee/dotfiles -b bspwm
cd dotfiles
``` 

# stuff you need (aka requirements)
- jetbrains mono font
- jetbrains mono nerd font
- arian8j2's picom fork
- bspwm
- sxhkd
- nitrogen (you can also use feh tho)
- rofi
- polybar
- bat 
- exa
- dunst
- starship
- zsh
- btop (optional)
- cava (optional)

install them via your package manager/aur, or compile them yourself

# copy the configs
```bash
cp -r cfg/* ~/.config/
cp -r bin/* ~/.local/bin/
cp -r home/* ~/
```

# compile st 
```bash
cd ~/.config/st 
sudo make clean install
``` 

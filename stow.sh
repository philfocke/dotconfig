#!/usr/bin/env bash


# Shared Files
cd ~/dotconfig/ || exit 1
echo "Installing shared Config"
for i in $(ls shared); do
    echo "Symlinking $i"
    stow -d shared -t ~ $i || echo "Fehler beim Symlinken von $i"
done

echo "Checking for System..."



if test "$(echo $OSTYPE)" == "$(echo linux-gnu)"; then
	echo "Linux-System gefunden"
	for i in $(ls linux); do
		echo "Symlinking $i"
    		stow -d linux -t ~ $i || echo "Fehler beim Symlinken von $i"
done

else
	echo "Mac gefunden"
	for i in $(ls mac); do
		echo "Symlinking $i"
    		stow -d mac -t ~ $i || echo "Fehler beim Symlinken von $i"
	done

fi

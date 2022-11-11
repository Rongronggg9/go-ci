package main

import (
	"log"
	"syscall"
)

func main() {
	curUid := syscall.Getuid()
	log.Printf("Current UID: %d", curUid)
	log.Printf("Setting UID to %d", curUid)
	setuidErr := syscall.Setuid(curUid)
	if setuidErr != nil {
		log.Fatalln(setuidErr)
	}
	log.Printf("New UID: %d", syscall.Getuid())
}

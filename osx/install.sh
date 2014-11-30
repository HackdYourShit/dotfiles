#!/bin/sh
source $HOME/.dotfiles/log.sh

# -- Mac OS X ------------------------------------------------------------------

#!/bin/sh

# Alot of these configs have been taken from the various places
# on the web, most from here
# https://github.com/mathiasbynens/dotfiles/blob/master/.osx




#  Reset text attributes to normal + without clearing screen.
alias Reset="tput sgr0"


# Here we go.. ask for the administrator password upfront and run a
# keep-alive to update existing `sudo` time stamp until script has finished
sudo -v


###############################################################################
# General UI/UX
###############################################################################


msg_run "Set your computer name (as done via System Preferences >> Sharing)"

sudo scutil --set ComputerName "Vinicius Souza"
sudo scutil --set HostName "Vinicius Souza"
sudo scutil --set LocalHostName "Vinicius Souza"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName  "Vinicius Souza"

msg_run "Hide the Spotlight icon"
sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search


msg_run "Increasing the window resize speed for Cocoa applications"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001


msg_run "Expanding the save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true


msg_run "Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

msg_run "Displaying ASCII control characters using caret notation in standard text views"
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

msg_run "Save to disk, rather than iCloud, by default)"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

msg_run "Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

msg_run "Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

msg_run "Removing duplicates in the 'Open With' menu"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user


msg_run "Disable smart quotes and smart dashes)"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

msg_run "Add ability to toggle between Light and Dark mode in Yosemite using ctrl+opt+cmd+t)"
# http://www.reddit.com/r/apple/comments/2jr6s2/1010_i_found_a_way_to_dynamically_switch_between/
sudo defaults write /Library/Preferences/.GlobalPreferences.plist _HIEnableThemeSwitchHotKey -bool true


###############################################################################
# General Power and Performance modifications
###############################################################################


msg_run "Disable hibernation? (speeds up entering sleep mode) (y/n)"
sudo pmset -a hibernatemode 0


msg_run "Remove the sleep image file to save disk space)"
msg_run "(If you're on a <128GB SSD, this helps but can have adverse affects on performance. You've been warned.)"
sudo rm /Private/var/vm/sleepimage
msg_run "Creating a zero-byte file instead"
sudo touch /Private/var/vm/sleepimage
msg_run "and make sure it can't be rewritten"
sudo chflags uchg /Private/var/vm/sleepimage

msg_run "Disable the menubar transparency)"
defaults write com.apple.universalaccess reduceTransparency -bool true


msg_run "Speeding up wake from sleep to 24 hours from an hour"
# http://www.cultofmac.com/221392/quick-hack-speeds-up-retina-macbooks-wake-from-sleep-os-x-tips/
sudo pmset -a standbydelay 86400


################################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
###############################################################################


msg_run "Increasing sound quality for Bluetooth headphones/headsets"
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40


msg_run "Enabling full keyboard access for all controls (enable Tab in modal dialogs, menu windows, etc.)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3


msg_run "Disabling press-and-hold for special keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false


msg_run "Setting a blazingly fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 0


msg_run "Disable auto-correct)"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

msg_run "Setting trackpad & mouse speed to a reasonable number"
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 2.5

msg_run "Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -int 300


msg_run "Disable display from automatically adjusting brightness)"
sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Display Enabled" -bool false

msg_run "Disable keyboard from automatically adjusting backlight brightness in low light)"
sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Keyboard Enabled" -bool false

###############################################################################
# Screen
###############################################################################

msg_run "Requiring password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0


msg_run "Where do you want screenshots to be stored? (hit ENTER if you want ~/Desktop as default)"
# Thanks https://github.com/omgmog
if [ ! -d "${HOME}/Pictures/screenshots" ]; then
	mkdir ${HOME}/Pictures/screenshots
fi
screenshot_location="${HOME}/Pictures/screenshots"
defaults write com.apple.screencapture location -string "${screenshot_location}"


msg_run "What format should screenshots be saved as? (hit ENTER for PNG, options: BMP, GIF, JPG, PDF, TIFF) "
defaults write com.apple.screencapture type -string "png"

msg_run "Enabling subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

msg_run "Enabling HiDPI display modes (requires restart)"
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

###############################################################################
# Finder
###############################################################################


msg_run "Show icons for hard drives, servers, and removable media on the desktop)"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true


msg_run "Show hidden files in Finder by default)"
defaults write com.apple.Finder AppleShowAllFiles -bool true


msg_run "Show dotfiles in Finder by default)"
defaults write com.apple.finder AppleShowAllFiles TRUE


msg_run "Show all filename extensions in Finder by default)"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

msg_run "Show status bar in Finder by default)"
defaults write com.apple.finder ShowStatusBar -bool true

msg_run "Display full POSIX path as Finder window title)"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

msg_run "Use column view in all Finder windows by default)"
defaults write com.apple.finder FXPreferredViewStyle Clmv


msg_run "Avoid creation of .DS_Store files on network volumes)"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

msg_run "Disable disk image verification)"
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true


msg_run "Allowing text selection in Quick Look/Preview in Finder by default"
defaults write com.apple.finder QLEnableTextSelection -bool true

msg_run "Enabling snap-to-grid for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist


###############################################################################
# Dock & Mission Control
###############################################################################

msg_run "Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 36

msg_run "Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

msg_run "Set Dock to auto-hide and remove the auto-hiding delay)"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

###############################################################################
# Chrome, Safari, & WebKit
###############################################################################

msg_run "Privacy: Donâ€™t send search queries to Apple"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true


msg_run "Hiding Safari's bookmarks bar by default"
defaults write com.apple.Safari ShowFavoritesBar -bool false


msg_run "Hiding Safari's sidebar in Top Sites"
defaults write com.apple.Safari ShowSidebarInTopSites -bool false


msg_run "Disabling Safari's thumbnail cache for History and Top Sites"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2


msg_run "Enabling Safari's debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true


msg_run "Making Safari's search banners default to Contains instead of Starts With"
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false


msg_run "Removing useless icons from Safari's bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"


msg_run "Enabling the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true


msg_run "Adding a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true


msg_run "Disabling the annoying backswipe in Chrome"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false


msg_run "Using the system-native print preview dialog in Chrome"
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome.canary DisablePrintPreview -bool true


###############################################################################
# Mail
###############################################################################


msg_run "Setting email addresses to copy as 'foo@example.com' instead of 'Foo Bar <foo@example.com>' in Mail.app"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false


###############################################################################
# Terminal
###############################################################################


msg_run "Enabling UTF-8 ONLY in Terminal.app and setting the Pro theme by default"
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"


###############################################################################
# Time Machine
###############################################################################


msg_run "Prevent Time Machine from prompting to use new hard drives as backup volume)"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true


msg_run "Disable local Time Machine backups? (This can take up a ton of SSD space on <128GB SSDs) (y/n)"
hash tmutil &> /dev/null && sudo tmutil disablelocal


###############################################################################
# Messages                                                                    #
###############################################################################



msg_run "Disable smart quotes in Messages.app? (it's annoying for messages that contain code) (y/n)"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false


msg_run "Disable continuous spell checking in Messages.app)"
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false


###############################################################################
# Transmission.app                                                            #
###############################################################################



msg_run "Do you use Transmission for torrenting)"

msg_run "Use `~/Downloads/Incomplete` to store incomplete downloads"
defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true
if [ ! -d "${HOME}/Downloads/Incomplete" ]; then
	mkdir ${HOME}/Downloads/Incomplete
fi
defaults write org.m0k.transmission IncompleteDownloadFolder -string "${HOME}/Downloads/Incomplete"


msg_run "Don't prompt for confirmation before downloading"
defaults write org.m0k.transmission DownloadAsk -bool false


msg_run "Hide the legal disclaimer"
defaults write org.m0k.transmission WarningLegal -bool false

###############################################################################
# Kill affected applications
############################"Terminal" "Transmission"; do
killall "${app}" > /dev/null 2>&1
msg_ok "osx"

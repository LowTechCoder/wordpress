DEV=$(echo "$1" | sed 's#/$##g') # remove last slash
LIVE=$(echo "$2" | sed 's#/$##g') # remove last slash
PLUGINS=wp-content/plugins
THEMES=wp-content/themes
WP_LIST=wp.txt
PLUGINS_LIST=wp_plugins.txt
THEMES_LIST=wp_themes.txt
echo "BACKUP YOUR LIVE AND DEV SITE FIRST!"
echo "Press ENTER to proceed..."
read
echo "Press ENTER to view top level WP DEV files that will later be copied to live."
echo "This list should exclude any file name that contains 'wp-config' and exclude the directory 'wp-content'..."
read
find "$DEV" -maxdepth 1 | grep 'wp-' | grep -v 'wp-config' | grep -v 'wp-content' > $WP_LIST
find "$DEV/$PLUGINS/" -maxdepth 1 | grep -v '.zip' | tail -n +2 > $PLUGINS_LIST #find plugins, only first level of files, remove zip files, remove first line which is plugins directory path (we only want what's inside plugins).
find "$DEV/$THEMES/" -maxdepth 1  | grep -v '.zip' | grep -v 'index.php' | grep -v 'twenty' | tail -n +2 > $THEMES_LIST
cat $WP_LIST
echo
echo "Press ENTER to view DEV Plugins list that will later be copied to LIVE."
echo "This list should exclude the top level 'plugins' directory..."
read
cat $PLUGINS_LIST
echo
echo "Press ENTER to view DEV Themes list that will later be copied to LIVE."
echo "This list should exclude wordpress default themes..."
read
cat $THEMES_LIST
echo
echo "Press ENTER to View contents of the LIVE site..."
read
echo "path: $LIVE"
ls "$LIVE"
echo
echo "Press Enter to view contents of the LIVE plugins..."
read
echo "path: $LIVE/$PLUGINS"
ls "$LIVE/$PLUGINS"
echo
echo "Press Enter to view contents of the LIVE Themes..."
read
echo "path: $LIVE/$THEMES"
ls "$LIVE/$THEMES"

echo
echo "Press ENTER to copy WP files from DEV to LIVE..."
read

#copy files and dirs loop
while IFS="" read -r p || [ -n "$p" ]
do
   #echo "$p"
   #echo "$LIVE"
   #rsync --dry-run -rv "$p" "$LIVE/"
   rsync -r "$p" "$LIVE/"

done < $WP_LIST

echo
echo "Press ENTER to copy Plugin files from DEV to LIVE..."
read

#copy files and dirs loop
while IFS="" read -r p || [ -n "$p" ]
do
   #echo "$p"
   #echo "$LIVE"
   #rsync --dry-run -rv "$p" "$LIVE/"
   rsync -r "$p" "$LIVE/$PLUGINS/"

done < $PLUGINS_LIST

echo
echo "Press ENTER to copy Themes files from DEV to LIVE..."
read

#copy files and dirs loop
while IFS="" read -r p || [ -n "$p" ]
do
   #echo "$p"
   #echo "$LIVE"
   #rsync --dry-run -rv "$p" "$LIVE/"
   rsync -r "$p" "$LIVE/$THEMES/"

done < $THEMES_LIST

echo "Now to change permissions and user:group"
echo "I don't have time to test this, so I will echo it out and give instructions."
echo "not sure if I need to add 'sudo' yet"
echo "cd into public_html"
echo "do this"
echo "find . -type f -exec chmod 644 {} \;"
echo "find . -type d -exec chmod 755 {} \;"

echo "chown -R USER:GROUP."


echo "All Done!!"

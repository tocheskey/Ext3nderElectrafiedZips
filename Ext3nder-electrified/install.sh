echo "This install script is ONLY for Electra betas, I built this version of Ext3nder from Ext3nder-Installer, run on RC1.3, as postinst don't run correctly rn on Electra Betas, I am recompiling that so that you will have an updatable veriosn of Ext3nder"
chmod +x /Ext3nder-electrified/wget
chmod +x /Ext3nder-electrified/unzip
chmod +x /Ext3nder-electrified/zip
chmod +x /Ext3nder-electrified/unzipsfx
/Ext3nder-electrified/wget -O impactor.zip http://cache.saurik.com/impactor/win/Impactor_0.9.44.zip
mkdir /Ext3nder-electrified/impact
mv /Ext3nder-electrified/impactor.zip /Ext3nder-electrified/impact/
/Ext3nder-electrified/unzip /Ext3nder-electrified/impact/impactor.zip 
/Ext3nder-electrified/unzip /Ext3nder-electrified/impact/Impactor.dat 
/Ext3nder-electrified/unzip /Ext3nder-electrified/impact/extender.ipa 
mv /Ext3nder-electrified/impact/Payload/Extender.app /Ext3nder-electrified/Extender.app
rm /Ext3nder-electrified/Extender.app/Info.plist
rm /Ext3nder-electrified/Extender.app/Extender
mv /Ext3nder-electrified/Extender /Ext3nder-electrified/Extender.app/Extender
cp /Ext3nder-electrified/Info.plist /Ext3nder-electrified/Extender.app/
rm impactor.zip
rm -rf /Ext3nder-electrified/impact
mkdir -p /var/mobile/Documents/Ext3nder/
chown -R 501:501 /var/mobile/Documents/Ext3nder/
chmod -R 755 /var/mobile/Documents/Ext3nder/

ln -s /Ext3nder-electrified/Library/MobileSubstrate/DynamicLibraries/Ext3nder_SpringBoard.dylib /Ext3nder-electrified/Library/Switches/Ext3nderSwitch.bundle
chmod +x /Ext3nder-electrified/Library/MobileSubstrate/DynamicLibraries/*
cp /Ext3nder-electrified/Library/MobileSubstrate/DynamicLibraries/* /bootstrap/Library/SBInject/
echo "Copying Files to SBinject"
mkdir /Library/Switches/
cp -r /Ext3nder-electrified/Library/Switches/Ext3nderSwitch.bundle /Library/Switches/
echo "Copied Switches"
rm -rf /Ext3nder-electrified/Extender.app/PlugIns
cp -f -r /Ext3nder-electrified/var/Ext3nder-Installer/* /Ext3nder-electrified/Extender.app/
sed -i 's#/System/Library/Frameworks/Security\\.framework/Security#@executable_path/////////////////////////////Sys\\.dylib#g' /Ext3nder-electrified/Extender.app/Extender
sed -i 's#/usr/lib/libSystem\\.B\\.dylib#@executable_path/Sys\\.dylib#g' /Ext3nder-electrified/Extender.app/Extender
sed -i 's#ldid/ldid\\.cpp(498): _assert(stream\\.sputn(static_cast<const char \\*>(data) + to#=======\\*=======\\*=======CSSTASHEDAPPEXECUTABLESIGNATURE=======\\*=======\\*=======#g' /Ext3nder-electrified/Extender.app/Extender
echo "** Copying Cydia Extender To /Applications"
rm -rf /Applications/Ext3nder.app
chown -R 0:0 /Ext3nder-electrified/Extender.app
chmod -R 755 /Ext3nder-electrified/Extender.app
mv -f /Ext3nder-electrified/Extender.app /Applications/Extender.app
jtool --sign --ent p.ent --inplace /Applications/Extender.app/Extender
jtool --sign --ent p.ent --inplace /Applications/Extender.app/deceit.dylib
jtool --sign --ent p.ent --inplace /Applications/Extender.app/Extender.dylib
jtool --sign --ent p.ent --inplace /Applications/Extender.app/Sys.dylib
jtool --sign --ent en.plist --inplace /Applications/Extender.app/Extender
jtool --sign --ent en.plist --inplace /Applications/Extender.app/Extender.dylib
chmod +x /Applications/Extender.app/Extender
chmod +x /Applications/Extender.app/deceit.dylib
chmod +x /Applications/Extender.app/Extender.dylib
chmod +x /Applications/Extender.app/Sys.dylib
chmod +x /Applications/Extender.app/WebUpload.bundle/libWebServer.dylib
/bootstrap/usr/bin/uicache
/bootstrap/usr/bin/killall backboardd
echo "You should be good!"
echo "You may need to respring!"
exit



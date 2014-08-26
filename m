From: Felipe Balbi <balbi@ti.com>
Subject: possible bug with v3.17-rc1
Date: Tue, 26 Aug 2014 12:23:51 -0500
Message-ID: <20140826172351.GG13949@saruman.home>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z0mFw3+mXTC5ycVe"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48346 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbaHZRY2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Aug 2014 13:24:28 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--Z0mFw3+mXTC5ycVe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

first of all, yes, I will try v3.17-rc2 shortly ;-)

So this kicked in when I was doing a rather large upgrade on my board,
so many packages were unpacked, installed, setup, etc.

I wonder if anybody has faced similar issues with v3.17-rc1 ?

This is with an AM437x StarterKit btw. Logs below

ps: this just might have screwed my filesystem :-p

root@saruman:~# apt-get upgrade
Reading package lists... 0%Reading package lists... 100%Reading package lis=
ts... Done
Building dependency tree... 0%Building dependency tree... 0%Building depend=
ency tree... 50%Building dependency tree... 50%Building dependency tree... =
73%Building dependency tree      =20
Reading state information... 0%Reading state information... 0%Reading state=
 information... Done
Calculating upgrade... Done
The following packages were automatically installed and are no longer requi=
red:
  accountsservice aisleriot apache2-bin apg argyll bluez bogofilter
  bogofilter-bdb bogofilter-common cheese-common cracklib-runtime crda
  cups-pk-helper dnsmasq-base dnsutils empathy-common espeak-data
  evince-common evolution-common evolution-data-server
  evolution-data-server-common finger five-or-more folks-common four-in-a-r=
ow
  gcr gdebi-core gedit-common gir1.2-accountsservice-1.0
  gir1.2-clutter-gst-2.0 gir1.2-evince-3.0 gir1.2-gck-1 gir1.2-gcr-3
  gir1.2-gdata-0.0 gir1.2-gdesktopenums-3.0 gir1.2-gdm3 gir1.2-gkbd-3.0
  gir1.2-gmenu-3.0 gir1.2-gnomebluetooth-1.0 gir1.2-gnomekeyring-1.0
  gir1.2-goa-1.0 gir1.2-gst-plugins-base-1.0 gir1.2-gstreamer-0.10
  gir1.2-gtkclutter-1.0 gir1.2-gtksource-3.0 gir1.2-gtop-2.0
  gir1.2-gucharmap-2.90 gir1.2-ibus-1.0 gir1.2-javascriptcoregtk-3.0
  gir1.2-mutter-3.0 gir1.2-networkmanager-1.0 gir1.2-nmgtk-1.0
  gir1.2-notify-0.7 gir1.2-packagekitglib-1.0 gir1.2-polkit-1.0
  gir1.2-rest-0.7 gir1.2-secret-1 gir1.2-soup-2.4 gir1.2-telepathyglib-0.12
  gir1.2-telepathylogger-0.2 gir1.2-totem-plparser-1.0 gir1.2-tracker-1.0
  gir1.2-upowerglib-1.0 gir1.2-vte-2.90 gir1.2-webkit-3.0 gir1.2-wnck-3.0
  gir1.2-xkl-1.0 gir1.2-zeitgeist-2.0 gir1.2-zpj-0.0 gjs gkbd-capplet gksu
  gnuchess gnuchess-book grilo-plugins-0.2 gstreamer0.10-alsa
  gstreamer0.10-nice gstreamer0.10-pulseaudio gstreamer1.0-clutter
  gstreamer1.0-nice gtk2-engines-pixbuf gtk2-engines-xfce guile-2.0-libs
  hwdata iagno iputils-tracepath iw libabw-0.0-0 libaccountsservice0
  libapache2-mod-dnssd libapr1 libaprutil1 libaprutil1-dbd-sqlite3
  libaprutil1-ldap libart-2.0-2 libass4 libatkmm-1.6-1 libbonoboui2-common
  libboost-system1.55.0 libbrlapi0.6 libcairomm-1.0-1 libcamel-1.2-49
  libcdr-0.0-0 libchamplain-0.12-0 libchamplain-gtk-0.12-0 libcheese-gtk23
  libcheese7 libclutter-gst-2.0-0 libclutter-gtk-1.0-0 libcolord-gtk1
  libcrack2 libdee-1.0-4 libdmapsharing-3.0-2 libdotconf0 libe-book-0.0-0
  libebackend-1.2-7 libebook-1.2-14 libebook-contacts-1.2-0 libecal-1.2-16
  libedata-book-1.2-20 libedata-cal-1.2-23 libedataserver-1.2-18 libedit2
  libespeak1 libetonyek-0.0-0 libevdocument3-4 libevview3-3 libexempi3
  libexo-common libexo-helpers libfarstream-0.1-0 libfarstream-0.2-2
  libfftw3-3 libfolks-eds25 libfolks-telepathy25 libfolks25 libfreehand-0.0=
-0
  libgail-3-0 libgarcon-1-0 libgarcon-common libgc1c2 libgck-1-0
  libgcr-3-common libgcr-base-3-1 libgcr-ui-3-1 libgdata-common libgdata19
  libgdict-1.0-6 libgdict-common libgdm1 libgeoclue0 libgeocode-glib0 libgj=
s0c
  libgksu2-0 libglade2-0 libglibmm-2.4-1c2a libgnome-bluetooth11
  libgnome-keyring-common libgnome-keyring0 libgnome-media-profiles-3.0-0
  libgnome-menu-3-0 libgnomecanvas2-0 libgnomecanvas2-common
  libgnomekbd-common libgnomekbd8 libgnomeui-common libgoa-backend-1.0-1
  libgpod-common libgpod4 libgrilo-0.2-1 libgsf-1-114 libgsf-1-common
  libgsl0ldbl libgtkmm-2.4-1c2a libgtkmm-3.0-1 libgtksourceview-3.0-1
  libgtksourceview-3.0-common libgtkspell3-3-0 libgtop2-7 libgtop2-common
  libgupnp-igd-1.0-4 libgweather-3-6 libgweather-common libgxps2 libibus-1.=
0-5
  libical1 libicc2 libidl0 libimdi0 libiptcdata0 libjpeg-progs libkeybinder0
  libkpathsea6 liblinear1 liblouis-data liblouis2 liblua5.1-0 libmagick++5
  libmeanwhile1 libmediaart-1.0-0 libmetacity-private0a libminiupnpc8
  libmission-control-plugins0 libmozjs185-1.0 libmspub-0.0-0 libmutter0b
  libmwaw-0.2-2 libnetfilter-conntrack3 libnice10 libnl-route-3-200
  libnm-glib-vpn1 libnm-gtk-common libnm-gtk0 libnotify-bin liboauth0
  libodfgen-0.0-0 libopts25 liborbit2 liborcus-0.6-0 libpackagekit-glib2-16
  libpam-gnome-keyring libpangomm-1.4-1 libpeas-common libperl5.18 libplot2=
c2
  libpst4 libpstoedit0c2a libpulse-mainloop-glib0 libpurple-bin libpurple0
  libpwquality-common libpwquality1 libreoffice-avmedia-backend-gstreamer
  libreoffice-base-core libreoffice-calc libreoffice-draw libreoffice-impre=
ss
  libreoffice-java-common libreoffice-math libreoffice-writer
  librest-extras-0.7-0 librtmp0 libsgutils2-2 libsocialweb-client2
  libsocialweb-common libsocialweb-service libsocialweb0 libsonic0 libspect=
re1
  libspeechd2 libtelepathy-farstream3 libtelepathy-logger3
  libtracker-control-1.0-0 libtracker-miner-1.0-0 libtracker-sparql-1.0-0
  libunique-1.0-0 libupower-glib1 libvisio-0.0-0 libwacom-common libwacom2
  libwnck-3-0 libwnck-3-common libwnck-common libwnck22 libwpd-0.9-9
  libwpg-0.2-2 libwps-0.2-2 libxfce4util-bin libxfce4util-common libxfce4ut=
il6
  libxfconf-0-2 libxres1 libytnef0 libzapojit-0.0-0 libzeitgeist-2.0-0
  libzephyr4 lightsoff lp-solve lsb-release media-player-info metacity-comm=
on
  mobile-broadband-provider-info mousetweaks mutter-common ndiff
  network-manager nmap ntp obexd-client openssh-client p11-kit p11-kit-modu=
les
  packagekit packagekit-backend-aptcc packagekit-tools perlmagick pidgin-da=
ta
  pstoedit python-apt-common python-cups python-cupshelpers python-gconf
  python-libxml2 python-lxml python-notify python-pycurl python-pyorbit
  python-smbc python-wnck python-xdg python-zeitgeist python3-apt
  python3-brlapi python3-cairo python3-chardet python3-dbus python3-debian
  python3-gi python3-gi-cairo python3-louis python3-mako python3-markupsafe
  python3-packagekit python3-pkg-resources python3-pyatspi python3-six
  python3-speechd python3-xdg quadrapassel realmd rhythmbox-data
  samba-dsdb-modules sound-theme-freedesktop speech-dispatcher
  speech-dispatcher-audio-plugins swell-foop system-config-printer-udev tali
  telepathy-gabble telepathy-haze telepathy-logger telepathy-mission-contro=
l-5
  telepathy-salut thunar-data totem-common tracker tracker-extract
  tracker-miner-fs tracker-utils unoconv upower wireless-regdb wpasupplicant
  x11-session-utils xbrlapi xfconf xfdesktop4-data xscreensaver
  xscreensaver-data xulrunner-29 zeitgeist zeitgeist-core zeitgeist-datahub
  zenity zenity-common
Use 'apt-get autoremove' to remove them.
The following packages have been kept back:
  gir1.2-gnomebluetooth-1.0 gir1.2-mutter-3.0 gir1.2-tracker-1.0
  gir1.2-upowerglib-1.0 gjs gnustep-base-runtime gstreamer1.0-plugins-bad
  gstreamer1.0-plugins-bad-dbg i3lock libalgorithm-diff-xs-perl
  libanyevent-perl libasync-interrupt-perl libcairo-perl libcommon-sense-pe=
rl
  libdbus2.0-cil libegl1-mesa libegl1-mesa-drivers libev-perl
  libfile-fcntllock-perl libgl1-mesa-dri libgl1-mesa-glx libglapi-mesa
  libgles2-mesa libglib-perl libgstreamer-plugins-bad1.0-0 libgtk2-perl
  libguard-perl libhtml-parser-perl libjson-xs-perl liblocale-gettext-perl
  libmm-glib0 libmono-cairo4.0-cil libmono-corlib4.0-cil libmono-corlib4.5-=
cil
  libmono-i18n-west4.0-cil libmono-i18n4.0-cil libmono-posix4.0-cil
  libmono-security4.0-cil libmono-sharpzip4.84-cil
  libmono-system-configuration4.0-cil libmono-system-core4.0-cil
  libmono-system-drawing4.0-cil libmono-system-security4.0-cil
  libmono-system-xml4.0-cil libmono-system4.0-cil libnet-dbus-perl
  libnet-ssleay-perl libpango-perl libpoppler-glib8 libpurple0
  libreoffice-base-core libreoffice-calc libreoffice-common libreoffice-core
  libreoffice-draw libreoffice-gnome libreoffice-gtk libreoffice-impress
  libreoffice-math libreoffice-style-galaxy libreoffice-style-tango
  libreoffice-writer libtext-charwidth-perl libtext-iconv-perl libtool
  libtracker-control-1.0-0 libtracker-miner-1.0-0 libtracker-sparql-1.0-0
  libwayland-egl1-mesa libxml-parser-perl metacity-common modemmanager
  mono-4.0-gac mono-gac mono-runtime mutter-common network-manager parted p=
erl
  perl-base perl-modules perlmagick python-pyatspi python3-pyatspi python3-=
uno
  rsyslog sysvinit tracker tracker-extract tracker-miner-fs tracker-utils u=
nar
  uno-libs3 upower ure usb-modeswitch xserver-xephyr xserver-xorg-core
  xserver-xorg-input-evdev xserver-xorg-input-synaptics
  xserver-xorg-input-wacom xserver-xorg-video-fbdev
The following packages will be upgraded:
  accountsservice alsa-utils anacron apache2-bin apt apt-utils aspell
  at-spi2-core autoconf autopoint base-files bash binfmt-support binutils
  bluez build-essential bzip2 cheese-common cpp cpp-4.8 cpp-4.9 crda cron c=
url
  dbus dbus-x11 debhelper dictionaries-common dmsetup dosfstools dpkg dpkg-=
dev
  dunst e2fslibs e2fsprogs empathy-common enchant espeak-data evolution-com=
mon
  evolution-data-server evolution-data-server-common fakeroot findutils
  five-or-more folks-common fontconfig fontconfig-config fonts-droid
  fonts-opensymbol four-in-a-row freerdp-x11 fuse g++ g++-4.9 gcc gcc-4.7-b=
ase
  gcc-4.8 gcc-4.8-base gcc-4.9 gcc-4.9-base gdisk geoip-database gettext
  gettext-base ghostscript gimp gimp-data gir1.2-accountsservice-1.0
  gir1.2-atspi-2.0 gir1.2-clutter-1.0 gir1.2-clutter-gst-2.0 gir1.2-cogl-1.0
  gir1.2-coglpango-1.0 gir1.2-gdata-0.0 gir1.2-gdesktopenums-3.0 gir1.2-gdm3
  gir1.2-gmenu-3.0 gir1.2-goa-1.0 gir1.2-gst-plugins-base-1.0
  gir1.2-gstreamer-0.10 gir1.2-gstreamer-1.0 gir1.2-gtk-3.0 gir1.2-ibus-1.0
  gir1.2-javascriptcoregtk-3.0 gir1.2-json-1.0 gir1.2-networkmanager-1.0
  gir1.2-nmgtk-1.0 gir1.2-pango-1.0 gir1.2-polkit-1.0 gir1.2-vte-2.90
  gir1.2-webkit-3.0 gir1.2-wnck-3.0 gir1.2-zeitgeist-2.0 glib-networking
  glib-networking-common glib-networking-services gnuchess gnupg gnupg-agent
  gnupg2 gnustep-base-common gnustep-common gpgv grep groff-base
  gsettings-desktop-schemas gstreamer-tools gstreamer0.10-plugins-bad
  gstreamer0.10-tools gstreamer1.0-alsa gstreamer1.0-clutter gstreamer1.0-d=
oc
  gstreamer1.0-libav gstreamer1.0-plugins-bad-doc gstreamer1.0-plugins-base
  gstreamer1.0-plugins-base-apps gstreamer1.0-plugins-base-dbg
  gstreamer1.0-plugins-base-doc gstreamer1.0-plugins-good
  gstreamer1.0-plugins-good-dbg gstreamer1.0-plugins-ugly
  gstreamer1.0-plugins-ugly-dbg gstreamer1.0-plugins-ugly-doc
  gstreamer1.0-pulseaudio gstreamer1.0-tools gstreamer1.0-x
  gtk2-engines-pixbuf hwdata iagno icedtea-7-jre-jamvm iceweasel imagemagick
  imagemagick-common init-system-helpers initscripts iperf iproute iproute2
  iputils-ping iputils-tracepath isc-dhcp-client isc-dhcp-common iso-codes
  keyboard-configuration kmod krb5-locales libaa1 libaacs0 libaccountsservi=
ce0
  libaprutil1 libaprutil1-dbd-sqlite3 libaprutil1-ldap libapt-inst1.5
  libapt-pkg4.12 libarchive13 libasan0 libasan1 libasn1-8-heimdal libasound2
  libasound2-data libasound2-plugins libaspell15 libasprintf-dev
  libasprintf0c2 libassuan0 libatk-adaptor libatk-bridge2.0-0 libatomic1
  libatspi2.0-0 libavcodec55 libavformat55 libavresample1 libavutil53
  libbabl-0.1-0 libbluetooth3 libbluray1 libbsd0 libbz2-1.0 libc-bin
  libc-dev-bin libc6 libc6-dev libcairo-gobject2 libcairo2 libcamel-1.2-49
  libcap-ng0 libcap2 libcap2-bin libcddb2 libchamplain-0.12-0
  libchamplain-gtk-0.12-0 libcheese-gtk23 libcheese7 libclutter-1.0-0
  libclutter-1.0-common libclutter-gst-2.0-0 libcogl-common libcogl-pango20
  libcogl-path20 libcogl20 libcomerr2 libcroco3 libcryptsetup4 libcups2
  libcupsfilters1 libcupsimage2 libcurl3 libcurl3-gnutls libdb5.3 libdbus-1=
-3
  libdc1394-22 libdca0 libdevmapper1.02.1 libdirac-decoder0 libdirac-encode=
r0
  libdiscid0 libdpkg-perl libdrm-nouveau2 libdrm-radeon1 libdrm2 libdvdnav4
  libdvdread4 libebackend-1.2-7 libebook-1.2-14 libebook-contacts-1.2-0
  libecal-1.2-16 libedata-book-1.2-20 libedata-cal-1.2-23
  libedataserver-1.2-18 libedit2 libee0 libenchant1c2a libeot0 libespeak1
  libestools2.1 libestr0 libevent-2.0-5 libexempi3 libexif12 libexiv2-12
  libexttextcat-2.0-0 libexttextcat-data libfakeroot libflite1 libfolks-eds=
25
  libfolks-telepathy25 libfolks25 libfontconfig1 libfreerdp-plugins-standard
  libfreerdp1 libfreetype6 libfuse2 libgail-3-0 libgail-common libgail18
  libgbm1 libgc1c2 libgcc-4.8-dev libgcc-4.9-dev libgcc1 libgcrypt11
  libgcrypt20 libgd3 libgdata-common libgdata19 libgdbm3 libgdm1 libgee-0.8=
-2
  libgegl-0.2-0 libgeoip1 libgettextpo-dev libgettextpo0 libgfortran3
  libgimp2.0 libglib2.0-0 libglib2.0-bin libglib2.0-data libglib2.0-dev
  libglib2.0-doc libgmp10 libgnome-menu-3-0 libgnutls-deb0-28
  libgnutls-openssl27 libgnutls26 libgoa-1.0-0b libgoa-1.0-common
  libgoa-backend-1.0-1 libgomp1 libgpg-error0 libgpgme11 libgphoto2-6
  libgphoto2-l10n libgphoto2-port10 libgs9 libgs9-common libgsl0ldbl
  libgssapi-krb5-2 libgssapi3-heimdal libgssdp-1.0-3
  libgstreamer-plugins-bad0.10-0 libgstreamer-plugins-base1.0-0
  libgstreamer0.10-0 libgstreamer1.0-0 libgstreamer1.0-dev libgtk-3-0
  libgtk-3-bin libgtk-3-common libgtk2.0-0 libgtk2.0-bin libgtk2.0-common
  libgtkglext1 libgtkspell3-3-0 libgudev-1.0-0 libgupnp-1.0-4
  libgupnp-av-1.0-2 libgweather-3-6 libgweather-common libharfbuzz-icu0
  libharfbuzz0b libhcrypto4-heimdal libheimbase1-heimdal libheimntlm0-heimd=
al
  libhogweed2 libhunspell-1.3-0 libhx509-5-heimdal libhyphen0 libibus-1.0-5
  libice6 libicu52 libidl0 libidn11 libiec61883-0 libimobiledevice4
  libio-html-perl libio-socket-ip-perl libio-socket-ssl-perl libiptcdata0
  libjack-jackd2-0 libjavascriptcoregtk-3.0-0 libjbig0 libjemalloc1
  libjpeg-progs libjson-glib-1.0-0 libjson-glib-1.0-common libjte1
  libk5crypto3 libkeyutils1 libkmod2 libkpathsea6 libkrb5-26-heimdal libkrb=
5-3
  libkrb5support0 liblapack3 liblcms1 libldap-2.4-2 liblinear1 liblouis-data
  liblouis2 liblqr-1-0 libltdl7 liblwp-protocol-https-perl liblzo2-2
  libmagick++5 libmagickcore5 libmagickcore5-extra libmagickwand5
  libmission-control-plugins0 libmng1 libmnl0 libmozjs185-1.0 libmpc3
  libmpg123-0 libmtp-common libmtp-runtime libmtp9 libmythes-1.2-0
  libnautilus-extension1a libncurses5 libncurses5-dev libncursesw5
  libneon27-gnutls libnet-http-perl libnettle4 libnm-glib-vpn1 libnm-glib4
  libnm-gtk-common libnm-gtk0 libnm-util2 libnspr4 libnss3 libntdb1 libobjc4
  libofa0 libopenal-data libopenal1 libopencv-calib3d2.4 libopencv-contrib2=
=2E4
  libopencv-core2.4 libopencv-features2d2.4 libopencv-flann2.4
  libopencv-highgui2.4 libopencv-imgproc2.4 libopencv-legacy2.4
  libopencv-ml2.4 libopencv-objdetect2.4 libopencv-video2.4 libopenraw1
  libopenvg1-mesa libopts25 libp11-kit0 libpam-cap libpam-modules
  libpam-modules-bin libpam-runtime libpam-systemd libpam0g libpango-1.0-0
  libpango1.0-0 libpangocairo-1.0-0 libpangoft2-1.0-0 libpangoxft-1.0-0
  libpcap0.8 libpciaccess0 libpcre3 libpcre3-dev libpcrecpp0 libpixman-1-0
  libpng12-0 libpolkit-agent-1-0 libpolkit-backend-1-0 libpolkit-gobject-1-0
  libpopt0 libprocps3 libpth20 libpulse-mainloop-glib0 libpulse0 libpulsedsp
  libpython-stdlib libpython2.7 libpython2.7-minimal libpython2.7-stdlib
  libpython3.4 libpython3.4-minimal libpython3.4-stdlib libqtcore4 libqtgui4
  libquvi-scripts libraw10 libraw1394-11 libreadline6 libreadline6-dev
  libreoffice-avmedia-backend-gstreamer libreoffice-java-common
  libroken18-heimdal librsvg2-2 librsvg2-common librtmp1 librygel-core-2.2-2
  librygel-renderer-2.2-2 librygel-renderer-gst-2.2-2 librygel-server-2.2-2
  libsamplerate0 libsasl2-2 libsasl2-modules libsasl2-modules-db
  libschroedinger-1.0-0 libsdl1.2debian libsidplay1 libslang2 libsm6
  libsmbclient libspandsp2 libspectre1 libsqlite3-0 libss2 libssl1.0.0
  libstdc++-4.9-dev libstdc++6 libswscale2 libsysfs-dev libsysfs2
  libsystemd-daemon0 libsystemd-id128-0 libsystemd-journal0 libsystemd-logi=
n0
  libtag1-vanilla libtag1c2a libtalloc2 libtasn1-6 libthai-data libthai0
  libtiff5 libtinfo-dev libtinfo5 libtwolame0 libubsan0 libudev1 libudisks2=
-0
  libunistring0 liburi-perl libusb-0.1-4 libv4l-0 libv4lconvert0 libvlc5
  libvlccore7 libvpx1 libvte-2.90-9 libvte-2.90-common libwbclient0
  libwebkitgtk-3.0-0 libwebkitgtk-3.0-common libwebp5 libwind0-heimdal
  libwnck-3-0 libwnck-3-common libwww-perl libx11-6 libx11-data libx11-xcb1
  libx264-142 libxapian22 libxaw7 libxdamage1 libxfixes3 libxfont1 libxft2
  libxi6 libxkbcommon0 libxml2 libxpm4 libyaml-0-2 libyaml-dev libzbar0
  libzeitgeist-2.0-0 linux-libc-dev login manpages manpages-dev mesa-utils
  minissdpd mtd-utils multiarch-support nano nautilus-data ncurses-base
  ncurses-bin ndiff nmap ntfs-3g ntp ntpdate openjdk-7-jre
  openjdk-7-jre-headless openssh-client openssl p11-kit p11-kit-modules pas=
swd
  patch policykit-1 poppler-data powertop procps pulseaudio
  pulseaudio-module-x11 pulseaudio-utils python python-apt-common python-gt=
k2
  python-libxml2 python-minimal python-numpy python-pycurl python-pyorbit
  python-smbc python-talloc python-zeitgeist python2.7 python2.7-minimal
  python3-apt python3-louis python3-pkg-resources python3-six python3.4
  python3.4-minimal qtcore4-l10n readline-common rygel rygel-playbin
  rygel-preferences samba-dsdb-modules samba-libs shotwell shotwell-common
  sqlite3 sysfsutils systemd systemd-sysv sysv-rc sysvinit-utils tasksel
  tasksel-data telepathy-gabble telepathy-mission-control-5 telepathy-salut
  traceroute transmission-gtk tzdata tzdata-java udev udisks2 vdpau-va-driv=
er
  vim vim-common vim-runtime vim-tiny vino vlc vlc-data vlc-nox
  vlc-plugin-notify vlc-plugin-pulse whois x11-apps x11-utils
  x11-xserver-utils xauth xfonts-encodings xfonts-utils xserver-common xterm
  zeitgeist zeitgeist-core zeitgeist-datahub zenity zenity-common zlib1g
  zlib1g-dev
638 upgraded, 0 newly installed, 0 to remove and 102 not upgraded.
Need to get 77.7 kB/419 MB of archives.
After this operation, 11.2 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
1% [Working]            Get:1 http://ftp.us.debian.org/debian/ sid/main lib=
udisks2-0 armel 2.1.3-3 [77.7 kB]
            1% [1 libudisks2-0 0 B/77.7 kB 0%]                             =
     100% [Working]              Fetched 77.7 kB in 0s (235 kB/s)
Extracting templates from packages: 4%Extracting templates from packages: 9=
%Extracting templates from packages: 14%Extracting templates from packages:=
 18%Extracting templates from packages: 23%Extracting templates from packag=
es: 28%Extracting templates from packages: 32%Extracting templates from pac=
kages: 37%Extracting templates from packages: 42%Extracting templates from =
packages: 47%Extracting templates from packages: 51%Extracting templates fr=
om packages: 56%Extracting templates from packages: 61%Extracting templates=
 from packages: 65%Extracting templates from packages: 70%Extracting templa=
tes from packages: 75%Extracting templates from packages: 79%Extracting tem=
plates from packages: 84%Extracting templates from packages: 89%Extracting =
templates from packages: 94%Extracting templates from packages: 98%Extracti=
ng templates from packages: 100%
Preconfiguring packages ...
(Reading database ... dpkg: warning: files list file for package 'libgtk-3-=
bin' missing; assuming package has no files currently installed
dpkg: warning: files list file for package 'libgd3:armel' missing; assuming=
 package has no files currently installed
(Reading database ... 5%(Reading database ... 10%(Reading database ... 15%(=
Reading database ... 20%(Reading database ... 25%(Reading database ... 30%(=
Reading database ... 35%(Reading database ... 40%(Reading database ... 45%(=
Reading database ... 50%(Reading database ... 55%(Reading database ... 60%(=
Reading database ... 65%(Reading database ... 70%(Reading database ... 75%(=
Reading database ... 80%(Reading database ... 85%(Reading database ... 90%(=
Reading database ... 95%(Reading database ... 100%(Reading database ... 921=
09 files and directories currently installed.)
Preparing to unpack .../base-files_7.5_armel.deb ...
Unpacking base-files (7.5) over (7.3) ...
Processing triggers for cracklib-runtime (2.9.1-1+b2) ...
Processing triggers for install-info (5.2.0.dfsg.1-4) ...
Processing triggers for man-db (2.6.7.1-1) ...
Setting up base-files (7.5) ...
(Reading database ... dpkg: warning: files list file for package 'libgtk-3-=
bin' missing; assuming package has no files currently installed
dpkg: warning: files list file for package 'libgd3:armel' missing; assuming=
 package has no files currently installed
(Reading database ... 5%(Reading database ... 10%(Reading database ... 15%(=
Reading database ... 20%(Reading database ... 25%(Reading database ... 30%(=
Reading database ... 35%(Reading database ... 40%(Reading database ... 45%(=
Reading database ... 50%(Reading database ... 55%(Reading database ... 60%(=
Reading database ... 65%(Reading database ... 70%(Reading database ... 75%(=
Reading database ... 80%(Reading database ... 85%[  521.177821] Unable to h=
andle kernel paging request at virtual address ac446b7c
[  521.185515] pgd =3D c0004000
[  521.188353] [ac446b7c] *pgd=3D00000000
[  521.192110] Internal error: Oops: 5 [#1] SMP ARM
[  521.196943] Modules linked in: xhci_hcd dwc3 matrix_keypad lis3lv02d_i2c=
 dwc3_omap lis3lv02d input_polldev spi_ti_qspi
[  521.208219] CPU: 0 PID: 972 Comm: kworker/0:3 Not tainted 3.17.0-rc1-000=
01-g3032495 #704
[  521.216708] Workqueue: events flush_to_ldisc
[  521.221196] task: ed3c6540 ti: ec356000 task.ti: ec356000
[  521.226858] PC is at memcpy+0x114/0x330
[  521.230868] LR is at n_tty_receive_buf_common+0x29c/0x930
[  521.236518] pc : [<c032a494>]    lr : [<c03a7470>]    psr: 60000013
[  521.236518] sp : ec357dd4  ip : 00000002  fp : ec357e3c
[  521.248509] r10: ed7e3800  r9 : 00000fe5  r8 : ed6c8000
[  521.253978] r7 : ed6c8024  r6 : ed7e3800  r5 : 000008ae  r4 : f07f7000
[  521.260798] r3 : 00000752  r2 : 000008aa  r1 : ac446b7c  r0 : f07f7790
[  521.267628] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 kernel
[  521.275256] Control: 10c5387d  Table: ad7a4059  DAC: 00000015
[  521.281257] Process kworker/0:3 (pid: 972, stack limit =3D 0xec356248)
[  521.287891] Stack: (0xec357dd4 to 0xec358000)
[  521.292454] 7dc0:                                              f07f7790 =
f07f7000 c03a7470
[  521.301000] 7de0: 00000752 ed6c8024 ed6c8000 f07f7000 ed7e393c ec357e3c =
ec357dc8 ec357e14
[  521.309555] 7e00: 00000000 ac446b7e 00000000 3ff7aa3a 00000001 ec3c1400 =
ed6c8004 ed7e3800
[  521.318106] 7e20: ed6c8024 ed6c8000 ed47e900 c0a462b8 ec357e54 ec357e40 =
c03a7b28 c03a71e0
[  521.326652] 7e40: 00000001 c0a462b8 ec357e84 ec357e58 c03ab1a0 c03a7b10 =
c03ab0bc ed6c8004
[  521.335208] 7e60: ed277740 edfb7a00 ec357ea8 00000000 edfbaf00 c0a462b8 =
ec357ee4 ec357e88
[  521.343757] 7e80: c005fe10 c03ab0c8 00000001 00000000 c005fd84 edfb7a00 =
00000001 00000000
[  521.352311] 7ea0: 00000000 ec356008 c123bee8 c0b9a828 00000000 c0824cbc =
c0639ec0 edfb7a00
[  521.360858] 7ec0: edfb7a30 ec356028 ec356000 ed277758 00000008 ed277740 =
ec357f24 ec357ee8
[  521.369407] 7ee0: c0060a40 c005fc4c c0639fe4 ed1c2ac0 00000000 ed277740 =
c00608f0 ed1c2ac0
[  521.377969] 7f00: 00000000 ed277740 c00608f0 00000000 00000000 00000000 =
ec357fac ec357f28
[  521.386532] 7f20: c0065470 c00608fc c0089444 00000000 ec357f54 ed277740 =
00000000 00000000
[  521.395085] 7f40: dead4ead ffffffff ffffffff c0a4adf8 00000000 00000000 =
c07e6984 ec357f5c
[  521.403628] 7f60: ec357f5c 00000000 00000000 dead4ead ffffffff ffffffff =
c0a4adf8 00000000
[  521.412184] 7f80: 00000000 c07e6984 ec357f88 ec357f88 ed1c2ac0 c006538c =
00000000 00000000
[  521.420732] 7fa0: 00000000 ec357fb0 c000ec48 c0065398 00000000 00000000 =
00000000 00000000
[  521.429281] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[  521.437822] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 =
ae7f6821 ae7f6c21
[  521.446382] Code: e211c003 0affffc4 e3c11003 e35c0002 (e491e004)=20
[  521.452857] ---[ end trace 3ed67d0e28f5d3b0 ]---
(Reading database ... 90%
=07Message from syslogd@saruman at Aug 26 17:13:15 ...
 kernel:[  521.192110] Internal error: Oops: 5 [#1] SMP ARM

=07Message from syslogd@saruman at Aug 26 17:13:15 ...
 kernel:[  521.281257] Process kworker/0:3 (pid: 972, stack limit =3D[  521=
=2E483919] Unable to handle kernel paging request at virtual address ffffff=
d0
[  521.494366] pgd =3D c0004000
[  521.497194] [ffffffd0] *pgd=3Dae7f6821, *pte=3D00000000, *ppte=3D00000000
[  521.503769] Internal error: Oops: 17 [#2] SMP ARM
[  521.508685] Modules linked in: xhci_hcd dwc3 matrix_keypad lis3lv02d_i2c=
 dwc3_omap lis3lv02d input_polldev spi_ti_qspi
[  521.519944] CPU: 0 PID: 972 Comm: kworker/0:3 Tainted: G      D        3=
=2E17.0-rc1-00001-g3032495 #704
[  521.529588] task: ed3c6540 ti: ec356000 task.ti: ec356000
[  521.535233] PC is at kthread_data+0x18/0x20
[  521.539606] LR is at wq_worker_sleeping+0x1c/0xe8
[  521.544522] pc : [<c0065bc0>]    lr : [<c0060e8c>]    psr: 00000093
[  521.544522] sp : ec357a18  ip : ec357a28  fp : ec357a24
[  521.556505] r10: ec356000  r9 : ed3c6540  r8 : edfb8000
[  521.561961] r7 : ec356000  r6 : c09a2000  r5 : 00000000  r4 : 00000000
[  521.568785] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : ed3c6540
[  521.575612] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segmen=
t user
[  521.583167] Control: 10c5387d  Table: ad2ac059  DAC: 00000015
[  521.589169] Process kworker/0:3 (pid: 972, stack limit =3D 0xec356248)
[  521.595817] Stack: (0xec357a18 to 0xec358000)
[  521.600363] 7a00:                                                       =
ec357a3c ec357a28
[  521.608914] 7a20: c0060e8c c0065bb4 00000020 ed3c68ac ec357af4 ec357a40 =
c0634e48 c0060e7c
[  521.617458] 7a40: 60000093 ed3c6540 ec357a64 ed410280 edfb5560 ed3c6fb8 =
ec356000 c0635174
[  521.626009] 7a60: ec357a7c ec357a70 c0089444 c0089264 c09a2000 c09a2000 =
c09a2000 c09a2000
[  521.634565] 7a80: ed3c6540 ed3f69c0 c0a4a384 c004ad14 ed410784 ed3c6540 =
ec357ab4 ec357aa8
[  521.643105] 7aa0: c00a01e4 c009ff0c ec357b04 ec357ab8 c004a574 c00a01d0 =
00000000 00000000
[  521.651660] 7ac0: c004a2f8 00000001 c099f478 ec356008 00000001 ed3c6828 =
ed3c6538 ed05ab00
[  521.660205] 7ae0: ed3c6540 ed3c6538 ec357b04 ec357af8 c0635174 c063498c =
ec357b54 ec357b08
[  521.668743] 7b00: c004ade4 c0635140 00000000 00000001 ed3c6828 ec357b20 =
ec357b44 ed3c6870
[  521.677287] 7b20: ec357b20 ec357b20 0000000b ec357d88 ec356000 0000000b =
c09b1aec ec356018
[  521.685829] 7b40: 00000001 c0a48d84 ec357bdc ec357b58 c00131ac c004a6d8 =
ec356248 0000000b
[  521.694381] 7b60: 00000001 00000008 00000000 00000000 60000113 c032a498 =
653c6540 63313132
[  521.702933] 7b80: 20333030 66666130 34636666 63336520 30303131 33652033 =
30306335 28203230
[  521.711485] 7ba0: 31393465 34303065 c0002029 c062f9e0 c0848bd8 ac446b7c =
00000005 00000000
[  521.720023] 7bc0: ec357d88 ac446b7c ed3c6540 ed7e3800 ec357bf4 ec357be0 =
c062e1bc c0012ddc
[  521.728559] 7be0: ec357d88 00000005 ec357c94 ec357bf8 c063ca34 c062e164 =
c11f807c c0a0f204
[  521.737088] 7c00: ed3c6b00 00000017 ec357cac ec357c18 c0089b88 c0088b1c =
58bfaf00 00000079
[  521.745628] 7c20: edfb57b8 00000004 edfb56c8 00000004 ec357c54 ec357c40 =
c00b7324 c00b4e40
[  521.754162] 7c40: 00000000 00004018 00000017 00000000 00000008 00000001 =
a4e2dbf7 138e0821
[  521.762699] 7c60: 586047ad 00000079 00000017 ec357d88 00000005 ac446b7c =
ac446b7c ec357d88
[  521.771253] 7c80: 00000fe5 ed7e3800 ec357cb4 ec357c98 c063cce4 c063c87c =
ac446b7c 00000005
[  521.779803] 7ca0: c063ccf4 c09b2954 ec357cd4 ec357cb8 c063cdb0 c063cc68 =
c09b2904 00000005
[  521.788360] 7cc0: c063ccf4 c09b2954 ec357d84 ec357cd8 c000847c c063cd00 =
ed00a45c 00000001
[  521.796903] 7ce0: 00000064 00000004 00000000 ed7e3800 ec357d24 ec357d00 =
c0639d20 000041bd
[  521.805444] 7d00: 204161bc 11110988 00000009 00000000 00000064 c0639f5c =
ed00a45c ed00a45c
[  521.813978] 7d20: ec357d3c ec357d30 c0086bac c0086ad4 ec357d64 ec357d40 =
c00a0fa4 00000000
[  521.822520] 7d40: ed7e3970 00000000 00000000 00000001 00000000 c03a7210 =
ec357db4 ec357d68
[  521.831075] 7d60: c008bc04 c032a494 60000013 ffffffff ec357dbc ed6c8000 =
ec357e3c ec357d88
[  521.839616] 7d80: c063aae4 c0008444 f07f7790 ac446b7c 000008aa 00000752 =
f07f7000 000008ae
[  521.848166] 7da0: ed7e3800 ed6c8024 ed6c8000 00000fe5 ed7e3800 ec357e3c =
00000002 ec357dd4
[  521.856710] 7dc0: c03a7470 c032a494 60000013 ffffffff ec357e3c f07f7790 =
f07f7000 c03a7470
[  521.865261] 7de0: 00000752 ed6c8024 ed6c8000 f07f7000 ed7e393c ec357e3c =
ec357dc8 ec357e14
[  521.873813] 7e00: 00000000 ac446b7e 00000000 3ff7aa3a 00000001 ec3c1400 =
ed6c8004 ed7e3800
[  521.882356] 7e20: ed6c8024 ed6c8000 ed47e900 c0a462b8 ec357e54 ec357e40 =
c03a7b28 c03a71e0
[  521.890911] 7e40: 00000001 c0a462b8 ec357e84 ec357e58 c03ab1a0 c03a7b10 =
c03ab0bc ed6c8004
[  521.899452] 7e60: ed277740 edfb7a00 ec357ea8 00000000 edfbaf00 c0a462b8 =
ec357ee4 ec357e88
[  521.907999] 7e80: c005fe10 c03ab0c8 00000001 00000000 c005fd84 edfb7a00 =
00000001 00000000
[  521.916555] 7ea0: 00000000 ec356008 c123bee8 c0b9a828 00000000 c0824cbc =
c0639ec0 edfb7a00
[  521.925093] 7ec0: edfb7a30 ec356028 ec356000 ed277758 00000008 ed277740 =
ec357f24 ec357ee8
[  521.933652] 7ee0: c0060a40 c005fc4c c0639fe4 ed1c2ac0 00000000 ed277740 =
c00608f0 ed1c2ac0
[  521.942204] 7f00: 00000000 ed277740 c00608f0 00000000 00000000 00000000 =
ec357fac ec357f28
[  521.950744] 7f20: c0065470 c00608fc c0089444 00000000 ec357f54 ed277740 =
00000000 00000000
[  521.959286] 7f40: dead4ead ffffffff ffffffff c0a4adf8 00000000 00000000 =
c07e6984 ec357f5c
[  521.967826] 7f60: ec357f5c 00000001 00010001 dead4ead ffffffff ffffffff =
c0a4adf8 00000000
[  521.976387] 7f80: 00000000 c07e6984 ec357f88 ec357f88 ed1c2ac0 c006538c =
00000000 00000000
[  521.984945] 7fa0: 00000000 ec357fb0 c000ec48 c0065398 00000000 00000000 =
00000000 00000000
[  521.993492] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[  522.002054] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 =
ae7f6821 ae7f6c21
[  522.010624] [<c0065bc0>] (kthread_data) from [<c0060e8c>] (wq_worker_sle=
eping+0x1c/0xe8)
[  522.019103] [<c0060e8c>] (wq_worker_sleeping) from [<c0634e48>] (__sched=
ule+0x4c8/0x7b4)
[  522.027583] [<c0634e48>] (__schedule) from [<c0635174>] (schedule+0x40/0=
x8c)
[  522.034966] [<c0635174>] (schedule) from [<c004ade4>] (do_exit+0x718/0x9=
c8)
[  522.042264] [<c004ade4>] (do_exit) from [<c00131ac>] (die+0x3dc/0x434)
[  522.049114] [<c00131ac>] (die) from [<c062e1bc>] (__do_kernel_fault.part=
=2E11+0x64/0x84)
[  522.057410] [<c062e1bc>] (__do_kernel_fault.part.11) from [<c063ca34>] (=
do_page_fault.part.12+0x1c4/0x3ec)
[  522.067526] [<c063ca34>] (do_page_fault.part.12) from [<c063cce4>] (do_p=
age_fault+0x88/0x98)
[  522.076360] [<c063cce4>] (do_page_fault) from [<c063cdb0>] (do_translati=
on_fault+0xbc/0xc8)
[  522.085115] [<c063cdb0>] (do_translation_fault) from [<c000847c>] (do_Da=
taAbort+0x44/0xa8)
[  522.093761] [<c000847c>] (do_DataAbort) from [<c063aae4>] (__dabt_svc+0x=
44/0x80)
[  522.101501] Exception stack(0xec357d88 to 0xec357dd0)
[  522.106787] 7d80:                   f07f7790 ac446b7c 000008aa 00000752 =
f07f7000 000008ae
[  522.115332] 7da0: ed7e3800 ed6c8024 ed6c8000 00000fe5 ed7e3800 ec357e3c =
00000002 ec357dd4
[  522.123891] 7dc0: c03a7470 c032a494 60000013 ffffffff
[  522.129207] [<c063aae4>] (__dabt_svc) from [<c032a494>] (memcpy+0x114/0x=
330)
[  522.136570] Code: e24cb004 e52de004 e8bd4000 e5903340 (e5130030)=20
[  522.142941] ---[ end trace 3ed67d0e28f5d3b1 ]---
[  522.147761] Fixing recursive fault but reboot is needed!
[  543.089605] BUG: spinlock lockup suspected on CPU#0, kworker/0:3/972
[  543.096262]  lock: 0xedfb8000, .magic: dead4ead, .owner: kworker/0:3/972=
, .owner_cpu: 0
[  543.104640] CPU: 0 PID: 972 Comm: kworker/0:3 Tainted: G      D        3=
=2E17.0-rc1-00001-g3032495 #704
[  543.114307] [<c0017110>] (unwind_backtrace) from [<c0012dcc>] (show_stac=
k+0x20/0x24)
[  543.122416] [<c0012dcc>] (show_stack) from [<c06331b0>] (dump_stack+0x8c=
/0xa4)
[  543.129982] [<c06331b0>] (dump_stack) from [<c062f8e0>] (spin_dump+0x84/=
0x98)
[  543.137459] [<c062f8e0>] (spin_dump) from [<c008e7bc>] (do_raw_spin_lock=
+0x124/0x1a8)
[  543.145661] [<c008e7bc>] (do_raw_spin_lock) from [<c0639ec0>] (_raw_spin=
_lock_irq+0x4c/0x54)
[  543.154475] [<c0639ec0>] (_raw_spin_lock_irq) from [<c0634a4c>] (__sched=
ule+0xcc/0x7b4)
[  543.162845] [<c0634a4c>] (__schedule) from [<c0635174>] (schedule+0x40/0=
x8c)
[  543.170222] [<c0635174>] (schedule) from [<c004afe8>] (do_exit+0x91c/0x9=
c8)
[  543.177507] [<c004afe8>] (do_exit) from [<c00131ac>] (die+0x3dc/0x434)
[  543.184336] [<c00131ac>] (die) from [<c062e1bc>] (__do_kernel_fault.part=
=2E11+0x64/0x84)
[  543.192627] [<c062e1bc>] (__do_kernel_fault.part.11) from [<c063ca34>] (=
do_page_fault.part.12+0x1c4/0x3ec)
[  543.202731] [<c063ca34>] (do_page_fault.part.12) from [<c063cce4>] (do_p=
age_fault+0x88/0x98)
[  543.211569] [<c063cce4>] (do_page_fault) from [<c000847c>] (do_DataAbort=
+0x44/0xa8)
[  543.219579] [<c000847c>] (do_DataAbort) from [<c063aae4>] (__dabt_svc+0x=
44/0x80)
[  543.227311] Exception stack(0xec3579d0 to 0xec357a18)
[  543.232592] 79c0:                                     ed3c6540 00000000 =
00000000 00000000
[  543.241156] 79e0: 00000000 00000000 c09a2000 ec356000 edfb8000 ed3c6540 =
ec356000 ec357a24
[  543.249720] 7a00: ec357a28 ec357a18 c0060e8c c0065bc0 00000093 ffffffff
[  543.256642] [<c063aae4>] (__dabt_svc) from [<c0065bc0>] (kthread_data+0x=
18/0x20)
[  543.264375] [<c0065bc0>] (kthread_data) from [<c0060e8c>] (wq_worker_sle=
eping+0x1c/0xe8)
[  543.272839] [<c0060e8c>] (wq_worker_sleeping) from [<c0634e48>] (__sched=
ule+0x4c8/0x7b4)
[  543.281309] [<c0634e48>] (__schedule) from [<c0635174>] (schedule+0x40/0=
x8c)
[  543.288684] [<c0635174>] (schedule) from [<c004ade4>] (do_exit+0x718/0x9=
c8)
[  543.295951] [<c004ade4>] (do_exit) from [<c00131ac>] (die+0x3dc/0x434)
[  543.302774] [<c00131ac>] (die) from [<c062e1bc>] (__do_kernel_fault.part=
=2E11+0x64/0x84)
[  543.311057] [<c062e1bc>] (__do_kernel_fault.part.11) from [<c063ca34>] (=
do_page_fault.part.12+0x1c4/0x3ec)
[  543.321163] [<c063ca34>] (do_page_fault.part.12) from [<c063cce4>] (do_p=
age_fault+0x88/0x98)
[  543.330003] [<c063cce4>] (do_page_fault) from [<c063cdb0>] (do_translati=
on_fault+0xbc/0xc8)
[  543.338735] [<c063cdb0>] (do_translation_fault) from [<c000847c>] (do_Da=
taAbort+0x44/0xa8)
[  543.347371] [<c000847c>] (do_DataAbort) from [<c063aae4>] (__dabt_svc+0x=
44/0x80)
[  543.355100] Exception stack(0xec357d88 to 0xec357dd0)
[  543.360370] 7d80:                   f07f7790 ac446b7c 000008aa 00000752 =
f07f7000 000008ae
[  543.368921] 7da0: ed7e3800 ed6c8024 ed6c8000 00000fe5 ed7e3800 ec357e3c =
00000002 ec357dd4
[  543.377468] 7dc0: c03a7470 c032a494 60000013 ffffffff
[  543.382768] [<c063aae4>] (__dabt_svc) from [<c032a494>] (memcpy+0x114/0x=
330)

--=20
balbi

--Z0mFw3+mXTC5ycVe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT/MKnAAoJEIaOsuA1yqREm8YQALBdpKryjKu5Ik3KgEZ9KXh9
ItXGJa5prVQuZKBWqnYVZXQgr9iBA7c6HRudGwaoSkonnXtxntSDp1afMZmiOhbi
oQGeRZabc+bDQO37v1rW95kIxIDOfaSEC/qgq6BPiRVFfNPm7ADWoWrU80j5/+vb
mnNXfLBdI+TQQyRf9BOPMDoqz3Nt0AR8bE8N6ScHj8VOxJv1GGe+tM/Q5BPLPgts
Mmohob+uHqiQ6E+GlxHM6pMBeH4sIEmTI6sP7YbasFEjsgCjuXS1P9/afQjcsezo
J9Vm1YqVbeauhMV3SPsnJki6leddwFvg8s7dWhP0MI0WCvyToCaVXZo1DqrBp1LE
1Ln05X8KW7i8Nq8qTf7Bbl1KjeDn3P0ItnqPT0TADkSuGUWPCiO6njZdq9yEALAk
OgshI4ZC26vdeWrs6TRgG6s4Mxm95kTWPKC948eMPvjZkmVOe9DR4p3y8ffTH2KW
7X8FzrFZnjcGcmD7wfEEwnxkXOXJf7HdSISp/KcOdhWmnhneRYCn83vB2H9gTuUG
YPFca4MCFTnpMuscnHAAMtbK3hQWRuWbIl3FGL/HeaWEHuj76Cb7cJnM4thZtHq4
kfO19LET5tL+sUNpR69EEFphBUpGDC4NIwDz5K08il4aSE0/mjELNw3z5VT/Q1K4
kxI1n7IhERBPcEua3E3f
=1uTn
-----END PGP SIGNATURE-----

--Z0mFw3+mXTC5ycVe--

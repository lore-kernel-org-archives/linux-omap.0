From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Nokia N900: musb is in wrong state after boot
Date: Sat, 9 Jan 2016 16:16:04 +0100
Message-ID: <201601091616.04193@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2778546.AqUeO7hYx4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--nextPart2778546.AqUeO7hYx4
Content-Type: multipart/mixed;
  boundary="Boundary-01=_0QSkWXgMB9ua+pO"
Content-Transfer-Encoding: 7bit


--Boundary-01=_0QSkWXgMB9ua+pO
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

when I boot 4.4.0-rc7+ kernel compiled with g_nokia into zImage on Nokia=20
N900 into userspace then usb gadget (g_nokia) does not work. Notebook,=20
connected on other side does not see any usb device... Connecting and=20
disconnecting cable does not change anything, still not work.

But if I run this command
$ echo peripheral > /sys/bus/platform/devices/musb-hdrc.0.auto/mode=20

then gadget starts working. Other side see usb device and can use it.=20
Also connecting and disconnecting usb cable working fine. After=20
connecting it again, usb device OK.

So it looks like musb is in some wrong state after boot if above command=20
is not called.

Any idea where is problem? In attachment is output from more musb sysfs=20
entries (before and after calling that command) which I think could be=20
useful. If you want to see more logs, let me know what.

Note that host mode on Nokia N900 does not work because of HW design.=20
=46or 2.6.28 Nokia's kernel there are special and ugly (!) patches which=20
enable host mode together with userspace interaction. So it does not=20
make sense to have other than peripheral mode enabled by default on=20
Nokia N900...

=2D-=20
Pali Roh=C3=A1r
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org

--Boundary-01=_0QSkWXgMB9ua+pO
Content-Type: text/plain;
  charset="UTF-8";
  name="musb_log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="musb_log"

Nokia-N900:~# grep "" /sys/bus/platform/devices/musb-hdrc.0.auto/*
/sys/bus/platform/devices/musb-hdrc.0.auto/driver_override:(null)
/sys/bus/platform/devices/musb-hdrc.0.auto/modalias:platform:musb-hdrc
/sys/bus/platform/devices/musb-hdrc.0.auto/mode:b_idle
/sys/bus/platform/devices/musb-hdrc.0.auto/uevent:DRIVER=3Dmusb-hdrc
/sys/bus/platform/devices/musb-hdrc.0.auto/uevent:MODALIAS=3Dplatform:musb-=
hdrc
/sys/bus/platform/devices/musb-hdrc.0.auto/vbus:Vbus on, timeout 1100 msec
Nokia-N900:~# grep "" /sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.=
0.auto/*
/sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/a_alt_hnp_suppo=
rt:0
/sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/a_hnp_support:0
/sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/b_hnp_enable:0
/sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/current_speed:U=
NKNOWN
/sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/is_a_peripheral=
:0
/sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/is_otg:1
/sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/is_selfpowered:0
/sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/maximum_speed:h=
igh-speed
grep: /sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/soft_conn=
ect: Permission denied
grep: /sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/srp: Perm=
ission denied
/sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/state:not attac=
hed
Nokia-N900:~# cat /sys/kernel/debug/musb-hdrc.0.auto/regdump
MUSB (M)HDRC Register Dump
=46Addr       : 00
Power       : a0
=46rame       : 0000
Index       : 00
Testmode    : 00
TxMaxPp     : a000
TxCSRp      : 0000
RxMaxPp     : 0000
RxCSR       : ffff
RxCount     : fffe
IntrRxE     : fffe
IntrTxE     : ffff
IntrUsbE    : f7
DevCtl      : 98
VControl    : 00000000
HWVers      : 0000
LinkInfo    : 5c
VPLen       : 3c
HS_EOF1     : 80
=46S_EOF1     : 77
LS_EOF1     : 72
SOFT_RST    : 00
DMA_CNTLch0 : 0000
DMA_ADDRch0 : 00000000
DMA_COUNTch0: 00000000
DMA_CNTLch1 : 0000
DMA_ADDRch1 : 00000000
DMA_COUNTch1: 00000000
DMA_CNTLch2 : 0000
DMA_ADDRch2 : 00000000
DMA_COUNTch2: 00000000
DMA_CNTLch3 : 0000
DMA_ADDRch3 : 00000000
DMA_COUNTch3: 00000000
DMA_CNTLch4 : 0000
DMA_ADDRch4 : 00000000
DMA_COUNTch4: 00000000
DMA_CNTLch5 : 0000
DMA_ADDRch5 : 00000000
DMA_COUNTch5: 00000000
DMA_CNTLch6 : 0000
DMA_ADDRch6 : 00000000
DMA_COUNTch6: 00000000
DMA_CNTLch7 : 0000
DMA_ADDRch7 : 00000000
DMA_COUNTch7: 00000000
ConfigData  : 00
BabbleCtl   : 00
TxFIFOsz    : 00
RxFIFOsz    : 00
TxFIFOadd   : 0000
RxFIFOadd   : 0000
EPInfo      : ff
RAMInfo     : 8c
Nokia-N900:~# cat /sys/kernel/debug/musb-hdrc.0.auto/softconnect
=2D1
Nokia-N900:~# cat /sys/kernel/debug/musb-hdrc.0.auto/testmode
Nokia-N900:~#=20
Nokia-N900:~#=20
Nokia-N900:~# echo peripheral > /sys/bus/platform/devices/musb-hdrc.0.auto/=
mode
Nokia-N900:~#=20
Nokia-N900:~#=20
Nokia-N900:~#=20
Nokia-N900:~# grep "" /sys/bus/platform/devices/musb-hdrc.0.auto/*
/sys/bus/platform/devices/musb-hdrc.0.auto/driver_override:(null)
/sys/bus/platform/devices/musb-hdrc.0.auto/modalias:platform:musb-hdrc
/sys/bus/platform/devices/musb-hdrc.0.auto/mode:b_peripheral
/sys/bus/platform/devices/musb-hdrc.0.auto/uevent:DRIVER=3Dmusb-hdrc
/sys/bus/platform/devices/musb-hdrc.0.auto/uevent:MODALIAS=3Dplatform:musb-=
hdrc
/sys/bus/platform/devices/musb-hdrc.0.auto/vbus:Vbus on, timeout 1100 msec
Nokia-N900:~# grep "" /sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.=
0.auto/*
/sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/a_alt_hnp_suppo=
rt:0
/sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/a_hnp_support:0
/sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/b_hnp_enable:0
/sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/current_speed:h=
igh-speed
/sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/is_a_peripheral=
:0
/sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/is_otg:1
/sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/is_selfpowered:0
/sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/maximum_speed:h=
igh-speed
grep: /sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/soft_conn=
ect: Permission denied
grep: /sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/srp: Perm=
ission denied
/sys/bus/platform/devices/musb-hdrc.0.auto/musb-hdrc.0.auto/state:configured
Nokia-N900:~# cat /sys/kernel/debug/musb-hdrc.0.auto/regdump
MUSB (M)HDRC Register Dump
=46Addr       : 1f
Power       : f0
=46rame       : 02dd
Index       : 00
Testmode    : 00
TxMaxPp     : f01f
TxCSRp      : 0000
RxMaxPp     : 0000
RxCSR       : ffff
RxCount     : fffe
IntrRxE     : fffe
IntrTxE     : ffff
IntrUsbE    : f7
DevCtl      : 99
VControl    : 00000000
HWVers      : 0000
LinkInfo    : 5c
VPLen       : 3c
HS_EOF1     : 80
=46S_EOF1     : 77
LS_EOF1     : 72
SOFT_RST    : 00
DMA_CNTLch0 : 0000
DMA_ADDRch0 : 00000000
DMA_COUNTch0: 00000000
DMA_CNTLch1 : 0000
DMA_ADDRch1 : 00000000
DMA_COUNTch1: 00000000
DMA_CNTLch2 : 0000
DMA_ADDRch2 : 00000000
DMA_COUNTch2: 00000000
DMA_CNTLch3 : 0000
DMA_ADDRch3 : 00000000
DMA_COUNTch3: 00000000
DMA_CNTLch4 : 0000
DMA_ADDRch4 : 00000000
DMA_COUNTch4: 00000000
DMA_CNTLch5 : 0000
DMA_ADDRch5 : 00000000
DMA_COUNTch5: 00000000
DMA_CNTLch6 : 0000
DMA_ADDRch6 : 00000000
DMA_COUNTch6: 00000000
DMA_CNTLch7 : 0000
DMA_ADDRch7 : 00000000
DMA_COUNTch7: 00000000
ConfigData  : 00
BabbleCtl   : 00
TxFIFOsz    : 00
RxFIFOsz    : 00
TxFIFOadd   : 0000
RxFIFOadd   : 0000
EPInfo      : ff
RAMInfo     : 8c
Nokia-N900:~# cat /sys/kernel/debug/musb-hdrc.0.auto/softconnect
=2D1
Nokia-N900:~# cat /sys/kernel/debug/musb-hdrc.0.auto/testmode
Nokia-N900:~#=20

--Boundary-01=_0QSkWXgMB9ua+pO--

--nextPart2778546.AqUeO7hYx4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlaRJDQACgkQi/DJPQPkQ1K8FACcD5w2t7ofU8zNVaRzoUvcrjRX
M2cAoJGjCilw7J6o5rjY4ymOyU4EDjt2
=i00+
-----END PGP SIGNATURE-----

--nextPart2778546.AqUeO7hYx4--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

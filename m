From: Martin Margraf <m_margraf@web.de>
Subject: osk5912 boot failure with u-boot 1.1.4
Date: Wed, 31 May 2006 16:10:55 +0200
Message-ID: <933035583@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

so, i compiled u-boot 1.1.4 (latest version from ftp://ftp.denx.de/pub/u-b=
oot and with the patches available from http://omap.spectrumdigital.com/os=
k5912/osk5912=5Ffaq.html)
and my 2.6.16.18 kernel with ELDK 3.1.1 and i get the following error.

#OMAP5912 OSK # bootm 0x100000
### Booting image at 00100000 ...
#   Image Name:   Linux Kernel Image
#   Image Type:   ARM Linux Kernel Image (gzip compressed)
#   Data Size:    1155123 Bytes =3D  1.1 MB
#   Load Address: 10c08000
#  Entry Point:  10c08000
#   Verifying Checksum ... OK
#  Uncompressing Kernel Image ... OK
#
#Starting kernel ...
#
#Uncompressing Linux......................................................=
........................ done, booting the kernel.
#
#Error: unrecognized/unsupported machine ID (r1 =3D 0x00000003).
#
#Available machine support:
#
#ID (hex)        NAME
#00000203        TI-OSK
#
#Please check your kernel config and/or bootloader.

these are the settings i made in the kernel .config:

system core type:=20
CONFIG=5FARCH=5FOMAP=3Dy
omap core type:
CONFIG=5FARCH=5FOMAP16XX=3Dy
omap board type:
#CONFIG=5FMACH=5FOMAP=5FOSK=3Dy

regards

martin
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=

Erweitern Sie FreeMail zu einem noch leistungsst=E4rkeren E-Mail-Postfach!	=09
Mehr Infos unter http://freemail.web.de/home/landingpad/=3Fmc=3D021131

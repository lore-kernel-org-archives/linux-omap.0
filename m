From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Trying to boot Panda with DT
Date: Tue, 13 Dec 2011 15:03:05 +0200
Message-ID: <1323781385.1877.75.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-whi9UQK6o+C1kREzisIW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:58067 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751037Ab1LMNDL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 08:03:11 -0500
Received: by lags15 with SMTP id s15so2720123lag.4
        for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 05:03:08 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap mailing list <linux-omap@vger.kernel.org>


--=-whi9UQK6o+C1kREzisIW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to boot Pandaboard ES with DT, but failing. I've debugged the
problem enough to see that the bootloader properly loads the DT blob,
and passes it to the kernel, but the kernel sees only garbage at that
address, and the devtree->magic check fails in setup_machine_fdt(). I
presume something overwrites it.

I'm using Pandaboard ES (so omap 4460), Benoit's
"for_3.3/1_omap_dt_i2c_twl_test" branch, u-boot from Linaro
(git://git.linaro.org/boot/u-boot-linaro-stable.git master). My u-boot
boot-script is below.

Should the setup work? What setup do you have? Any ideas what could be
wrong?

 Tomi

u-boot boot script:
-------------------

set netmask 255.255.255.0
set ipaddr 192.168.1.15
set serverip 192.168.1.1

set kaddr 0x82000000
set dtbaddr 0x85000000

set bootcmd 'tftpboot ${kaddr} uImage; tftpboot ${dtbaddr} omap4-panda.dtb;=
 fdt addr ${dtbaddr}; fdt resize; bootm ${kaddr} - ${dtbaddr}'

set bootargs 'console=3DttyO2,115200n8 root=3D/dev/nfs nfsroot=3D192.168.1.=
1:/tftpboot/rootfs,tcp,nolock,rsize=3D1024,wsize=3D1024 ip=3D192.168.1.15::=
:::eth0: vram=3D36M rootdelay=3D1 no_console_suspend debug earlyprintk cons=
ole loglevel=3D8'

usb start

boot


boot log (with added debug prints)
----------------------------------

## Booting kernel from Legacy Image at 82000000 ...
   Image Name:   Linux-3.2.0-rc1-00014-g4d66c8f-d
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    3664960 Bytes =3D 3.5 MiB
   Load Address: 80008000
   Entry Point:  80008000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 85000000
   Booting using the fdt blob at 0x85000000
   Loading Kernel Image ... OK
OK
   reserving fdt memory region: addr=3D9d000000 size=3D3000000
   reserving fdt memory region: addr=3D85000000 size=3D1000
   Loading Device Tree to bfef3000, end bfef6fff ... OK

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
DT phys bfef3000, virt ffef3000
illegal DT magic
Warning: Neither atags nor dtb found


--=-whi9UQK6o+C1kREzisIW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO500JAAoJEPo9qoy8lh71sVUP/RW5apaiK7K2dvL2OHdoFQL0
SIMvHKS9KejayTP30znHKSqebB7MRLLO8oAikfx5ZApP2MJ5qLti0mNnU7yqZYLN
UNWogFQpInwc5XtqPXVyBNsKhC0BptKpeBfoZ1e8oedGKVyXJbfdTQgyg0ywfdrF
j2eLiDcgwuNRHoHiQI5u7ht9y4DmwrkAqEcc/CG9AcbuNhhh6d+CP/l0E9ZWSKLX
D1NWbguiOjj9p3MCu7f3/n+lg2nmBlzQAkmhsOVljNxOv4P4jOi8PO+tnxLTN7L0
Le5Hjg7gkRAxHP6GKOPfMjF3pAvIY9IRy1N+p36KXLgrGYlt++UW3cdoTsAUfEUf
wPqCkwhAfK8UU91Kg589YyFpJvwjam9IB9odsFEohX0A2+4aB06n2KuUXPXc8oEj
zkwHSXiO60uyrFO3FJIiCzkBmAS+4sDe8vEOsJ1mF23yu6H6nN86K6ifRv2FzdNn
QsFB4IcznX45v6OEtwHJ5oMTED6xERfP2cVQLZP41L96QDfs9QAIPGJ4Trk/SAf9
C3/2zyIlLSyzviRl0uwzztqWyHGOSKsj56jFGYR1MHjkYGz613CAoJY8S9ubYDqI
mMNRmY3giSR2FwqKq48VPcYVuJk20AoqwNC6txQL3W1Sl2kysH9PPhXBmwB89/fa
fehFIP+v19l/nfh3E5cF
=fxp+
-----END PGP SIGNATURE-----

--=-whi9UQK6o+C1kREzisIW--


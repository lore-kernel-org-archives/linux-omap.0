From: Merlijn Wajer <merlijn@wizzup.org>
Subject: Nokia N900 on 5.4 and 5.5
Date: Fri, 7 Feb 2020 15:54:14 +0100
Message-ID: <79b91017-b52a-8aff-4b9c-913ae655f7bf@wizzup.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lBuyN4AWvJL8LwRL2KCIwlOtHXHmt034X"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from a80-127-99-228.adsl.xs4all.nl ([80.127.99.228]:32796 "EHLO
        hetgrotebos.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726674AbgBGOxL (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 7 Feb 2020 09:53:11 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, "Arthur D." <spinal.by@gmail.com>, Tony Lindgren <tony@atomide.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lBuyN4AWvJL8LwRL2KCIwlOtHXHmt034X
Content-Type: multipart/mixed; boundary="m8BCXAro0qvsecVFpTRxgrKKj0TRLcljU"

--m8BCXAro0qvsecVFpTRxgrKKj0TRLcljU
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

I've tried to build 5.4.18 and 5.5.2 for the Nokia N900, using
omap2plus_defconfig. Using appended DTB, like so:

$ cat arch/arm/boot/zImage arch/arm/boot/dts/omap3-n900.dtb > zImage.dtb
$ mkimage -A arm -O linux -T kernel -C none -a 80008000 -e 80008000 -n
zImage -d zImage.dtb uImage

But they both fail to boot for me - the device resets almost instantly:

> data abort
>=20
>     MAYBE you should read doc/README.arm-unaligned-accesses
>=20
> pc : [<8000c878>]          lr : [<80008160>]
> sp : 803c46c8  ip : 003a1870     fp : 003a1848
> r10: 803ba890  r9 : 00caa42c     r8 : 80000100
> r7 : 000007a3  r6 : 803a9878     r5 : 80000100  r4 : 80008000
> r3 : 00004e6c  r2 : 00019fa8     r1 : 803a9878  r0 : 00000000
> Flags: nZcv  IRQs off  FIQs on  Mode SVC_32
> Resetting CPU ...
>=20
> resetting ...

Full log below. I tried the same with "-Os" instead of "-O2" ; to no avai=
l.

Any clue what could be up?

Cheers,
Merlijn

[1]
> NOLO X-Loader (v1.4.14, Jun  3 2010)
> Secondary image size 109384
> Booting secondary
> [   0.002] Nokia OMAP Loader v1.4.14 (Jun  3 2010) running on Nokia N90=
0 F5 (RX-51)
> [   0.014] I2C v3.12
> [   0.033] System DMA v4.0
> [   0.036] OneNAND device ID 0040, version ID 0121 (256 MiB, 66 MHz)
> [   0.071]   OneNAND blocks unlocked in 28040 us
> [   0.075]   Flash id: ec4021
> [   0.094] Partition table successfully read
> [   0.102] TWL4030 PWR ISR: 40
> [   0.105] Reset reason: por
> [   0.108] McSPI v2.1
> [   0.111] LP5523 found at I2C bus 2, address 0x32
> [   0.122] SMB138C: Not loading driver (version reg. 0x4b)
> [   0.128] BQ24150 (rev. 3) found on I2C bus 1, address 0x6b
> [   0.134] SSI version 1.0
> [   0.148] Battery voltage 3.780 V, BSI: 971
> [   0.164] Initializing LCD panel
> [   0.167]   Detecting LCD panel moscow
> [   0.171]     Panel ID: 108d77
> [   0.174]   Detected LCD panel: acx565akm
> [   0.178] DISPC: version 3.0
> [   0.183]   LCD pixel clock 24000 kHz
> [   0.214]   Logo drawn in 5 ms (11700 kB/s)
> [   0.345]   =EF=BF=BDber-cool backlight fade-in took 9 ms
> [   0.352] Initializing USB
> [   0.360]   No USB host detected
> [   0.363] Loading kernel image info
> Loading kernel (1961 kB)... done in 71 ms (27535 kB/s)
> [   0.443] Loading initfs image info
> [   0.447] Total bootup time 450 ms
> [   0.451] Serial console disabled
>=20
>=20
> U-Boot 2013.04 (Apr 20 2013 - 11:00:56)
>=20
> OMAP3530-HS ES3.1, CPU-OPP2, L3-165MHz, Max CPU Clock 600 MHz
> Nokia RX-51 + LPDDR/OneNAND
> I2C:   ready
> DRAM:  256 MiB
> MMC:   OMAP SD/MMC: 0, OMAP SD/MMC: 1
> Using default environment
>=20
> In:    vga
> Out:   vga
> Err:   vga
> data abort
>=20
>     MAYBE you should read doc/README.arm-unaligned-accesses
>=20
> pc : [<8000c878>]          lr : [<80008160>]
> sp : 803c46c8  ip : 003a1870     fp : 003a1848
> r10: 803ba890  r9 : 00caa42c     r8 : 80000100
> r7 : 000007a3  r6 : 803a9878     r5 : 80000100  r4 : 80008000
> r3 : 00004e6c  r2 : 00019fa8     r1 : 803a9878  r0 : 00000000
> Flags: nZcv  IRQs off  FIQs on  Mode SVC_32
> Resetting CPU ...
>=20
> resetting ...


--m8BCXAro0qvsecVFpTRxgrKKj0TRLcljU--

--lBuyN4AWvJL8LwRL2KCIwlOtHXHmt034X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCXj16FgAKCRAGN09rynK8
WkwCAQD5KnlpBt8UjjsjguGrW5Dk0T0K2u/PjEiyFtjAl19wzwEA3PgR0o98lSYI
U3qyE8YX6rlqOLvYvCJ9K2p1ZMwhyg8=
=IxhY
-----END PGP SIGNATURE-----

--lBuyN4AWvJL8LwRL2KCIwlOtHXHmt034X--

From: Merlijn Wajer <merlijn@wizzup.org>
Subject: N900: Remove mmc1 "safety feature"? (was: Re: mmc0 on Nokia N900 on
 Linux 5.4.18)
Date: Sat, 8 Feb 2020 22:44:49 +0100
Message-ID: <1eac0db3-17ce-8ebd-4997-8b1c282126e4@wizzup.org>
References: <5362c659-120f-5247-aaa5-7916229300bc@wizzup.org>
 <20200208190448.GA12984@amd>
 <270f27c9-afd6-171d-7dce-fe1d71dd8f9a@wizzup.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3UrNbDU4ZycEPwssQWPTUWhghJlLTnQdb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from a80-127-99-228.adsl.xs4all.nl ([80.127.99.228]:48316 "EHLO
        hetgrotebos.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727473AbgBHVno (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Sat, 8 Feb 2020 16:43:44 -0500
In-Reply-To: <270f27c9-afd6-171d-7dce-fe1d71dd8f9a@wizzup.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, "Arthur D." <spinal.by@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3UrNbDU4ZycEPwssQWPTUWhghJlLTnQdb
Content-Type: multipart/mixed; boundary="MBoO1g0WCW8I9EC53NJXdEQf7MVFTWKev"

--MBoO1g0WCW8I9EC53NJXdEQf7MVFTWKev
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

On 08/02/2020 20:18, Merlijn Wajer wrote:
> Hi,
>=20
> On 08/02/2020 20:04, Pavel Machek wrote:
>> Hi!
>>
>>> When booting Linux 5.4.18 with omap2plus_defconfig, I no longer get a=

>>> /dev/mmcblk0 device - the one corresponding to my microSD card, where=

>>> u-boot also loads the kernel from.
>>>
>>> This also likely seems to be a regression, but I haven't tried to hun=
t
>>> it down yet.
>>>
>>> Kernel log attached, below.
>>
>> Do you have back cover attached? That's common trap...
>=20
> Right.
>=20
> No, I did not, since I have the serial pins connected to my PC, and the=

> whole device is mounted on a piece of hardware for that. I thought that=

> we fixed the problem where we require the cover to be on...

Indeed, this was the problem.

Is there really a reason to have this in the DTS? I have a hard time
imagining a use case for not showing SD card to users or developers
simply because the casing is open. If anything, this sounds like it
should be a userspace thing.

That said, any opposition to a patch to invert the logic - have users or
developers specifically enable some code to *not* show the MMC card when
the cover is open? Or perhaps just outright remove the check in the
kernel? How about something like the patch below (which we currently ship=
)?

Cheers,
Merlijn


=46rom 9ce9bb2557208bb347909823d4710c9f93f65bf0 Mon Sep 17 00:00:00 2001
From: Arthur Demchenkov <spinal.by@gmail.com>
Date: Mon, 25 Mar 2019 01:44:23 +0300
Subject: [PATCH] ARM: dts: n900: ignore mmc1 card detect gpio

Allow the device to boot from external MMC with back cover removed.

See https://github.com/maemo-leste/bugtracker/issues/225
---
 arch/arm/boot/dts/omap3-n900.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts
b/arch/arm/boot/dts/omap3-n900.dts
index 7028a7cb2849e..03481302704de 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -805,10 +805,6 @@
 	pinctrl-0 =3D <&mmc1_pins>;
 	vmmc-supply =3D <&vmmc1>;
 	bus-width =3D <4>;
-	/* For debugging, it is often good idea to remove this GPIO.
-	   It means you can remove back cover (to reboot by removing
-	   battery) and still use the MMC card. */
-	cd-gpios =3D <&gpio6 0 GPIO_ACTIVE_LOW>; /* 160 */
 };

 /* most boards use vaux3, only some old versions use vmmc2 instead */


--MBoO1g0WCW8I9EC53NJXdEQf7MVFTWKev--

--3UrNbDU4ZycEPwssQWPTUWhghJlLTnQdb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCXj8r0QAKCRAGN09rynK8
WknKAQCeAnnUCYOXeZHpUioYr38Mmvsgcj0C6GTqBvBAcMW/0wD/cXjzlpiRNSQa
m2N7y2fitjTIJaPBpbi4aMyEcSOpegE=
=VXih
-----END PGP SIGNATURE-----

--3UrNbDU4ZycEPwssQWPTUWhghJlLTnQdb--

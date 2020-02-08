From: Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: mmc0 on Nokia N900 on Linux 5.4.18
Date: Sat, 8 Feb 2020 20:18:03 +0100
Message-ID: <270f27c9-afd6-171d-7dce-fe1d71dd8f9a@wizzup.org>
References: <5362c659-120f-5247-aaa5-7916229300bc@wizzup.org>
 <20200208190448.GA12984@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kmgpGVHVIQox3TvKNeb4s1LuIuChsK3yN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from a80-127-99-228.adsl.xs4all.nl ([80.127.99.228]:47072 "EHLO
        hetgrotebos.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727471AbgBHTQ7 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Sat, 8 Feb 2020 14:16:59 -0500
In-Reply-To: <20200208190448.GA12984@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, "Arthur D." <spinal.by@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kmgpGVHVIQox3TvKNeb4s1LuIuChsK3yN
Content-Type: multipart/mixed; boundary="Godpv0TubRGtGgxbDycfxXVquR7hLmF7R"

--Godpv0TubRGtGgxbDycfxXVquR7hLmF7R
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

On 08/02/2020 20:04, Pavel Machek wrote:
> Hi!
>=20
>> When booting Linux 5.4.18 with omap2plus_defconfig, I no longer get a
>> /dev/mmcblk0 device - the one corresponding to my microSD card, where
>> u-boot also loads the kernel from.
>>
>> This also likely seems to be a regression, but I haven't tried to hunt=

>> it down yet.
>>
>> Kernel log attached, below.
>=20
> Do you have back cover attached? That's common trap...

Right.

No, I did not, since I have the serial pins connected to my PC, and the
whole device is mounted on a piece of hardware for that. I thought that
we fixed the problem where we require the cover to be on...

Cheers,
Merlijn


--Godpv0TubRGtGgxbDycfxXVquR7hLmF7R--

--kmgpGVHVIQox3TvKNeb4s1LuIuChsK3yN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCXj8JbQAKCRAGN09rynK8
WkuvAP92aeI6v4uJelHIsAMscZFdCxHjD0IZxPtzpfBcUEMYygD/RQVAYQi6z9Wb
QM/geCjOCGQHtZ2b/JRQAm4KH9MlCQk=
=fUYw
-----END PGP SIGNATURE-----

--kmgpGVHVIQox3TvKNeb4s1LuIuChsK3yN--

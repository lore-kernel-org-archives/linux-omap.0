From: Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 1/3] RFC: power: supply: cpcap-battery: Add helper for
 rough capacity
Date: Tue, 21 Jan 2020 11:42:39 +0100
Message-ID: <db73a651-afc4-5c3d-0610-ccb13b8cc0d3@wizzup.org>
References: <20200119201124.29620-1-tony@atomide.com>
 <20200121095712.GC6934@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZV0UXeggGjgy0vnUD6yFk2dAym4vahIL3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from a80-127-99-228.adsl.xs4all.nl ([80.127.99.228]:53712 "EHLO
        hetgrotebos.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727255AbgAULDY (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jan 2020 06:03:24 -0500
In-Reply-To: <20200121095712.GC6934@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, "Arthur D." <spinal.by@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZV0UXeggGjgy0vnUD6yFk2dAym4vahIL3
Content-Type: multipart/mixed; boundary="QYIawYk1VfQa3SBw84dG6nrEa5eQbJzu4"

--QYIawYk1VfQa3SBw84dG6nrEa5eQbJzu4
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 21/01/2020 10:57, Pavel Machek wrote:
> Hi!
>=20
>> Get a rough battery charge estimate until we've seen a high or low
>> battery level. After that we can use the coulomb counter to calculate
>> the battery capacity.
>>
>> Note that I should probably update this to support ocv-capacity-table
>> before this makes sense to apply. With ocv-capacity-table we should be=

>> able to estimate battery state as described in the documentation for
>> Documentation/devicetree/bindings/power/supply/battery.txt.
>=20
> Maybe we should let userspace do that?
>=20
> https://github.com/pavelmachek/libbattery

Unless this gets integrated in UPower, My point of view is that
userspace probably wants some uniform approach. Kernel interface
definitely is one uniform interface that would also get picked up by UPow=
er.

Cheers,
Merlijn


--QYIawYk1VfQa3SBw84dG6nrEa5eQbJzu4--

--ZV0UXeggGjgy0vnUD6yFk2dAym4vahIL3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCXibVnwAKCRAGN09rynK8
WnHmAP0XzimrNifs/U3JxeJXPtmn/YMxwxvKMR86frWQOSJa9AEAg+x50PDiFZyk
DAn8/PMcCeHP5Bf0GxdQs/L4m5o1kwg=
=wO2z
-----END PGP SIGNATURE-----

--ZV0UXeggGjgy0vnUD6yFk2dAym4vahIL3--

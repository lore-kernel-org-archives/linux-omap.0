From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH 4/5] ARM: dts: Add basic support for omap3 LDP zoom1
 labrador
Date: Sat, 16 Nov 2013 08:04:09 +0000
Message-ID: <20131116080408.GA15300@earth.universe>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <1384562167-14725-5-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:35614 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208Ab3KPIEh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 16 Nov 2013 03:04:37 -0500
Content-Disposition: inline
In-Reply-To: <1384562167-14725-5-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2013 at 04:36:06PM -0800, Tony Lindgren wrote:
> Basic things like serial, Ethernet, MMC, NAND, DSS, touchscreen
> and GPIO keys work.
>=20
> For twl4030-keypad we're still missing the binding, but
> support for that should be trivial to add once the driver
> has been updated.

DT bindings for twl4030-keypad are being worked on:

https://lkml.org/lkml/2013/11/8/463

> MUSB I'm pretty sure I got got to enumerate once, but I
> suspect the battery charging somehow disrupts it and it's
> not enumerating in general for some reason.

Try to add this:

&usb_otg_hs {
	phys =3D <&usb2_phy>;
	phy-names =3D "usb2-phy";
};

Those were introduced by the new generic PHY framework, see
for example: https://lkml.org/lkml/2013/9/27/37

> [...]

-- Sebastian

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJShyb4AAoJENju1/PIO/qaVEgP/0fR9y8x1/QtYHzCf5GDKhlY
TK8bMRhN+hHv//qJW6J6iY9dfF7mSQCuJE0Sz8I6gC0sW1o3URlTpjgvSOQPpryY
HVyH58z1Y4TOYQ0EwLd0RNYCtJQEKV2Tyy3GG6XbGPzXC0nwsYH93qj30/LsDMDG
wNONHAgcYE33Fdok0HFgUlOicY0SuOoY4JaaLQ/UvUC6PkG+DNYoPH9iTF1aynGL
ZFI7c8prezRdhZiUw2ryJFvMZiJDIeksxOiiU0eEFBQqDnwtsIs597I4McmckK0o
Q75soJD7KbNx3UtRnzljs+d2BITCRCldaJ20jK+Lmkm45Q76t7jMBCSq4OzEf8m6
hrrVLdwokudRNejjc/yvwaePL7RZz+f5AiDsL8Ts4Ev0n2a/vVDrsoltSWPVWBDK
qEpgaSDZOY8sgv5JUQHfu19pCB04Qa+hL/lre8CrttWl4SlOKSqELvB3uCa2HrzM
tFtL9vOxkTRn9Hj9vttl3sEZALKUd+egiEReGSko15Pnewob9OXThEy+uroxHIql
nbHkun8nHLhwILUabfU4uj2lCgT0WS7l7wZjY0wX+k1VHyipdeta44DqShfDfoyP
OtQgENfd/1d4BBINqgIGiPoB7+7Gne0EdEtoq19T/XhxjemVvFklPY0n854g9AhQ
6wDphVv7DREqDTO5rld+
=eiDx
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--

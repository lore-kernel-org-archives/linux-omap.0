From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 13/26] ARM: omap3.dtsi: add omapdss information
Date: Fri, 13 Dec 2013 11:29:27 +0200
Message-ID: <52AAD377.9060701@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com> <2364383.8GWpsWSoJu@avalon> <52A9760A.3000801@ti.com> <14299863.f0rzOyPfdL@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="VjaThOAf0QrttoqA63GnM7lrhfFlQkLtr"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48841 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686Ab3LMJ3e (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Dec 2013 04:29:34 -0500
In-Reply-To: <14299863.f0rzOyPfdL@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>

--VjaThOAf0QrttoqA63GnM7lrhfFlQkLtr
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-13 05:24, Laurent Pinchart wrote:

> Right. The real question is whether the DSI or HDMI IPs can be used in =
a=20
> system without the DSS core. If not, it might make sense to just merge =
the=20
> drivers into a single module (of course with a clear interface between =
the=20
> different parts to avoid spaghetti code).

The drivers are already in single kernel module, omapdss.ko.

The HDMI IP is used on another SoC, without DSS. They have their own
display architecture. DSI IP might need some small modifications to work
without DSS, but not much. It doesn't have any strict DSS/DISPC
dependencies.

> Given that the DSS core has a set of registers not dedicated to any of =
the=20
> submodules I believe it should be represented by a device. The omapdss =
driver=20
> thus doesn't look virtual to me, it supports a real piece of hardware.

As noted in another mail, dss_core and omapdss devices are different
things. dss_core is not virtual, omapdss is.

>> But then, I feel that they are quite independent and probably should b=
e
>> separate devices.
>=20
> Even if they're separate devices they could be instantiated by DSS core=
 based=20
> on DT nodes. I'm not sure whether that's the best idea, but it might be=
 worth=20
> thinking about it.

What would be the difference to the one in this series? In this series,
the submodules are instantiated automatically by the driver framework.
The only difference I see is that the submodule devices would
appear/disappear dynamically, but... what would be the benefit?

 Tomi



--VjaThOAf0QrttoqA63GnM7lrhfFlQkLtr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSqtN3AAoJEPo9qoy8lh713FMP/1AZlldTK7n2LPizDWPJ/6LI
VNMDR10/5tDNfWt8HrW4NzSBu4mxN3+4spBJ5WrcaxaS3jNdILNeAd2lC5SsGDqo
zMV/ppvZ1K8BReg0kasl0x3j5OeNopAz39P+lMQxm0Y1Wb0HEfNjfE/+Kf5bMEoO
w0jb6h2MY1wE7LnLThK6Irq5DmjT7lhjOW6YMbKwqOotHaUqYSC/kjkR8NgJFLDa
IIAfOqrvMVBPijdx+rxyB/H77V3j6s0P0KZy+4EvEhZDos3K9Ol8sP35+tel8tRL
amctGx3e3apJw+wgUwFRVnj8U5TGrWLKptlGtVqAglr5zM2DoBthpwxytEMHRGIp
+wGXNwEotJpJLTC9FSomMGupVbxbMNI1jXNUS3QOGkeZ7SBgbZENhebm/k1xtaJf
IqDyJRMDhdzZ4xhFlya1GKaseEwPxrc/f7G3wJnPaUbepg6J+6u1w0yHB8EYT7Mz
UuMDb5FBFgP16KyJjjMudaj8U8PkqIb24JpLqdOaxNnI/q8f1yIB6T0XtCWeSyyI
vtQs/sNjprjEcEWnWrjwUc1QxbGx2QuMbwoWd0Wp4VzjABjougd5Hl61jVkeTKDW
0zm9Fl7p1p0zUxY8ICbVLC0z3iBUX/dg7fIvfA11e6P21rzfLo1gmkqNXflEgr2S
FLkrL5pVA82s8HUzV4GB
=afPU
-----END PGP SIGNATURE-----

--VjaThOAf0QrttoqA63GnM7lrhfFlQkLtr--

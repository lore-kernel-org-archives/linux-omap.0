From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: OMAP5: DSS hwmod data
Date: Wed, 12 Mar 2014 12:33:04 +0200
Message-ID: <532037E0.1080309@ti.com>
References: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="N7G4pfgKmNrMRSpVss0rXbSU1RUc4aDUG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51057 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753664AbaCLKdc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Mar 2014 06:33:32 -0400
In-Reply-To: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--N7G4pfgKmNrMRSpVss0rXbSU1RUc4aDUG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/03/14 12:26, Tomi Valkeinen wrote:
> Hi,
>=20
> This patch adds hwmod data for omap5 display subsystem. I have tested t=
his on
> omap5-uevm with a DSI panel. I cannot test omap5-uevm's hdmi output yet=
, as the
> mainline is missing omap5 HDMI driver.
>=20
> I do see this when booting:
>=20
>   omap_hwmod: dss_dispc: cannot be enabled for reset (3)
>   omap_hwmod: dss_dsi1: cannot be enabled for reset (3)
>   omap_hwmod: dss_dsi2: cannot be enabled for reset (3)
>   omap_hwmod: dss_hdmi: cannot be enabled for reset (3)
>   omap_hwmod: dss_rfbi: cannot be enabled for reset (3)
>=20
> But at least DSI works just fine.

Oh, I forgot to say that I tested this on top of the DSS DT branch, and
unpublished omap5 and omap5-uevm display patches. So if applied to the
current mainline, the hwmods are not used at all (except the reset at
boot time, I think).

But if this gets merged for 3.15, it'll make adding omap5 DSS support
easier for 3.16 as the HWMOD data is already there.

 Tomi



--N7G4pfgKmNrMRSpVss0rXbSU1RUc4aDUG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTIDfgAAoJEPo9qoy8lh71VakP/ArMU738Aeh/ErsfOm+Yv2L1
OTSMTdAur9yO3AfgrbhgYSOmhKwq+c3zEFKBgUKrQVo/ZTkyfgMoq/0B9RbAPo/t
C/8InQwqvVca775vIWvoQKydLsWT3On5ASNL71m1Ql57MMJ4Ns5ORnUCBtZ7AvCB
7QJ9UzL1250pfDttTOGS/d33bZH0o11uYqJgsi99YB7Ml/RZwEqRf+up09rweGyJ
J265K8LX1IuOWyqKc5N4JzCPkekFfEl8cm9Hn8TYFSTjOoHZKr3SDDU+Dg8WcAUN
eSfDITqj4iNoRnFHuYxVnv1VhIsE+LO3aYuJ3q/F1PzarmEdgu0JVQ5xDDjQiJiD
Nd/dj10N4jHs1wep5kLw9YPFuFOCgkv+HdWWRNXkrgPIcisrdQ0Kw3JEA2fR1mhi
8AZyjgsH8WJM+3HdeRaL+QG0+wC6FEGOPrxfi4uFP9qH8EwtLaq1SoB8QXAKpUTj
tUwtamFU9P1R4CrOMjuQsPaVnv0O3wb9UtjGSGaww94/uo10yhzSP1EqE3zAz9N5
wu5/hBxtuji1DuFGDTq5uXO6ga5GbaQpmE8eU5l8GXDb0H4dT8Q9mYFwjLoVkDTk
GsCsdq620TtbiLPi247QXH0+yh16l2Ql5QuflveVMCtgVHS+Ug3cb3hRHihdR8L+
OxexiVqOndcDYRZ+jRjc
=IxE+
-----END PGP SIGNATURE-----

--N7G4pfgKmNrMRSpVss0rXbSU1RUc4aDUG--

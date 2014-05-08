From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/2] ARM: dts: Fix OMAP3 ISP functional clock configuration
Date: Thu, 8 May 2014 13:57:15 +0300
Message-ID: <536B630B.8010303@ti.com>
References: <1398076907-2901-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="eTLk0VWgpthgllvrehgsdI2D7BD3Cemjx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48558 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbaEHK5n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2014 06:57:43 -0400
In-Reply-To: <1398076907-2901-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

--eTLk0VWgpthgllvrehgsdI2D7BD3Cemjx
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 21/04/14 13:41, Laurent Pinchart wrote:
> Hello,
>=20
> This patch set enables rate propagation from the OMAP3 ISP functional c=
lock to
> the DPLL4 M5 clock. It copies Tomi Valkeinen's similar patch set for th=
e OMAP
> DSS functional clock from the "OMAP: OMAP3 DSS related clock patches" p=
atch
> series.
>=20
> Laurent Pinchart (2):
>   ARM: dts: use ti,fixed-factor-clock for dpll4_m5x2_mul_ck
>   ARM: dts: set 'ti,set-rate-parent' for dpll4_m5 path
>=20
>  arch/arm/boot/dts/omap36xx-clocks.dtsi | 2 +-
>  arch/arm/boot/dts/omap3xxx-clocks.dtsi | 7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
>=20

These look fine to me.

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi



--eTLk0VWgpthgllvrehgsdI2D7BD3Cemjx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTa2MLAAoJEPo9qoy8lh71lRUP/1cNtBwEfJjDeXhkU+euh/3I
PIQilRd8pJ2WbnnB6nWpTkHMI2plyx0Z8r6S0VtEg7tR4kg85aB3P9IamQfHtef3
8jij1PFIoXN+jbu+Z0uZBdxjWgYWkVaq6bBRsD1d/T7ioYW3eD69qvfUm8nK/BWn
iFvatGFNRDeyDkk6Cd+StxqjMG0cg3c3vOVhei3w59Ww533LpkFudErgqcjOZCyv
fZkzriZdEa9axZaEf3QUrdwzOksVBUbzGE2FjOfET9Q0jkybxZYYL0MQJEV29Gcw
b3fEEGfT5UM9gTDGiVvbFnFvR9X6sDJWuTN8MLwq9hE04UPscrnPEPv98mDFrRki
SLRepxldhiB1aTNcg75b11f+fxpfqEmTjnm/iCZn9sZkaLVvOTs/9aEWJCstGBfd
xNuNqgQfq1eSaNjB79skxbXiR3BpaP6gdMHV6Z4gY4m3cI75qRwwCEknWWu3vDC2
dLhVYkbQpe/pg7Yo1zSzO2x3ECoXYL3E0S17rrqKrpjICBb4QwTDGT4NGeABIyPc
1+7wL5Dt0LFAEpVRTMzjR5U5yKgs6CDrvOLlWmZ8isc9JoaEHEW6qo/YhWJIB4W4
spDqmCXmCOjTcfOlis/7GC5t1Z4wKI4JPAaf43MQpIj3l3YSjnymwZjfpPZOoJUw
ZTj4Ek7GbO0m2CQ2jUPX
=/kMI
-----END PGP SIGNATURE-----

--eTLk0VWgpthgllvrehgsdI2D7BD3Cemjx--

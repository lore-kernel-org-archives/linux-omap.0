From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/2] ARM: dts: Fix OMAP3 ISP functional clock configuration
Date: Tue, 13 May 2014 01:16:51 +0200
Message-ID: <8771357.o1oFFUoBzb@avalon>
References: <1398076907-2901-1-git-send-email-laurent.pinchart@ideasonboard.com> <536B630B.8010303@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7842628.5t6yqtQnxf"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:52816 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbaELXRD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 19:17:03 -0400
In-Reply-To: <536B630B.8010303@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--nextPart7842628.5t6yqtQnxf
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Thursday 08 May 2014 13:57:15 Tomi Valkeinen wrote:
> On 21/04/14 13:41, Laurent Pinchart wrote:
> > Hello,
> >=20
> > This patch set enables rate propagation from the OMAP3 ISP function=
al
> > clock to the DPLL4 M5 clock. It copies Tomi Valkeinen's similar pat=
ch set
> > for the OMAP DSS functional clock from the "OMAP: OMAP3 DSS related=
 clock
> > patches" patch series.
> >=20
> > Laurent Pinchart (2):
> >   ARM: dts: use ti,fixed-factor-clock for dpll4_m5x2_mul_ck
> >   ARM: dts: set 'ti,set-rate-parent' for dpll4_m5 path
> > =20
> >  arch/arm/boot/dts/omap36xx-clocks.dtsi | 2 +-
> >  arch/arm/boot/dts/omap3xxx-clocks.dtsi | 7 ++++---
> >  2 files changed, 5 insertions(+), 4 deletions(-)
>=20
> These look fine to me.
>=20
> Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Thank you.

Tony, could you please pick the patches up for v3.16 ?

=2D-=20
Regards,

Laurent Pinchart

--nextPart7842628.5t6yqtQnxf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTcVZvAAoJEIkPb2GL7hl1bvEH/0dYE64IravVNWdw4gZ5kkNw
MPUGWnlro6yjEkqgPJ3AS0G5RM8EvpCyWBvMHzdRcaifdsDNcVAtR4n1pkyzxgP2
IBz3Yb+Qx8vom0XLQH8PztwWBY2FFqn2ap7m07r0/uNRuW8fiMqFAspEBP8BRK7r
W1vp/SaZlk9Alf3loqof4ni2KaOtb3nj1l1NRA4VuOfZdXLVLn1NMcZxsruKCPVB
YDDlCXxgMOGWLDY1oWbauYqhA/nzyjwJCqUk4FwEqmUiNC5YfVgzybL0tfsso9hI
grLpVlawV41b/kP7E7Rvqg9tLIBn6I/O5PP1r8VNWTaxGGElVYTNchmN3veuZqM=
=RKQD
-----END PGP SIGNATURE-----

--nextPart7842628.5t6yqtQnxf--


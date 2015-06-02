From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: am4372: Add emif node
Date: Tue, 2 Jun 2015 14:22:28 -0500
Message-ID: <20150602192228.GF9623@saruman.tx.rr.com>
References: <1430933133-33412-1-git-send-email-d-gerlach@ti.com>
 <1430933133-33412-3-git-send-email-d-gerlach@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y1L3PTX8QE8cb2T+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48634 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942AbbFBTZD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jun 2015 15:25:03 -0400
Content-Disposition: inline
In-Reply-To: <1430933133-33412-3-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

--Y1L3PTX8QE8cb2T+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2015 at 12:25:33PM -0500, Dave Gerlach wrote:
> Add node for TI AM4372 EMIF.
>=20
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>

Tony, this patch fixes the regression I just reported at [1], care to
pick this one up ?

Tested-by: Felipe Balbi <balbi@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>

[1] http://marc.info/?l=3Dlinux-omap&m=3D143327283632248&w=3D2

> ---
>  Documentation/devicetree/bindings/memory-controllers/ti/emif.txt | 1 +
>  arch/arm/boot/dts/am4372.dtsi                                    | 6 +++=
+++
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/memory-controllers/ti/emif=
=2Etxt b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
> index 938f8e1..0db6047 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
> @@ -8,6 +8,7 @@ of the EMIF IP and memory parts attached to it.
>  Required properties:
>  - compatible	: Should be of the form "ti,emif-<ip-rev>" where <ip-rev>
>    is the IP revision of the specific EMIF instance.
> +		  For am437x should be ti,emif-am4372.
> =20
>  - phy-type	: <u32> indicating the DDR phy type. Following are the
>    allowed values
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index c80a3e2..9521a38 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -132,6 +132,12 @@
>  			};
>  		};
> =20
> +		emif: emif@4c000000 {
> +			compatible =3D "ti,emif-am4372";
> +			reg =3D <0x4c000000 0x1000000>;
> +			ti,hwmods =3D "emif";
> +		};
> +
>  		edma: edma@49000000 {
>  			compatible =3D "ti,edma3";
>  			ti,hwmods =3D "tpcc", "tptc0", "tptc1", "tptc2";
> --=20
> 2.3.6
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--Y1L3PTX8QE8cb2T+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbgJzAAoJEIaOsuA1yqRERzEP/3Uy6A5/GX/7UbcHtYjWydIz
hpLseuoOr4/228pA8oqd4VcTJZcPVDXifjhPFNc1klXCjfRnj1iWItxQS7irKQqx
wT3YNmOVn3qqz6EPGCb4ZVuFVzx2qAQp0njaFVuvgcPCTdFwusLlN+iOmCnhUwhr
IneJY2ISDmnsMPOxNGhN9b7oSVwjmcDPMSdkl5g5EY+Yg8Jn+VwzIo4bgrhQNxsg
lLMNUevwCIQHsIOhNZS0C3XZutrfWEjz3b2Y08WjObTo1F8unudzdbrgm4CSF22G
f/AQIgiWnNRfYPp2g83VtXuUm6iKruen3qyNaITZOcCV7aFx2bkzSD20GxQBkFFX
xVwxnvy0EIJCvSNeLofMMUd8ra/Ex/cNh4kQS6VL77R4ZMCK+mnJ6Ob5myMVk1No
vGTvBG60v9yu7Oz+y4NnNsgHobpZ5X+NguBzjEUuSTsMe4bFEUhBNDNpZTM9bMPd
cqWvAP11tXllsEoPhlgAsJYkALRcq5y3fXnEA7UXdDZ4dyqoy4LrpHkuQUmjYvY0
tJvsVbDvH0VVJiKuPi+1Iy8Evnn9cxBuK9XsVGA43f2SncapNEZKhJeP+tB7Pfmx
F4epcsKQAqEQScovZ1gCn3xF/b3ywHTZpy85j2kdE3OBmfIgKRzb8mxFF+iLUjBC
Pq8JjQDDEP0Q4J6IXZiW
=Nijk
-----END PGP SIGNATURE-----

--Y1L3PTX8QE8cb2T+--

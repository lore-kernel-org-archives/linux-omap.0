From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/7] regulator: Add DT bindings for tps65218 PMIC
 regulators.
Date: Tue, 8 Jul 2014 08:37:38 -0500
Message-ID: <20140708133738.GD25811@saruman.home>
References: <1404814597-4404-1-git-send-email-j-keerthy@ti.com>
 <1404814597-4404-3-git-send-email-j-keerthy@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404814597-4404-3-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 08, 2014 at 03:46:32PM +0530, Keerthy wrote:
> Add DT bindings for tps65218 PMIC regulators.
>=20
> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

> ---
>=20
> Changes in V2:
>   * Added dcdc3, dcdc5, dcdc6 compatible properties.
>=20
>  .../devicetree/bindings/regulator/tps65218.txt     |   23 ++++++++++++++=
++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/tps65218.=
txt
>=20
> diff --git a/Documentation/devicetree/bindings/regulator/tps65218.txt b/D=
ocumentation/devicetree/bindings/regulator/tps65218.txt
> new file mode 100644
> index 0000000..fccc1d2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/tps65218.txt
> @@ -0,0 +1,23 @@
> +TPS65218 family of regulators
> +
> +Required properties:
> +For tps65218 regulators/LDOs
> +- compatible:
> +  - "ti,tps65218-dcdc1" for DCDC1
> +  - "ti,tps65218-dcdc2" for DCDC2
> +  - "ti,tps65218-dcdc3" for DCDC3
> +  - "ti,tps65218-dcdc4" for DCDC4
> +  - "ti,tps65218-dcdc5" for DCDC5
> +  - "ti,tps65218-dcdc6" for DCDC6
> +  - "ti,tps65218-ldo1" for LDO1
> +
> +Optional properties:
> +- Any optional property defined in bindings/regulator/regulator.txt
> +
> +Example:
> +
> +	xyz: regulator@0 {
> +		compatible =3D "ti,tps65218-dcdc1";
> +		regulator-min-microvolt  =3D <1000000>;
> +		regulator-max-microvolt  =3D <3000000>;
> +	};
> --=20
> 1.7.9.5
>=20

--=20
balbi

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTu/QiAAoJEIaOsuA1yqRErmgQAIe5s2Rb5VRYdMN1OiQacf+b
PqPhc2y8SccaHlIMFKewDeIxdxfS/j2oabHRrvDolO+tNOOIACIz3YMlkSJRsMEU
69C0NLtX+5sNuSz5gXPRnTDt1vbeowvW9DZzZoEwsbQWAlRlTvPNbDIIPN5jVj68
wkbSVt4sjVkg+fKr0OOxwjo1dzy6Jxk8WhM+Ch0Xw2YucdrKj5LX3825+DsmUOVF
VRup95GAr2HQSaMmCtDjHSPg29bvpEnGITiMhcPF5SVMmTlRh6gBdzSxId8twbc8
xPgBOGHkloJNyL/hu/82DoRZNXJBFT0Aw6lcKDrv92ZBCNJ4FTzqXIHBeHA5DcmT
2O/aHW94qqrN8CpCba5jaUXpkeBb4m7kmTIsPLqFzvfBK7pKz8LapRxWB8GahylD
OlsyoCmWazuNErTwlCbmZSDXUwWazU1Mrpb2sQA3xlGEL3+6s1LPpgcXWbvgN5PA
vatV9cZm71w0MiFuDjD99XBHSekU9TPG4MhO6mYuVqFreLFEm/+Yx5H7TQ+Xtkud
PxyvFaIxWY3NDJsbVuvVszBMtLFMtMrrW5QbPfLCCUAnXTJFkZHX0H7/wNH5/dYg
ve6Cv27dMod2ytLY7+cSBRsrA7fYJRB/x9V97GKpegGSjzP+WDTeeLEMmnSGTOUl
uJNDfnbOdJ8tJ6mVPx8n
=5hYv
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

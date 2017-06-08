From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] power: supply: cpcap-battery: Add a battery driver
Date: Thu, 8 Jun 2017 23:26:05 +0200
Message-ID: <20170608212605.szsva63owfwqurpv@earth>
References: <20170519055146.2038-1-tony@atomide.com>
 <20170520170533.GN10472@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7twhhxwypvi7pfcr"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170520170533.GN10472-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--7twhhxwypvi7pfcr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 20, 2017 at 10:05:33AM -0700, Tony Lindgren wrote:
> I guess we should leave out the interrupts in the binding for now
> too. Or at least move them to optional properties.
>=20
> Anyways, below is the related dts patch I've been using.

> 8< -------------------------
> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Date: Fri, 19 May 2017 14:23:25 -0700
> Subject: [PATCH] ARM: dts: omap4-droid4: Configure CPCAP battery driver
>=20
> Configure CPCAP battery driver.
>=20
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/bo=
ot/dts/motorola-cpcap-mapphone.dtsi
> --- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
> +++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
> @@ -26,6 +26,21 @@
>  			#io-channel-cells =3D <1>;
>  		};
> =20
> +		cpcap_battery: battery {
> +			compatible =3D "motorola,cpcap-battery";
> +			interrupts-extended =3D <
> +				&cpcap 5 0 &cpcap 3 0
> +				&cpcap 20 0 &cpcap 54 0
> +			>;
> +			interrupt-names =3D
> +				"lowbph", "lowbpl",
> +				"chrgcurr1", "battdetb";
> +			io-channels =3D <&cpcap_adc 0 &cpcap_adc 1
> +				       &cpcap_adc 5 &cpcap_adc 6>;
> +			io-channel-names =3D "battdetb", "battp",
> +					   "chg_isense", "batti";

missing

power-supplies =3D <&cpcap_charger>;

> +		};
> +
>  		cpcap_charger: charger {
>  			compatible =3D "motorola,mapphone-cpcap-charger";
>  			interrupts-extended =3D <

-- Sebastian

--7twhhxwypvi7pfcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk5wOwACgkQ2O7X88g7
+pq1mw//d2UN4XSKIyPAwk1b4BDDqS1APQ3jICoHu4N9TlWsxlZHBN5qvgOmri4P
KrgC9G9NpRzbE3O6FGya+WxvYI7Ohtc1Gr9WfOBsiwWIGEbrh3i4zcd//4sydYQt
1Rq9F9mFR6tTjZhrle6eWxBAIKcxfK4yw5uKKXXXHuuOFN6iaiATCI4jqkA5YD0q
FYQnC9z3QDFZD6/sQGlDpfdVFJgNJGcstC5hbe5XkCTsNChrSaoi65SozI5VInd+
7aXCYYyTeEZAF1cOK9pBwldE59KlCHDrhtJcoXTjxDV3xbG1DgNVY/YDpy6QM79P
gGnZQfE91hjZeKCsc/6eG+bj/XBkgcup+GpkWqRdwubTF/kOpSP44jVzECruaTaq
JY24idENnNCXql61DBl9LXYv8GAETV+/sOWFY8X7MX+0YlvOezTmESDWsp42OLB2
rBUUWYQ5Tr97lA+qAE7KsMhjlxJFuWzCgguxPgTIyBHCLktEM6TpMXbrLmJRJTxv
nftlcN1gk7xCc7ZMYNvDCXA9tX33wpqVW8jyklDQO4avJ2wR+d2/9N8qzOXzTXyD
ReHpD2H8427oLy5Eo6KfDusizXa5mn5fygGXM3Ug+Jod0V38Ht+3I4JRejogX29j
GtZxoVABPqFczpZfV5RprXhtL5qltxc42ZDNE5E0PgHimq31Ihw=
=8UiL
-----END PGP SIGNATURE-----

--7twhhxwypvi7pfcr--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

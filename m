From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] ARM: dts: omap4-droid4: Add CPCAP PMIC battery
 charger configuration
Date: Wed, 22 Mar 2017 03:20:08 +0100
Message-ID: <20170322022008.gwofxgo6h4c42is4@earth>
References: <20170317041012.26800-1-tony@atomide.com>
 <20170317041012.26800-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tzakymahjkkwsfba"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170317041012.26800-3-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--tzakymahjkkwsfba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 16, 2017 at 09:10:11PM -0700, Tony Lindgren wrote:
> Add CPCAP PMIC battery charger configuration.
>=20
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Reviewed-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Tested-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> ---
>  arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/bo=
ot/dts/motorola-cpcap-mapphone.dtsi
> --- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
> +++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
> @@ -26,6 +26,25 @@
>  			#io-channel-cells =3D <1>;
>  		};
> =20
> +		cpcap_charger: charger {
> +			compatible =3D "motorola,mapphone-cpcap-charger";
> +			interrupts-extended =3D <
> +				&cpcap 13 0 &cpcap 12 0 &cpcap 29 0 &cpcap 28 0
> +				&cpcap 22 0 &cpcap 20 0 &cpcap 19 0 &cpcap 54 0
> +			>;
> +			interrupt-names =3D
> +				"chrg_det", "rvrs_chrg", "chrg_se1b", "se0conn",
> +				"rvrs_mode", "chrgcurr1", "vbusvld", "battdetb";
> +			mode-gpios =3D <&gpio3 29 GPIO_ACTIVE_LOW
> +				      &gpio3 23 GPIO_ACTIVE_LOW>;
> +			io-channels =3D <&cpcap_adc 0 &cpcap_adc 1
> +				       &cpcap_adc 2 &cpcap_adc 5
> +				       &cpcap_adc 6>;
> +			io-channel-names =3D "battdetb", "battp",
> +					   "vbus", "chg_isense",
> +					   "batti";
> +		};
> +
>  		cpcap_regulator: regulator {
>  			compatible =3D "motorola,mapphone-cpcap-regulator";
> =20
> --=20
> 2.11.1

--tzakymahjkkwsfba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljR31gACgkQ2O7X88g7
+pqXUA/5AUaguKYHpZmXjuaNGzAFuoiQMJ1915yXrSKQcMMXwr+S3e/Ju8Ry55IH
eO071b0gAjcI23ASQ+TFBELT4tTaA7inbAEhGnKmRb9zYIOtRWWyOXVBk56vrH9m
MIdCkiFxaM5WIASDbzAoE08ChBY80UtyUFLyJsbVzX7f5nWD0xe7RO4lLvACMufg
euqOSVrNv6ivHBox4YX5D7ZYxiYc+aYvln+HTbMtbfQM2oDQIjXMytKfHIECJH1+
X8pjnUwYuFBq9kwZCP/sAIcAZwwaRLW4P5zlOsOnerreFN/h0vqMUbpdap6glw5J
jPc1l7uOPp/v9/5cycArkYUdhIZHRgIjw9Ly9iOSVZWAm/15AG58NsbHSKLHlLFJ
Mn/vpt1gQc4s+Gd8BP13IYqeJdLvsFdoAK9EUhZJH+5eBS+zvUOINtYm+uqNZwVB
uO535sZcgk34wgLPUkiDqp+7hL0Tacl++kZU3JjCJow1MSfmUEtghniN64mNFWf8
GOMeTQmS7J56OOGT6ZXCnREkIsoIGIpma5S3PfQz28/Il9SH6ZgNzscUX/5xU3NA
BV2Q6NBVQkMgio7r29bwoFlP0/q6ZOM2gf0Si8b0EWlN2pPdo1w37RIds5Tq0g4x
xqhTLbxCW/8M4tACRHR1sCVGQePOQQ/ocI0+rao1TscsfQlECCs=
=Zr9f
-----END PGP SIGNATURE-----

--tzakymahjkkwsfba--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

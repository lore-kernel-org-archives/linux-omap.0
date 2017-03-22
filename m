From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: dts: omap4-droid4: Add CPCAP PMIC ADC
 configuration
Date: Wed, 22 Mar 2017 03:19:41 +0100
Message-ID: <20170322021941.qxfggbcaw4fepiuy@earth>
References: <20170317041012.26800-1-tony@atomide.com>
 <20170317041012.26800-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xvoimker5rc3pvze"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170317041012.26800-2-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--xvoimker5rc3pvze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 16, 2017 at 09:10:10PM -0700, Tony Lindgren wrote:
> Add CPCAP PMIC ADC configuration.
>=20
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Reviewed-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Tested-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> ---
>  arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/bo=
ot/dts/motorola-cpcap-mapphone.dtsi
> --- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
> +++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
> @@ -19,6 +19,13 @@
>  		spi-max-frequency =3D <3000000>;
>  		spi-cs-high;
> =20
> +		cpcap_adc: adc {
> +			compatible =3D "motorola,mapphone-cpcap-adc";
> +			interrupts-extended =3D <&cpcap 8 0>;
> +			interrupt-names =3D "adcdone";
> +			#io-channel-cells =3D <1>;
> +		};
> +
>  		cpcap_regulator: regulator {
>  			compatible =3D "motorola,mapphone-cpcap-regulator";
> =20
> --=20
> 2.11.1

--xvoimker5rc3pvze
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljR3z0ACgkQ2O7X88g7
+pq+tw//bS5eozjefbyhbqfwyqWPioHDATd3mvtuy5jaT+lKZGNmchoelymeaHNc
DGQvJq1ib3OCyo79sSS7jZn+XR+IZy7nWGf1MBM1x5llhmtAidhrpXdCwZoXPW5k
7yX+eW3EGUm7+k0HjmN6P+/XzPuuxmnHpTYDVXbvhrIzhmdFBow8DsO6bCXWtcum
PyUnqENqtHwmVQD8oiCz8mG15dnsbFG6pLFhyzyhx+Wm1VviWj4HkHzj7kgEVqnN
zyfFruet6o9W6VZ+mPwOdmmm/80jvLnftDhDxN6hR4Q5U7qrcjJA5FFMv7TAcxI6
iTWwgXQTF0sfl3lQ0Y4i6VXtKk2eA3ekNB3ACuzwdA32zPwvePcULf/JmLqtZNhd
Y+66H0s+0XaqxNAFzD3BtKuzfAQslC3ZWEWY/qp01lQUxQQlBn+fOqavMwcyoa2S
Mu6XcNMhduEME4lxD8nE8mkXeetOvLAUuYEFLMHx90/0SeCy9syBDbE7z9rkhLpz
xqTFV9dBcQooF0/ytI0/Or4PsQRrUicVqGf3dJxaNWbaZ4b59L4Bf29sg0KtHFSr
zJEAHvQO2Bd5Z8dvp4i5DAz1FM0UCMTx/40YKeRz9JTh6tEDNTDdJrMCSJm0DisY
ysPrySTiZRyDgsE/wnyVuFkutBpbhbJAtfjFiOZl+AdknEXe0xo=
=qKwc
-----END PGP SIGNATURE-----

--xvoimker5rc3pvze--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

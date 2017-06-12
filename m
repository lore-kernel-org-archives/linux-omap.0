From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: omap4-droid4: Configure CPCAP battery driver
Date: Mon, 12 Jun 2017 16:15:39 +0200
Message-ID: <20170612141539.yskljy4qqewiqc5u@earth>
References: <20170612072138.30203-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lgv5vmkaaendqmtm"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170612072138.30203-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--lgv5vmkaaendqmtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 12, 2017 at 12:21:38AM -0700, Tony Lindgren wrote:
> Configure CPCAP battery driver.
>=20
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Reviewed-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

-- Sebastian

> ---
>  arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/bo=
ot/dts/motorola-cpcap-mapphone.dtsi
> --- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
> +++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
> @@ -26,6 +26,22 @@
>  			#io-channel-cells =3D <1>;
>  		};
> =20
> +		cpcap_battery: battery {
> +			compatible =3D "motorola,cpcap-battery";
> +			interrupts-extended =3D <
> +				&cpcap 6 0 &cpcap 5 0 &cpcap 3 0
> +				&cpcap 20 0 &cpcap 54 0
> +			>;
> +			interrupt-names =3D
> +				"eol", "lowbph", "lowbpl",
> +				"chrgcurr1", "battdetb";
> +			io-channels =3D <&cpcap_adc 0 &cpcap_adc 1
> +				       &cpcap_adc 5 &cpcap_adc 6>;
> +			io-channel-names =3D "battdetb", "battp",
> +					   "chg_isense", "batti";
> +			power-supplies =3D <&cpcap_charger>;
> +		};
> +
>  		cpcap_charger: charger {
>  			compatible =3D "motorola,mapphone-cpcap-charger";
>  			interrupts-extended =3D <
> --=20
> 2.13.0
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--lgv5vmkaaendqmtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk+ogYACgkQ2O7X88g7
+pruiw//bIFkDjlba4aMryBkWBnmKTvQWkA0bqD3dK6fAko8/4k2tuBP9UvU1TnK
NGUEj7hJGVdSr4HfE5jYghEki9/wXkjOPjB8PSGIMsO/u2e7lr9Mv/mcwybYg4YD
+WMo92mzoGEZkxIsezIDx32OFOoSDjfDFagBoaDbRyR47Eim2NoTmDZSAWuCCwuF
HGD7qmDIBQg0Zbd8qAPQQhr5UOQv6sGzl8e4qjc9DtBeJ9hEsPWqjQijqnPcl9Wv
74aNS82gDZkshkXV68hosJrKogU1bq+AvfNplt3VXxwrKZZ45CyZxQ5Dj+fD+hvq
0voOHer6nwxrwsvm7E6TaxYIlwRPX1khiJuGpFm1fTyKL03h2hUTbHRcdM97N+D3
pnglLH8IlFxn27fE33p6d5rvLDVCl3L0lhlrBukFn+zsv6ThNvoXWoFWEnYk63gN
u8t9aMeldMYU1nfEc4lQH5o8Cld1Cl5gq1fu6AMeMvYqXsM/FS69L9e9ElO0R2c/
4Cu6YefStKUbN/E4gsuYv8ApkfrLDaQQqc7Tm5kwCXfkyAPRw1ACfrfmLj1rYha9
Fm5GBQWopBs2F8Ntmm2eRH7l9UmPvp+r0IAXOZH6CXKje5DstN7KbejUroH1QCV1
JWai8PKMt1Buz0J8zSxljIpEdNzr6+ZVqp+q36ism0wQmXH8KIc=
=1Mfv
-----END PGP SIGNATURE-----

--lgv5vmkaaendqmtm--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

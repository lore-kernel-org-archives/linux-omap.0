From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: omap4-droid4: Stop disabling SRAM and GPMC
Date: Tue, 18 Apr 2017 14:17:09 +0200
Message-ID: <20170418121709.fttvxuhrjo3d2vd3@earth>
References: <20170328004612.16350-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cjxcofgx4cqdpcrz"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170328004612.16350-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--cjxcofgx4cqdpcrz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 27, 2017 at 05:46:12PM -0700, Tony Lindgren wrote:
> I disabled SRAM and GPMC originally when seeing errors with
> omap_barriers_init(). But that is no longer happening probably
> because the memory range is now properly configured to 1021 MB
> instead of 1024 MB. So let's enable SRAM and GPMC so we get
> omap_barriers_init() working and can idle the GPMC.
>=20
> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Tested-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

-- Sebastian

>  arch/arm/boot/dts/omap4-droid4-xt894.dts | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts=
/omap4-droid4-xt894.dts
> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -24,8 +24,7 @@
> =20
>  	/*
>  	 * We seem to have only 1021 MB accessible, 1021 - 1022 is locked,
> -	 * then 1023 - 1024 seems to contain mbm. For SRAM, see the notes
> -	 * below about SRAM and L3_ICLK2 being unused by default,
> +	 * then 1023 - 1024 seems to contain mbm.
>  	 */
>  	memory {
>  		device_type =3D "memory";
> @@ -176,11 +175,6 @@
>  	};
>  };
> =20
> -/* L3_2 interconnect is unused, SRAM, GPMC and L3_ICLK2 disabled */
> -&gpmc {
> -	status =3D "disabled";
> -};
> -
>  &hdmi {
>  	status =3D "okay";
>  	pinctrl-0 =3D <&dss_hdmi_pins>;
> @@ -356,11 +350,6 @@
>  	};
>  };
> =20
> -/* L3_2 interconnect is unused, SRAM, GPMC and L3_ICLK2 disabled */
> -&ocmcram {
> -	status =3D "disabled";
> -};
> -
>  &omap4_pmx_core {
> =20
>  	/* hdmi_hpd.gpio_63 */
> --=20
> 2.12.1

--cjxcofgx4cqdpcrz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlj2A78ACgkQ2O7X88g7
+posVA//TGJieDOeTAEk9JcC0mDoWzlQ5k8vzmGiSKi+G06YkFgFGwDkbT5GsfDv
7/HWbu1vJJD3wdJE10bgOyLW6CPt7Kd5GVKW8TJkDJstKvDuC15g09YChCNovpaD
1zzfqCHATZzl206YJKLFsQOlG+WaBaVjFO/odYfTrFSJhablI/JuWNY0hGrQxyUp
ZXbV6C9F2z92tt/jFaN1aOQNLmVroLiEgssSBtN1kfodkZXLA0Fbx0fVtjj8Kcoi
dQs2RbDSXVulKfKOics3MFCyXhk+rca/iGROnLJ49pAz8+0fD0x4iPwOfFEn2hQ6
AfEeOqus6Re38CleRiSM3/sOY85DQv/6CVJUJ2F8LIniPgwjycloX7OUHJD4MOx+
YsUrMuD5Zaoy6CKaLfGWhARKKwnjL0l6efSnQ0e7nqAOTMGEfY5ljqCGldPSKsnD
19l5C9FEtrsSeTTZhB8Lw3AIk0o6o/0GwHZyETp9PdwqwqKjmtLuhMGEyEcFmZF/
3tmedDmsMMbR4ze7gEw4iQIYWbn4NDL+LtN03tVZ9V6DDUXHm1r9XPk/5oX6GXNX
zfTIiuAYQ/jMBnZX+fDVMvch93rM6zyiZJFPhpa8o7lw9ib8nqkqQSN45mfHKhHH
CLabg1eYB2LCCGnuFMUCOUpUEzU66f1n9/VYvljVl8maUac4zo0=
=c4j/
-----END PGP SIGNATURE-----

--cjxcofgx4cqdpcrz--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

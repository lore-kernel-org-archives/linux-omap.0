From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv3 4/6] omap3: pmic: add API to get common SMPS regulators
Date: Mon, 18 Jul 2011 21:23:48 +0300
Message-ID: <20110718182347.GK25081@legolas.emea.dhcp.ti.com>
References: <1311010522-5868-1-git-send-email-t-kristo@ti.com>
 <1311010522-5868-5-git-send-email-t-kristo@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g4MvFqI7wmANiPDo"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:34682 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751469Ab1GRSXx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jul 2011 14:23:53 -0400
Received: by eyd10 with SMTP id 10so2317110eyd.1
        for <linux-omap@vger.kernel.org>; Mon, 18 Jul 2011 11:23:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311010522-5868-5-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, toddpoynor@google.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com


--g4MvFqI7wmANiPDo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 18, 2011 at 08:35:20PM +0300, Tero Kristo wrote:
> diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-c=
ommon.h
> index 5e83a5b..fde8467 100644
> --- a/arch/arm/mach-omap2/twl-common.h
> +++ b/arch/arm/mach-omap2/twl-common.h
> @@ -25,6 +25,11 @@
>  #define TWL_COMMON_REGULATOR_VPLL1	(1 << 4)
>  #define TWL_COMMON_REGULATOR_VPLL2	(1 << 5)
> =20
> +/* TWLxxxx SMPS regulators */
> +#define SMPS_COMMON_REGULATOR_MPU	(1 << 0)
> +#define SMPS_COMMON_REGULATOR_CORE	(1 << 1)
> +#define SMPS_COMMON_REGULATOR_IVA	(1 << 2)
> +#define SMPS_COMMON_REGULATOR_MPU_IVA	(1 << 3)
> =20
>  struct twl4030_platform_data;
> =20
> @@ -56,4 +61,13 @@ void omap3_pmic_get_config(struct twl4030_platform_dat=
a *pmic_data,
>  void omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
>  			   u32 pdata_flags, u32 regulators_flags);
> =20
> +void omap_pmic_get_smps_config(struct platform_device *smps_dev,
> +				u32 smps_flags);
> +
> +static inline void omap3_pmic_get_smps_config(struct platform_device *sm=
ps_dev)
> +{
> +	omap_pmic_get_smps_config(smps_dev, SMPS_COMMON_REGULATOR_MPU_IVA |
> +		SMPS_COMMON_REGULATOR_CORE);
> +}

if these are specific to OMAP SoC, why do they come on twl-common.h
header ?

--=20
balbi

--g4MvFqI7wmANiPDo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOJHozAAoJEAv8Txj19kN1qEIH/A0jIzL2OES9PNDPoqX5YbtK
50DxFYwEoSFXrmvdKT0y6x76jgVgsKtcfgGIO2gHkg78Mwxpsyb3XRXe46AEFXRj
DXKyDP70GlAbj9Bx1RohpepOZjrKn7sOKjJ+yXId/euZGwc7vH4fO19R1Bdi1/Hq
vJkGJSCRxdy+t2ECTOa149il/+4fWo93hzpAshuNuOqz2c6wbJlRHF1tBBUCqe3L
owGwPgIsdpO9Jvce30gweqsUqU1DfTMRImUJp6xkBRHviJCN0iBWthRUIetFM41h
mShhWycuaKfo5BEn8ZgLmGOfLtqnbVFxPFHdfg4MFPxYja9i1PrOhvJKuO3dSE4=
=7Znb
-----END PGP SIGNATURE-----

--g4MvFqI7wmANiPDo--

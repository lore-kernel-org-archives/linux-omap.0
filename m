From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3] ARM: omap2: twl-common: Add default power configuration
Date: Wed, 3 Apr 2013 14:27:28 +0200
Message-ID: <515C2030.7090809@ti.com>
References: <1364990351-6778-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53885 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762456Ab3DCM1f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Apr 2013 08:27:35 -0400
In-Reply-To: <1364990351-6778-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>

Whata...

On 04/03/2013 01:59 PM, Peter Ujfalusi wrote:
> From: Matthias Brugger <matthias.bgg@gmail.com>
>=20
> This patch adds a generic power script configuration.
> When rebooting an OMAP3530 at 125 MHz, the reboot hangs.
> With the generic power script, TWL4030 will be reset
> when a warm reset occures. This way the OMAP3530 does not
> hang on reboot.
>=20
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Tony, Matthias,
>=20
> Changes since v2:
> - remove the __initdata from all the structures introduced by this pa=
tch
>=20
> Regards,
> Peter
>=20
>  arch/arm/mach-omap2/twl-common.c | 38 ++++++++++++++++++++++++++++++=
++++++++
>  arch/arm/mach-omap2/twl-common.h |  1 +
>  2 files changed, 39 insertions(+)
>=20
> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/t=
wl-common.c
> index 51e138c..7551bbc 100644
> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -121,6 +121,41 @@ static struct twl4030_audio_data omap3_audio_pda=
ta =3D {
>  	.codec =3D &omap3_codec,
>  };
> =20
> +static struct twl4030_ins wrst_seq[] __initdata =3D {

The __initdata remained :o

Will resend it.

> +	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_OFF), 2},
> +	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_WRST), 15},
> +	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_WRST), 15},
> +	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_WRST), 0x60},
> +	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
> +	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2},
> +};
> +
> +static struct twl4030_script wrst_script __initdata =3D {
> +	.script =3D wrst_seq,
> +	.size	=3D ARRAY_SIZE(wrst_seq),
> +	.flags	=3D TWL4030_WRST_SCRIPT,
> +};
> +
> +static struct twl4030_script *omap3_power_scripts[] __initdata =3D {
> +	&wrst_script,
> +};
> +
> +static struct twl4030_resconfig omap3_rconfig[] __initdata =3D {
> +	{ .resource =3D RES_HFCLKOUT, .devgroup =3D DEV_GRP_P3, .type =3D -=
1,
> +		.type2 =3D -1 },
> +	{ .resource =3D RES_VDD1, .devgroup =3D DEV_GRP_P1, .type =3D -1,
> +		.type2 =3D -1 },
> +	{ .resource =3D RES_VDD2, .devgroup =3D DEV_GRP_P1, .type =3D -1,
> +		.type2 =3D -1 },
> +	{ 0, 0},
> +};
> +
> +static struct twl4030_power_data omap3_power_pdata __initdata =3D {
> +	.scripts	=3D omap3_power_scripts,
> +	.num		=3D ARRAY_SIZE(omap3_power_scripts),
> +	.resource_config =3D omap3_rconfig,
> +};
> +
>  static struct regulator_consumer_supply omap3_vdda_dac_supplies[] =3D=
 {
>  	REGULATOR_SUPPLY("vdda_dac", "omapdss_venc"),
>  };
> @@ -225,6 +260,9 @@ void __init omap3_pmic_get_config(struct twl4030_=
platform_data *pmic_data,
>  	if (pdata_flags & TWL_COMMON_PDATA_AUDIO && !pmic_data->audio)
>  		pmic_data->audio =3D &omap3_audio_pdata;
> =20
> +	if (pdata_flags & TWL_COMMON_PDATA_POWER && !pmic_data->power)
> +		pmic_data->power =3D &omap3_power_pdata;
> +
>  	/* Common regulator configurations */
>  	if (regulators_flags & TWL_COMMON_REGULATOR_VDAC && !pmic_data->vda=
c)
>  		pmic_data->vdac =3D &omap3_vdac_idata;
> diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/t=
wl-common.h
> index 24b65d0..b64590b8 100644
> --- a/arch/arm/mach-omap2/twl-common.h
> +++ b/arch/arm/mach-omap2/twl-common.h
> @@ -7,6 +7,7 @@
>  #define TWL_COMMON_PDATA_BCI		(1 << 1)
>  #define TWL_COMMON_PDATA_MADC		(1 << 2)
>  #define TWL_COMMON_PDATA_AUDIO		(1 << 3)
> +#define TWL_COMMON_PDATA_POWER		(1 << 4)
> =20
>  /* Common LDO regulators for TWL4030/TWL6030 */
>  #define TWL_COMMON_REGULATOR_VDAC	(1 << 0)
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

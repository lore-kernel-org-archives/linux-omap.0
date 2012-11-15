From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: omap_twl: Change TWL4030_MODULE_PM_RECEIVER
 to TWL_MODULE_PM_RECEIVER
Date: Thu, 15 Nov 2012 09:10:30 +0100
Message-ID: <50A4A376.3020703@ti.com>
References: <1352799152-20980-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40290 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992899Ab2KOIKg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 03:10:36 -0500
In-Reply-To: <1352799152-20980-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@ti.com>

Hi Tony,

On 11/13/2012 10:32 AM, Peter Ujfalusi wrote:
> To facilitate upcoming cleanup in twl stack.
> No functional change.

Would you please consider this patch for 3.8? It would shorten the time=
 I'll
need to progress on the cleanup regarding to twl-core greatly.

Thank you,
P=E9ter

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/mach-omap2/omap_twl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/oma=
p_twl.c
> index 2bf35dc..018abb4 100644
> --- a/arch/arm/mach-omap2/omap_twl.c
> +++ b/arch/arm/mach-omap2/omap_twl.c
> @@ -337,8 +337,8 @@ int __init omap3_twl_set_sr_bit(bool enable)
>  	if (twl_sr_enable_autoinit)
>  		pr_warning("%s: unexpected multiple calls\n", __func__);
> =20
> -	ret =3D twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &temp,
> -					TWL4030_DCDC_GLOBAL_CFG);
> +	ret =3D twl_i2c_read_u8(TWL_MODULE_PM_RECEIVER, &temp,
> +			      TWL4030_DCDC_GLOBAL_CFG);
>  	if (ret)
>  		goto err;
> =20
> @@ -347,8 +347,8 @@ int __init omap3_twl_set_sr_bit(bool enable)
>  	else
>  		temp &=3D ~SMARTREFLEX_ENABLE;
> =20
> -	ret =3D twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, temp,
> -				TWL4030_DCDC_GLOBAL_CFG);
> +	ret =3D twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, temp,
> +			       TWL4030_DCDC_GLOBAL_CFG);
>  	if (!ret) {
>  		twl_sr_enable_autoinit =3D true;
>  		return 0;
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

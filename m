From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PM-WIP/voltdm_c][PATCH 05/11] OMAP4: PM: VC: fix highspeed i2c for SR
Date: Wed, 18 May 2011 10:59:51 +0200
Message-ID: <87hb8sxu2g.fsf@ti.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com>
	<1305695854-9638-6-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:36640 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755700Ab1ERJAH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 05:00:07 -0400
Received: by wwi18 with SMTP id 18so4396207wwi.4
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 02:00:04 -0700 (PDT)
In-Reply-To: <1305695854-9638-6-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Wed, 18 May 2011 00:17:28 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Patch "OMAP3+: VC: make I2C config programmable with PMIC-specific settings"
> wrongly uses shift register causing mcode to be set instead
> of HS mode bit to be set for I2C_SR.

Oops, thanks for testing/finding/fixing.

> Fix the same for OMAP4 and rename the "shift" to "mask" to rightly
> indicate what is to be provided in the structure.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Thanks, adding to voltdm work, probably will fold into original patch.

Kevin

> ---
>  arch/arm/mach-omap2/vc.c          |    4 ++--
>  arch/arm/mach-omap2/vc.h          |    4 ++--
>  arch/arm/mach-omap2/vc3xxx_data.c |    2 +-
>  arch/arm/mach-omap2/vc44xx_data.c |    2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> index 79b9e86..f8185d2 100644
> --- a/arch/arm/mach-omap2/vc.c
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -240,8 +240,8 @@ void __init omap_vc_i2c_init(struct voltagedomain *voltdm)
>  
>  	i2c_high_speed = voltdm->pmic->i2c_high_speed;
>  	if (i2c_high_speed)
> -		voltdm->rmw(vc->common->i2c_cfg_hsen_shift,
> -			    vc->common->i2c_cfg_hsen_shift,
> +		voltdm->rmw(vc->common->i2c_cfg_hsen_mask,
> +			    vc->common->i2c_cfg_hsen_mask,
>  			    vc->common->i2c_cfg_reg);
>  
>  	mcode = voltdm->pmic->i2c_mcode;
> diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
> index 85f13f1..f0fb61f 100644
> --- a/arch/arm/mach-omap2/vc.h
> +++ b/arch/arm/mach-omap2/vc.h
> @@ -36,7 +36,7 @@ struct voltagedomain;
>   * @cmd_ret_shift: RET field shift in PRM_VC_CMD_VAL_* register
>   * @cmd_off_shift: OFF field shift in PRM_VC_CMD_VAL_* register
>   * @i2c_cfg_reg: I2C configuration register offset
> - * @i2c_cfg_hsen_shift: high-speed mode bit field shift in I2C config register
> + * @i2c_cfg_hsen_mask: high-speed mode bit field mask in I2C config register
>   * @i2c_mcode_mask: MCODE field mask for I2C config register
>   *
>   * XXX One of cmd_on_mask and cmd_on_shift are not needed
> @@ -58,7 +58,7 @@ struct omap_vc_common {
>  	u8 cmd_off_shift;
>  	u8 cfg_channel_reg;
>  	u8 i2c_cfg_reg;
> -	u8 i2c_cfg_hsen_shift;
> +	u8 i2c_cfg_hsen_mask;
>  	u8 i2c_mcode_mask;
>  };
>  
> diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
> index 688d55d..95d7701 100644
> --- a/arch/arm/mach-omap2/vc3xxx_data.c
> +++ b/arch/arm/mach-omap2/vc3xxx_data.c
> @@ -44,7 +44,7 @@ static struct omap_vc_common omap3_vc_common = {
>  	.cmd_ret_shift	 = OMAP3430_VC_CMD_RET_SHIFT,
>  	.cmd_off_shift	 = OMAP3430_VC_CMD_OFF_SHIFT,
>  	.cfg_channel_reg = OMAP3_PRM_VC_CH_CONF_OFFSET,
> -	.i2c_cfg_hsen_shift = OMAP3430_HSEN_MASK,
> +	.i2c_cfg_hsen_mask = OMAP3430_HSEN_MASK,
>  	.i2c_cfg_reg	 = OMAP3_PRM_VC_I2C_CFG_OFFSET,
>  	.i2c_mcode_mask	 = OMAP3430_MCODE_MASK,
>  };
> diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
> index 8aee1fe..fe4f4e5 100644
> --- a/arch/arm/mach-omap2/vc44xx_data.c
> +++ b/arch/arm/mach-omap2/vc44xx_data.c
> @@ -46,7 +46,7 @@ static const struct omap_vc_common omap4_vc_common = {
>  	.cmd_off_shift = OMAP4430_OFF_SHIFT,
>  	.cfg_channel_reg = OMAP4_PRM_VC_CFG_CHANNEL_OFFSET,
>  	.i2c_cfg_reg = OMAP4_PRM_VC_CFG_I2C_MODE_OFFSET,
> -	.i2c_cfg_hsen_shift = OMAP4430_HSMODEEN_SHIFT,
> +	.i2c_cfg_hsen_mask = OMAP4430_HSMODEEN_MASK,
>  	.i2c_mcode_mask	 = OMAP4430_HSMCODE_MASK,
>  };

From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: Fix omap3 off idle power consumption
 creeping up
Date: Tue, 21 Apr 2015 17:12:27 -0500
Message-ID: <20150421221227.GA9919@kahuna>
References: <1429632619-23474-1-git-send-email-tony@atomide.com>
 <20150421214718.GN18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42489 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964981AbbDUWMz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Apr 2015 18:12:55 -0400
Content-Disposition: inline
In-Reply-To: <20150421214718.GN18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@kernel.org>, Tero Kristo <t-kristo@ti.com>

On 14:47-20150421, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150421 09:24]:
> > If we use a combination of VMODE and I2C4 for retention modes,
> > eventually the off idle power consumption will creep up by about
> > 23mW, even during off mode with I2C4 always staying enabled.
> > 
> > Looks like the only way to fix the extra power consumption is to
> > disable I2C4 usage by setting SEL_VMODE for both off idle and
> > retention idle. Let's also update the comments accordingly.
> 
> Thanks Nishanth for pointing me to the related SmartReflex I2C4
> erratum. No need to disable I2C4 with the SREN workaround :)
> 
> Better patch below, presumably this only affects omap3?
SREN applies to both OMAP3 and 4 - so, the patch looks right.

> 
> Regards,
> 
> Tony
> 
> 8< ------------------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Tue, 21 Apr 2015 14:31:23 -0700
> Subject: [PATCH] ARM: OMAP2+: Fix omap3 off idle power consumption creeping up
> 
> If we use a combination of VMODE and I2C4 for retention modes,
> eventually the off idle power consumption will creep up by about
> 23mW, even during off mode with I2C4 always staying enabled.
> 
> Turns out this is because of erratum 2.11 "Extra Power Consumed
I suggest using the unique ID
i531 - that remains constant across SoCs.

> When Repeated Start Operation Mode Is Enabled on I2C Interface
> Dedicated for Smart Reflex (I2C4)" as pointed out by Nishanth
> Menon <nm@ti.com>.
> 
> Let's fix the issue by adding i2c_cfg_clear_mask for the bits
> to clear when initializing the I2C4 adapter so we can clear
> SREN bit that drives the I2C4 lines low otherwise when there
> is no traffic.
> 
> Fixes: 3b8c4ebb7630 ("ARM: OMAP3: Fix idle mode signaling for
> sys_clkreq and sys_off_mode")
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> --- a/arch/arm/mach-omap2/prm-regbits-34xx.h
> +++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
> @@ -112,6 +112,7 @@
>  #define OMAP3430_VC_CMD_ONLP_SHIFT			16
>  #define OMAP3430_VC_CMD_RET_SHIFT			8
>  #define OMAP3430_VC_CMD_OFF_SHIFT			0
> +#define OMAP3430_SREN_MASK				(1 << 4)
>  #define OMAP3430_HSEN_MASK				(1 << 3)
>  #define OMAP3430_MCODE_MASK				(0x7 << 0)
>  #define OMAP3430_VALID_MASK				(1 << 24)
> --- a/arch/arm/mach-omap2/vc.c
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -316,7 +316,8 @@ static void __init omap3_vc_init_pmic_signaling(struct voltagedomain *voltdm)
>  	 * idle. And we can also scale voltages to zero for off-idle.
>  	 * Note that no actual voltage scaling during off-idle will
>  	 * happen unless the board specific twl4030 PMIC scripts are
> -	 * loaded.
> +	 * loaded. See also omap_vc_i2c_init for comments regarding
> +	 * erratum 2.11.

^^ here as well. 2.11 on 3630 is 2.3 on OMAP3430 etc..
>  	 */
>  	val = voltdm->read(OMAP3_PRM_VOLTCTRL_OFFSET);
>  	if (!(val & OMAP3430_PRM_VOLTCTRL_SEL_OFF)) {
> @@ -704,9 +705,16 @@ static void __init omap_vc_i2c_init(struct voltagedomain *voltdm)
>  		return;
>  	}
>  
> +	/*
> +	 * Note that for omap3 OMAP3430_SREN_MASK clears SREN to work around
> +	 * erratum 2.11 "Extra Power Consumed When Repeated Start Operation
> +	 * Mode Is Enabled on I2C Interface Dedicated for Smart Reflex (I2C4)".
> +	 * Otherwise I2C4 eventually leads into about 23mW extran power being
> +	 * consumed even during off idle using VMODE.
> +	 */
>  	i2c_high_speed = voltdm->pmic->i2c_high_speed;
>  	if (i2c_high_speed)
> -		voltdm->rmw(vc->common->i2c_cfg_hsen_mask,
> +		voltdm->rmw(vc->common->i2c_cfg_clear_mask,
>  			    vc->common->i2c_cfg_hsen_mask,
>  			    vc->common->i2c_cfg_reg);
>  
> --- a/arch/arm/mach-omap2/vc.h
> +++ b/arch/arm/mach-omap2/vc.h
> @@ -34,6 +34,7 @@ struct voltagedomain;
>   * @cmd_ret_shift: RET field shift in PRM_VC_CMD_VAL_* register
>   * @cmd_off_shift: OFF field shift in PRM_VC_CMD_VAL_* register
>   * @i2c_cfg_reg: I2C configuration register offset
> + * @i2c_cfg_clear_mask: high-speed mode bit clear mask in I2C config register
>   * @i2c_cfg_hsen_mask: high-speed mode bit field mask in I2C config register
>   * @i2c_mcode_mask: MCODE field mask for I2C config register
>   *
> @@ -52,6 +53,7 @@ struct omap_vc_common {
>  	u8 cmd_ret_shift;
>  	u8 cmd_off_shift;
>  	u8 i2c_cfg_reg;
> +	u8 i2c_cfg_clear_mask;
>  	u8 i2c_cfg_hsen_mask;
>  	u8 i2c_mcode_mask;
>  };
> --- a/arch/arm/mach-omap2/vc3xxx_data.c
> +++ b/arch/arm/mach-omap2/vc3xxx_data.c
> @@ -28,6 +28,7 @@
>  /*
>   * VC data common to 34xx/36xx chips
>   * XXX This stuff presumably belongs in the vc3xxx.c or vc.c file.
> + * Note that we must clear SREN to work around erratum 2.11.
>   */
>  static struct omap_vc_common omap3_vc_common = {
>  	.bypass_val_reg	 = OMAP3_PRM_VC_BYPASS_VAL_OFFSET,
> @@ -40,6 +41,7 @@ static struct omap_vc_common omap3_vc_common = {
>  	.cmd_onlp_shift	 = OMAP3430_VC_CMD_ONLP_SHIFT,
>  	.cmd_ret_shift	 = OMAP3430_VC_CMD_RET_SHIFT,
>  	.cmd_off_shift	 = OMAP3430_VC_CMD_OFF_SHIFT,
> +	.i2c_cfg_clear_mask = OMAP3430_SREN_MASK,
>  	.i2c_cfg_hsen_mask = OMAP3430_HSEN_MASK,
>  	.i2c_cfg_reg	 = OMAP3_PRM_VC_I2C_CFG_OFFSET,
>  	.i2c_mcode_mask	 = OMAP3430_MCODE_MASK,
> --- a/arch/arm/mach-omap2/vc44xx_data.c
> +++ b/arch/arm/mach-omap2/vc44xx_data.c
> @@ -42,6 +42,7 @@ static const struct omap_vc_common omap4_vc_common = {
>  	.cmd_ret_shift = OMAP4430_RET_SHIFT,
>  	.cmd_off_shift = OMAP4430_OFF_SHIFT,
>  	.i2c_cfg_reg = OMAP4_PRM_VC_CFG_I2C_MODE_OFFSET,
> +	.i2c_cfg_clear_mask = 0,
>  	.i2c_cfg_hsen_mask = OMAP4430_HSMODEEN_MASK,
>  	.i2c_mcode_mask	 = OMAP4430_HSMCODE_MASK,
>  };

-- 
Regards,
Nishanth Menon

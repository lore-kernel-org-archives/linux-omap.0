From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] Move voltage controller configuration to pm34xx.c
Date: Tue, 5 Aug 2008 13:55:19 +0300
Message-ID: <20080805105518.GS7193@atomide.com>
References: <1217511458-9950-1-git-send-email-peter.de-schrijver@nokia.com> <1217511458-9950-2-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51428 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbYHEKzW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 06:55:22 -0400
Content-Disposition: inline
In-Reply-To: <1217511458-9950-2-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

* Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com> [080731 16:39]:
> 
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
> ---
>  arch/arm/mach-omap2/smartreflex.c |   60 -------------------------------------
>  1 files changed, 0 insertions(+), 60 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index b41fe96..7e4f9a4 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -362,64 +362,6 @@ static void sr_configure_vp(int srid)
>  	}
>  }
>  
> -static void sr_configure_vc(void)
> -{
> -	prm_write_mod_reg((R_SRI2C_SLAVE_ADDR << OMAP3430_SMPS_SA1_SHIFT) |
> -			(R_SRI2C_SLAVE_ADDR << OMAP3430_SMPS_SA0_SHIFT),
> -			OMAP3430_GR_MOD, OMAP3_PRM_VC_SMPS_SA_OFFSET);
> -
> -	prm_write_mod_reg((R_VDD2_SR_CONTROL << OMAP3430_VOLRA1_SHIFT) |
> -			(R_VDD1_SR_CONTROL << OMAP3430_VOLRA0_SHIFT),
> -			OMAP3430_GR_MOD, OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET);
> -
> -	prm_write_mod_reg((OMAP3430_VC_CMD_VAL0_ON <<
> -		OMAP3430_VC_CMD_ON_SHIFT) |
> -		(OMAP3430_VC_CMD_VAL0_ONLP << OMAP3430_VC_CMD_ONLP_SHIFT) |
> -		(OMAP3430_VC_CMD_VAL0_RET << OMAP3430_VC_CMD_RET_SHIFT) |
> -		(OMAP3430_VC_CMD_VAL0_OFF << OMAP3430_VC_CMD_OFF_SHIFT),
> -		OMAP3430_GR_MOD, OMAP3_PRM_VC_CMD_VAL_0_OFFSET);
> -
> -	prm_write_mod_reg((OMAP3430_VC_CMD_VAL1_ON <<
> -		OMAP3430_VC_CMD_ON_SHIFT) |
> -		(OMAP3430_VC_CMD_VAL1_ONLP << OMAP3430_VC_CMD_ONLP_SHIFT) |
> -		(OMAP3430_VC_CMD_VAL1_RET << OMAP3430_VC_CMD_RET_SHIFT) |
> -		(OMAP3430_VC_CMD_VAL1_OFF << OMAP3430_VC_CMD_OFF_SHIFT),
> -		OMAP3430_GR_MOD, OMAP3_PRM_VC_CMD_VAL_1_OFFSET);
> -
> -	prm_write_mod_reg(OMAP3430_CMD1 | OMAP3430_RAV1,
> -				OMAP3430_GR_MOD,
> -				OMAP3_PRM_VC_CH_CONF_OFFSET);
> -
> -	prm_write_mod_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN | OMAP3430_SREN,
> -				OMAP3430_GR_MOD,
> -				OMAP3_PRM_VC_I2C_CFG_OFFSET);
> -
> -	/* Setup voltctrl and other setup times */
> -	/* XXX CONFIG_SYSOFFMODE has not been implemented yet */
> -#ifdef CONFIG_OMAP_SYSOFFMODE
> -	prm_write_mod_reg(OMAP3430_AUTO_OFF | OMAP3430_AUTO_RET |
> -			OMAP3430_SEL_OFF, OMAP3430_GR_MOD,
> -			OMAP3_PRM_VOLTCTRL_OFFSET);
> -
> -	prm_write_mod_reg(OMAP3430_CLKSETUP_DURATION, OMAP3430_GR_MOD,
> -			OMAP3_PRM_CLKSETUP_OFFSET);
> -	prm_write_mod_reg((OMAP3430_VOLTSETUP_TIME2 <<
> -			OMAP3430_SETUP_TIME2_SHIFT) |
> -			(OMAP3430_VOLTSETUP_TIME1 <<
> -			OMAP3430_SETUP_TIME1_SHIFT),
> -			OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
> -
> -	prm_write_mod_reg(OMAP3430_VOLTOFFSET_DURATION, OMAP3430_GR_MOD,
> -			OMAP3_PRM_VOLTOFFSET_OFFSET);
> -	prm_write_mod_reg(OMAP3430_VOLTSETUP2_DURATION, OMAP3430_GR_MOD,
> -			OMAP3_PRM_VOLTSETUP2_OFFSET);
> -#else
> -	prm_set_mod_reg_bits(OMAP3430_AUTO_RET, OMAP3430_GR_MOD,
> -			OMAP3_PRM_VOLTCTRL_OFFSET);
> -#endif
> -
> -}
> -
>  static void sr_configure(struct omap_sr *sr)
>  {
>  	u32 sr_config;
> @@ -845,8 +787,6 @@ static int __init omap3_sr_init(void)
>  	sr_set_nvalues(&sr2);
>  	sr_configure_vp(SR2);
>  
> -	sr_configure_vc();
> -
>  	/* Enable SR on T2 */
>  	ret = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &RdReg,
>  					R_DCDC_GLOBAL_CFG);

This patch does not seem to move code, it just removes it. Can you do
the patches where the first patch just moves the existing code, then
the second patch adds the new changes? That way it's easier to read.

Thanks,

Tony

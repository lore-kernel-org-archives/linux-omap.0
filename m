From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/3] OMAP3: PM: Smartreflex IP update changes for OMAP3630
Date: Mon, 08 Mar 2010 09:46:16 -0800
Message-ID: <87lje2u2on.fsf@deeprootsystems.com>
References: <1268068851-30022-1-git-send-email-thara@ti.com>
	<1268068851-30022-2-git-send-email-thara@ti.com>
	<1268068851-30022-3-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:63198 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab0CHRqX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 12:46:23 -0500
Received: by fxm19 with SMTP id 19so6585237fxm.21
        for <linux-omap@vger.kernel.org>; Mon, 08 Mar 2010 09:46:21 -0800 (PST)
In-Reply-To: <1268068851-30022-3-git-send-email-thara@ti.com> (Thara Gopinath's message of "Mon\,  8 Mar 2010 22\:50\:50 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com, vishwanath.bs@ti.com, sawant@ti.com, b-cousson@ti.com

Thara Gopinath <thara@ti.com> writes:

> OMAP3430 uses the 65nm version of the smartreflex IP where as
> OMAP3630 and OMAP4430 uses the 45nm updated IP.
>
> This patch adds support for the updated smartreflex IP used
> in OMAP3630 and OMAP4 in the smartreflex driver.
>
> Major changes between the two versions of IP involve:
> 1. Change in offset position for ERRCONFIG and SENERROR registers
> 2. Change in bit positions for VP bound interrupt enable and status
>    in ERRCONFIG register.
> 3. Change in bit positions and width of SENNENABLE and SENPENABLE
>    bits in SRCONFIG registers.
> 4. Introduction of separate irq registers for MCU bound interrupts.
> 5. Removal of clockactivity bits in ERRCONFIG and introduction of
>   idlemode and wakeupenable bits in ERRCONFIG.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/smartreflex.c |  218 ++++++++++++++++++++++++++++---------
>  arch/arm/mach-omap2/smartreflex.h |   51 +++++++--
>  2 files changed, 208 insertions(+), 61 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 7aa84ab..2b1c529 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -58,6 +58,18 @@ static struct omap_smartreflex_class_data *sr_class;
>  
>  #define SR_REGADDR(offs)	(sr->srbase_addr + offset)
>  
> +static inline int sr_type(void)
> +{
> +	if (cpu_is_omap3630())

what about OMAP4?

> +		return SR_TYPE_V2;
> +	else if (cpu_is_omap343x())
> +		return SR_TYPE_V1;
> +	else {
> +		pr_err("Trying to enable SR for Chip not support SR! \n");
> +		return 0;
> +	}
> +}

Instead of calling a function to check the type each time.  How about
adding a 'type' field to sr_info, setting the type once at init and
checking the flag at runtime.

>  static inline void sr_write_reg(struct omap_sr *sr, unsigned offset, u32 value)
>  {
>  	__raw_writel(value, SR_REGADDR(offset));
> @@ -67,9 +79,11 @@ static inline void sr_modify_reg(struct omap_sr *sr, unsigned offset, u32 mask,
>  					u32 value)
>  {
>  	u32 reg_val;
> +	u32 errconfig_offs, errconfig_mask;
>  
>  	reg_val = __raw_readl(SR_REGADDR(offset));
>  	reg_val &= ~mask;
> +
>  	/*
>  	 * Smartreflex error config register is special as it contains
>  	 * certain status bits which if written a 1 into means a clear
> @@ -78,8 +92,16 @@ static inline void sr_modify_reg(struct omap_sr *sr, unsigned offset, u32 mask,
>  	 * value. Now if there is an actual reguest to write to these bits
>  	 * they will be set in the nex step.
>  	 */
> -	if (offset == ERRCONFIG)
> -		reg_val &= ~ERRCONFIG_STATUS_MASK;
> +	if (sr_type() == SR_TYPE_V1) {
> +		errconfig_offs = ERRCONFIG_V1;
> +		errconfig_mask = ERRCONFIG_STATUS_V1_MASK;
> +	} else if (sr_type() == SR_TYPE_V2) {
> +		errconfig_offs = ERRCONFIG_V2;
> +		errconfig_mask = ERRCONFIG_VPBOUNDINTST_V2;
> +	}
> +
> +	if (offset == errconfig_offs)
> +		reg_val &= ~errconfig_mask;
>  
>  	reg_val |= value;
>  	__raw_writel(reg_val, SR_REGADDR(offset));
> @@ -135,13 +157,21 @@ static void sr_clk_disable(struct omap_sr *sr)
>  static irqreturn_t sr_omap_isr(int irq, void *data)
>  {
>  	struct omap_sr *sr_info = (struct omap_sr *)data;
> -	u32 status;
> +	u32 status = 0;
>  
> -	/* Read the status bits */
> -	status = sr_read_reg(sr_info, ERRCONFIG);
> +	if (sr_type() == SR_TYPE_V1) {
> +		/* Read the status bits */
> +		status = sr_read_reg(sr_info, ERRCONFIG_V1);
>  
> -	/* Clear them by writing back */
> -	sr_write_reg(sr_info, ERRCONFIG, status);
> +		/* Clear them by writing back */
> +		sr_write_reg(sr_info, ERRCONFIG_V1, status);
> +	} else if (sr_type() == SR_TYPE_V2) {
> +		/* Read the status bits */
> +		sr_read_reg(sr_info, IRQSTATUS);
> +
> +		/* Clear them by writing back */
> +		sr_write_reg(sr_info, IRQSTATUS, status);
> +	}
>  
>  	/* Call the class driver notify function if registered*/
>  	if (sr_class->class_type == SR_CLASS2 && sr_class->notify)
> @@ -208,6 +238,7 @@ static void sr_configure(struct omap_sr *sr)
>  {
>  	u32 sr_config;
>  	u32 senp_en , senn_en;
> +	u8 senp_shift, senn_shift;
>  	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
>  
>  	/* Common settings for SR Class3 and SR Class2 */
> @@ -218,8 +249,16 @@ static void sr_configure(struct omap_sr *sr)
>  	senn_en = pdata->senn_mod;
>  
>  	sr_config = (sr->clk_length << SRCONFIG_SRCLKLENGTH_SHIFT) |
> -		SRCONFIG_SENENABLE | (senn_en << SRCONFIG_SENNENABLE_SHIFT) |
> -		(senp_en << SRCONFIG_SENPENABLE_SHIFT) | SRCONFIG_DELAYCTRL;
> +		SRCONFIG_SENENABLE;
> +	if (sr_type() == SR_TYPE_V1) {
> +		sr_config |= SRCONFIG_DELAYCTRL;
> +		senn_shift = SRCONFIG_SENNENABLE_V1_SHIFT;
> +		senp_shift = SRCONFIG_SENPENABLE_V1_SHIFT;
> +	} else if (sr_type() == SR_TYPE_V2) {
> +		senn_shift = SRCONFIG_SENNENABLE_V2_SHIFT;
> +		senp_shift = SRCONFIG_SENPENABLE_V2_SHIFT;
> +	}
> +	sr_config |= ((senn_en << senn_shift) | (senp_en << senp_shift));
>  	sr_write_reg(sr, SRCONFIG, sr_config);
>  
>  	if ((sr_class->class_type == SR_CLASS3) || (sr_class->class_type ==
> @@ -230,20 +269,30 @@ static void sr_configure(struct omap_sr *sr)
>  		 * SR CLASS 2 can choose between ERROR module and MINMAXAVG
>  		 * module.
>  		 */
> -		u32 sr_errconfig;
> +		u32 sr_errconfig, errconfig_offs;
> +		u32 vpboundint_en, vpboundint_st;
> +
> +		if (sr_type() == SR_TYPE_V1) {
> +			errconfig_offs = ERRCONFIG_V1;
> +			vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V1;
> +			vpboundint_st = ERRCONFIG_VPBOUNDINTST_V1;
> +		} else if (sr_type() == SR_TYPE_V2) {
> +			errconfig_offs = ERRCONFIG_V2;
> +			vpboundint_en = ERRCONFIG_VPBOUNDINTEN_V2;
> +			vpboundint_st = ERRCONFIG_VPBOUNDINTST_V2;
> +		}
>  
>  		sr_modify_reg(sr, SRCONFIG, SRCONFIG_ERRGEN_EN,
>  			SRCONFIG_ERRGEN_EN);
>  		sr_errconfig = (sr->err_weight << ERRCONFIG_ERRWEIGHT_SHIFT) |
>  			(sr->err_maxlimit << ERRCONFIG_ERRMAXLIMIT_SHIFT) |
>  			(sr->err_minlimit <<  ERRCONFIG_ERRMiNLIMIT_SHIFT);
> -		sr_modify_reg(sr, ERRCONFIG, (SR_ERRWEIGHT_MASK |
> +		sr_modify_reg(sr, errconfig_offs, (SR_ERRWEIGHT_MASK |
>  			SR_ERRMAXLIMIT_MASK | SR_ERRMINLIMIT_MASK),
>  			sr_errconfig);
>  		/* Enabling the interrupts if the ERROR module is used */
> -		sr_modify_reg(sr, ERRCONFIG,
> -			(ERRCONFIG_VPBOUNDINTEN),
> -			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST));
> +		sr_modify_reg(sr, errconfig_offs,
> +			vpboundint_en, (vpboundint_en | vpboundint_st));
>  	} else if ((sr_class->class_type == SR_CLASS2) &&
>  			(sr_class->mod_use == SR_USE_ERROR_MOD)) {
>  		/*
> @@ -263,12 +312,27 @@ static void sr_configure(struct omap_sr *sr)
>  		 * Enabling the interrupts if MINMAXAVG module is used.
>  		 * TODO: check if all the interrupts are mandatory
>  		 */
> -		sr_modify_reg(sr, ERRCONFIG,
> -			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUVALIDINTEN |
> -			ERRCONFIG_MCUBOUNDINTEN),
> -			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUACCUMINTST |
> -			 ERRCONFIG_MCUVALIDINTEN | ERRCONFIG_MCUVALIDINTST |
> -			 ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_MCUBOUNDINTST));
> +		if (sr_type() == SR_TYPE_V1) {
> +			sr_modify_reg(sr, ERRCONFIG_V1,
> +				(ERRCONFIG_MCUACCUMINTEN |
> +				 ERRCONFIG_MCUVALIDINTEN |
> +				 ERRCONFIG_MCUBOUNDINTEN),
> +				(ERRCONFIG_MCUACCUMINTEN |
> +				 ERRCONFIG_MCUACCUMINTST |
> +				 ERRCONFIG_MCUVALIDINTEN |
> +				 ERRCONFIG_MCUVALIDINTST |
> +				 ERRCONFIG_MCUBOUNDINTEN |
> +				 ERRCONFIG_MCUBOUNDINTST));
> +		} else if (sr_type() == SR_TYPE_V2) {
> +			sr_write_reg(sr, IRQSTATUS,
> +				IRQSTATUS_MCUACCUMINT | IRQSTATUS_MCVALIDINT |
> +				IRQSTATUS_MCBOUNDSINT |
> +				IRQSTATUS_MCUDISABLEACKINT);
> +			sr_write_reg(sr, IRQENABLE_SET,
> +				IRQENABLE_MCUACCUMINT | IRQENABLE_MCUVALIDINT |
> +				IRQENABLE_MCUBOUNDSINT |
> +				IRQENABLE_MCUDISABLEACKINT);
> +		}
>  	}
>  }
>  
> @@ -318,6 +382,81 @@ static void sr_stop_vddautocomap(int srid)
>  
>  }
>  
> +static void sr_v1_disable(struct omap_sr *sr)
> +{
> +	int timeout = 0;
> +
> +	/* Enable MCUDisableAcknowledge interrupt */
> +	sr_modify_reg(sr, ERRCONFIG_V1,
> +			ERRCONFIG_MCUDISACKINTEN, ERRCONFIG_MCUDISACKINTEN);
> +
> +	/* SRCONFIG - disable SR */
> +	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, 0x0);
> +
> +	/* Disable all other SR interrupts and clear the status */
> +	sr_modify_reg(sr, ERRCONFIG_V1,
> +			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUVALIDINTEN |
> +			ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_VPBOUNDINTEN_V1),
> +			(ERRCONFIG_MCUACCUMINTST | ERRCONFIG_MCUVALIDINTST |
> +			ERRCONFIG_MCUBOUNDINTST |
> +			ERRCONFIG_VPBOUNDINTST_V1));
> +
> +	/* Wait for SR to be disabled.
> +	 * wait until ERRCONFIG.MCUDISACKINTST = 1. Typical latency is 1us.
> +	 */
> +	while ((timeout < SR_DISABLE_TIMEOUT) &&
> +		(!(sr_read_reg(sr, ERRCONFIG_V1) &
> +		ERRCONFIG_MCUDISACKINTST))) {
> +		udelay(1);
> +		timeout++;
> +	}
> +
> +	if (timeout == SR_DISABLE_TIMEOUT)
> +		pr_warning("SR%d disable timedout\n", sr->srid);
> +
> +	/* Disable MCUDisableAcknowledge interrupt & clear pending interrupt */
> +	sr_modify_reg(sr, ERRCONFIG_V1, ERRCONFIG_MCUDISACKINTEN,
> +			ERRCONFIG_MCUDISACKINTST);
> +}
> +
> +static void sr_v2_disable(struct omap_sr *sr)
> +{
> +	int timeout = 0;
> +
> +	/* Enable MCUDisableAcknowledge interrupt */
> +	sr_write_reg(sr, IRQENABLE_SET, IRQENABLE_MCUDISABLEACKINT);
> +
> +	/* SRCONFIG - disable SR */
> +	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, 0x0);
> +
> +	/* Disable all other SR interrupts and clear the status */
> +	sr_modify_reg(sr, ERRCONFIG_V2, ERRCONFIG_VPBOUNDINTEN_V2,
> +			ERRCONFIG_VPBOUNDINTST_V2);
> +	sr_write_reg(sr, IRQENABLE_CLR, (IRQENABLE_MCUACCUMINT |
> +			IRQENABLE_MCUVALIDINT |
> +			IRQENABLE_MCUBOUNDSINT));
> +	sr_write_reg(sr, IRQSTATUS, (IRQSTATUS_MCUACCUMINT |
> +			IRQSTATUS_MCVALIDINT |
> +			IRQSTATUS_MCBOUNDSINT));
> +
> +	/* Wait for SR to be disabled.
> +	 * wait until IRQSTATUS.MCUDISACKINTST = 1. Typical latency is 1us.
> +	 */

multi-line comment style

> +	while ((timeout < SR_DISABLE_TIMEOUT) &&
> +		(!(sr_read_reg(sr, IRQSTATUS) &
> +		IRQSTATUS_MCUDISABLEACKINT))) {
> +		udelay(1);
> +		timeout++;
> +	}

use omap_test_timeout()

> +	if (timeout == SR_DISABLE_TIMEOUT)
> +		pr_warning("SR%d disable timedout\n", sr->srid);
> +
> +	/* Disable MCUDisableAcknowledge interrupt & clear pending interrupt */
> +	sr_write_reg(sr, IRQENABLE_CLR, IRQENABLE_MCUDISABLEACKINT);
> +	sr_write_reg(sr, IRQSTATUS, IRQSTATUS_MCUDISABLEACKINT);
> +}
> +
>  /* Public Functions */
>  
>  /**
> @@ -373,6 +512,7 @@ int sr_enable(int srid, u32 target_opp_no)
>  	sr_configure(sr);
>  
>  	nvalue_reciprocal = pdata->sr_nvalue[target_opp_no - 1];
> +

stray whitespace change

>  	if (nvalue_reciprocal == 0) {
>  		pr_notice("OPP%d doesn't support SmartReflex\n",
>  								target_opp_no);
> @@ -395,44 +535,18 @@ int sr_enable(int srid, u32 target_opp_no)
>  void sr_disable(int srid)
>  {
>  	struct omap_sr *sr = _sr_lookup(srid);
> -	int timeout = 0;
>  
>  	/* Check if SR is already disabled. If yes do nothing */
>  	if (!(sr_read_reg(sr, SRCONFIG) & SRCONFIG_SRENABLE))
>  		return;
>  
> -	/* Enable MCUDisableAcknowledge interrupt */
> -	sr_modify_reg(sr, ERRCONFIG,
> -			ERRCONFIG_MCUDISACKINTEN, ERRCONFIG_MCUDISACKINTEN);
> +	if (sr_type() == SR_TYPE_V1)
> +		sr_v1_disable(sr);
>  
> -	/* SRCONFIG - disable SR */
> -	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, 0x0);
> -
> -	/* Disable all other SR interrupts and clear the status */
> -	sr_modify_reg(sr, ERRCONFIG,
> -			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUVALIDINTEN |
> -			ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_VPBOUNDINTEN),
> -			(ERRCONFIG_MCUACCUMINTST | ERRCONFIG_MCUVALIDINTST |
> -			ERRCONFIG_MCUBOUNDINTST | ERRCONFIG_VPBOUNDINTST));
> -
> -	/* Wait for SR to be disabled.
> -	 * wait until ERRCONFIG.MCUDISACKINTST = 1. Typical latency is 1us.
> -	 */
> -	while ((timeout < SR_DISABLE_TIMEOUT) &&
> -		(!(sr_read_reg(sr, ERRCONFIG) & ERRCONFIG_MCUDISACKINTST))) {
> -
> -		udelay(1);
> -		timeout++;
> -	}
> -
> -	if (timeout == SR_DISABLE_TIMEOUT)
> -		pr_warning("SR%d disable timedout\n", srid);
> -
> -	/* Disable MCUDisableAcknowledge interrupt & clear pending interrupt
> -	 * Also enable VPBOUND interrrupt
> -	 */
> -	sr_modify_reg(sr, ERRCONFIG, ERRCONFIG_MCUDISACKINTEN,
> -			ERRCONFIG_MCUDISACKINTST);
> +	else if (sr_type() == SR_TYPE_V2)
> +		sr_v2_disable(sr);
> +	else
> +		return;

Rather than the if-else, how about adding a ->disable hook to sr_info
set at init time and called here.

Kevin

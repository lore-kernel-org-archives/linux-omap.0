From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [GIT PULL] for testing: OMAP hwmod driver conversions:
 watchdog, UART, i2c
Date: Tue, 5 Oct 2010 18:43:09 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003FF3B2E32@dbde02.ent.ti.com>
References: <8762xpenf8.fsf@deeprootsystems.com>
 <20100928201844.GI3117@atomide.com> <87tyl8rxwp.fsf@deeprootsystems.com>
 <20100930021819.GD3117@atomide.com> <877hi3i9cp.fsf@deeprootsystems.com>
 <87pqvvgt8g.fsf@deeprootsystems.com> <877hi3gqq7.fsf@deeprootsystems.com>
 <0680EC522D0CC943BC586913CF3768C003FF2DAF74@dbde02.ent.ti.com>
 <4CA60F88.4020303@ti.com>
 <alpine.DEB.2.00.1010042359170.13816@utopia.booyaka.com>
  <0680EC522D0CC943BC586913CF3768C003FF3B2E05@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35766 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752715Ab0JENNS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 09:13:18 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003FF3B2E05@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>



> -----Original Message-----
> From: Nayak, Rajendra
> Sent: Tuesday, October 05, 2010 6:04 PM
> To: Nayak, Rajendra; Paul Walmsley; Cousson, Benoit
> Cc: Kevin Hilman; Tony Lindgren; linux-omap@vger.kernel.org; Varadarajan, Charulatha; Raja, Govindraj
> Subject: RE: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog, UART, i2c
> 
> <snip>..
> 
> > >
> > > Below is an untested patch to provide some mechanism to deal with this --
> > > I'd appreciate everyone's comments on this, particularly the comments in
> > > the patch code on how to deal with this problem.
> >
> > Hi Paul,
> >
> > I'll test this patch to see if it solves the issue seen with i2c on n800.
> 
> Hi Paul, Benoit, Kevin,
> 
> So looks like the issue with i2c on n800 isn't really because of additional
> delay needed after a clock enable, but related to the omap_readl/writel's
> done on the 16bit i2c registers as I was suspecting earlier.

Sorry, I meant to say __raw_readl/writel instead.

> 
> The below patch fixes the n800 issue for me. My mailer might mess up the alignment
> hence attaching it too.
> 
> From af9733f2e63a16b446635d52015e05d631f0788f Mon Sep 17 00:00:00 2001
> From: Rajendra Nayak <rnayak@ti.com>
> Date: Tue, 5 Oct 2010 16:36:30 +0530
> Subject: [PATCH] OMAP: hwmod: Handle modules with 16bit registers
> 
> Some modules which have 16bit registers can cause imprecise
> aborts if a __raw_readl/writel is used to read/write 32 bits.
> 
> Add an additional flag to identify modules which have such
> hard requirement, and handle it in the hwmod framework.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c             |   24 +++++++++++++++---------
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 ++++--
>  2 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 955861a..5a30658 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -184,7 +184,7 @@ static int _update_sysc_cache(struct omap_hwmod *oh)
> 
>  	/* XXX ensure module interface clock is up */
> 
> -	oh->_sysc_cache = omap_hwmod_readl(oh, oh->class->sysc->sysc_offs);
> +	oh->_sysc_cache = omap_hwmod_read(oh, oh->class->sysc->sysc_offs);
> 
>  	if (!(oh->class->sysc->sysc_flags & SYSC_NO_CACHE))
>  		oh->_int_flags |= _HWMOD_SYSCONFIG_LOADED;
> @@ -211,7 +211,7 @@ static void _write_sysconfig(u32 v, struct omap_hwmod *oh)
> 
>  	if (oh->_sysc_cache != v) {
>  		oh->_sysc_cache = v;
> -		omap_hwmod_writel(v, oh, oh->class->sysc->sysc_offs);
> +		omap_hwmod_write(v, oh, oh->class->sysc->sysc_offs);
>  	}
>  }
> 
> @@ -1133,12 +1133,12 @@ static int _reset(struct omap_hwmod *oh)
>  	_write_sysconfig(v, oh);
> 
>  	if (oh->class->sysc->sysc_flags & SYSS_HAS_RESET_STATUS)
> -		omap_test_timeout((omap_hwmod_readl(oh,
> +		omap_test_timeout((omap_hwmod_read(oh,
>  						    oh->class->sysc->syss_offs)
>  				   & SYSS_RESETDONE_MASK),
>  				  MAX_MODULE_SOFTRESET_WAIT, c);
>  	else if (oh->class->sysc->sysc_flags & SYSC_HAS_RESET_STATUS)
> -		omap_test_timeout(!(omap_hwmod_readl(oh,
> +		omap_test_timeout(!(omap_hwmod_read(oh,
>  						     oh->class->sysc->sysc_offs)
>  				   & SYSC_TYPE2_SOFTRESET_MASK),
>  				  MAX_MODULE_SOFTRESET_WAIT, c);
> @@ -1378,14 +1378,20 @@ static int _setup(struct omap_hwmod *oh, void *data)
> 
>  /* Public functions */
> 
> -u32 omap_hwmod_readl(struct omap_hwmod *oh, u16 reg_offs)
> +u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs)
>  {
> -	return __raw_readl(oh->_mpu_rt_va + reg_offs);
> +	if (oh->flags & HWMOD_16BIT_REG)
> +		return __raw_readw(oh->_mpu_rt_va + reg_offs);
> +	else
> +		return __raw_readl(oh->_mpu_rt_va + reg_offs);
>  }
> 
> -void omap_hwmod_writel(u32 v, struct omap_hwmod *oh, u16 reg_offs)
> +void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs)
>  {
> -	__raw_writel(v, oh->_mpu_rt_va + reg_offs);
> +	if (oh->flags & HWMOD_16BIT_REG)
> +		__raw_writew(v, oh->_mpu_rt_va + reg_offs);
> +	else
> +		__raw_writel(v, oh->_mpu_rt_va + reg_offs);
>  }
> 
>  /**
> @@ -1732,7 +1738,7 @@ void omap_hwmod_ocp_barrier(struct omap_hwmod *oh)
>  	 * Forces posted writes to complete on the OCP thread handling
>  	 * register writes
>  	 */
> -	omap_hwmod_readl(oh, oh->class->sysc->sysc_offs);
> +	omap_hwmod_read(oh, oh->class->sysc->sysc_offs);
>  }
> 
>  /**
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index c1835af..7eaa8ed 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -370,6 +370,7 @@ struct omap_hwmod_omap4_prcm {
>   *     This is needed for devices like DSS that require optional clocks enabled
>   *     in order to complete the reset. Optional clocks will be disabled
>   *     again after the reset.
> + * HWMOD_16BIT_REG: Module has 16bit registers
>   */
>  #define HWMOD_SWSUP_SIDLE			(1 << 0)
>  #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
> @@ -379,6 +380,7 @@ struct omap_hwmod_omap4_prcm {
>  #define HWMOD_SET_DEFAULT_CLOCKACT		(1 << 5)
>  #define HWMOD_NO_IDLEST				(1 << 6)
>  #define HWMOD_CONTROL_OPT_CLKS_IN_RESET		(1 << 7)
> +#define HWMOD_16BIT_REG				(1 << 8)
> 
>  /*
>   * omap_hwmod._int_flags definitions
> @@ -527,8 +529,8 @@ int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode);
>  int omap_hwmod_reset(struct omap_hwmod *oh);
>  void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
> 
> -void omap_hwmod_writel(u32 v, struct omap_hwmod *oh, u16 reg_offs);
> -u32 omap_hwmod_readl(struct omap_hwmod *oh, u16 reg_offs);
> +void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs);
> +u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs);
> 
>  int omap_hwmod_count_resources(struct omap_hwmod *oh);
>  int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res);
> --
> 1.7.0.4
> 


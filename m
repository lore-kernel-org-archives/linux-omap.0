From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2/3 CM: clean up 3430ES2-only defines
Date: Fri, 28 Mar 2008 12:16:05 +0200
Message-ID: <20080328101604.GN24896@atomide.com>
References: <alpine.DEB.1.00.0803280029560.13553@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61561 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755139AbYC1KQH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 06:16:07 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0803280029560.13553@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080328 08:32]:
> 
> This patch marks several CM register bit fields that are only valid on
> 3430ES2 and beyond to be 3430ES2 defines.  
> 
> While we're here, clean up the register defines in cm.h, and improve
> documentation slightly.  Also, since CM_AUTOIDLE3 is now in use on
> both OMAP24xx and OMAP34xx, remove the platform-specific prefix from
> its name.

Pushing today & folding into omap2-upstream series.

Tony


> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> ---
>  arch/arm/mach-omap2/clock34xx.h       |    2 -
>  arch/arm/mach-omap2/cm-regbits-34xx.h |   22 +++++++------
>  arch/arm/mach-omap2/cm.h              |   55 ++++++++++++++++------------------
>  arch/arm/mach-omap2/pm.c              |    2 -
>  arch/arm/mach-omap2/prm.h             |    4 +-
>  drivers/usb/host/ehci-omap.c          |   10 +++---
>  6 files changed, 48 insertions(+), 47 deletions(-)
> 
> Index: linux-omap/arch/arm/mach-omap2/clock34xx.h
> ===================================================================
> --- linux-omap.orig/arch/arm/mach-omap2/clock34xx.h	2008-03-28 00:27:00.000000000 -0600
> +++ linux-omap/arch/arm/mach-omap2/clock34xx.h	2008-03-28 00:27:02.000000000 -0600
> @@ -851,7 +851,7 @@
>  	.parent		= &dpll5_m2_ck,
>  	.init           = &omap2_init_clksel_parent,
>  	.clksel_reg     = OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST2),
> -	.clksel_mask    = OMAP3430_ST_PERIPH2_CLK,
> +	.clksel_mask    = OMAP3430ES2_ST_PERIPH2_CLK_MASK,
>  	.clksel         = omap_120m_fck_clksel,
>  	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES |
>  				PARENT_CONTROLS_CLOCK,
> Index: linux-omap/arch/arm/mach-omap2/cm-regbits-34xx.h
> ===================================================================
> --- linux-omap.orig/arch/arm/mach-omap2/cm-regbits-34xx.h	2008-03-28 00:26:50.000000000 -0600
> +++ linux-omap/arch/arm/mach-omap2/cm-regbits-34xx.h	2008-03-28 00:27:02.000000000 -0600
> @@ -203,8 +203,8 @@
>  #define OMAP3430_ST_DES1				(1 << 0)
>  
>  /* CM_IDLEST3_CORE */
> -#define OMAP3430_ST_USBTLL				(1 << 2)
> -#define OMAP3430_ST_USBTLL_SHIFT			2
> +#define OMAP3430ES2_ST_USBTLL_SHIFT			2
> +#define OMAP3430ES2_ST_USBTLL_MASK			(1 << 2)
>  
>  /* CM_AUTOIDLE1_CORE */
>  #define OMAP3430_AUTO_AES2				(1 << 28)
> @@ -275,8 +275,8 @@
>  #define OMAP3430_AUTO_DES1_SHIFT			0
>  
>  /* CM_AUTOIDLE3_CORE */
> -#define OMAP3430_AUTO_USBTLL				(1 << 2)
> -#define OMAP3430_AUTO_USBTLL_SHIFT			2
> +#define OMAP3430ES2_AUTO_USBTLL_SHIFT			2
> +#define OMAP3430ES2_AUTO_USBTLL_MASK			(1 << 2)
>  
>  /* CM_CLKSEL_CORE */
>  #define OMAP3430_CLKSEL_SSI_SHIFT			8
> @@ -411,8 +411,10 @@
>  #define OMAP3430_ST_CORE_CLK				(1 << 0)
>  
>  /* CM_IDLEST2_CKGEN */
> -#define OMAP3430_ST_120M_CLK				(1 << 1)
> -#define OMAP3430_ST_PERIPH2_CLK				(1 << 0)
> +#define OMAP3430ES2_ST_120M_CLK_SHIFT			1
> +#define OMAP3430ES2_ST_120M_CLK_MASK			(1 << 1)
> +#define OMAP3430ES2_ST_PERIPH2_CLK_SHIFT		0
> +#define OMAP3430ES2_ST_PERIPH2_CLK_MASK			(1 << 0)
>  
>  /* CM_AUTOIDLE_PLL */
>  #define OMAP3430_AUTO_PERIPH_DPLL_SHIFT			3
> @@ -654,17 +656,17 @@
>  
>  /* CM_AUTOIDLE_USBHOST */
>  #define OMAP3430ES2_AUTO_USBHOST_SHIFT			0
> -#define OMAP3430ES2_AUTO_USBHOST_MASK			(1<<0)
> +#define OMAP3430ES2_AUTO_USBHOST_MASK			(1 << 0)
>  
>  /* CM_SLEEPDEP_USBHOST */
>  #define OMAP3430ES2_EN_MPU_SHIFT			1
> -#define OMAP3430ES2_EN_MPU_MASK				(1<<1)
> +#define OMAP3430ES2_EN_MPU_MASK				(1 << 1)
>  #define OMAP3430ES2_EN_IVA2_SHIFT			2
> -#define OMAP3430ES2_EN_IVA2_MASK			(1<<2)
> +#define OMAP3430ES2_EN_IVA2_MASK			(1 << 2)
>  
>  /* CM_CLKSTCTRL_USBHOST */
>  #define OMAP3430ES2_CLKTRCTRL_USBHOST_SHIFT		0
> -#define OMAP3430ES2_CLKTRCTRL_USBHOST_MASK		(3<<0)
> +#define OMAP3430ES2_CLKTRCTRL_USBHOST_MASK		(3 << 0)
>  
>  
>  
> Index: linux-omap/arch/arm/mach-omap2/cm.h
> ===================================================================
> --- linux-omap.orig/arch/arm/mach-omap2/cm.h	2008-03-28 00:26:50.000000000 -0600
> +++ linux-omap/arch/arm/mach-omap2/cm.h	2008-03-28 00:27:02.000000000 -0600
> @@ -31,6 +31,7 @@
>  /*
>   * Architecture-specific global CM registers
>   * Use cm_{read,write}_reg() with these registers.
> + * These registers appear once per CM module.
>   */
>  
>  #define OMAP3430_CM_REVISION		OMAP_CM_REGADDR(OCP_MOD, 0x0000)
> @@ -58,23 +59,25 @@
>  /*
>   * Module specific CM registers from CM_BASE + domain offset
>   * Use cm_{read,write}_mod_reg() with these registers.
> + * These register offsets generally appear in more than one PRCM submodule.
>   */
>  
>  /* Common between 24xx and 34xx */
>  
> -#define CM_FCLKEN1					0x0000
> -#define CM_FCLKEN					CM_FCLKEN1
> -#define CM_CLKEN					CM_FCLKEN1
> -#define CM_ICLKEN1					0x0010
> -#define CM_ICLKEN					CM_ICLKEN1
> +#define CM_FCLKEN					0x0000
> +#define CM_FCLKEN1					CM_FCLKEN
> +#define CM_CLKEN					CM_FCLKEN
> +#define CM_ICLKEN					0x0010
> +#define CM_ICLKEN1					CM_ICLKEN
>  #define CM_ICLKEN2					0x0014
>  #define CM_ICLKEN3					0x0018
> -#define CM_IDLEST1					0x0020
> -#define CM_IDLEST					CM_IDLEST1
> +#define CM_IDLEST					0x0020
> +#define CM_IDLEST1					CM_IDLEST
>  #define CM_IDLEST2					0x0024
>  #define CM_AUTOIDLE					0x0030
> -#define CM_AUTOIDLE1					0x0030
> +#define CM_AUTOIDLE1					CM_AUTOIDLE
>  #define CM_AUTOIDLE2					0x0034
> +#define CM_AUTOIDLE3					0x0038
>  #define CM_CLKSEL					0x0040
>  #define CM_CLKSEL1					CM_CLKSEL
>  #define CM_CLKSEL2					0x0044
> @@ -85,11 +88,26 @@
>  
>  #define OMAP24XX_CM_FCLKEN2				0x0004
>  #define OMAP24XX_CM_ICLKEN4				0x001c
> -#define OMAP24XX_CM_AUTOIDLE3				0x0038
>  #define OMAP24XX_CM_AUTOIDLE4				0x003c
>  
>  #define OMAP2430_CM_IDLEST3				0x0028
>  
> +#define OMAP3430_CM_CLKEN_PLL				0x0004
> +#define OMAP3430ES2_CM_CLKEN2				0x0004
> +#define OMAP3430ES2_CM_FCLKEN3				0x0008
> +#define OMAP3430_CM_IDLEST_PLL				CM_IDLEST2
> +#define OMAP3430_CM_AUTOIDLE_PLL			CM_AUTOIDLE2
> +#define OMAP3430_CM_CLKSEL1				CM_CLKSEL
> +#define OMAP3430_CM_CLKSEL1_PLL				CM_CLKSEL
> +#define OMAP3430_CM_CLKSEL2_PLL				CM_CLKSEL2
> +#define OMAP3430_CM_SLEEPDEP				CM_CLKSEL2
> +#define OMAP3430_CM_CLKSEL3				CM_CLKSTCTRL
> +#define OMAP3430_CM_CLKSTST				0x004c
> +#define OMAP3430ES2_CM_CLKSEL4				0x004c
> +#define OMAP3430ES2_CM_CLKSEL5				0x0050
> +#define OMAP3430_CM_CLKSEL2_EMU				0x0050
> +#define OMAP3430_CM_CLKSEL3_EMU				0x0054
> +
>  
>  /* Clock management domain register get/set */
>  
> @@ -119,24 +137,5 @@
>  /* CM_IDLEST_GFX */
>  #define OMAP_ST_GFX					(1 << 0)
>  
> -#define OMAP3430_CM_CLKEN_PLL				0x0004
> -#define OMAP3430ES2_CM_CLKEN2				0x0004
> -#define OMAP3430ES2_CM_FCLKEN3				0x0008
> -#define OMAP3430_CM_IDLEST_PLL				CM_IDLEST2
> -#define OMAP3430_CM_AUTOIDLE_PLL			CM_AUTOIDLE2
> -#define OMAP3430_CM_CLKSEL1				CM_CLKSEL
> -#define OMAP3430_CM_CLKSEL1_PLL				CM_CLKSEL
> -#define OMAP3430_CM_CLKSEL2_PLL				CM_CLKSEL2
> -#define OMAP3430_CM_SLEEPDEP				CM_CLKSEL2
> -#define OMAP3430_CM_CLKSEL3				CM_CLKSTCTRL
> -#define OMAP3430_CM_CLKSTST				0x004c
> -#define OMAP3430ES2_CM_CLKSEL4				0x004c
> -#define OMAP3430ES2_CM_CLKSEL5				0x0050
> -#define OMAP3430_CM_CLKSEL2_EMU				0x0050
> -#define OMAP3430_CM_CLKSEL3_EMU				0x0054
> -#define OMAP3430_CM_IDLEST3_CORE			0x0028
> -#define OMAP3430_CM_AUTOIDLE3_CORE			0x0038
> -
> -
>  
>  #endif
> Index: linux-omap/arch/arm/mach-omap2/pm.c
> ===================================================================
> --- linux-omap.orig/arch/arm/mach-omap2/pm.c	2008-03-28 00:26:50.000000000 -0600
> +++ linux-omap/arch/arm/mach-omap2/pm.c	2008-03-28 00:27:02.000000000 -0600
> @@ -735,7 +735,7 @@
>  	cm_write_mod_reg(OMAP24XX_AUTO_SDRC |
>  			 OMAP24XX_AUTO_GPMC |
>  			 OMAP24XX_AUTO_SDMA,
> -			 CORE_MOD, OMAP24XX_CM_AUTOIDLE3);
> +			 CORE_MOD, CM_AUTOIDLE3);
>  	cm_write_mod_reg(OMAP24XX_AUTO_PKA |
>  			 OMAP24XX_AUTO_AES |
>  			 OMAP24XX_AUTO_RNG |
> Index: linux-omap/arch/arm/mach-omap2/prm.h
> ===================================================================
> --- linux-omap.orig/arch/arm/mach-omap2/prm.h	2008-03-28 00:26:50.000000000 -0600
> +++ linux-omap/arch/arm/mach-omap2/prm.h	2008-03-28 00:27:02.000000000 -0600
> @@ -132,8 +132,8 @@
>  #define RM_RSTTIME					0x0054
>  #define RM_RSTST					0x0058
>  
> -#define PM_WKEN1					0x00a0
> -#define PM_WKEN						PM_WKEN1
> +#define PM_WKEN						0x00a0
> +#define PM_WKEN1					PM_WKEN
>  #define PM_WKST						0x00b0
>  #define PM_WKST1					PM_WKST
>  #define PM_WKDEP					0x00c8
> Index: linux-omap/drivers/usb/host/ehci-omap.c
> ===================================================================
> --- linux-omap.orig/drivers/usb/host/ehci-omap.c	2008-03-28 00:26:50.000000000 -0600
> +++ linux-omap/drivers/usb/host/ehci-omap.c	2008-03-28 00:27:02.000000000 -0600
> @@ -179,7 +179,7 @@
>  			PLL_MOD, OMAP3430ES2_CM_CLKEN2);
>  
>  	while (!(cm_read_mod_reg(PLL_MOD, CM_IDLEST2) &
> -				OMAP3430_ST_PERIPH2_CLK))
> +				OMAP3430ES2_ST_PERIPH2_CLK_MASK))
>  		dev_dbg(hcd->self.controller,
>  			"idlest2 = 0x%x\n",
>  			cm_read_mod_reg(PLL_MOD, CM_IDLEST2));
> @@ -246,12 +246,12 @@
>  	clk_enable(ehci_clocks->usbtll_ick_clk);
>  
>  	/* Disable Auto Idle of USBTLL */
> -	cm_write_mod_reg((0 << OMAP3430_AUTO_USBTLL_SHIFT),
> -				CORE_MOD, OMAP3430_CM_AUTOIDLE3_CORE);
> +	cm_write_mod_reg((0 << OMAP3430ES2_AUTO_USBTLL_SHIFT),
> +				CORE_MOD, CM_AUTOIDLE3);
>  
>  	/* Wait for TLL to be Active */
> -	while ((cm_read_mod_reg(CORE_MOD, OMAP3430_CM_IDLEST3_CORE) &
> -		(1 << OMAP3430_ST_USBTLL_SHIFT)));
> +	while ((cm_read_mod_reg(CORE_MOD, OMAP2430_CM_IDLEST3) &
> +		(1 << OMAP3430ES2_ST_USBTLL_SHIFT)));
>  
>  	/* perform TLL soft reset, and wait until reset is complete */
>  	omap_writel(1 << OMAP_USBTLL_SYSCONFIG_SOFTRESET_SHIFT,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

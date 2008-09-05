From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RESEND 3][PATCH] Adding csi2_fck declaration to clock34xx.h
Date: Fri, 5 Sep 2008 00:03:50 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809050003380.25143@utopia.booyaka.com>
References: <A24693684029E5489D1D202277BE894411A07DA1@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46049 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbYIEGDw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 02:03:52 -0400
In-Reply-To: <A24693684029E5489D1D202277BE894411A07DA1@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 3 Sep 2008, Aguirre Rodriguez, Sergio Alberto wrote:

> From: Sergio Aguirre <saaguirre@ti.com>
> 
> ARM: OMAP: Add CSI2 clock struct for handling it with clock API.
> 
> Add CSI2 clock struct for handling it with clock API when TI PM is disabled.
> 
> Signed-off-by: Sergio Aguirre <saaguirre@ti.com>

Acked-by: Paul Walmsley <paul@pwsan.com>


> ---
>  arch/arm/mach-omap2/clock34xx.h       |   12 ++++++++++++
>  arch/arm/mach-omap2/cm-regbits-34xx.h |    2 ++
>  2 files changed, 14 insertions(+)
> 
> Index: linux-omap-2.6/arch/arm/mach-omap2/clock34xx.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/clock34xx.h	2008-08-28 13:59:57.000000000 -0500
> +++ linux-omap-2.6/arch/arm/mach-omap2/clock34xx.h	2008-09-03 11:33:20.000000000 -0500
> @@ -2228,6 +2228,17 @@
>  	.recalc		= &followparent_recalc,
>  };
>  
> +static struct clk csi2_96m_fck = {
> +	.name		= "csi2_96m_fck",
> +	.parent		= &core_96m_fck,
> +	.init		= &omap2_init_clk_clkdm,
> +	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
> +	.enable_bit	= OMAP3430_EN_CSI2_SHIFT,
> +	.flags		= CLOCK_IN_OMAP343X,
> +	.clkdm		= { .name = "cam_clkdm" },
> +	.recalc		= &followparent_recalc,
> +};
> +
>  /* USBHOST - 3430ES2 only */
>  
>  static struct clk usbhost_120m_fck = {
> @@ -3208,6 +3219,7 @@
>  	&dss_ick,
>  	&cam_mclk,
>  	&cam_ick,
> +	&csi2_96m_fck,
>  	&usbhost_120m_fck,
>  	&usbhost_48m_fck,
>  	&usbhost_ick,
> Index: linux-omap-2.6/arch/arm/mach-omap2/cm-regbits-34xx.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/cm-regbits-34xx.h	2008-08-28 13:59:57.000000000 -0500
> +++ linux-omap-2.6/arch/arm/mach-omap2/cm-regbits-34xx.h	2008-09-02 17:53:48.000000000 -0500
> @@ -530,6 +530,8 @@
>  #define OMAP3430_CLKACTIVITY_DSS_MASK			(1 << 0)
>  
>  /* CM_FCLKEN_CAM specific bits */
> +#define OMAP3430_EN_CSI2				(1 << 1)
> +#define OMAP3430_EN_CSI2_SHIFT				1
>  
>  /* CM_ICLKEN_CAM specific bits */
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul

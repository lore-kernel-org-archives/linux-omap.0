From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap1: clk: make clk fwk build again on omap1
Date: Thu, 13 Nov 2008 10:55:49 -0800
Message-ID: <20081113185548.GA3106@atomide.com>
References: <1226444207-14588-1-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51461 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbYKMSzx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 13:55:53 -0500
Content-Disposition: inline
In-Reply-To: <1226444207-14588-1-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Paul Walmsley <paul@pwsan.com>

* Felipe Balbi <me@felipebalbi.com> [081111 14:57]:
> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> Fix it by passing u32 into enable_reg and letting
> clock.c use OMAP1_IO_ADDRESS().
> 
> This will probably be changed by a better solution
> later on, but at least we make it buildable again.

Huh? At least OSK builds and boots just fine here.
Have you tested this patch?

Tony


> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
>  arch/arm/mach-omap1/clock.c                |   38 ++++++++--------
>  arch/arm/mach-omap1/clock.h                |   64 ++++++++++++++--------------
>  arch/arm/plat-omap/include/mach/hardware.h |    2 +-
>  3 files changed, 52 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
> index 4d0c444..997cfda 100644
> --- a/arch/arm/mach-omap1/clock.c
> +++ b/arch/arm/mach-omap1/clock.c
> @@ -41,7 +41,7 @@ static void omap1_watchdog_recalc(struct clk * clk)
>  
>  static void omap1_uart_recalc(struct clk * clk)
>  {
> -	unsigned int val = __raw_readl(clk->enable_reg);
> +	unsigned int val = __raw_readl(OMAP1_IO_ADDRESS(clk->enable_reg));
>  	if (val & clk->enable_bit)
>  		clk->rate = 48000000;
>  	else
> @@ -372,14 +372,14 @@ static int omap1_set_uart_rate(struct clk * clk, unsigned long rate)
>  {
>  	unsigned int val;
>  
> -	val = __raw_readl(clk->enable_reg);
> +	val = __raw_readl(OMAP1_IO_ADDRESS(clk->enable_reg));
>  	if (rate == 12000000)
>  		val &= ~(1 << clk->enable_bit);
>  	else if (rate == 48000000)
>  		val |= (1 << clk->enable_bit);
>  	else
>  		return -EINVAL;
> -	__raw_writel(val, clk->enable_reg);
> +	__raw_writel(val, OMAP1_IO_ADDRESS(clk->enable_reg));
>  	clk->rate = rate;
>  
>  	return 0;
> @@ -398,8 +398,8 @@ static int omap1_set_ext_clk_rate(struct clk * clk, unsigned long rate)
>  	else
>  		ratio_bits = (dsor - 2) << 2;
>  
> -	ratio_bits |= __raw_readw(clk->enable_reg) & ~0xfd;
> -	__raw_writew(ratio_bits, clk->enable_reg);
> +	ratio_bits |= __raw_readw(OMAP1_IO_ADDRESS(clk->enable_reg)) & ~0xfd;
> +	__raw_writew(ratio_bits, OMAP1_IO_ADDRESS(clk->enable_reg));
>  
>  	return 0;
>  }
> @@ -440,8 +440,8 @@ static void omap1_init_ext_clk(struct clk * clk)
>  	__u16 ratio_bits;
>  
>  	/* Determine current rate and ensure clock is based on 96MHz APLL */
> -	ratio_bits = __raw_readw(clk->enable_reg) & ~1;
> -	__raw_writew(ratio_bits, clk->enable_reg);
> +	ratio_bits = __raw_readw(OMAP1_IO_ADDRESS(clk->enable_reg)) & ~1;
> +	__raw_writew(ratio_bits, OMAP1_IO_ADDRESS(clk->enable_reg));
>  
>  	ratio_bits = (ratio_bits & 0xfc) >> 2;
>  	if (ratio_bits > 6)
> @@ -499,20 +499,20 @@ static int omap1_clk_enable_generic(struct clk *clk)
>  	if (clk->flags & ALWAYS_ENABLED)
>  		return 0;
>  
> -	if (unlikely(clk->enable_reg == NULL)) {
> +	if (unlikely(clk->enable_reg == 0)) {
>  		printk(KERN_ERR "clock.c: Enable for %s without enable code\n",
>  		       clk->name);
>  		return -EINVAL;
>  	}
>  
>  	if (clk->flags & ENABLE_REG_32BIT) {
> -		regval32 = __raw_readl(clk->enable_reg);
> +		regval32 = __raw_readl(OMAP1_IO_ADDRESS(clk->enable_reg));
>  		regval32 |= (1 << clk->enable_bit);
> -		__raw_writel(regval32, clk->enable_reg);
> +		__raw_writel(regval32, OMAP1_IO_ADDRESS(clk->enable_reg));
>  	} else {
> -		regval16 = __raw_readw(clk->enable_reg);
> +		regval16 = __raw_readw(OMAP1_IO_ADDRESS(clk->enable_reg));
>  		regval16 |= (1 << clk->enable_bit);
> -		__raw_writew(regval16, clk->enable_reg);
> +		__raw_writew(regval16, OMAP1_IO_ADDRESS(clk->enable_reg));
>  	}
>  
>  	return 0;
> @@ -523,17 +523,17 @@ static void omap1_clk_disable_generic(struct clk *clk)
>  	__u16 regval16;
>  	__u32 regval32;
>  
> -	if (clk->enable_reg == NULL)
> +	if (clk->enable_reg == 0)
>  		return;
>  
>  	if (clk->flags & ENABLE_REG_32BIT) {
> -		regval32 = __raw_readl(clk->enable_reg);
> +		regval32 = __raw_readl(OMAP1_IO_ADDRESS(clk->enable_reg));
>  		regval32 &= ~(1 << clk->enable_bit);
> -		__raw_writel(regval32, clk->enable_reg);
> +		__raw_writel(regval32, OMAP1_IO_ADDRESS(clk->enable_reg));
>  	} else {
> -		regval16 = __raw_readw(clk->enable_reg);
> +		regval16 = __raw_readw(OMAP1_IO_ADDRESS(clk->enable_reg));
>  		regval16 &= ~(1 << clk->enable_bit);
> -		__raw_writew(regval16, clk->enable_reg);
> +		__raw_writew(regval16, OMAP1_IO_ADDRESS(clk->enable_reg));
>  	}
>  }
>  
> @@ -609,9 +609,9 @@ static void __init omap1_clk_disable_unused(struct clk *clk)
>  
>  	/* Is the clock already disabled? */
>  	if (clk->flags & ENABLE_REG_32BIT)
> -		regval32 = __raw_readl(clk->enable_reg);
> +		regval32 = __raw_readl(OMAP1_IO_ADDRESS(clk->enable_reg));
>  	else
> -		regval32 = __raw_readw(clk->enable_reg);
> +		regval32 = __raw_readw(OMAP1_IOADRESS(clk->enable_reg));
>  
>  	if ((regval32 & (1 << clk->enable_bit)) == 0)
>  		return;
> diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
> index 44eda0f..3f5fe43 100644
> --- a/arch/arm/mach-omap1/clock.h
> +++ b/arch/arm/mach-omap1/clock.h
> @@ -174,7 +174,7 @@ static struct arm_idlect1_clk ck_dpll1out = {
>  		.parent		= &ck_dpll1,
>  		.flags		= CLOCK_IN_OMAP16XX | CLOCK_IDLE_CONTROL |
>  				  ENABLE_REG_32BIT | RATE_PROPAGATES,
> -		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
> +		.enable_reg	= ARM_IDLECT2,
>  		.enable_bit	= EN_CKOUT_ARM,
>  		.recalc		= &followparent_recalc,
>  		.enable		= &omap1_clk_enable_generic,
> @@ -188,7 +188,7 @@ static struct clk sossi_ck = {
>  	.parent		= &ck_dpll1out.clk,
>  	.flags		= CLOCK_IN_OMAP16XX | CLOCK_NO_IDLE_PARENT |
>  			  ENABLE_REG_32BIT,
> -	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_1),
> +	.enable_reg	= MOD_CONF_CTRL_1,
>  	.enable_bit	= 16,
>  	.recalc		= &omap1_sossi_recalc,
>  	.set_rate	= &omap1_set_sossi_rate,
> @@ -215,7 +215,7 @@ static struct arm_idlect1_clk armper_ck = {
>  		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
>  				  CLOCK_IN_OMAP310 | RATE_CKCTL |
>  				  CLOCK_IDLE_CONTROL,
> -		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
> +		.enable_reg	= ARM_IDLECT2,
>  		.enable_bit	= EN_PERCK,
>  		.rate_offset	= CKCTL_PERDIV_OFFSET,
>  		.recalc		= &omap1_ckctl_recalc,
> @@ -229,7 +229,7 @@ static struct clk arm_gpio_ck = {
>  	.name		= "arm_gpio_ck",
>  	.parent		= &ck_dpll1,
>  	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
> -	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
> +	.enable_reg	= ARM_IDLECT2,
>  	.enable_bit	= EN_GPIOCK,
>  	.recalc		= &followparent_recalc,
>  	.enable		= &omap1_clk_enable_generic,
> @@ -242,7 +242,7 @@ static struct arm_idlect1_clk armxor_ck = {
>  		.parent		= &ck_ref,
>  		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
>  				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
> -		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
> +		.enable_reg	= ARM_IDLECT2,
>  		.enable_bit	= EN_XORPCK,
>  		.recalc		= &followparent_recalc,
>  		.enable		= &omap1_clk_enable_generic,
> @@ -257,7 +257,7 @@ static struct arm_idlect1_clk armtim_ck = {
>  		.parent		= &ck_ref,
>  		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
>  				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
> -		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
> +		.enable_reg	= ARM_IDLECT2,
>  		.enable_bit	= EN_TIMCK,
>  		.recalc		= &followparent_recalc,
>  		.enable		= &omap1_clk_enable_generic,
> @@ -272,7 +272,7 @@ static struct arm_idlect1_clk armwdt_ck = {
>  		.parent		= &ck_ref,
>  		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
>  				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
> -		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
> +		.enable_reg	= ARM_IDLECT2,
>  		.enable_bit	= EN_WDTCK,
>  		.recalc		= &omap1_watchdog_recalc,
>  		.enable		= &omap1_clk_enable_generic,
> @@ -300,7 +300,7 @@ static struct clk dsp_ck = {
>  	.parent		= &ck_dpll1,
>  	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
>  			  RATE_CKCTL,
> -	.enable_reg	= OMAP1_IO_ADDRESS(ARM_CKCTL),
> +	.enable_reg	= ARM_CKCTL,
>  	.enable_bit	= EN_DSPCK,
>  	.rate_offset	= CKCTL_DSPDIV_OFFSET,
>  	.recalc		= &omap1_ckctl_recalc,
> @@ -324,7 +324,7 @@ static struct clk dspper_ck = {
>  	.parent		= &ck_dpll1,
>  	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
>  			  RATE_CKCTL,
> -	.enable_reg	= IOMEM(DSP_IDLECT2),
> +	.enable_reg	= DSP_IDLECT2,
>  	.enable_bit	= EN_PERCK,
>  	.rate_offset	= CKCTL_PERDIV_OFFSET,
>  	.recalc		= &omap1_ckctl_recalc_dsp_domain,
> @@ -337,7 +337,7 @@ static struct clk dspxor_ck = {
>  	.name		= "dspxor_ck",
>  	.parent		= &ck_ref,
>  	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
> -	.enable_reg	= IOMEM(DSP_IDLECT2),
> +	.enable_reg	= DSP_IDLECT2,
>  	.enable_bit	= EN_XORPCK,
>  	.recalc		= &followparent_recalc,
>  	.enable		= &omap1_clk_enable_dsp_domain,
> @@ -348,7 +348,7 @@ static struct clk dsptim_ck = {
>  	.name		= "dsptim_ck",
>  	.parent		= &ck_ref,
>  	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
> -	.enable_reg	= IOMEM(DSP_IDLECT2),
> +	.enable_reg	= DSP_IDLECT2,
>  	.enable_bit	= EN_DSPTIMCK,
>  	.recalc		= &followparent_recalc,
>  	.enable		= &omap1_clk_enable_dsp_domain,
> @@ -402,7 +402,7 @@ static struct clk l3_ocpi_ck = {
>  	.name		= "l3_ocpi_ck",
>  	.parent		= &tc_ck.clk,
>  	.flags		= CLOCK_IN_OMAP16XX,
> -	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
> +	.enable_reg	= ARM_IDLECT3,
>  	.enable_bit	= EN_OCPI_CK,
>  	.recalc		= &followparent_recalc,
>  	.enable		= &omap1_clk_enable_generic,
> @@ -413,7 +413,7 @@ static struct clk tc1_ck = {
>  	.name		= "tc1_ck",
>  	.parent		= &tc_ck.clk,
>  	.flags		= CLOCK_IN_OMAP16XX,
> -	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
> +	.enable_reg	= ARM_IDLECT3,
>  	.enable_bit	= EN_TC1_CK,
>  	.recalc		= &followparent_recalc,
>  	.enable		= &omap1_clk_enable_generic,
> @@ -424,7 +424,7 @@ static struct clk tc2_ck = {
>  	.name		= "tc2_ck",
>  	.parent		= &tc_ck.clk,
>  	.flags		= CLOCK_IN_OMAP16XX,
> -	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
> +	.enable_reg	= ARM_IDLECT3,
>  	.enable_bit	= EN_TC2_CK,
>  	.recalc		= &followparent_recalc,
>  	.enable		= &omap1_clk_enable_generic,
> @@ -457,7 +457,7 @@ static struct arm_idlect1_clk api_ck = {
>  		.parent		= &tc_ck.clk,
>  		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
>  				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
> -		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
> +		.enable_reg	= ARM_IDLECT2,
>  		.enable_bit	= EN_APICK,
>  		.recalc		= &followparent_recalc,
>  		.enable		= &omap1_clk_enable_generic,
> @@ -472,7 +472,7 @@ static struct arm_idlect1_clk lb_ck = {
>  		.parent		= &tc_ck.clk,
>  		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
>  				  CLOCK_IDLE_CONTROL,
> -		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
> +		.enable_reg	= ARM_IDLECT2,
>  		.enable_bit	= EN_LBCK,
>  		.recalc		= &followparent_recalc,
>  		.enable		= &omap1_clk_enable_generic,
> @@ -503,7 +503,7 @@ static struct clk lcd_ck_16xx = {
>  	.name		= "lcd_ck",
>  	.parent		= &ck_dpll1,
>  	.flags		= CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP730 | RATE_CKCTL,
> -	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
> +	.enable_reg	= ARM_IDLECT2,
>  	.enable_bit	= EN_LCDCK,
>  	.rate_offset	= CKCTL_LCDDIV_OFFSET,
>  	.recalc		= &omap1_ckctl_recalc,
> @@ -517,7 +517,7 @@ static struct arm_idlect1_clk lcd_ck_1510 = {
>  		.parent		= &ck_dpll1,
>  		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
>  				  RATE_CKCTL | CLOCK_IDLE_CONTROL,
> -		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
> +		.enable_reg	= ARM_IDLECT2,
>  		.enable_bit	= EN_LCDCK,
>  		.rate_offset	= CKCTL_LCDDIV_OFFSET,
>  		.recalc		= &omap1_ckctl_recalc,
> @@ -535,7 +535,7 @@ static struct clk uart1_1510 = {
>  	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
>  			  ENABLE_REG_32BIT | ALWAYS_ENABLED |
>  			  CLOCK_NO_IDLE_PARENT,
> -	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
> +	.enable_reg	= MOD_CONF_CTRL_0,
>  	.enable_bit	= 29,	/* Chooses between 12MHz and 48MHz */
>  	.set_rate	= &omap1_set_uart_rate,
>  	.recalc		= &omap1_uart_recalc,
> @@ -551,7 +551,7 @@ static struct uart_clk uart1_16xx = {
>  		.rate		= 48000000,
>  		.flags		= CLOCK_IN_OMAP16XX | RATE_FIXED |
>  				  ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
> -		.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
> +		.enable_reg	= MOD_CONF_CTRL_0,
>  		.enable_bit	= 29,
>  		.enable		= &omap1_clk_enable_uart_functional,
>  		.disable	= &omap1_clk_disable_uart_functional,
> @@ -567,7 +567,7 @@ static struct clk uart2_ck = {
>  	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
>  			  CLOCK_IN_OMAP310 | ENABLE_REG_32BIT |
>  			  ALWAYS_ENABLED | CLOCK_NO_IDLE_PARENT,
> -	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
> +	.enable_reg	= MOD_CONF_CTRL_0,
>  	.enable_bit	= 30,	/* Chooses between 12MHz and 48MHz */
>  	.set_rate	= &omap1_set_uart_rate,
>  	.recalc		= &omap1_uart_recalc,
> @@ -583,7 +583,7 @@ static struct clk uart3_1510 = {
>  	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
>  			  ENABLE_REG_32BIT | ALWAYS_ENABLED |
>  			  CLOCK_NO_IDLE_PARENT,
> -	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
> +	.enable_reg	= MOD_CONF_CTRL_0,
>  	.enable_bit	= 31,	/* Chooses between 12MHz and 48MHz */
>  	.set_rate	= &omap1_set_uart_rate,
>  	.recalc		= &omap1_uart_recalc,
> @@ -599,7 +599,7 @@ static struct uart_clk uart3_16xx = {
>  		.rate		= 48000000,
>  		.flags		= CLOCK_IN_OMAP16XX | RATE_FIXED |
>  				  ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
> -		.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
> +		.enable_reg	= MOD_CONF_CTRL_0,
>  		.enable_bit	= 31,
>  		.enable		= &omap1_clk_enable_uart_functional,
>  		.disable	= &omap1_clk_disable_uart_functional,
> @@ -613,7 +613,7 @@ static struct clk usb_clko = {	/* 6 MHz output on W4_USB_CLKO */
>  	.rate		= 6000000,
>  	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
>  			  CLOCK_IN_OMAP310 | RATE_FIXED | ENABLE_REG_32BIT,
> -	.enable_reg	= OMAP1_IO_ADDRESS(ULPD_CLOCK_CTRL),
> +	.enable_reg	= ULPD_CLOCK_CTRL,
>  	.enable_bit	= USB_MCLK_EN_BIT,
>  	.enable		= &omap1_clk_enable_generic,
>  	.disable	= &omap1_clk_disable_generic,
> @@ -625,7 +625,7 @@ static struct clk usb_hhc_ck1510 = {
>  	.rate		= 48000000, /* Actually 2 clocks, 12MHz and 48MHz */
>  	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
>  			  RATE_FIXED | ENABLE_REG_32BIT,
> -	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
> +	.enable_reg	= MOD_CONF_CTRL_0,
>  	.enable_bit	= USB_HOST_HHC_UHOST_EN,
>  	.enable		= &omap1_clk_enable_generic,
>  	.disable	= &omap1_clk_disable_generic,
> @@ -638,7 +638,7 @@ static struct clk usb_hhc_ck16xx = {
>  	/* OTG_SYSCON_2.OTG_PADEN == 0 (not 1510-compatible) */
>  	.flags		= CLOCK_IN_OMAP16XX |
>  			  RATE_FIXED | ENABLE_REG_32BIT,
> -	.enable_reg	= OMAP1_IO_ADDRESS(OTG_BASE + 0x08), /* OTG_SYSCON_2 */
> +	.enable_reg	= (OTG_BASE + 0x08), /* OTG_SYSCON_2 */
>  	.enable_bit	= 8 /* UHOST_EN */,
>  	.enable		= &omap1_clk_enable_generic,
>  	.disable	= &omap1_clk_disable_generic,
> @@ -649,7 +649,7 @@ static struct clk usb_dc_ck = {
>  	/* Direct from ULPD, no parent */
>  	.rate		= 48000000,
>  	.flags		= CLOCK_IN_OMAP16XX | RATE_FIXED,
> -	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
> +	.enable_reg	= SOFT_REQ_REG,
>  	.enable_bit	= 4,
>  	.enable		= &omap1_clk_enable_generic,
>  	.disable	= &omap1_clk_disable_generic,
> @@ -660,7 +660,7 @@ static struct clk mclk_1510 = {
>  	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
>  	.rate		= 12000000,
>   	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | RATE_FIXED,
> - 	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
> + 	.enable_reg	= SOFT_REQ_REG,
>   	.enable_bit	= 6,
>  	.enable		= &omap1_clk_enable_generic,
>  	.disable	= &omap1_clk_disable_generic,
> @@ -670,7 +670,7 @@ static struct clk mclk_16xx = {
>  	.name		= "mclk",
>  	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
>  	.flags		= CLOCK_IN_OMAP16XX,
> -	.enable_reg	= OMAP1_IO_ADDRESS(COM_CLK_DIV_CTRL_SEL),
> +	.enable_reg	= COM_CLK_DIV_CTRL_SEL,
>  	.enable_bit	= COM_ULPD_PLL_CLK_REQ,
>  	.set_rate	= &omap1_set_ext_clk_rate,
>  	.round_rate	= &omap1_round_ext_clk_rate,
> @@ -692,7 +692,7 @@ static struct clk bclk_16xx = {
>  	.name		= "bclk",
>  	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
>  	.flags		= CLOCK_IN_OMAP16XX,
> -	.enable_reg	= OMAP1_IO_ADDRESS(SWD_CLK_DIV_CTRL_SEL),
> +	.enable_reg	= SWD_CLK_DIV_CTRL_SEL,
>  	.enable_bit	= SWD_ULPD_PLL_CLK_REQ,
>  	.set_rate	= &omap1_set_ext_clk_rate,
>  	.round_rate	= &omap1_round_ext_clk_rate,
> @@ -709,7 +709,7 @@ static struct clk mmc1_ck = {
>  	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
>  			  CLOCK_IN_OMAP310 | RATE_FIXED | ENABLE_REG_32BIT |
>  			  CLOCK_NO_IDLE_PARENT,
> -	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
> +	.enable_reg	= MOD_CONF_CTRL_0,
>  	.enable_bit	= 23,
>  	.enable		= &omap1_clk_enable_generic,
>  	.disable	= &omap1_clk_disable_generic,
> @@ -723,7 +723,7 @@ static struct clk mmc2_ck = {
>  	.rate		= 48000000,
>  	.flags		= CLOCK_IN_OMAP16XX |
>  			  RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
> -	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
> +	.enable_reg	= MOD_CONF_CTRL_0,
>  	.enable_bit	= 20,
>  	.enable		= &omap1_clk_enable_generic,
>  	.disable	= &omap1_clk_disable_generic,
> diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
> index 3486524..bc994f2 100644
> --- a/arch/arm/plat-omap/include/mach/hardware.h
> +++ b/arch/arm/plat-omap/include/mach/hardware.h
> @@ -89,7 +89,7 @@
>  #define DPLL_CTL		(0xfffecf00)
>  
>  /* DSP clock control. Must use __raw_readw() and __raw_writew() with these */
> -#define DSP_CONFIG_REG_BASE     IOMEM(0xe1008000)
> +#define DSP_CONFIG_REG_BASE     0xe1008000
>  #define DSP_CKCTL		(DSP_CONFIG_REG_BASE + 0x0)
>  #define DSP_IDLECT1		(DSP_CONFIG_REG_BASE + 0x4)
>  #define DSP_IDLECT2		(DSP_CONFIG_REG_BASE + 0x8)
> -- 
> 1.6.0.2.307.gc427
> 

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Temporary fix to boot OMAP1 based boards
Date: Wed, 24 Sep 2008 11:34:48 +0300
Message-ID: <20080924083446.GH5222@atomide.com>
References: <dfeb90390809230823l7c37d15au49c5726c7510718c@mail.gmail.com> <20080924.065137.142952786.Hiroshi.DOYU@nokia.com> <dfeb90390809240005xadef43dhb78c8ae214baab64@mail.gmail.com> <20080924071201.GE5222@atomide.com> <20080924075959.GF5222@atomide.com> <alpine.DEB.2.00.0809240202250.15312@utopia.booyaka.com> <20080924080652.GG5222@atomide.com> <alpine.DEB.2.00.0809240207480.15312@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oC1+HKm2/end4ao3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54628 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533AbYIXIez (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 04:34:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0809240207480.15312@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@booyaka.com>
Cc: Arun KS <arunks@mistralsolutions.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Paul Walmsley <paul@booyaka.com> [080924 11:08]:
> On Wed, 24 Sep 2008, Tony Lindgren wrote:
> 
> > * Paul Walmsley <paul@booyaka.com> [080924 11:03]:
> > > On Wed, 24 Sep 2008, Tony Lindgren wrote:
> > > 
> > > > * Tony Lindgren <tony@atomide.com> [080924 10:12]:
> > > > > * Arun KS <arunks@mistralsolutions.com> [080924 10:05]:
> > > > > > On Wed, Sep 24, 2008 at 9:21 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > How about introducing a new typedef in order to accommodate the
> > > > > > > different size of enable_regs without ifdefs?
> > > > > > >
> > > > > > > I think that this is apparently the case categorized into (a) in
> > > > > > > 'CodyingStyle'.
> > > > > > 
> > > > > > I am not sure which is the right way to do. Is this what you meant?
> > > > > 
> > > > > No, let's not do this. It should be void __iomem * for sure. Most of
> > > > > the omap1 clock registers looks just fine for void __iomem *, let's
> > > > > figure out which registers are broken.
> > > > 
> > > > I've pushed a fix for this. Turns out I missed some conversions to
> > > > void __iomem * while merging code from arm-devel branch. Fix also
> > > > attached.
> > > 
> > > Those registers should be u16 for OMAP2/3.  OMAP1 needs something similar, 
> > > which will also get rid of those casts to void __iomem * - hacking on 
> > > something now ...
> > 
> > Argh, sorry. Yeah it's an offset for omap2/3.. Will revert immediately.
> 
> No problem, it's really my fault - I need to start testing on OMAP1 also.

How about this for a quick fix? It produces now a bunch of warnings
until omap1 clock uses offsets too.

Tony


--oC1+HKm2/end4ao3
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omap1-clock-fix-v2.patch"

>From fff89ca6ab98a359ff114da7db3803b700258319 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 24 Sep 2008 11:31:03 +0300
Subject: [PATCH] Fix omap1 clock issues

This fixes booting, and is a step toward fixing things properly:

- Make enable_reg u32 instead of u16
- Get rid of VIRTUAL_IO_ADDRESS for clocks
- Use __raw_read/write instead of omap_read/write for clock registers

This patch adds a bunch of compile warnings until omap1 clock
also uses offsets.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 90ae0ef..799867c 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -41,7 +41,7 @@ static void omap1_watchdog_recalc(struct clk * clk)
 
 static void omap1_uart_recalc(struct clk * clk)
 {
-	unsigned int val = omap_readl(clk->enable_reg);
+	unsigned int val = __raw_readl(clk->enable_reg);
 	if (val & clk->enable_bit)
 		clk->rate = 48000000;
 	else
@@ -372,14 +372,14 @@ static int omap1_set_uart_rate(struct clk * clk, unsigned long rate)
 {
 	unsigned int val;
 
-	val = omap_readl(clk->enable_reg);
+	val = __raw_readl(clk->enable_reg);
 	if (rate == 12000000)
 		val &= ~(1 << clk->enable_bit);
 	else if (rate == 48000000)
 		val |= (1 << clk->enable_bit);
 	else
 		return -EINVAL;
-	omap_writel(val, clk->enable_reg);
+	__raw_writel(val, clk->enable_reg);
 	clk->rate = rate;
 
 	return 0;
@@ -398,8 +398,8 @@ static int omap1_set_ext_clk_rate(struct clk * clk, unsigned long rate)
 	else
 		ratio_bits = (dsor - 2) << 2;
 
-	ratio_bits |= omap_readw(clk->enable_reg) & ~0xfd;
-	omap_writew(ratio_bits, clk->enable_reg);
+	ratio_bits |= __raw_readw(clk->enable_reg) & ~0xfd;
+	__raw_writew(ratio_bits, clk->enable_reg);
 
 	return 0;
 }
@@ -440,8 +440,8 @@ static void omap1_init_ext_clk(struct clk * clk)
 	__u16 ratio_bits;
 
 	/* Determine current rate and ensure clock is based on 96MHz APLL */
-	ratio_bits = omap_readw(clk->enable_reg) & ~1;
-	omap_writew(ratio_bits, clk->enable_reg);
+	ratio_bits = __raw_readw(clk->enable_reg) & ~1;
+	__raw_writew(ratio_bits, clk->enable_reg);
 
 	ratio_bits = (ratio_bits & 0xfc) >> 2;
 	if (ratio_bits > 6)
@@ -506,25 +506,13 @@ static int omap1_clk_enable_generic(struct clk *clk)
 	}
 
 	if (clk->flags & ENABLE_REG_32BIT) {
-		if (clk->flags & VIRTUAL_IO_ADDRESS) {
-			regval32 = __raw_readl(clk->enable_reg);
-			regval32 |= (1 << clk->enable_bit);
-			__raw_writel(regval32, clk->enable_reg);
-		} else {
-			regval32 = omap_readl(clk->enable_reg);
-			regval32 |= (1 << clk->enable_bit);
-			omap_writel(regval32, clk->enable_reg);
-		}
+		regval32 = __raw_readl(clk->enable_reg);
+		regval32 |= (1 << clk->enable_bit);
+		__raw_writel(regval32, clk->enable_reg);
 	} else {
-		if (clk->flags & VIRTUAL_IO_ADDRESS) {
-			regval16 = __raw_readw(clk->enable_reg);
-			regval16 |= (1 << clk->enable_bit);
-			__raw_writew(regval16, clk->enable_reg);
-		} else {
-			regval16 = omap_readw(clk->enable_reg);
-			regval16 |= (1 << clk->enable_bit);
-			omap_writew(regval16, clk->enable_reg);
-		}
+		regval16 = __raw_readw(clk->enable_reg);
+		regval16 |= (1 << clk->enable_bit);
+		__raw_writew(regval16, clk->enable_reg);
 	}
 
 	return 0;
@@ -539,25 +527,13 @@ static void omap1_clk_disable_generic(struct clk *clk)
 		return;
 
 	if (clk->flags & ENABLE_REG_32BIT) {
-		if (clk->flags & VIRTUAL_IO_ADDRESS) {
-			regval32 = __raw_readl(clk->enable_reg);
-			regval32 &= ~(1 << clk->enable_bit);
-			__raw_writel(regval32, clk->enable_reg);
-		} else {
-			regval32 = omap_readl(clk->enable_reg);
-			regval32 &= ~(1 << clk->enable_bit);
-			omap_writel(regval32, clk->enable_reg);
-		}
+		regval32 = __raw_readl(clk->enable_reg);
+		regval32 &= ~(1 << clk->enable_bit);
+		__raw_writel(regval32, clk->enable_reg);
 	} else {
-		if (clk->flags & VIRTUAL_IO_ADDRESS) {
-			regval16 = __raw_readw(clk->enable_reg);
-			regval16 &= ~(1 << clk->enable_bit);
-			__raw_writew(regval16, clk->enable_reg);
-		} else {
-			regval16 = omap_readw(clk->enable_reg);
-			regval16 &= ~(1 << clk->enable_bit);
-			omap_writew(regval16, clk->enable_reg);
-		}
+		regval16 = __raw_readw(clk->enable_reg);
+		regval16 &= ~(1 << clk->enable_bit);
+		__raw_writew(regval16, clk->enable_reg);
 	}
 }
 
@@ -632,17 +608,10 @@ static void __init omap1_clk_disable_unused(struct clk *clk)
 	}
 
 	/* Is the clock already disabled? */
-	if (clk->flags & ENABLE_REG_32BIT) {
-		if (clk->flags & VIRTUAL_IO_ADDRESS)
-			regval32 = __raw_readl(clk->enable_reg);
-			else
-				regval32 = omap_readl(clk->enable_reg);
-	} else {
-		if (clk->flags & VIRTUAL_IO_ADDRESS)
-			regval32 = __raw_readw(clk->enable_reg);
-		else
-			regval32 = omap_readw(clk->enable_reg);
-	}
+	if (clk->flags & ENABLE_REG_32BIT)
+		regval32 = __raw_readl(clk->enable_reg);
+	else
+		regval32 = __raw_readw(clk->enable_reg);
 
 	if ((regval32 & (1 << clk->enable_bit)) == 0)
 		return;
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index 5635b51..6d4f77d 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -174,7 +174,7 @@ static struct arm_idlect1_clk ck_dpll1out = {
 		.parent		= &ck_dpll1,
 		.flags		= CLOCK_IN_OMAP16XX | CLOCK_IDLE_CONTROL |
 				  ENABLE_REG_32BIT | RATE_PROPAGATES,
-		.enable_reg	= (void __iomem *)ARM_IDLECT2,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_CKOUT_ARM,
 		.recalc		= &followparent_recalc,
 		.enable		= &omap1_clk_enable_generic,
@@ -188,7 +188,7 @@ static struct clk sossi_ck = {
 	.parent		= &ck_dpll1out.clk,
 	.flags		= CLOCK_IN_OMAP16XX | CLOCK_NO_IDLE_PARENT |
 			  ENABLE_REG_32BIT,
-	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_1,
+	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_1),
 	.enable_bit	= 16,
 	.recalc		= &omap1_sossi_recalc,
 	.set_rate	= &omap1_set_sossi_rate,
@@ -215,7 +215,7 @@ static struct arm_idlect1_clk armper_ck = {
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 				  CLOCK_IN_OMAP310 | RATE_CKCTL |
 				  CLOCK_IDLE_CONTROL,
-		.enable_reg	= (void __iomem *)ARM_IDLECT2,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_PERCK,
 		.rate_offset	= CKCTL_PERDIV_OFFSET,
 		.recalc		= &omap1_ckctl_recalc,
@@ -229,7 +229,7 @@ static struct clk arm_gpio_ck = {
 	.name		= "arm_gpio_ck",
 	.parent		= &ck_dpll1,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310,
-	.enable_reg	= (void __iomem *)ARM_IDLECT2,
+	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 	.enable_bit	= EN_GPIOCK,
 	.recalc		= &followparent_recalc,
 	.enable		= &omap1_clk_enable_generic,
@@ -242,7 +242,7 @@ static struct arm_idlect1_clk armxor_ck = {
 		.parent		= &ck_ref,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
-		.enable_reg	= (void __iomem *)ARM_IDLECT2,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_XORPCK,
 		.recalc		= &followparent_recalc,
 		.enable		= &omap1_clk_enable_generic,
@@ -257,7 +257,7 @@ static struct arm_idlect1_clk armtim_ck = {
 		.parent		= &ck_ref,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
-		.enable_reg	= (void __iomem *)ARM_IDLECT2,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_TIMCK,
 		.recalc		= &followparent_recalc,
 		.enable		= &omap1_clk_enable_generic,
@@ -272,7 +272,7 @@ static struct arm_idlect1_clk armwdt_ck = {
 		.parent		= &ck_ref,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
-		.enable_reg	= (void __iomem *)ARM_IDLECT2,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_WDTCK,
 		.recalc		= &omap1_watchdog_recalc,
 		.enable		= &omap1_clk_enable_generic,
@@ -300,7 +300,7 @@ static struct clk dsp_ck = {
 	.parent		= &ck_dpll1,
 	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  RATE_CKCTL,
-	.enable_reg	= (void __iomem *)ARM_CKCTL,
+	.enable_reg	= OMAP1_IO_ADDRESS(ARM_CKCTL),
 	.enable_bit	= EN_DSPCK,
 	.rate_offset	= CKCTL_DSPDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
@@ -323,7 +323,7 @@ static struct clk dspper_ck = {
 	.name		= "dspper_ck",
 	.parent		= &ck_dpll1,
 	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  RATE_CKCTL | VIRTUAL_IO_ADDRESS,
+			  RATE_CKCTL,
 	.enable_reg	= DSP_IDLECT2,
 	.enable_bit	= EN_PERCK,
 	.rate_offset	= CKCTL_PERDIV_OFFSET,
@@ -336,8 +336,7 @@ static struct clk dspper_ck = {
 static struct clk dspxor_ck = {
 	.name		= "dspxor_ck",
 	.parent		= &ck_ref,
-	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  VIRTUAL_IO_ADDRESS,
+	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
 	.enable_reg	= DSP_IDLECT2,
 	.enable_bit	= EN_XORPCK,
 	.recalc		= &followparent_recalc,
@@ -348,8 +347,7 @@ static struct clk dspxor_ck = {
 static struct clk dsptim_ck = {
 	.name		= "dsptim_ck",
 	.parent		= &ck_ref,
-	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
-			  VIRTUAL_IO_ADDRESS,
+	.flags		= CLOCK_IN_OMAP310 | CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX,
 	.enable_reg	= DSP_IDLECT2,
 	.enable_bit	= EN_DSPTIMCK,
 	.recalc		= &followparent_recalc,
@@ -404,7 +402,7 @@ static struct clk l3_ocpi_ck = {
 	.name		= "l3_ocpi_ck",
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP16XX,
-	.enable_reg	= (void __iomem *)ARM_IDLECT3,
+	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
 	.enable_bit	= EN_OCPI_CK,
 	.recalc		= &followparent_recalc,
 	.enable		= &omap1_clk_enable_generic,
@@ -415,7 +413,7 @@ static struct clk tc1_ck = {
 	.name		= "tc1_ck",
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP16XX,
-	.enable_reg	= (void __iomem *)ARM_IDLECT3,
+	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
 	.enable_bit	= EN_TC1_CK,
 	.recalc		= &followparent_recalc,
 	.enable		= &omap1_clk_enable_generic,
@@ -426,7 +424,7 @@ static struct clk tc2_ck = {
 	.name		= "tc2_ck",
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP16XX,
-	.enable_reg	= (void __iomem *)ARM_IDLECT3,
+	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT3),
 	.enable_bit	= EN_TC2_CK,
 	.recalc		= &followparent_recalc,
 	.enable		= &omap1_clk_enable_generic,
@@ -459,7 +457,7 @@ static struct arm_idlect1_clk api_ck = {
 		.parent		= &tc_ck.clk,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 				  CLOCK_IN_OMAP310 | CLOCK_IDLE_CONTROL,
-		.enable_reg	= (void __iomem *)ARM_IDLECT2,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_APICK,
 		.recalc		= &followparent_recalc,
 		.enable		= &omap1_clk_enable_generic,
@@ -474,7 +472,7 @@ static struct arm_idlect1_clk lb_ck = {
 		.parent		= &tc_ck.clk,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
 				  CLOCK_IDLE_CONTROL,
-		.enable_reg	= (void __iomem *)ARM_IDLECT2,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_LBCK,
 		.recalc		= &followparent_recalc,
 		.enable		= &omap1_clk_enable_generic,
@@ -505,7 +503,7 @@ static struct clk lcd_ck_16xx = {
 	.name		= "lcd_ck",
 	.parent		= &ck_dpll1,
 	.flags		= CLOCK_IN_OMAP16XX | CLOCK_IN_OMAP730 | RATE_CKCTL,
-	.enable_reg	= (void __iomem *)ARM_IDLECT2,
+	.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 	.enable_bit	= EN_LCDCK,
 	.rate_offset	= CKCTL_LCDDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
@@ -519,7 +517,7 @@ static struct arm_idlect1_clk lcd_ck_1510 = {
 		.parent		= &ck_dpll1,
 		.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
 				  RATE_CKCTL | CLOCK_IDLE_CONTROL,
-		.enable_reg	= (void __iomem *)ARM_IDLECT2,
+		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_LCDCK,
 		.rate_offset	= CKCTL_LCDDIV_OFFSET,
 		.recalc		= &omap1_ckctl_recalc,
@@ -537,7 +535,7 @@ static struct clk uart1_1510 = {
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
 			  ENABLE_REG_32BIT | ALWAYS_ENABLED |
 			  CLOCK_NO_IDLE_PARENT,
-	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
+	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 	.enable_bit	= 29,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
 	.recalc		= &omap1_uart_recalc,
@@ -553,7 +551,7 @@ static struct uart_clk uart1_16xx = {
 		.rate		= 48000000,
 		.flags		= CLOCK_IN_OMAP16XX | RATE_FIXED |
 				  ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
-		.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
+		.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 		.enable_bit	= 29,
 		.enable		= &omap1_clk_enable_uart_functional,
 		.disable	= &omap1_clk_disable_uart_functional,
@@ -569,7 +567,7 @@ static struct clk uart2_ck = {
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  CLOCK_IN_OMAP310 | ENABLE_REG_32BIT |
 			  ALWAYS_ENABLED | CLOCK_NO_IDLE_PARENT,
-	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
+	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 	.enable_bit	= 30,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
 	.recalc		= &omap1_uart_recalc,
@@ -585,7 +583,7 @@ static struct clk uart3_1510 = {
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
 			  ENABLE_REG_32BIT | ALWAYS_ENABLED |
 			  CLOCK_NO_IDLE_PARENT,
-	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
+	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 	.enable_bit	= 31,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
 	.recalc		= &omap1_uart_recalc,
@@ -601,7 +599,7 @@ static struct uart_clk uart3_16xx = {
 		.rate		= 48000000,
 		.flags		= CLOCK_IN_OMAP16XX | RATE_FIXED |
 				  ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
-		.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
+		.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 		.enable_bit	= 31,
 		.enable		= &omap1_clk_enable_uart_functional,
 		.disable	= &omap1_clk_disable_uart_functional,
@@ -615,7 +613,7 @@ static struct clk usb_clko = {	/* 6 MHz output on W4_USB_CLKO */
 	.rate		= 6000000,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  CLOCK_IN_OMAP310 | RATE_FIXED | ENABLE_REG_32BIT,
-	.enable_reg	= (void __iomem *)ULPD_CLOCK_CTRL,
+	.enable_reg	= OMAP1_IO_ADDRESS(ULPD_CLOCK_CTRL),
 	.enable_bit	= USB_MCLK_EN_BIT,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
@@ -627,7 +625,7 @@ static struct clk usb_hhc_ck1510 = {
 	.rate		= 48000000, /* Actually 2 clocks, 12MHz and 48MHz */
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 |
 			  RATE_FIXED | ENABLE_REG_32BIT,
-	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
+	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 	.enable_bit	= USB_HOST_HHC_UHOST_EN,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
@@ -640,7 +638,7 @@ static struct clk usb_hhc_ck16xx = {
 	/* OTG_SYSCON_2.OTG_PADEN == 0 (not 1510-compatible) */
 	.flags		= CLOCK_IN_OMAP16XX |
 			  RATE_FIXED | ENABLE_REG_32BIT,
-	.enable_reg	= (void __iomem *)OTG_BASE + 0x08 /* OTG_SYSCON_2 */,
+	.enable_reg	= OMAP1_IO_ADDRESS(OTG_BASE + 0x08), /* OTG_SYSCON_2 */
 	.enable_bit	= 8 /* UHOST_EN */,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
@@ -651,7 +649,7 @@ static struct clk usb_dc_ck = {
 	/* Direct from ULPD, no parent */
 	.rate		= 48000000,
 	.flags		= CLOCK_IN_OMAP16XX | RATE_FIXED,
-	.enable_reg	= (void __iomem *)SOFT_REQ_REG,
+	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
 	.enable_bit	= 4,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
@@ -662,7 +660,7 @@ static struct clk mclk_1510 = {
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.rate		= 12000000,
  	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP310 | RATE_FIXED,
- 	.enable_reg	= (void __iomem *)SOFT_REQ_REG,
+ 	.enable_reg	= OMAP1_IO_ADDRESS(SOFT_REQ_REG),
  	.enable_bit	= 6,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
@@ -672,7 +670,7 @@ static struct clk mclk_16xx = {
 	.name		= "mclk",
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.flags		= CLOCK_IN_OMAP16XX,
-	.enable_reg	= (void __iomem *)COM_CLK_DIV_CTRL_SEL,
+	.enable_reg	= OMAP1_IO_ADDRESS(COM_CLK_DIV_CTRL_SEL),
 	.enable_bit	= COM_ULPD_PLL_CLK_REQ,
 	.set_rate	= &omap1_set_ext_clk_rate,
 	.round_rate	= &omap1_round_ext_clk_rate,
@@ -694,7 +692,7 @@ static struct clk bclk_16xx = {
 	.name		= "bclk",
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.flags		= CLOCK_IN_OMAP16XX,
-	.enable_reg	= (void __iomem *)SWD_CLK_DIV_CTRL_SEL,
+	.enable_reg	= OMAP1_IO_ADDRESS(SWD_CLK_DIV_CTRL_SEL),
 	.enable_bit	= SWD_ULPD_PLL_CLK_REQ,
 	.set_rate	= &omap1_set_ext_clk_rate,
 	.round_rate	= &omap1_round_ext_clk_rate,
@@ -712,7 +710,7 @@ static struct clk mmc1_ck = {
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  CLOCK_IN_OMAP310 | RATE_FIXED | ENABLE_REG_32BIT |
 			  CLOCK_NO_IDLE_PARENT,
-	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
+	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 	.enable_bit	= 23,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
@@ -726,7 +724,7 @@ static struct clk mmc2_ck = {
 	.rate		= 48000000,
 	.flags		= CLOCK_IN_OMAP16XX |
 			  RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
-	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
+	.enable_reg	= OMAP1_IO_ADDRESS(MOD_CONF_CTRL_0),
 	.enable_bit	= 20,
 	.enable		= &omap1_clk_enable_generic,
 	.disable	= &omap1_clk_disable_generic,
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index f26ad8c..9088925 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -67,7 +67,7 @@ struct clk {
 	struct clk		*parent;
 	unsigned long		rate;
 	__u32			flags;
-	u16			enable_reg;
+	u32			enable_reg;
 	__u8			enable_bit;
 	__s8			usecount;
 	u8			idlest_bit;
@@ -137,7 +137,7 @@ extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
 #define VIRTUAL_CLOCK		(1 << 3)	/* Composite clock from table */
 #define ALWAYS_ENABLED		(1 << 4)	/* Clock cannot be disabled */
 #define ENABLE_REG_32BIT	(1 << 5)	/* Use 32-bit access */
-#define VIRTUAL_IO_ADDRESS	(1 << 6)	/* Clock in virtual address */
+
 #define CLOCK_IDLE_CONTROL	(1 << 7)
 #define CLOCK_NO_IDLE_PARENT	(1 << 8)
 #define DELAYED_APP		(1 << 9)	/* Delay application of clock */

--oC1+HKm2/end4ao3--

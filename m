From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] Replace clk_use/unuse with clk_enable/disable, please test
Date: Thu, 5 Jan 2006 15:20:48 -0800
Message-ID: <20060105232047.GD4741@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7iMSBzlTiPOCCT2k"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

Following patch removes clk_use/unuse for omap, and replaces them with
clk_enable/disable.

The reason for this patch is that omap clock framework has drifted away
from the common arm implementation. Also having the two different set of
functions was confusing.

Generic arm clock framework will remove clk_use/unuse soon, and this
patch makes omap follow the other arm clock framework implementations.

Please comment and test it, I'm planning on pushing it soon. For any new
drivers not yet in our tree the update is minimal. Just replace
clk_use/unuse with clk_enable/disable.

Toshihiro, can you please check the dsp related changes? The problem
there seems to be that the dsp code may enable certain clocks and then
they stay on during suspend.

I've just added clk_enable() clk_disable() in few places there to shut
down any clocks left on from dsp code.

Also, does api_ck_handle reference count work properly in
dsp_cpustat_update()? It seems that clk_enable(api_ck_handle) and
clk_disable(api_ck_handle) may get called multiple times...

Regards,

Tony


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline;
	filename=patch-omap-rename-clocks-2006-01-05-151614

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 4277eee..a98415f 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -50,10 +50,10 @@ static int omap1_clk_enable_dsp_domain(s
 {
 	int retval;
 
-	retval = omap1_clk_use(&api_ck.clk);
+	retval = omap1_clk_enable(&api_ck.clk);
 	if (!retval) {
-		retval = omap1_clk_enable(clk);
-		omap1_clk_unuse(&api_ck.clk);
+		retval = omap1_clk_enable_generic(clk);
+		omap1_clk_disable(&api_ck.clk);
 	}
 
 	return retval;
@@ -61,9 +61,9 @@ static int omap1_clk_enable_dsp_domain(s
 
 static void omap1_clk_disable_dsp_domain(struct clk *clk)
 {
-	if (omap1_clk_use(&api_ck.clk) == 0) {
-		omap1_clk_disable(clk);
-		omap1_clk_unuse(&api_ck.clk);
+	if (omap1_clk_enable(&api_ck.clk) == 0) {
+		omap1_clk_disable_generic(clk);
+		omap1_clk_disable(&api_ck.clk);
 	}
 }
 
@@ -72,7 +72,7 @@ static int omap1_clk_enable_uart_functio
 	int ret;
 	struct uart_clk *uclk;
 
-	ret = omap1_clk_enable(clk);
+	ret = omap1_clk_enable_generic(clk);
 	if (ret == 0) {
 		/* Set smart idle acknowledgement mode */
 		uclk = (struct uart_clk *)clk;
@@ -91,7 +91,7 @@ static void omap1_clk_disable_uart_funct
 	uclk = (struct uart_clk *)clk;
 	omap_writeb((omap_readb(uclk->sysc_addr) & ~0x18), uclk->sysc_addr);
 
-	omap1_clk_disable(clk);
+	omap1_clk_disable_generic(clk);
 }
 
 static void omap1_clk_allow_idle(struct clk *clk)
@@ -230,9 +230,9 @@ static void omap1_ckctl_recalc_dsp_domai
 	 * Note that DSP_CKCTL virt addr = phys addr, so
 	 * we must use __raw_readw() instead of omap_readw().
 	 */
-	omap1_clk_use(&api_ck.clk);
+	omap1_clk_enable(&api_ck.clk);
 	dsor = 1 << (3 & (__raw_readw(DSP_CKCTL) >> clk->rate_offset));
-	omap1_clk_unuse(&api_ck.clk);
+	omap1_clk_disable(&api_ck.clk);
 
 	if (unlikely(clk->rate == clk->parent->rate / dsor))
 		return; /* No change, quick exit */
@@ -412,12 +412,12 @@ static void omap1_init_ext_clk(struct cl
 	clk-> rate = 96000000 / dsor;
 }
 
-static int omap1_clk_use(struct clk *clk)
+static int omap1_clk_enable(struct clk *clk)
 {
 	int ret = 0;
 	if (clk->usecount++ == 0) {
 		if (likely(clk->parent)) {
-			ret = omap1_clk_use(clk->parent);
+			ret = omap1_clk_enable(clk->parent);
 
 			if (unlikely(ret != 0)) {
 				clk->usecount--;
@@ -432,7 +432,7 @@ static int omap1_clk_use(struct clk *clk
 		ret = clk->enable(clk);
 
 		if (unlikely(ret != 0) && clk->parent) {
-			omap1_clk_unuse(clk->parent);
+			omap1_clk_disable(clk->parent);
 			clk->usecount--;
 		}
 	}
@@ -440,12 +440,12 @@ static int omap1_clk_use(struct clk *clk
 	return ret;
 }
 
-static void omap1_clk_unuse(struct clk *clk)
+static void omap1_clk_disable(struct clk *clk)
 {
 	if (clk->usecount > 0 && !(--clk->usecount)) {
 		clk->disable(clk);
 		if (likely(clk->parent)) {
-			omap1_clk_unuse(clk->parent);
+			omap1_clk_disable(clk->parent);
 			if (clk->flags & CLOCK_NO_IDLE_PARENT)
 				if (!cpu_is_omap24xx())
 					omap1_clk_allow_idle(clk->parent);
@@ -453,7 +453,7 @@ static void omap1_clk_unuse(struct clk *
 	}
 }
 
-static int omap1_clk_enable(struct clk *clk)
+static int omap1_clk_enable_generic(struct clk *clk)
 {
 	__u16 regval16;
 	__u32 regval32;
@@ -492,7 +492,7 @@ static int omap1_clk_enable(struct clk *
 	return 0;
 }
 
-static void omap1_clk_disable(struct clk *clk)
+static void omap1_clk_disable_generic(struct clk *clk)
 {
 	__u16 regval16;
 	__u32 regval32;
@@ -654,8 +654,8 @@ late_initcall(omap1_late_clk_reset);
 #endif
 
 static struct clk_functions omap1_clk_functions = {
-	.clk_use		= omap1_clk_use,
-	.clk_unuse		= omap1_clk_unuse,
+	.clk_enable		= omap1_clk_enable,
+	.clk_disable		= omap1_clk_disable,
 	.clk_round_rate		= omap1_clk_round_rate,
 	.clk_set_rate		= omap1_clk_set_rate,
 };
@@ -780,9 +780,9 @@ int __init omap1_clk_init(void)
 	 * Only enable those clocks we will need, let the drivers
 	 * enable other clocks as necessary
 	 */
-	clk_use(&armper_ck.clk);
-	clk_use(&armxor_ck.clk);
-	clk_use(&armtim_ck.clk); /* This should be done by timer code */
+	clk_enable(&armper_ck.clk);
+	clk_enable(&armxor_ck.clk);
+	clk_enable(&armtim_ck.clk); /* This should be done by timer code */
 
 	if (cpu_is_omap1510())
 		clk_enable(&arm_gpio_ck);
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index f3bdfb5..4f18d1b 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -13,8 +13,8 @@
 #ifndef __ARCH_ARM_MACH_OMAP1_CLOCK_H
 #define __ARCH_ARM_MACH_OMAP1_CLOCK_H
 
-static int omap1_clk_enable(struct clk * clk);
-static void omap1_clk_disable(struct clk * clk);
+static int omap1_clk_enable_generic(struct clk * clk);
+static void omap1_clk_disable_generic(struct clk * clk);
 static void omap1_ckctl_recalc(struct clk * clk);
 static void omap1_watchdog_recalc(struct clk * clk);
 static void omap1_ckctl_recalc_dsp_domain(struct clk * clk);
@@ -30,8 +30,8 @@ static long omap1_round_ext_clk_rate(str
 static void omap1_init_ext_clk(struct clk * clk);
 static int omap1_select_table_rate(struct clk * clk, unsigned long rate);
 static long omap1_round_to_table_rate(struct clk * clk, unsigned long rate);
-static int omap1_clk_use(struct clk *clk);
-static void omap1_clk_unuse(struct clk *clk);
+static int omap1_clk_enable(struct clk *clk);
+static void omap1_clk_disable(struct clk *clk);
 
 struct mpu_rate {
 	unsigned long		rate;
@@ -152,8 +152,8 @@ static struct clk ck_ref = {
 	.rate		= 12000000,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  ALWAYS_ENABLED,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk ck_dpll1 = {
@@ -161,8 +161,8 @@ static struct clk ck_dpll1 = {
 	.parent		= &ck_ref,
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  RATE_PROPAGATES | ALWAYS_ENABLED,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct arm_idlect1_clk ck_dpll1out = {
@@ -173,8 +173,8 @@ static struct arm_idlect1_clk ck_dpll1ou
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_CKOUT_ARM,
 		.recalc		= &followparent_recalc,
-		.enable		= &omap1_clk_enable,
-		.disable	= &omap1_clk_disable,
+		.enable		= &omap1_clk_enable_generic,
+		.disable	= &omap1_clk_disable_generic,
 	},
 	.idlect_shift	= 12,
 };
@@ -186,8 +186,8 @@ static struct clk arm_ck = {
 			  RATE_CKCTL | RATE_PROPAGATES | ALWAYS_ENABLED,
 	.rate_offset	= CKCTL_ARMDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct arm_idlect1_clk armper_ck = {
@@ -200,8 +200,8 @@ static struct arm_idlect1_clk armper_ck 
 		.enable_bit	= EN_PERCK,
 		.rate_offset	= CKCTL_PERDIV_OFFSET,
 		.recalc		= &omap1_ckctl_recalc,
-		.enable		= &omap1_clk_enable,
-		.disable	= &omap1_clk_disable,
+		.enable		= &omap1_clk_enable_generic,
+		.disable	= &omap1_clk_disable_generic,
 	},
 	.idlect_shift	= 2,
 };
@@ -213,8 +213,8 @@ static struct clk arm_gpio_ck = {
 	.enable_reg	= (void __iomem *)ARM_IDLECT2,
 	.enable_bit	= EN_GPIOCK,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct arm_idlect1_clk armxor_ck = {
@@ -226,8 +226,8 @@ static struct arm_idlect1_clk armxor_ck 
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_XORPCK,
 		.recalc		= &followparent_recalc,
-		.enable		= &omap1_clk_enable,
-		.disable	= &omap1_clk_disable,
+		.enable		= &omap1_clk_enable_generic,
+		.disable	= &omap1_clk_disable_generic,
 	},
 	.idlect_shift	= 1,
 };
@@ -241,8 +241,8 @@ static struct arm_idlect1_clk armtim_ck 
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_TIMCK,
 		.recalc		= &followparent_recalc,
-		.enable		= &omap1_clk_enable,
-		.disable	= &omap1_clk_disable,
+		.enable		= &omap1_clk_enable_generic,
+		.disable	= &omap1_clk_disable_generic,
 	},
 	.idlect_shift	= 9,
 };
@@ -256,8 +256,8 @@ static struct arm_idlect1_clk armwdt_ck 
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_WDTCK,
 		.recalc		= &omap1_watchdog_recalc,
-		.enable		= &omap1_clk_enable,
-		.disable	= &omap1_clk_disable,
+		.enable		= &omap1_clk_enable_generic,
+		.disable	= &omap1_clk_disable_generic,
 	},
 	.idlect_shift	= 0,
 };
@@ -272,8 +272,8 @@ static struct clk arminth_ck16xx = {
 	 *
 	 * 1510 version is in TC clocks.
 	 */
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk dsp_ck = {
@@ -285,8 +285,8 @@ static struct clk dsp_ck = {
 	.enable_bit	= EN_DSPCK,
 	.rate_offset	= CKCTL_DSPDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk dspmmu_ck = {
@@ -296,8 +296,8 @@ static struct clk dspmmu_ck = {
 			  RATE_CKCTL | ALWAYS_ENABLED,
 	.rate_offset	= CKCTL_DSPMMUDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk dspper_ck = {
@@ -349,8 +349,8 @@ static struct arm_idlect1_clk tc_ck = {
 				  CLOCK_IDLE_CONTROL,
 		.rate_offset	= CKCTL_TCDIV_OFFSET,
 		.recalc		= &omap1_ckctl_recalc,
-		.enable		= &omap1_clk_enable,
-		.disable	= &omap1_clk_disable,
+		.enable		= &omap1_clk_enable_generic,
+		.disable	= &omap1_clk_disable_generic,
 	},
 	.idlect_shift	= 6,
 };
@@ -364,8 +364,8 @@ static struct clk arminth_ck1510 = {
 	 *
 	 * 16xx version is in MPU clocks.
 	 */
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk tipb_ck = {
@@ -374,8 +374,8 @@ static struct clk tipb_ck = {
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP1510 | ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk l3_ocpi_ck = {
@@ -386,8 +386,8 @@ static struct clk l3_ocpi_ck = {
 	.enable_reg	= (void __iomem *)ARM_IDLECT3,
 	.enable_bit	= EN_OCPI_CK,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk tc1_ck = {
@@ -397,8 +397,8 @@ static struct clk tc1_ck = {
 	.enable_reg	= (void __iomem *)ARM_IDLECT3,
 	.enable_bit	= EN_TC1_CK,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk tc2_ck = {
@@ -408,8 +408,8 @@ static struct clk tc2_ck = {
 	.enable_reg	= (void __iomem *)ARM_IDLECT3,
 	.enable_bit	= EN_TC2_CK,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk dma_ck = {
@@ -419,8 +419,8 @@ static struct clk dma_ck = {
 	.flags		= CLOCK_IN_OMAP1510 | CLOCK_IN_OMAP16XX |
 			  ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk dma_lcdfree_ck = {
@@ -428,8 +428,8 @@ static struct clk dma_lcdfree_ck = {
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct arm_idlect1_clk api_ck = {
@@ -441,8 +441,8 @@ static struct arm_idlect1_clk api_ck = {
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_APICK,
 		.recalc		= &followparent_recalc,
-		.enable		= &omap1_clk_enable,
-		.disable	= &omap1_clk_disable,
+		.enable		= &omap1_clk_enable_generic,
+		.disable	= &omap1_clk_disable_generic,
 	},
 	.idlect_shift	= 8,
 };
@@ -455,8 +455,8 @@ static struct arm_idlect1_clk lb_ck = {
 		.enable_reg	= (void __iomem *)ARM_IDLECT2,
 		.enable_bit	= EN_LBCK,
 		.recalc		= &followparent_recalc,
-		.enable		= &omap1_clk_enable,
-		.disable	= &omap1_clk_disable,
+		.enable		= &omap1_clk_enable_generic,
+		.disable	= &omap1_clk_disable_generic,
 	},
 	.idlect_shift	= 4,
 };
@@ -466,8 +466,8 @@ static struct clk rhea1_ck = {
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk rhea2_ck = {
@@ -475,8 +475,8 @@ static struct clk rhea2_ck = {
 	.parent		= &tc_ck.clk,
 	.flags		= CLOCK_IN_OMAP16XX | ALWAYS_ENABLED,
 	.recalc		= &followparent_recalc,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk lcd_ck_16xx = {
@@ -487,8 +487,8 @@ static struct clk lcd_ck_16xx = {
 	.enable_bit	= EN_LCDCK,
 	.rate_offset	= CKCTL_LCDDIV_OFFSET,
 	.recalc		= &omap1_ckctl_recalc,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct arm_idlect1_clk lcd_ck_1510 = {
@@ -501,8 +501,8 @@ static struct arm_idlect1_clk lcd_ck_151
 		.enable_bit	= EN_LCDCK,
 		.rate_offset	= CKCTL_LCDDIV_OFFSET,
 		.recalc		= &omap1_ckctl_recalc,
-		.enable		= &omap1_clk_enable,
-		.disable	= &omap1_clk_disable,
+		.enable		= &omap1_clk_enable_generic,
+		.disable	= &omap1_clk_disable_generic,
 	},
 	.idlect_shift	= 3,
 };
@@ -518,8 +518,8 @@ static struct clk uart1_1510 = {
 	.enable_bit	= 29,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
 	.recalc		= &omap1_uart_recalc,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct uart_clk uart1_16xx = {
@@ -550,8 +550,8 @@ static struct clk uart2_ck = {
 	.enable_bit	= 30,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
 	.recalc		= &omap1_uart_recalc,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk uart3_1510 = {
@@ -565,8 +565,8 @@ static struct clk uart3_1510 = {
 	.enable_bit	= 31,	/* Chooses between 12MHz and 48MHz */
 	.set_rate	= &omap1_set_uart_rate,
 	.recalc		= &omap1_uart_recalc,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct uart_clk uart3_16xx = {
@@ -593,8 +593,8 @@ static struct clk usb_clko = {	/* 6 MHz 
 			  RATE_FIXED | ENABLE_REG_32BIT,
 	.enable_reg	= (void __iomem *)ULPD_CLOCK_CTRL,
 	.enable_bit	= USB_MCLK_EN_BIT,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk usb_hhc_ck1510 = {
@@ -605,8 +605,8 @@ static struct clk usb_hhc_ck1510 = {
 			  RATE_FIXED | ENABLE_REG_32BIT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= USB_HOST_HHC_UHOST_EN,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk usb_hhc_ck16xx = {
@@ -618,8 +618,8 @@ static struct clk usb_hhc_ck16xx = {
 			  RATE_FIXED | ENABLE_REG_32BIT,
 	.enable_reg	= (void __iomem *)OTG_BASE + 0x08 /* OTG_SYSCON_2 */,
 	.enable_bit	= 8 /* UHOST_EN */,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk usb_dc_ck = {
@@ -629,8 +629,8 @@ static struct clk usb_dc_ck = {
 	.flags		= CLOCK_IN_OMAP16XX | RATE_FIXED,
 	.enable_reg	= (void __iomem *)SOFT_REQ_REG,
 	.enable_bit	= 4,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk mclk_1510 = {
@@ -638,8 +638,8 @@ static struct clk mclk_1510 = {
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.rate		= 12000000,
 	.flags		= CLOCK_IN_OMAP1510 | RATE_FIXED,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk mclk_16xx = {
@@ -651,8 +651,8 @@ static struct clk mclk_16xx = {
 	.set_rate	= &omap1_set_ext_clk_rate,
 	.round_rate	= &omap1_round_ext_clk_rate,
 	.init		= &omap1_init_ext_clk,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk bclk_1510 = {
@@ -660,8 +660,8 @@ static struct clk bclk_1510 = {
 	/* Direct from ULPD, no parent. May be enabled by ext hardware. */
 	.rate		= 12000000,
 	.flags		= CLOCK_IN_OMAP1510 | RATE_FIXED,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk bclk_16xx = {
@@ -673,8 +673,8 @@ static struct clk bclk_16xx = {
 	.set_rate	= &omap1_set_ext_clk_rate,
 	.round_rate	= &omap1_round_ext_clk_rate,
 	.init		= &omap1_init_ext_clk,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk mmc1_ck = {
@@ -686,8 +686,8 @@ static struct clk mmc1_ck = {
 			  RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 23,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk mmc2_ck = {
@@ -699,8 +699,8 @@ static struct clk mmc2_ck = {
 			  RATE_FIXED | ENABLE_REG_32BIT | CLOCK_NO_IDLE_PARENT,
 	.enable_reg	= (void __iomem *)MOD_CONF_CTRL_0,
 	.enable_bit	= 20,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk virtual_ck_mpu = {
@@ -711,8 +711,8 @@ static struct clk virtual_ck_mpu = {
 	.recalc		= &followparent_recalc,
 	.set_rate	= &omap1_select_table_rate,
 	.round_rate	= &omap1_round_to_table_rate,
-	.enable		= &omap1_clk_enable,
-	.disable	= &omap1_clk_disable,
+	.enable		= &omap1_clk_enable_generic,
+	.disable	= &omap1_clk_disable_generic,
 };
 
 static struct clk * onchip_clks[] = {
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index 6810cfb..c404682 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -146,7 +146,7 @@ void __init omap_serial_init(void)
 			if (IS_ERR(uart1_ck))
 				printk("Could not get uart1_ck\n");
 			else {
-				clk_use(uart1_ck);
+				clk_enable(uart1_ck);
 				if (cpu_is_omap1510())
 					clk_set_rate(uart1_ck, 12000000);
 			}
@@ -166,7 +166,7 @@ void __init omap_serial_init(void)
 			if (IS_ERR(uart2_ck))
 				printk("Could not get uart2_ck\n");
 			else {
-				clk_use(uart2_ck);
+				clk_enable(uart2_ck);
 				if (cpu_is_omap1510())
 					clk_set_rate(uart2_ck, 12000000);
 				else
@@ -188,7 +188,7 @@ void __init omap_serial_init(void)
 			if (IS_ERR(uart3_ck))
 				printk("Could not get uart3_ck\n");
 			else {
-				clk_use(uart3_ck);
+				clk_enable(uart3_ck);
 				if (cpu_is_omap1510())
 					clk_set_rate(uart3_ck, 12000000);
 			}
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 440db51..74786a4 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -113,7 +113,7 @@ static void omap2_clk_fixed_enable(struc
 /* Enables clock without considering parent dependencies or use count
  * REVISIT: Maybe change this to use clk->enable like on omap1?
  */
-static int omap2_clk_enable(struct clk * clk)
+static int _omap2_clk_enable(struct clk * clk)
 {
 	u32 regval32;
 
@@ -152,7 +152,7 @@ static void omap2_clk_fixed_disable(stru
 }
 
 /* Disables clock without considering parent dependencies or use count */
-static void omap2_clk_disable(struct clk *clk)
+static void _omap2_clk_disable(struct clk *clk)
 {
 	u32 regval32;
 
@@ -169,23 +169,23 @@ static void omap2_clk_disable(struct clk
 	__raw_writel(regval32, clk->enable_reg);
 }
 
-static int omap2_clk_use(struct clk *clk)
+static int omap2_clk_enable(struct clk *clk)
 {
 	int ret = 0;
 
 	if (clk->usecount++ == 0) {
 		if (likely((u32)clk->parent))
-			ret = omap2_clk_use(clk->parent);
+			ret = omap2_clk_enable(clk->parent);
 
 		if (unlikely(ret != 0)) {
 			clk->usecount--;
 			return ret;
 		}
 
-		ret = omap2_clk_enable(clk);
+		ret = _omap2_clk_enable(clk);
 
 		if (unlikely(ret != 0) && clk->parent) {
-			omap2_clk_unuse(clk->parent);
+			omap2_clk_disable(clk->parent);
 			clk->usecount--;
 		}
 	}
@@ -193,12 +193,12 @@ static int omap2_clk_use(struct clk *clk
 	return ret;
 }
 
-static void omap2_clk_unuse(struct clk *clk)
+static void omap2_clk_disable(struct clk *clk)
 {
 	if (clk->usecount > 0 && !(--clk->usecount)) {
-		omap2_clk_disable(clk);
+		_omap2_clk_disable(clk);
 		if (likely((u32)clk->parent))
-			omap2_clk_unuse(clk->parent);
+			omap2_clk_disable(clk->parent);
 	}
 }
 
@@ -822,7 +822,7 @@ static int omap2_clk_set_parent(struct c
 		reg = (void __iomem *)src_sel;
 
 		if (clk->usecount > 0)
-			omap2_clk_disable(clk);
+			_omap2_clk_disable(clk);
 
 		/* Set new source value (previous dividers if any in effect) */
 		reg_val = __raw_readl(reg) & ~(field_mask << src_off);
@@ -833,7 +833,7 @@ static int omap2_clk_set_parent(struct c
 			__raw_writel(0x1, (void __iomem *)&PRCM_CLKCFG_CTRL);
 
 		if (clk->usecount > 0)
-			omap2_clk_enable(clk);
+			_omap2_clk_enable(clk);
 
 		clk->parent = new_parent;
 
@@ -948,8 +948,6 @@ static int omap2_select_table_rate(struc
 static struct clk_functions omap2_clk_functions = {
 	.clk_enable		= omap2_clk_enable,
 	.clk_disable		= omap2_clk_disable,
-	.clk_use		= omap2_clk_use,
-	.clk_unuse		= omap2_clk_unuse,
 	.clk_round_rate		= omap2_clk_round_rate,
 	.clk_set_rate		= omap2_clk_set_rate,
 	.clk_set_parent		= omap2_clk_set_parent,
@@ -994,7 +992,7 @@ static void __init omap2_disable_unused_
 			continue;
 
 		printk(KERN_INFO "Disabling unused clock \"%s\"\n", ck->name);
-		omap2_clk_disable(ck);
+		_omap2_clk_disable(ck);
 	}
 }
 late_initcall(omap2_disable_unused_clocks);
@@ -1069,10 +1067,10 @@ int __init omap2_clk_init(void)
 	 * Only enable those clocks we will need, let the drivers
 	 * enable other clocks as necessary
 	 */
-	clk_use(&sync_32k_ick);
-	clk_use(&omapctrl_ick);
+	clk_enable(&sync_32k_ick);
+	clk_enable(&omapctrl_ick);
 	if (cpu_is_omap2430())
-		clk_use(&sdrc_ick);
+		clk_enable(&sdrc_ick);
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 07f1efa..d33e2ba 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -24,7 +24,7 @@ static void omap2_propagate_rate(struct 
 static void omap2_mpu_recalc(struct clk * clk);
 static int omap2_select_table_rate(struct clk * clk, unsigned long rate);
 static long omap2_round_to_table_rate(struct clk * clk, unsigned long rate);
-static void omap2_clk_unuse(struct clk *clk);
+static void omap2_clk_disable(struct clk *clk);
 static void omap2_sys_clk_recalc(struct clk * clk);
 static u32 omap2_clksel_to_divisor(u32 div_sel, u32 field_val);
 static u32 omap2_clksel_get_divisor(struct clk *clk);
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index f4df04f..818b669 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -119,14 +119,14 @@ void __init omap_serial_init()
 			if (IS_ERR(uart1_ick))
 				printk("Could not get uart1_ick\n");
 			else {
-				clk_use(uart1_ick);
+				clk_enable(uart1_ick);
 			}
 
 			uart1_fck = clk_get(NULL, "uart1_fck");
 			if (IS_ERR(uart1_fck))
 				printk("Could not get uart1_fck\n");
 			else {
-				clk_use(uart1_fck);
+				clk_enable(uart1_fck);
 			}
 			break;
 		case 1:
@@ -134,14 +134,14 @@ void __init omap_serial_init()
 			if (IS_ERR(uart2_ick))
 				printk("Could not get uart2_ick\n");
 			else {
-				clk_use(uart2_ick);
+				clk_enable(uart2_ick);
 			}
 
 			uart2_fck = clk_get(NULL, "uart2_fck");
 			if (IS_ERR(uart2_fck))
 				printk("Could not get uart2_fck\n");
 			else {
-				clk_use(uart2_fck);
+				clk_enable(uart2_fck);
 			}
 			break;
 		case 2:
@@ -149,14 +149,14 @@ void __init omap_serial_init()
 			if (IS_ERR(uart3_ick))
 				printk("Could not get uart3_ick\n");
 			else {
-				clk_use(uart3_ick);
+				clk_enable(uart3_ick);
 			}
 
 			uart3_fck = clk_get(NULL, "uart3_fck");
 			if (IS_ERR(uart3_fck))
 				printk("Could not get uart3_fck\n");
 			else {
-				clk_use(uart3_fck);
+				clk_enable(uart3_fck);
 			}
 			break;
 		}
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 9ec1144..c44b861 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -103,7 +103,7 @@ static void __init omap2_gp_timer_init(v
 	if (IS_ERR(sys_ck))
 		printk(KERN_ERR "Could not get sys_ck\n");
 	else {
-		clk_use(sys_ck);
+		clk_enable(sys_ck);
 		tick_period = clk_get_rate(sys_ck) / 100;
 		clk_put(sys_ck);
 	}
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index befb326..14abc66 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -59,12 +59,8 @@ int clk_enable(struct clk *clk)
 	int ret = 0;
 
 	spin_lock_irqsave(&clockfw_lock, flags);
-	if (clk->enable)
-		ret = clk->enable(clk);
-	else if (arch_clock->clk_enable)
+	if (arch_clock->clk_enable)
 		ret = arch_clock->clk_enable(clk);
-	else
-		printk(KERN_ERR "Could not enable clock %s\n", clk->name);
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 
 	return ret;
@@ -76,41 +72,12 @@ void clk_disable(struct clk *clk)
 	unsigned long flags;
 
 	spin_lock_irqsave(&clockfw_lock, flags);
-	if (clk->disable)
-		clk->disable(clk);
-	else if (arch_clock->clk_disable)
+	if (arch_clock->clk_disable)
 		arch_clock->clk_disable(clk);
-	else
-		printk(KERN_ERR "Could not disable clock %s\n", clk->name);
 	spin_unlock_irqrestore(&clockfw_lock, flags);
 }
 EXPORT_SYMBOL(clk_disable);
 
-int clk_use(struct clk *clk)
-{
-	unsigned long flags;
-	int ret = 0;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-	if (arch_clock->clk_use)
-		ret = arch_clock->clk_use(clk);
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(clk_use);
-
-void clk_unuse(struct clk *clk)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-	if (arch_clock->clk_unuse)
-		arch_clock->clk_unuse(clk);
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-}
-EXPORT_SYMBOL(clk_unuse);
-
 int clk_get_usecount(struct clk *clk)
 {
 	unsigned long flags;
diff --git a/arch/arm/plat-omap/dsp/dsp_common.c b/arch/arm/plat-omap/dsp/dsp_common.c
index 88481a1..1fe6099 100644
--- a/arch/arm/plat-omap/dsp/dsp_common.c
+++ b/arch/arm/plat-omap/dsp/dsp_common.c
@@ -171,7 +171,7 @@ static void dsp_gbl_idle(void)
 	unsigned char idle_text[GBL_IDLE_TEXT_SIZE] = GBL_IDLE_TEXT_INIT;
 
 	__dsp_reset();
-	clk_use(api_ck_handle);
+	clk_enable(api_ck_handle);
 
 #if 0
 	omap_writew(MPUI_DSP_BOOT_CONFIG_IDLE, MPUI_DSP_BOOT_CONFIG);
@@ -185,7 +185,7 @@ static void dsp_gbl_idle(void)
 
 	__dsp_run();
 	udelay(100);	/* to make things stable */
-	clk_unuse(api_ck_handle);
+	clk_disable(api_ck_handle);
 }
 
 static void dsp_cpu_idle(void)
@@ -194,7 +194,7 @@ static void dsp_cpu_idle(void)
 	unsigned char icrh, icrl;
 
 	__dsp_reset();
-	clk_use(api_ck_handle);
+	clk_enable(api_ck_handle);
 
 	/*
 	 * icr settings:
@@ -216,7 +216,7 @@ static void dsp_cpu_idle(void)
 		dsp_set_rstvect(idle_boot_base);
 	__dsp_run();
 	udelay(100);	/* to make things stable */
-	clk_unuse(api_ck_handle);
+	clk_disable(api_ck_handle);
 }
 
 void dsp_set_idle_boot_base(unsigned long adr, size_t size)
@@ -243,7 +243,7 @@ static int init_done;
 
 /*
  * note: if we are in pm_suspend / pm_resume function,
- * we are out of clk_use() management.
+ * we are out of clk_enable() management.
  */
 void omap_dsp_pm_suspend(void)
 {
@@ -255,6 +255,8 @@ void omap_dsp_pm_suspend(void)
 	if (! init_done)
 		return;
 
+	/* DSP code may have turned this on, make sure it gets turned off */
+	clk_enable(dsp_ck_handle);
 	clk_disable(dsp_ck_handle);
 
 	/* Stop any DSP domain clocks */
@@ -263,6 +265,7 @@ void omap_dsp_pm_suspend(void)
 	save_dsp_idlect2 = __raw_readw(DSP_IDLECT2);
 	__raw_writew(0, DSP_IDLECT2);
 	omap_writew(save_arm_idlect2, ARM_IDLECT2);
+	clk_disable(api_ck_handle);
 }
 
 void omap_dsp_pm_resume(void)
@@ -277,6 +280,7 @@ void omap_dsp_pm_resume(void)
 	clk_enable(api_ck_handle);
 	__raw_writew(save_dsp_idlect2, DSP_IDLECT2);
 	omap_writew(save_arm_idlect2, ARM_IDLECT2);
+	clk_disable(api_ck_handle);
 
 	/* Run DSP, if it was running */
 	if (cpustat.stat != CPUSTAT_RESET)
@@ -340,7 +344,7 @@ static void dsp_cpustat_update(void)
 	if (cpustat.req == CPUSTAT_RUN) {
 		if (cpustat.stat < CPUSTAT_RUN) {
 			__dsp_reset();
-			clk_use(api_ck_handle);
+			clk_enable(api_ck_handle);
 			udelay(10);
 			__dsp_run();
 			cpustat.stat = CPUSTAT_RUN;
@@ -353,7 +357,7 @@ static void dsp_cpustat_update(void)
 
 	if (cpustat.stat == CPUSTAT_RUN) {
 		disable_irq(INT_DSP_MMU);
-		clk_unuse(api_ck_handle);
+		clk_disable(api_ck_handle);
 	}
 
 	/*
diff --git a/arch/arm/plat-omap/dsp/dsp_mem.c b/arch/arm/plat-omap/dsp/dsp_mem.c
index fbce6eb..1bd2669 100644
--- a/arch/arm/plat-omap/dsp/dsp_mem.c
+++ b/arch/arm/plat-omap/dsp/dsp_mem.c
@@ -662,7 +662,7 @@ static int dsp_mmu_load_tlb(unsigned lon
 	int lbase, victim;
 	unsigned short cam_l_va_mask;
 
-	clk_use(dsp_ck_handle);
+	clk_enable(dsp_ck_handle);
 
 	get_tlb_lock(&lbase, NULL);
 	for (victim = 0; victim < lbase; victim++) {
@@ -700,7 +700,7 @@ found_victim:
 		lbase++;
 	set_tlb_lock(lbase, lbase);
 
-	clk_unuse(dsp_ck_handle);
+	clk_disable(dsp_ck_handle);
 	return 0;
 }
 
@@ -710,7 +710,7 @@ static int dsp_mmu_clear_tlb(unsigned lo
 	int i;
 	int max_valid = 0;
 
-	clk_use(dsp_ck_handle);
+	clk_enable(dsp_ck_handle);
 
 	get_tlb_lock(&lbase, NULL);
 	for (i = 0; i < lbase; i++) {
@@ -740,18 +740,18 @@ static int dsp_mmu_clear_tlb(unsigned lo
 	/* set new lock base */
 	set_tlb_lock(max_valid+1, max_valid+1);
 
-	clk_unuse(dsp_ck_handle);
+	clk_disable(dsp_ck_handle);
 	return 0;
 }
 
 static void dsp_mmu_gflush(void)
 {
-	clk_use(dsp_ck_handle);
+	clk_enable(dsp_ck_handle);
 
 	__dsp_mmu_gflush();
 	set_tlb_lock(1, 1);
 
-	clk_unuse(dsp_ck_handle);
+	clk_disable(dsp_ck_handle);
 }
 
 /*
@@ -1149,7 +1149,7 @@ static void dsp_mmu_init(void)
 	unsigned long phys;
 	void *virt;
 
-	clk_use(dsp_ck_handle);
+	clk_enable(dsp_ck_handle);
 	down_write(&exmap_sem);
 
 	dsp_mmu_disable();	/* clear all */
@@ -1173,7 +1173,7 @@ static void dsp_mmu_init(void)
 	dsp_mmu_load_tlb(DSP_INIT_PAGE, phys, DSPMMU_CAM_L_SLST_4KB,
 			 DSPMMU_CAM_L_P, DSPMMU_RAM_L_AP_FA);
 	up_write(&exmap_sem);
-	clk_unuse(dsp_ck_handle);
+	clk_disable(dsp_ck_handle);
 }
 
 static void dsp_mmu_shutdown(void)
@@ -1279,7 +1279,7 @@ static ssize_t intmem_read(struct file *
 
 	if (p >= size)
 		return 0;
-	clk_use(api_ck_handle);
+	clk_enable(api_ck_handle);
 	read = count;
 	if (count > size - p)
 		read = size - p;
@@ -1289,7 +1289,7 @@ static ssize_t intmem_read(struct file *
 	}
 	*ppos += read;
 out:
-	clk_unuse(api_ck_handle);
+	clk_disable(api_ck_handle);
 	return read;
 }
 
@@ -1341,7 +1341,7 @@ static ssize_t intmem_write(struct file 
 
 	if (p >= size)
 		return 0;
-	clk_use(api_ck_handle);
+	clk_enable(api_ck_handle);
 	written = count;
 	if (count > size - p)
 		written = size - p;
@@ -1351,7 +1351,7 @@ static ssize_t intmem_write(struct file 
 	}
 	*ppos += written;
 out:
-	clk_unuse(api_ck_handle);
+	clk_disable(api_ck_handle);
 	return written;
 }
 
@@ -1481,7 +1481,7 @@ static ssize_t mmu_show(struct device *d
 	int lbase, victim;
 	int i;
 
-	clk_use(dsp_ck_handle);
+	clk_enable(dsp_ck_handle);
 	down_read(&exmap_sem);
 
 	get_tlb_lock(&lbase, &victim);
@@ -1534,7 +1534,7 @@ static ssize_t mmu_show(struct device *d
 	set_tlb_lock(lbase, victim);
 
 	up_read(&exmap_sem);
-	clk_unuse(dsp_ck_handle);
+	clk_disable(dsp_ck_handle);
 	return len;
 }
 
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 19e0273..687aefe 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -884,19 +884,19 @@ static int __init _omap_gpio_init(void)
 		if (IS_ERR(gpio_ick))
 			printk("Could not get arm_gpio_ck\n");
 		else
-			clk_use(gpio_ick);
+			clk_enable(gpio_ick);
 	}
 	if (cpu_is_omap24xx()) {
 		gpio_ick = clk_get(NULL, "gpios_ick");
 		if (IS_ERR(gpio_ick))
 			printk("Could not get gpios_ick\n");
 		else
-			clk_use(gpio_ick);
+			clk_enable(gpio_ick);
 		gpio_fck = clk_get(NULL, "gpios_fck");
 		if (IS_ERR(gpio_ick))
 			printk("Could not get gpios_fck\n");
 		else
-			clk_use(gpio_fck);
+			clk_enable(gpio_fck);
 	}
 
 #ifdef CONFIG_ARCH_OMAP15XX
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index b0a393d..1775762 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -192,11 +192,11 @@ static void omap_mcbsp_dsp_request(void)
 {
 	if (cpu_is_omap1510() || cpu_is_omap16xx()) {
 		omap_dsp_request_mem();
-		clk_use(mcbsp_dsp_ck);
-		clk_use(mcbsp_api_ck);
+		clk_enable(mcbsp_dsp_ck);
+		clk_enable(mcbsp_api_ck);
 
 		/* enable 12MHz clock to mcbsp 1 & 3 */
-		clk_use(mcbsp_dspxor_ck);
+		clk_enable(mcbsp_dspxor_ck);
 
 		/*
 		 * DSP external peripheral reset
@@ -211,9 +211,9 @@ static void omap_mcbsp_dsp_free(void)
 {
 	if (cpu_is_omap1510() || cpu_is_omap16xx()) {
 		omap_dsp_release_mem();
-		clk_unuse(mcbsp_dspxor_ck);
-		clk_unuse(mcbsp_dsp_ck);
-		clk_unuse(mcbsp_api_ck);
+		clk_disable(mcbsp_dspxor_ck);
+		clk_disable(mcbsp_dsp_ck);
+		clk_disable(mcbsp_api_ck);
 	}
 }
 
diff --git a/arch/arm/plat-omap/ocpi.c b/arch/arm/plat-omap/ocpi.c
index b861482..4b87b12 100644
--- a/arch/arm/plat-omap/ocpi.c
+++ b/arch/arm/plat-omap/ocpi.c
@@ -62,9 +62,6 @@ int ocpi_enable(void)
 	if (!cpu_is_omap16xx())
 		return -ENODEV;
 
-	/* Make sure there's clock for OCPI */
-	clk_enable(ocpi_ck);
-
 	/* Enable access for OHCI in OCPI */
 	val = omap_readl(OCPI_PROT);
 	val &= ~0xff;
@@ -88,7 +85,7 @@ static int __init omap_ocpi_init(void)
 	if (IS_ERR(ocpi_ck))
 		return PTR_ERR(ocpi_ck);
 
-	clk_use(ocpi_ck);
+	clk_enable(ocpi_ck);
 	ocpi_enable();
 	printk("OMAP OCPI interconnect driver loaded\n");
 
@@ -102,7 +99,7 @@ static void __exit omap_ocpi_exit(void)
 	if (!cpu_is_omap16xx())
 		return;
 
-	clk_unuse(ocpi_ck);
+	clk_disable(ocpi_ck);
 	clk_put(ocpi_ck);
 }
 
diff --git a/arch/arm/plat-omap/timer32k.c b/arch/arm/plat-omap/timer32k.c
index 9e74ce5..5078d22 100644
--- a/arch/arm/plat-omap/timer32k.c
+++ b/arch/arm/plat-omap/timer32k.c
@@ -293,13 +293,13 @@ static __init void omap_init_32k_timer(v
 		if (IS_ERR(gpt1_ick))
 			printk(KERN_ERR "Could not get gpt1_ick\n");
 		else
-			clk_use(gpt1_ick);
+			clk_enable(gpt1_ick);
 
 		gpt1_fck = clk_get(NULL, "gpt1_fck");
 		if (IS_ERR(gpt1_fck))
 			printk(KERN_ERR "Could not get gpt1_fck\n");
 		else
-			clk_use(gpt1_fck);
+			clk_enable(gpt1_fck);
 
 		mdelay(100);		/* Wait for clocks to stabilize */
 
diff --git a/drivers/char/omap-rng.c b/drivers/char/omap-rng.c
index a40f999..42a3232 100644
--- a/drivers/char/omap-rng.c
+++ b/drivers/char/omap-rng.c
@@ -83,7 +83,7 @@ static int __init rng_init(void)
 			printk(KERN_ERR "omap-rng.c: Could not get rng_ick\n");
 			return PTR_ERR(rng_ick);
 		}
-		clk_use(rng_ick);
+		clk_enable(rng_ick);
 	}
 
 	printk("OMAP Random Number Generator ver. %02x\n",
diff --git a/drivers/char/watchdog/omap_wdt.c b/drivers/char/watchdog/omap_wdt.c
index 8f6fa68..95d483a 100644
--- a/drivers/char/watchdog/omap_wdt.c
+++ b/drivers/char/watchdog/omap_wdt.c
@@ -120,12 +120,12 @@ static int omap_wdt_open(struct inode *i
 		return -EBUSY;
 
 	if (cpu_is_omap16xx()) {
-		clk_use(armwdt_ck);	/* Enable the clock */
+		clk_enable(armwdt_ck);	/* Enable the clock */
 	}
 
 	if (cpu_is_omap24xx()) {
-		clk_use(mpu_wdt_ick);	/* Enable the interface clock */
-		clk_use(mpu_wdt_fck);	/* Enable the functional clock */
+		clk_enable(mpu_wdt_ick);	/* Enable the interface clock */
+		clk_enable(mpu_wdt_fck);	/* Enable the functional clock */
 	}
 
 	/* initialize prescaler */
@@ -149,14 +149,14 @@ static int omap_wdt_release(struct inode
 	omap_wdt_disable();
 
 	if (cpu_is_omap16xx()) {
-		clk_unuse(armwdt_ck);	/* Disable the clock */
+		clk_disable(armwdt_ck);	/* Disable the clock */
 		clk_put(armwdt_ck);
 		armwdt_ck = NULL;
 	}
 
 	if (cpu_is_omap24xx()) {
-		clk_unuse(mpu_wdt_ick);	/* Disable the clock */
-		clk_unuse(mpu_wdt_fck);	/* Disable the clock */
+		clk_disable(mpu_wdt_ick);	/* Disable the clock */
+		clk_disable(mpu_wdt_fck);	/* Disable the clock */
 		clk_put(mpu_wdt_ick);
 		clk_put(mpu_wdt_fck);
 		mpu_wdt_ick = NULL;
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index c217d51..899161a 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -555,11 +555,11 @@ static void omap_i2c_24xx_enable_clocks(
 {
 	if (cpu_is_omap24xx()) {
 		if (enable) {
-			clk_use(omap_i2c_dev->iclk);
-			clk_use(omap_i2c_dev->fclk);
+			clk_enable(omap_i2c_dev->iclk);
+			clk_enable(omap_i2c_dev->fclk);
 		} else {
-			clk_unuse(omap_i2c_dev->iclk);
-			clk_unuse(omap_i2c_dev->fclk);
+			clk_disable(omap_i2c_dev->iclk);
+			clk_disable(omap_i2c_dev->fclk);
 		}
 	}
 }
diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
index dc530d6..b27700c 100644
--- a/drivers/mmc/omap.c
+++ b/drivers/mmc/omap.c
@@ -240,7 +240,7 @@ mmc_omap_start_command(struct mmc_omap_h
 	if (host->data && !(host->data->flags & MMC_DATA_WRITE))
 		cmdreg |= 1 << 15;
 
-	clk_use(host->fclk);
+	clk_enable(host->fclk);
 
 	OMAP_MMC_WRITE(host->base, CTO, 200);
 	OMAP_MMC_WRITE(host->base, ARGL, cmd->arg & 0xffff);
@@ -274,7 +274,7 @@ mmc_omap_xfer_done(struct mmc_omap_host 
 	}
 	host->data = NULL;
 	host->sg_len = 0;
-	clk_unuse(host->fclk);
+	clk_disable(host->fclk);
 
 	/* NOTE:  MMC layer will sometimes poll-wait CMD13 next, issuing
 	 * dozens of requests until the card finishes writing data.
@@ -378,7 +378,7 @@ mmc_omap_cmd_done(struct mmc_omap_host *
 	if (host->data == NULL || cmd->error != MMC_ERR_NONE) {
 		DBG("MMC%d: End request, err %x\n", host->id, cmd->error);
 		host->mrq = NULL;
-		clk_unuse(host->fclk);
+		clk_disable(host->fclk);
 		mmc_request_done(host->mmc, cmd->mrq);
 	}
 }
@@ -1131,7 +1131,7 @@ static void mmc_omap_set_ios(struct mmc_
 	}
 	host->hw_bus_mode = host->bus_mode;
 
-	clk_use(host->fclk);
+	clk_enable(host->fclk);
 
 	/* On insanely high arm_per frequencies something sometimes
 	 * goes somehow out of sync, and the POW bit is not being set,
@@ -1147,7 +1147,7 @@ static void mmc_omap_set_ios(struct mmc_
 		while (0 == (OMAP_MMC_READ(host->base, STAT) & 1));
 		OMAP_MMC_WRITE(host->base, STAT, 1);
 	}
-	clk_unuse(host->fclk);
+	clk_disable(host->fclk);
 }
 
 static int mmc_omap_get_ro(struct mmc_host *mmc)
@@ -1203,7 +1203,7 @@ static int __init mmc_omap_probe(struct 
 		host->iclk = clk_get(&pdev->dev, "mmc_ick");
 		if (IS_ERR(host->iclk))
 			goto out;
-		clk_use(host->iclk);
+		clk_enable(host->iclk);
 	}
 
 	if (!cpu_is_omap24xx())
diff --git a/drivers/mtd/nand/omap-hw.c b/drivers/mtd/nand/omap-hw.c
index 6afab16..793fe0d 100644
--- a/drivers/mtd/nand/omap-hw.c
+++ b/drivers/mtd/nand/omap-hw.c
@@ -740,7 +740,7 @@ static int __init omap_nand_init(void)
 
 	omap_nand_clk = clk_get(NULL, "armper_ck");
 	BUG_ON(omap_nand_clk == NULL);
-	clk_use(omap_nand_clk);
+	clk_enable(omap_nand_clk);
 
 	l = nand_read_reg(NND_REVISION);	
 	printk(KERN_INFO "omap-hw-nand: OMAP NAND Controller rev. %d.%d\n", l>>4, l & 0xf);
@@ -838,7 +838,7 @@ module_init(omap_nand_init);
  */
 static void __exit omap_nand_cleanup (void)
 {
-	clk_unuse(omap_nand_clk);
+	clk_disable(omap_nand_clk);
 	clk_put(omap_nand_clk);
 	nand_release(omap_mtd);
 	kfree(omap_mtd);
diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index c66d6fb..8d3e6d1 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -1315,12 +1315,12 @@ static void omap_udc_enable_clock(int en
 		return;
 
 	if (enable) {
-		clk_use(udc->dc_clk);
-		clk_use(udc->hhc_clk);
+		clk_enable(udc->dc_clk);
+		clk_enable(udc->hhc_clk);
 		udelay(100);
 	} else {
-		clk_unuse(udc->hhc_clk);
-		clk_unuse(udc->dc_clk);
+		clk_disable(udc->hhc_clk);
+		clk_disable(udc->dc_clk);
 	}
 }
 
@@ -2775,8 +2775,8 @@ static int __init omap_udc_probe(struct 
 		hhc_clk = clk_get(&pdev->dev, "usb_hhc_ck");
 		BUG_ON(IS_ERR(dc_clk) || IS_ERR(hhc_clk));
 		/* can't use omap_udc_enable_clock yet */
-		clk_use(dc_clk);
-		clk_use(hhc_clk);
+		clk_enable(dc_clk);
+		clk_enable(hhc_clk);
 		udelay(100);
 	}
 
@@ -2905,8 +2905,8 @@ bad_on_1710:
 	if (cpu_is_omap16xx()) {
 		udc->dc_clk = dc_clk;
 		udc->hhc_clk = hhc_clk;
-		clk_unuse(hhc_clk);
-		clk_unuse(dc_clk);
+		clk_disable(hhc_clk);
+		clk_disable(dc_clk);
 	}
 
 	create_proc_file();
@@ -2930,8 +2930,8 @@ cleanup0:
 		put_device(xceiv->dev);
 
  	if (cpu_is_omap16xx()) {
- 		clk_unuse(hhc_clk);
- 		clk_unuse(dc_clk);
+ 		clk_disable(hhc_clk);
+ 		clk_disable(dc_clk);
  		clk_put(hhc_clk);
  		clk_put(dc_clk);
  	}
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index a0ad788..e10bb25 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -73,13 +73,13 @@ static int host_initialized;
 static void omap_ohci_clock_power(int on)
 {
 	if (on) {
-		clk_use(usb_dc_ck);
-		clk_use(usb_host_ck);
+		clk_enable(usb_dc_ck);
+		clk_enable(usb_host_ck);
 		/* guesstimate for T5 == 1x 32K clock + APLL lock time */
 		udelay(100);
 	} else {
-		clk_unuse(usb_host_ck);
-		clk_unuse(usb_dc_ck);
+		clk_disable(usb_host_ck);
+		clk_disable(usb_dc_ck);
 	}
 }
 
diff --git a/drivers/video/omap/dispc.c b/drivers/video/omap/dispc.c
index 87ef57e..bb8be06 100644
--- a/drivers/video/omap/dispc.c
+++ b/drivers/video/omap/dispc.c
@@ -638,20 +638,20 @@ static void put_dss_clocks(void)
 static void enable_lcd_clocks(int enable)
 {
 	if (enable) {
-		clk_use(dispc.dss_ick);
-		clk_use(dispc.dss1_fck);
+		clk_enable(dispc.dss_ick);
+		clk_enable(dispc.dss1_fck);
 	} else {
-		clk_unuse(dispc.dss1_fck);
-		clk_unuse(dispc.dss_ick);
+		clk_disable(dispc.dss1_fck);
+		clk_disable(dispc.dss_ick);
 	}
 }
 
 static void enable_digit_clocks(int enable)
 {
 	if (enable)
-		clk_use(dispc.dss_54m_fck);
+		clk_enable(dispc.dss_54m_fck);
 	else
-		clk_unuse(dispc.dss_54m_fck);
+		clk_disable(dispc.dss_54m_fck);
 }
 
 static void omap_dispc_suspend(void)
diff --git a/drivers/video/omap/lcdc.c b/drivers/video/omap/lcdc.c
index 5700d25..c5551e2 100644
--- a/drivers/video/omap/lcdc.c
+++ b/drivers/video/omap/lcdc.c
@@ -603,7 +603,7 @@ static int omap_lcdc_init(struct omapfb_
 		pr_err("failed to adjust LCD rate\n");
 		goto fail1;
 	}
-	clk_use(omap_lcdc.lcd_ck);
+	clk_enable(omap_lcdc.lcd_ck);
 
 	r = request_irq(OMAP_LCDC_IRQ, lcdc_irq_handler, 0, "omap-lcdc",
 			omap_lcdc.fbdev);
@@ -638,7 +638,7 @@ fail4:
 fail3:
 	free_irq(OMAP_LCDC_IRQ, omap_lcdc.fbdev);
 fail2:
-	clk_unuse(omap_lcdc.lcd_ck);
+	clk_disable(omap_lcdc.lcd_ck);
 fail1:
 	clk_put(omap_lcdc.lcd_ck);
 fail0:
@@ -652,7 +652,7 @@ static void omap_lcdc_cleanup(void)
 			      omap_lcdc.vram_virt, omap_lcdc.vram_phys);
 	omap_free_lcd_dma();
 	free_irq(OMAP_LCDC_IRQ, omap_lcdc.fbdev);
-	clk_unuse(omap_lcdc.lcd_ck);
+	clk_disable(omap_lcdc.lcd_ck);
 	clk_put(omap_lcdc.lcd_ck);
 }
 
diff --git a/include/asm-arm/arch-omap/clock.h b/include/asm-arm/arch-omap/clock.h
index 740c297..46a0402 100644
--- a/include/asm-arm/arch-omap/clock.h
+++ b/include/asm-arm/arch-omap/clock.h
@@ -38,8 +38,6 @@ struct clk {
 struct clk_functions {
 	int		(*clk_enable)(struct clk *clk);
 	void		(*clk_disable)(struct clk *clk);
-	int		(*clk_use)(struct clk *clk);
-	void		(*clk_unuse)(struct clk *clk);
 	long		(*clk_round_rate)(struct clk *clk, unsigned long rate);
 	int		(*clk_set_rate)(struct clk *clk, unsigned long rate);
 	int		(*clk_set_parent)(struct clk *clk, struct clk *parent);
diff --git a/sound/arm/omap-aic23.c b/sound/arm/omap-aic23.c
index cc49f08..5d9a63a 100644
--- a/sound/arm/omap-aic23.c
+++ b/sound/arm/omap-aic23.c
@@ -759,7 +759,7 @@ int omap_aic23_clock_on(void)
 		return -ECANCELED;
 	}
 
-	clk_use(aic23_mclk);
+	clk_enable(aic23_mclk);
 
 	printk(KERN_DEBUG
 		"MCLK = %d [%d], usecount = %d\n",
@@ -787,7 +787,7 @@ int omap_aic23_clock_off(void)
 			       CODEC_CLOCK);
 		}
 
-		clk_unuse(aic23_mclk);
+		clk_disable(aic23_mclk);
 	}
 	
 	audio_aic23_write(POWER_DOWN_CONTROL_ADDR,
diff --git a/sound/oss/omap-audio-aic23.c b/sound/oss/omap-audio-aic23.c
index 218f15d..30ac0bd 100644
--- a/sound/oss/omap-audio-aic23.c
+++ b/sound/oss/omap-audio-aic23.c
@@ -689,7 +689,7 @@ static int __init audio_aic23_init(void)
 			}
 		}
 
-                clk_use( aic23_mclk );
+                clk_enable( aic23_mclk );
 
                 DPRINTK("MCLK = %d [%d], usecount = %d\n",(uint)clk_get_rate( aic23_mclk ), 
                         CODEC_CLOCK, clk_get_usecount( aic23_mclk));

--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--7iMSBzlTiPOCCT2k--

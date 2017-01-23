From: Andrew Murray <amurray@embedded-bits.co.uk>
Subject: [PATCH v2] ARM: OMAP1/2: clock: Remove unused mpurate cmdline option
Date: Mon, 23 Jan 2017 19:59:54 +0000
Message-ID: <1485201594-23583-1-git-send-email-amurray@embedded-bits.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Andrew Murray <amurray@embedded-bits.co.uk>, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The 'mpurate' option, historically used for specifying an initial
MPU rate at boot, no longer has any effect due to the supporting
code being removed as it was 'wrong and dangerous' [1].

This patch removes the remaining dead code associated with the
__setup macros to avoid confusion and reduce bloat.

[1] https://patchwork.kernel.org/patch/5954631/
---
Changes since v1:

 * Remove related omap2_clk_print_new_rates function which is also unused
   (this was previously used to print clock rates after use of mpurate)
---
 arch/arm/mach-omap1/clock.c | 20 ---------------
 arch/arm/mach-omap1/clock.h |  2 --
 arch/arm/mach-omap2/clock.c | 61 ---------------------------------------------
 arch/arm/mach-omap2/clock.h |  4 ---
 4 files changed, 87 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 4f5fd4a..43e3e18 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -720,26 +720,6 @@ EXPORT_SYMBOL(clk_get_parent);
  * OMAP specific clock functions shared between omap1 and omap2
  */
 
-int __initdata mpurate;
-
-/*
- * By default we use the rate set by the bootloader.
- * You can override this with mpurate= cmdline option.
- */
-static int __init omap_clk_setup(char *str)
-{
-	get_option(&str, &mpurate);
-
-	if (!mpurate)
-		return 1;
-
-	if (mpurate < 1000)
-		mpurate *= 1000000;
-
-	return 1;
-}
-__setup("mpurate=", omap_clk_setup);
-
 /* Used for clocks that always have same value as the parent clock */
 unsigned long followparent_recalc(struct clk *clk)
 {
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index 1e4918a..f2d1be2 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -173,8 +173,6 @@ struct clk_functions {
 	void		(*clk_disable_unused)(struct clk *clk);
 };
 
-extern int mpurate;
-
 extern int clk_init(struct clk_functions *custom_clocks);
 extern void clk_preinit(struct clk *clk);
 extern int clk_register(struct clk *clk);
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index d058125..1270afd 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -78,8 +78,6 @@ int __init omap2_clk_setup_ll_ops(void)
  * OMAP2+ specific clock functions
  */
 
-/* Private functions */
-
 /* Public functions */
 
 /**
@@ -112,65 +110,6 @@ void omap2_init_clk_clkdm(struct clk_hw *hw)
 	}
 }
 
-static int __initdata mpurate;
-
-/*
- * By default we use the rate set by the bootloader.
- * You can override this with mpurate= cmdline option.
- */
-static int __init omap_clk_setup(char *str)
-{
-	get_option(&str, &mpurate);
-
-	if (!mpurate)
-		return 1;
-
-	if (mpurate < 1000)
-		mpurate *= 1000000;
-
-	return 1;
-}
-__setup("mpurate=", omap_clk_setup);
-
-/**
- * omap2_clk_print_new_rates - print summary of current clock tree rates
- * @hfclkin_ck_name: clk name for the off-chip HF oscillator
- * @core_ck_name: clk name for the on-chip CORE_CLK
- * @mpu_ck_name: clk name for the ARM MPU clock
- *
- * Prints a short message to the console with the HFCLKIN oscillator
- * rate, the rate of the CORE clock, and the rate of the ARM MPU clock.
- * Called by the boot-time MPU rate switching code.   XXX This is intended
- * to be handled by the OPP layer code in the near future and should be
- * removed from the clock code.  No return value.
- */
-void __init omap2_clk_print_new_rates(const char *hfclkin_ck_name,
-				      const char *core_ck_name,
-				      const char *mpu_ck_name)
-{
-	struct clk *hfclkin_ck, *core_ck, *mpu_ck;
-	unsigned long hfclkin_rate;
-
-	mpu_ck = clk_get(NULL, mpu_ck_name);
-	if (WARN(IS_ERR(mpu_ck), "clock: failed to get %s.\n", mpu_ck_name))
-		return;
-
-	core_ck = clk_get(NULL, core_ck_name);
-	if (WARN(IS_ERR(core_ck), "clock: failed to get %s.\n", core_ck_name))
-		return;
-
-	hfclkin_ck = clk_get(NULL, hfclkin_ck_name);
-	if (WARN(IS_ERR(hfclkin_ck), "Failed to get %s.\n", hfclkin_ck_name))
-		return;
-
-	hfclkin_rate = clk_get_rate(hfclkin_ck);
-
-	pr_info("Switched to new clocking rate (Crystal/Core/MPU): %ld.%01ld/%ld/%ld MHz\n",
-		(hfclkin_rate / 1000000), ((hfclkin_rate / 100000) % 10),
-		(clk_get_rate(core_ck) / 1000000),
-		(clk_get_rate(mpu_ck) / 1000000));
-}
-
 /**
  * ti_clk_init_features - init clock features struct for the SoC
  *
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 67da640..4e66295 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -64,10 +64,6 @@
 #define OMAP4XXX_EN_DPLL_FRBYPASS		0x6
 #define OMAP4XXX_EN_DPLL_LOCKED			0x7
 
-void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
-			       const char *core_ck_name,
-			       const char *mpu_ck_name);
-
 extern u16 cpu_mask;
 
 extern const struct clkops clkops_omap2_dflt_wait;
-- 
2.5.0

From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 07/11] OMAP2/3 clock: combine OMAP2 & 3 boot-time MPU rate
	change code
Date: Mon, 22 Feb 2010 21:50:53 -0700
Message-ID: <20100223045052.18888.77299.stgit@localhost.localdomain>
References: <20100223044915.18888.83242.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60268 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab0BWE5j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Feb 2010 23:57:39 -0500
In-Reply-To: <20100223044915.18888.83242.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The OMAP2 and OMAP3 boot-time MPU rate change code is almost
identical.  Merge them into mach-omap2/clock.c, and add kerneldoc
documentation.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c     |   85 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock.h     |    4 ++
 arch/arm/mach-omap2/clock2xxx.c |   34 ++++------------
 arch/arm/mach-omap2/clock3xxx.c |   59 ++++-----------------------
 4 files changed, 107 insertions(+), 75 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 426d76f..d1f115d 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -17,6 +17,8 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/bitops.h>
@@ -349,6 +351,89 @@ void omap2_clk_disable_unused(struct clk *clk)
 }
 #endif
 
+/**
+ * omap2_clk_switch_mpurate_at_boot - switch ARM MPU rate by boot-time argument
+ * @mpurate_ck_name: clk name of the clock to change rate
+ *
+ * Change the ARM MPU clock rate to the rate specified on the command
+ * line, if one was specified.  @mpurate_ck_name should be
+ * "virt_prcm_set" on OMAP2xxx and "dpll1_ck" on OMAP34xx/OMAP36xx.
+ * XXX Does not handle voltage scaling - on OMAP2xxx this is currently
+ * handled by the virt_prcm_set clock, but this should be handled by
+ * the OPP layer.  XXX This is intended to be handled by the OPP layer
+ * code in the near future and should be removed from the clock code.
+ * Returns -EINVAL if 'mpurate' is zero or if clk_set_rate() rejects
+ * the rate, -ENOENT if the struct clk referred to by @mpurate_ck_name
+ * cannot be found, or 0 upon success.
+ */
+int __init omap2_clk_switch_mpurate_at_boot(const char *mpurate_ck_name)
+{
+	struct clk *mpurate_ck;
+	int r;
+
+	if (!mpurate)
+		return -EINVAL;
+
+	mpurate_ck = clk_get(NULL, mpurate_ck_name);
+	if (WARN(IS_ERR(mpurate_ck), "Failed to get %s.\n", mpurate_ck_name))
+		return -ENOENT;
+
+	r = clk_set_rate(mpurate_ck, mpurate);
+	if (IS_ERR_VALUE(r)) {
+		WARN(1, "clock: %s: unable to set MPU rate to %d: %d\n",
+		     mpurate_ck->name, mpurate, r);
+		return -EINVAL;
+	}
+
+	calibrate_delay();
+	recalculate_root_clocks();
+
+	clk_put(mpurate_ck);
+
+	return 0;
+}
+
+/**
+ * omap2_clk_print_new_rates - print summary of current clock tree rates
+ * @hfclkin_ck_name: clk name for the off-chip HF oscillator
+ * @core_ck_name: clk name for the on-chip CORE_CLK
+ * @mpu_ck_name: clk name for the ARM MPU clock
+ *
+ * Prints a short message to the console with the HFCLKIN oscillator
+ * rate, the rate of the CORE clock, and the rate of the ARM MPU clock.
+ * Called by the boot-time MPU rate switching code.   XXX This is intended
+ * to be handled by the OPP layer code in the near future and should be
+ * removed from the clock code.  No return value.
+ */
+void __init omap2_clk_print_new_rates(const char *hfclkin_ck_name,
+				      const char *core_ck_name,
+				      const char *mpu_ck_name)
+{
+	struct clk *hfclkin_ck, *core_ck, *mpu_ck;
+	unsigned long hfclkin_rate;
+
+	mpu_ck = clk_get(NULL, mpu_ck_name);
+	if (WARN(IS_ERR(mpu_ck), "clock: failed to get %s.\n", mpu_ck_name))
+		return;
+
+	core_ck = clk_get(NULL, core_ck_name);
+	if (WARN(IS_ERR(core_ck), "clock: failed to get %s.\n", core_ck_name))
+		return;
+
+	hfclkin_ck = clk_get(NULL, hfclkin_ck_name);
+	if (WARN(IS_ERR(hfclkin_ck), "Failed to get %s.\n", hfclkin_ck_name))
+		return;
+
+	hfclkin_rate = clk_get_rate(hfclkin_ck);
+
+	pr_info("Switched to new clocking rate (Crystal/Core/MPU): "
+		"%ld.%01ld/%ld/%ld MHz\n",
+		(hfclkin_rate / 1000000),
+		((hfclkin_rate / 100000) % 10),
+		(clk_get_rate(core_ck) / 1000000),
+		(clk_get_rate(mpu_ck) / 1000000));
+}
+
 /* Common data */
 
 struct clk_functions omap2_clk_functions = {
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index ae626f7..49ad473 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -93,6 +93,10 @@ void omap2_clk_dflt_find_companion(struct clk *clk, void __iomem **other_reg,
 				   u8 *other_bit);
 void omap2_clk_dflt_find_idlest(struct clk *clk, void __iomem **idlest_reg,
 				u8 *idlest_bit, u8 *idlest_val);
+int omap2_clk_switch_mpurate_at_boot(const char *mpurate_ck_name);
+void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
+			       const char *core_ck_name,
+			       const char *mpu_ck_name);
 
 extern u8 cpu_mask;
 
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index 7a2f5ad..80bb0f0 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -50,40 +50,24 @@ void omap2xxx_clk_prepare_for_reboot(void)
 }
 
 /*
- * Switch the MPU rate if specified on cmdline.
- * We cannot do this early until cmdline is parsed.
+ * Switch the MPU rate if specified on cmdline.  We cannot do this
+ * early until cmdline is parsed.  XXX This should be removed from the
+ * clock code and handled by the OPP layer code in the near future.
  */
 static int __init omap2xxx_clk_arch_init(void)
 {
-	struct clk *virt_prcm_set, *sys_ck, *dpll_ck, *mpu_ck;
-	unsigned long sys_ck_rate;
+	int ret;
 
 	if (!cpu_is_omap24xx())
 		return 0;
 
-	if (!mpurate)
-		return -EINVAL;
+	ret = omap2_clk_switch_mpurate_at_boot("virt_prcm_set");
+	if (!ret)
+		omap2_clk_print_new_rates("sys_ck", "dpll_ck", "mpu_ck");
 
-	virt_prcm_set = clk_get(NULL, "virt_prcm_set");
-	sys_ck = clk_get(NULL, "sys_ck");
-	dpll_ck = clk_get(NULL, "dpll_ck");
-	mpu_ck = clk_get(NULL, "mpu_ck");
-
-	if (clk_set_rate(virt_prcm_set, mpurate))
-		pr_err("Could not find matching MPU rate\n");
-
-	recalculate_root_clocks();
-
-	sys_ck_rate = clk_get_rate(sys_ck);
-
-	pr_info("Switched to new clocking rate (Crystal/DPLL/MPU): "
-		"%ld.%01ld/%ld/%ld MHz\n",
-		(sys_ck_rate / 1000000), (sys_ck_rate / 100000) % 10,
-		(clk_get_rate(dpll_ck) / 1000000),
-		(clk_get_rate(mpu_ck) / 1000000));
-
-	return 0;
+	return ret;
 }
+
 arch_initcall(omap2xxx_clk_arch_init);
 
 
diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index d142457..a447c4d 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -18,12 +18,9 @@
 
 #include <linux/kernel.h>
 #include <linux/errno.h>
-#include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-#include <linux/err.h>
 
-#include <plat/cpu.h>
 #include <plat/clock.h>
 
 #include "clock.h"
@@ -83,63 +80,25 @@ void __init omap3_clk_lock_dpll5(void)
 
 /* Common clock code */
 
-/* REVISIT: Move this init stuff out into clock.c */
-
 /*
- * Switch the MPU rate if specified on cmdline.
- * We cannot do this early until cmdline is parsed.
+ * Switch the MPU rate if specified on cmdline.  We cannot do this
+ * early until cmdline is parsed.  XXX This should be removed from the
+ * clock code and handled by the OPP layer code in the near future.
  */
 static int __init omap3xxx_clk_arch_init(void)
 {
-	struct clk *osc_sys_ck, *dpll1_ck, *arm_fck, *core_ck;
-	unsigned long osc_sys_rate;
-	bool err = 0;
+	int ret;
 
 	if (!cpu_is_omap34xx())
 		return 0;
 
-	if (!mpurate)
-		return -EINVAL;
-
-	/* XXX test these for success */
-	dpll1_ck = clk_get(NULL, "dpll1_ck");
-	if (WARN(IS_ERR(dpll1_ck), "Failed to get dpll1_ck.\n"))
-		err = 1;
-
-	arm_fck = clk_get(NULL, "arm_fck");
-	if (WARN(IS_ERR(arm_fck), "Failed to get arm_fck.\n"))
-		err = 1;
-
-	core_ck = clk_get(NULL, "core_ck");
-	if (WARN(IS_ERR(core_ck), "Failed to get core_ck.\n"))
-		err = 1;
-
-	osc_sys_ck = clk_get(NULL, "osc_sys_ck");
-	if (WARN(IS_ERR(osc_sys_ck), "Failed to get osc_sys_ck.\n"))
-		err = 1;
-
-	if (err)
-		return -ENOENT;
+	ret = omap2_clk_switch_mpurate_at_boot("dpll1_ck");
+	if (!ret)
+		omap2_clk_print_new_rates("osc_sys_ck", "arm_fck", "core_ck");
 
-	/* REVISIT: not yet ready for 343x */
-	if (clk_set_rate(dpll1_ck, mpurate))
-		printk(KERN_ERR "*** Unable to set MPU rate\n");
-
-	recalculate_root_clocks();
-
-	osc_sys_rate = clk_get_rate(osc_sys_ck);
-
-	pr_info("Switched to new clocking rate (Crystal/Core/MPU): "
-		"%ld.%01ld/%ld/%ld MHz\n",
-		(osc_sys_rate / 1000000),
-		((osc_sys_rate / 100000) % 10),
-		(clk_get_rate(core_ck) / 1000000),
-		(clk_get_rate(arm_fck) / 1000000));
-
-	calibrate_delay();
-
-	return 0;
+	return ret;
 }
+
 arch_initcall(omap3xxx_clk_arch_init);
 
 



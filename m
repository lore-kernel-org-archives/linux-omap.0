From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 13/18] OMAP2/3 clock: clean up omap*_clk_arch_init()
Date: Fri, 15 Jan 2010 02:07:05 -0700
Message-ID: <20100115090704.30690.11508.stgit@localhost.localdomain>
References: <20100115090613.30690.49355.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48744 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756837Ab0AOJIP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 04:08:15 -0500
In-Reply-To: <20100115090613.30690.49355.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

In the OMAP3xxx clock code, remove the #ifdef CONFIG_ARCH_OMAP3 in
clock34xx.c, since this file is only compiled for OMAP3xxx builds.  Also,
rename omap2_clk_arch_init in this file to omap3xxx_clk_arch_init() to
pave the way for multi-OMAP kernels.  Ensure that it is not executed
on non-OMAP3xxx systems.

In the OMAP2xxx clock code, rename omap2_clk_arch_init in this file to
omap2xxx_clk_arch_init() to pave the way for multi-OMAP kernels.
Ensure that it is not executed on non-OMAP2xxx systems.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock2xxx.c |    7 +++++--
 arch/arm/mach-omap2/clock34xx.c |   16 +++++-----------
 2 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index e5b9851..b7e81ec 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -101,11 +101,14 @@ void omap2_clk_prepare_for_reboot(void)
  * Switch the MPU rate if specified on cmdline.
  * We cannot do this early until cmdline is parsed.
  */
-static int __init omap2_clk_arch_init(void)
+static int __init omap2xxx_clk_arch_init(void)
 {
 	struct clk *virt_prcm_set, *sys_ck, *dpll_ck, *mpu_ck;
 	unsigned long sys_ck_rate;
 
+	if (!cpu_is_omap24xx())
+		return 0;
+
 	if (!mpurate)
 		return -EINVAL;
 
@@ -129,6 +132,6 @@ static int __init omap2_clk_arch_init(void)
 
 	return 0;
 }
-arch_initcall(omap2_clk_arch_init);
+arch_initcall(omap2xxx_clk_arch_init);
 
 
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 552ad30..d38ad44 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -163,12 +163,6 @@ int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
 /* Common clock code */
 
 /*
- * As it is structured now, this will prevent an OMAP2/3 multiboot
- * kernel from compiling.  This will need further attention.
- */
-#if defined(CONFIG_ARCH_OMAP3)
-
-/*
  * Set clocks for bypass mode for reboot to work.
  */
 void omap2_clk_prepare_for_reboot(void)
@@ -213,11 +207,14 @@ void omap3_clk_lock_dpll5(void)
  * Switch the MPU rate if specified on cmdline.
  * We cannot do this early until cmdline is parsed.
  */
-static int __init omap2_clk_arch_init(void)
+static int __init omap3xxx_clk_arch_init(void)
 {
 	struct clk *osc_sys_ck, *dpll1_ck, *arm_fck, *core_ck;
 	unsigned long osc_sys_rate;
 
+	if (!cpu_is_omap34xx())
+		return 0;
+
 	if (!mpurate)
 		return -EINVAL;
 
@@ -246,9 +243,6 @@ static int __init omap2_clk_arch_init(void)
 
 	return 0;
 }
-arch_initcall(omap2_clk_arch_init);
-
-
-#endif
+arch_initcall(omap3xxx_clk_arch_init);
 
 



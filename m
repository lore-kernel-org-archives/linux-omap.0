From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/13] ARM: OMAP2xxx: clock: move virt_prcm_set code into
 clkt2xxx_virt_prcm_set.c
Date: Thu, 25 Oct 2012 17:21:16 -0600
Message-ID: <20121025232115.17558.12450.stgit@dusk.lan>
References: <20121025231818.17558.57884.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38282 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485Ab2JYXYC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 19:24:02 -0400
In-Reply-To: <20121025231818.17558.57884.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Collect all of the virt_prcm_set-specific clocktype code into
mach-omap2/clkt2xxx_virt_prcm_set.c.  Remove its dependency on the
'sclk' and 'vclk' global variables.  Those variables will be removed
by subsequent patches.

This is part of the process of cleaning up the OMAP2xxx clock code
and preparing for the removal of the omap_prcm_restart() function.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |   66 +++++++++++++++++++++++---
 arch/arm/mach-omap2/clock2420_data.c         |   19 ++-----
 arch/arm/mach-omap2/clock2430_data.c         |   19 ++-----
 arch/arm/mach-omap2/clock2xxx.h              |    2 +
 4 files changed, 70 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index 1b95078..f9c71f3 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -1,7 +1,7 @@
 /*
  * OMAP2xxx DVFS virtual clock functions
  *
- * Copyright (C) 2005-2008 Texas Instruments, Inc.
+ * Copyright (C) 2005-2008, 2012 Texas Instruments, Inc.
  * Copyright (C) 2004-2010 Nokia Corporation
  *
  * Contacts:
@@ -47,6 +47,13 @@
 const struct prcm_config *curr_prcm_set;
 const struct prcm_config *rate_table;
 
+/*
+ * sys_ck_rate: the rate of the external high-frequency clock
+ * oscillator on the board.  Set by the SoC-specific clock init code.
+ * Once set during a boot, will not change.
+ */
+static unsigned long sys_ck_rate;
+
 /**
  * omap2_table_mpu_recalc - just return the MPU speed
  * @clk: virt_prcm_set struct clk
@@ -68,15 +75,14 @@ unsigned long omap2_table_mpu_recalc(struct clk *clk)
 long omap2_round_to_table_rate(struct clk *clk, unsigned long rate)
 {
 	const struct prcm_config *ptr;
-	long highest_rate, sys_clk_rate;
+	long highest_rate;
 
 	highest_rate = -EINVAL;
-	sys_clk_rate = __clk_get_rate(sclk);
 
 	for (ptr = rate_table; ptr->mpu_speed; ptr++) {
 		if (!(ptr->flags & cpu_mask))
 			continue;
-		if (ptr->xtal_speed != sys_clk_rate)
+		if (ptr->xtal_speed != sys_ck_rate)
 			continue;
 
 		highest_rate = ptr->mpu_speed;
@@ -95,15 +101,12 @@ int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 	const struct prcm_config *prcm;
 	unsigned long found_speed = 0;
 	unsigned long flags;
-	long sys_clk_rate;
-
-	sys_clk_rate = __clk_get_rate(sclk);
 
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
 		if (!(prcm->flags & cpu_mask))
 			continue;
 
-		if (prcm->xtal_speed != sys_clk_rate)
+		if (prcm->xtal_speed != sys_ck_rate)
 			continue;
 
 		if (prcm->mpu_speed <= rate) {
@@ -169,3 +172,50 @@ int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 
 	return 0;
 }
+
+/**
+ * omap2xxx_clkt_vps_check_bootloader_rate - determine which of the rate
+ * table sets matches the current CORE DPLL hardware rate
+ *
+ * Check the MPU rate set by bootloader.  Sets the 'curr_prcm_set'
+ * global to point to the active rate set when found; otherwise, sets
+ * it to NULL.  No return value;
+ */
+void omap2xxx_clkt_vps_check_bootloader_rates(void)
+{
+	const struct prcm_config *prcm = NULL;
+	unsigned long rate;
+
+	rate = omap2xxx_clk_get_core_rate();
+	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
+		if (!(prcm->flags & cpu_mask))
+			continue;
+		if (prcm->xtal_speed != sys_ck_rate)
+			continue;
+		if (prcm->dpll_speed <= rate)
+			break;
+	}
+	curr_prcm_set = prcm;
+}
+
+/**
+ * omap2xxx_clkt_vps_late_init - store a copy of the sys_ck rate
+ *
+ * Store a copy of the sys_ck rate for later use by the OMAP2xxx DVFS
+ * code.  (The sys_ck rate does not -- or rather, must not -- change
+ * during kernel runtime.)  Must be called after we have a valid
+ * sys_ck rate, but before the virt_prcm_set clock rate is
+ * recalculated.  No return value.
+ */
+void omap2xxx_clkt_vps_late_init(void)
+{
+	struct clk *c;
+
+	c = clk_get(NULL, "sys_ck");
+	if (IS_ERR(c)) {
+		WARN(1, "could not locate sys_ck\n");
+	} else {
+		sys_ck_rate = clk_get_rate(c);
+		clk_put(c);
+	}
+}
diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 69335d3..0cae0f5 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1,7 +1,7 @@
 /*
  * OMAP2420 clock data
  *
- * Copyright (C) 2005-2009 Texas Instruments, Inc.
+ * Copyright (C) 2005-2009, 2012 Texas Instruments, Inc.
  * Copyright (C) 2004-2011 Nokia Corporation
  *
  * Contacts:
@@ -1927,9 +1927,7 @@ static struct omap_clk omap2420_clks[] = {
 
 int __init omap2420_clk_init(void)
 {
-	const struct prcm_config *prcm;
 	struct omap_clk *c;
-	u32 clkrate;
 
 	prcm_clksrc_ctrl = OMAP2420_PRCM_CLKSRC_CTRL;
 	cm_idlest_pll = OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST);
@@ -1954,20 +1952,13 @@ int __init omap2420_clk_init(void)
 		omap2_init_clk_clkdm(c->lk.clk);
 	}
 
+	omap2xxx_clkt_vps_late_init();
+
 	/* Disable autoidle on all clocks; let the PM code enable it later */
 	omap_clk_disable_autoidle_all();
 
-	/* Check the MPU rate set by bootloader */
-	clkrate = omap2xxx_clk_get_core_rate();
-	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
-		if (!(prcm->flags & cpu_mask))
-			continue;
-		if (prcm->xtal_speed != sys_ck.rate)
-			continue;
-		if (prcm->dpll_speed <= clkrate)
-			break;
-	}
-	curr_prcm_set = prcm;
+	/* XXX Can this be done from the virt_prcm_set clk init function? */
+	omap2xxx_clkt_vps_check_bootloader_rates();
 
 	recalculate_root_clocks();
 
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 8d9894c..0c4f719 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1,7 +1,7 @@
 /*
  * OMAP2430 clock data
  *
- * Copyright (C) 2005-2009 Texas Instruments, Inc.
+ * Copyright (C) 2005-2009, 2012 Texas Instruments, Inc.
  * Copyright (C) 2004-2011 Nokia Corporation
  *
  * Contacts:
@@ -2026,9 +2026,7 @@ static struct omap_clk omap2430_clks[] = {
 
 int __init omap2430_clk_init(void)
 {
-	const struct prcm_config *prcm;
 	struct omap_clk *c;
-	u32 clkrate;
 
 	prcm_clksrc_ctrl = OMAP2430_PRCM_CLKSRC_CTRL;
 	cm_idlest_pll = OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST);
@@ -2053,20 +2051,13 @@ int __init omap2430_clk_init(void)
 		omap2_init_clk_clkdm(c->lk.clk);
 	}
 
+	omap2xxx_clkt_vps_late_init();
+
 	/* Disable autoidle on all clocks; let the PM code enable it later */
 	omap_clk_disable_autoidle_all();
 
-	/* Check the MPU rate set by bootloader */
-	clkrate = omap2xxx_clk_get_core_rate();
-	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
-		if (!(prcm->flags & cpu_mask))
-			continue;
-		if (prcm->xtal_speed != sys_ck.rate)
-			continue;
-		if (prcm->dpll_speed <= clkrate)
-			break;
-	}
-	curr_prcm_set = prcm;
+	/* XXX Can this be done from the virt_prcm_set clk init function? */
+	omap2xxx_clkt_vps_check_bootloader_rates();
 
 	recalculate_root_clocks();
 
diff --git a/arch/arm/mach-omap2/clock2xxx.h b/arch/arm/mach-omap2/clock2xxx.h
index 19dc0659..25b8d02 100644
--- a/arch/arm/mach-omap2/clock2xxx.h
+++ b/arch/arm/mach-omap2/clock2xxx.h
@@ -20,6 +20,8 @@ u32 omap2xxx_get_apll_clkin(void);
 u32 omap2xxx_get_sysclkdiv(void);
 void omap2xxx_clk_prepare_for_reboot(void);
 void omap2xxx_clkt_dpllcore_init(struct clk *clk);
+void omap2xxx_clkt_vps_check_bootloader_rates(void);
+void omap2xxx_clkt_vps_late_init(void);
 
 #ifdef CONFIG_SOC_OMAP2420
 int omap2420_clk_init(void);



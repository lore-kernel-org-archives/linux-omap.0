From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 13/15] omap3: fix usecount tracking
Date: Fri, 25 Nov 2011 17:49:46 +0200
Message-ID: <1322236188-19456-14-git-send-email-t-kristo@ti.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41913 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754040Ab1KYPuS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 10:50:18 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id pAPFoIkx003226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:18 -0600
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id pAPFoIvE005607
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:18 -0600 (CST)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id pAPFoIiU018000
	for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 09:50:18 -0600 (CST)
In-Reply-To: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, nm@ti.com

Some of the clocks are marked as autoidle, as they are handled by hardware.
Namely, core and per dplls are marked as such, and also sdrc_ick.

Per clkdomain manual transitions are also disabled, as this does not work,
and attempting to do so causes problems.

mpu_iva voltdm usecounts are also now handled within idle loop to allow
mpu_iva domain to transition smoothly.

After this patch, usecount numbers for core, per and mpu_iva domains
reach zero when domain is ready to idle (i.e. just before wfi.)

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c        |    3 +++
 arch/arm/mach-omap2/clockdomains3xxx_data.c |    2 +-
 arch/arm/mach-omap2/pm34xx.c                |    8 ++++++++
 3 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index dadb8c6..76c2a28 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -432,6 +432,7 @@ static struct clk dpll3_ck = {
 	.round_rate	= &omap2_dpll_round_rate,
 	.clkdm_name	= "dpll3_clkdm",
 	.recalc		= &omap3_dpll_recalc,
+	.autoidle	= 1,
 };
 
 /*
@@ -615,6 +616,7 @@ static struct clk dpll4_ck = {
 	.set_rate	= &omap3_dpll4_set_rate,
 	.clkdm_name	= "dpll4_clkdm",
 	.recalc		= &omap3_dpll_recalc,
+	.autoidle	= 1,
 };
 
 /*
@@ -1744,6 +1746,7 @@ static struct clk sdrc_ick = {
 	.flags		= ENABLE_ON_INIT,
 	.clkdm_name	= "core_l3_clkdm",
 	.recalc		= &followparent_recalc,
+	.autoidle	= 1,
 };
 
 static struct clk gpmc_fck = {
diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
index b84e138..d0cbeb4 100644
--- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
@@ -282,7 +282,7 @@ static struct clockdomain usbhost_clkdm = {
 static struct clockdomain per_clkdm = {
 	.name		= "per_clkdm",
 	.pwrdm		= { .name = "per_pwrdm" },
-	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP | CLKDM_NO_MANUAL_TRANSITIONS,
 	.dep_bit	= OMAP3430_EN_PER_SHIFT,
 	.wkdep_srcs	= per_wkdeps,
 	.sleepdep_srcs	= per_sleepdeps,
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7255d9b..dc0d040 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -84,6 +84,7 @@ void (*omap3_do_wfi_sram)(void);
 static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
 static struct powerdomain *cam_pwrdm;
+static struct voltagedomain *mpu_iva_voltdm;
 
 static inline void omap3_per_save_context(void)
 {
@@ -365,6 +366,8 @@ void omap_sram_idle(void)
 	}
 	pwrdm_pre_transition();
 
+	voltdm_pwrdm_disable(mpu_iva_voltdm);
+
 	/* NEON control */
 	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
 		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
@@ -478,6 +481,8 @@ console_still_active:
 		omap3_disable_io_chain();
 	}
 
+	voltdm_pwrdm_enable(mpu_iva_voltdm);
+
 	pwrdm_post_transition();
 
 	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
@@ -893,6 +898,9 @@ static int __init omap3_pm_init(void)
 
 	(void) clkdm_for_each(clkdms_setup, NULL);
 
+	mpu_iva_voltdm = voltdm_lookup("mpu_iva");
+	voltdm_pwrdm_enable(mpu_iva_voltdm);
+
 	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
 	if (mpu_pwrdm == NULL) {
 		printk(KERN_ERR "Failed to get mpu_pwrdm\n");
-- 
1.7.4.1


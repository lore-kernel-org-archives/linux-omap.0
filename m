From: Mike Turquette <mturquette@gmail.com>
Subject: [PATCH 2/2] OMAP3: PM: remove TWL4030 A2S script before reboot
Date: Wed,  3 Feb 2010 13:43:27 -0600
Message-ID: <1265226207-22971-3-git-send-email-mturquette@ti.com>
References: <1265226207-22971-1-git-send-email-mturquette@ti.com>
 <1265226207-22971-2-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:33713 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932473Ab0BCToA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 14:44:00 -0500
Received: by mail-yw0-f198.google.com with SMTP id 36so1626263ywh.15
        for <linux-omap@vger.kernel.org>; Wed, 03 Feb 2010 11:43:59 -0800 (PST)
In-Reply-To: <1265226207-22971-2-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Turquette <mturquette@ti.com>

Removes TWL4030 sleep script prior to rebooting, only on OMAP3. This is
necessary since DPLL3 reset causes SYS_OFFMODE pin to go low, resulting
in the sleep script being executed on TWL4030. This usually results in
VDD1 & VDD2 voltage collapse while ROM code is executing, followed by an
MPU Watch Dog reset or worse, an irrecoverable hang.

Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/clock34xx.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 0d30e53..0d6d1d6 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -28,6 +28,7 @@
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/cpufreq.h>
+#include <linux/i2c/twl.h>
 
 #include <plat/cpu.h>
 #include <plat/clock.h>
@@ -311,6 +312,8 @@ struct clk_functions omap2_clk_functions = {
  */
 void omap2_clk_prepare_for_reboot(void)
 {
+	int err = 0;
+
 	/* REVISIT: Not ready for 343x */
 #if 0
 	u32 rate;
@@ -321,6 +324,18 @@ void omap2_clk_prepare_for_reboot(void)
 	rate = clk_get_rate(sclk);
 	clk_set_rate(vclk, rate);
 #endif
+
+	/*
+	 * PRCM on OMAP3 will drive SYS_OFFMODE low during DPLL3 warm reset.
+	 * This causes Gaia sleep script to execute, usually killing VDD1 and
+	 * VDD2 while code is running.  WA is to disable the sleep script
+	 * before warm reset.
+	 */
+#ifdef CONFIG_TWL4030_POWER
+	err = twl4030_remove_script(TWL4030_SLEEP_SCRIPT);
+	if (err)
+		pr_err("twl4030: error trying to disable sleep script!\n");
+#endif
 }
 
 void omap3_clk_lock_dpll5(void)
-- 
1.6.3.2


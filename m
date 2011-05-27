From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP_CPUFREQ][PATCH v4 2/4] OMAP2+: cpufreq: use OPP library
Date: Thu, 26 May 2011 19:39:18 -0700
Message-ID: <1306463960-27340-3-git-send-email-nm@ti.com>
References: <1306463960-27340-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:43475 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753349Ab1E0Cjf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 22:39:35 -0400
Received: by mail-gx0-f176.google.com with SMTP id 7so768235gxk.7
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 19:39:35 -0700 (PDT)
In-Reply-To: <1306463960-27340-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

OMAP2 is the only family using clk_[init|exit]_cpufreq_table, however,
the cpufreq code has does not use clk_init_cpufreq_table. As a result,
it is unusuable for OMAP2 and only usable only on platforms using OPP
library.

So move the compilation for cpufreq only if OPP is available for the
architecture and deny OMAP2 in multi-OMAP builds until OMAP2 is fixed.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/Makefile            |    4 ++--
 arch/arm/mach-omap2/omap2plus-cpufreq.c |   12 +++++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index dcf5200..70c9fc7 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -54,10 +54,10 @@ ifeq ($(CONFIG_PM_OPP),y)
 obj-y					+= opp.o
 obj-$(CONFIG_ARCH_OMAP3)		+= opp3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= opp4xxx_data.o
-endif
-
 # CPUFREQ driver
 obj-$(CONFIG_CPU_FREQ)			+= omap2plus-cpufreq.o
+endif
+
 
 # Power Management
 ifeq ($(CONFIG_PM),y)
diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index acf18e8..e10fcf8 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -1,7 +1,7 @@
 /*
  *  OMAP2PLUS cpufreq driver
  *
- *  CPU frequency scaling for OMAP
+ *  CPU frequency scaling for OMAP using OPP information
  *
  *  Copyright (C) 2005 Nokia Corporation
  *  Written by Tony Lindgren <tony@atomide.com>
@@ -203,7 +203,6 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 
 static int omap_cpu_exit(struct cpufreq_policy *policy)
 {
-	clk_exit_cpufreq_table(&freq_table);
 	clk_put(mpu_clk);
 	return 0;
 }
@@ -226,12 +225,15 @@ static struct cpufreq_driver omap_driver = {
 
 static int __init omap_cpufreq_init(void)
 {
-	if (cpu_is_omap24xx())
+	if (cpu_is_omap24xx()) {
 		mpu_clk_name = "virt_prcm_set";
-	else if (cpu_is_omap34xx())
+		pr_warning("%s: omap2 cpufreq needs fixing\n", __func__);
+		return -EINVAL;
+	} else if (cpu_is_omap34xx()) {
 		mpu_clk_name = "dpll1_ck";
-	else if (cpu_is_omap44xx())
+	} else if (cpu_is_omap44xx()) {
 		mpu_clk_name = "dpll_mpu_ck";
+	}
 
 	if (!mpu_clk_name) {
 		pr_err("%s: unsupported Silicon?\n", __func__);
-- 
1.7.1


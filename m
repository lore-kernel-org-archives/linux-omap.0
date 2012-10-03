From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 3/4] cpufreq: OMAP: fix clock usage to be SoC independent, remove plat/ includes
Date: Wed,  3 Oct 2012 16:00:28 -0700
Message-ID: <1349305229-28480-4-git-send-email-khilman@deeprootsystems.com>
References: <1349305229-28480-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:47064 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932466Ab2JCXAi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Oct 2012 19:00:38 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1430950dak.19
        for <linux-omap@vger.kernel.org>; Wed, 03 Oct 2012 16:00:38 -0700 (PDT)
In-Reply-To: <1349305229-28480-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

OMAP core code now has SoC-independent clock alias for the scalable
CPU clock.  Using it means driver is SoC independent and will work for
AM3xxx SoCs as well as OMAP1/3/4.

While here, remove some unnecessary plat/ includes that are
interfering with multi-subarch ARM kernels.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
[tony@atomide.com: updated already changed clock aliases]
Signed-off-by: Tony Lindgren <tony@atomide.com>
[khilman@ti.com: minor shortlog/changelog updates]
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/cpufreq/omap-cpufreq.c |   19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 7d4d455..5d1f5e4 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -30,19 +30,14 @@
 #include <asm/smp_plat.h>
 #include <asm/cpu.h>
 
-#include <plat/clock.h>
-#include <plat/common.h>
 #include <plat/omap_device.h>
 
-#include <mach/hardware.h>
-
 /* OPP tolerance in percentage */
 #define	OPP_TOLERANCE	4
 
 static struct cpufreq_frequency_table *freq_table;
 static atomic_t freq_table_users = ATOMIC_INIT(0);
 static struct clk *mpu_clk;
-static char *mpu_clk_name;
 static struct device *mpu_dev;
 static struct regulator *mpu_reg;
 
@@ -179,7 +174,7 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
 {
 	int result = 0;
 
-	mpu_clk = clk_get(NULL, mpu_clk_name);
+	mpu_clk = clk_get(NULL, "cpufreq_ck");
 	if (IS_ERR(mpu_clk))
 		return PTR_ERR(mpu_clk);
 
@@ -260,18 +255,6 @@ static struct cpufreq_driver omap_driver = {
 
 static int __init omap_cpufreq_init(void)
 {
-	if (cpu_is_omap24xx())
-		mpu_clk_name = "virt_prcm_set";
-	else if (cpu_is_omap34xx())
-		mpu_clk_name = "dpll1_ck";
-	else if (cpu_is_omap44xx())
-		mpu_clk_name = "dpll_mpu_ck";
-
-	if (!mpu_clk_name) {
-		pr_err("%s: unsupported Silicon?\n", __func__);
-		return -EINVAL;
-	}
-
 	mpu_dev = omap_device_get_by_hwmod_name("mpu");
 	if (IS_ERR(mpu_dev)) {
 		pr_warning("%s: unable to get the mpu device\n", __func__);
-- 
1.7.9.2


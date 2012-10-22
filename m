From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] ARM: OMAP3: Beagle: fix OPP customization and initcall ordering
Date: Mon, 22 Oct 2012 13:33:29 -0700
Message-ID: <1350938009-22716-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45656 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756156Ab2JVUdb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 16:33:31 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2272104pbb.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Oct 2012 13:33:31 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.infradead.org

From: Kevin Hilman <khilman@ti.com>

After commit 24d7b40a60cf19008334bcbcbd98da374d4d9c64 (ARM: OMAP2+:
PM: MPU DVFS: use generic CPU device for MPU-SS), OPPs are registered
using an existing CPU device, not the omap_device for MPU-SS.

First, fix the board file to use get_cpu_device() as required by the
above commit, otherwise custom OPPs will be added to the wrong device.

Second, the board files OPP init is called from the its init_machine
method, and the generic CPU devices are not yet created when
init_machine is run.  Therefore OPP initialization will fail.  To fix,
use a device_initcall() for the board file's OPP customization.

Reported-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Tony, unless there are objections, I'll add this to a series of 
PM related fixes I have left for v3.7-rc.

 arch/arm/mach-omap2/board-omap3beagle.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 388c431..befad2a 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -24,6 +24,7 @@
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
 #include <linux/opp.h>
+#include <linux/cpu.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -444,12 +445,13 @@ static struct omap_board_mux board_mux[] __initdata = {
 };
 #endif
 
-static void __init beagle_opp_init(void)
+static int __init beagle_opp_init(void)
 {
 	int r = 0;
 
-	/* Initialize the omap3 opp table */
-	if (omap3_opp_init()) {
+	/* Initialize the omap3 opp table if not already created. */
+	r = omap3_opp_init();
+	if (IS_ERR_VALUE(r) && (r != -EEXIST)) {
 		pr_err("%s: opp default init failed\n", __func__);
 		return;
 	}
@@ -458,13 +460,13 @@ static void __init beagle_opp_init(void)
 	if (cpu_is_omap3630()) {
 		struct device *mpu_dev, *iva_dev;
 
-		mpu_dev = omap_device_get_by_hwmod_name("mpu");
+		mpu_dev = get_cpu_device(0);
 		iva_dev = omap_device_get_by_hwmod_name("iva");
 
 		if (IS_ERR(mpu_dev) || IS_ERR(iva_dev)) {
 			pr_err("%s: Aiee.. no mpu/dsp devices? %p %p\n",
 				__func__, mpu_dev, iva_dev);
-			return;
+			return -ENODEV;
 		}
 		/* Enable MPU 1GHz and lower opps */
 		r = opp_enable(mpu_dev, 800000000);
@@ -484,8 +486,9 @@ static void __init beagle_opp_init(void)
 			opp_disable(iva_dev, 660000000);
 		}
 	}
-	return;
+	return 0;
 }
+device_initcall(beagle_opp_init);
 
 static void __init omap3_beagle_init(void)
 {
@@ -522,8 +525,6 @@ static void __init omap3_beagle_init(void)
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
 	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
-
-	beagle_opp_init();
 }
 
 MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
-- 
1.8.0


From: Nishanth Menon <nm@ti.com>
Subject: [PM-SR][PATCH 1/2 v2] omap3: sr: fix memory leak and simplify the code
Date: Fri,  9 Jul 2010 10:04:34 -0500
Message-ID: <1278687874-26123-1-git-send-email-nm@ti.com>
References: <[PATCH 1/2] omap3: sr: fix memory leak and simplify the code>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54326 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754816Ab0GIPEn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Jul 2010 11:04:43 -0400
In-Reply-To: <[PATCH 1/2] omap3: sr: fix memory leak and simplify the code>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>, Peter p2 De Schrijver <peter.de-schrijver@nokia.com>, Nishanth Menon <nm@ti.com>

From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>

This patch fixes the following problem indicated by kmemleak:

kmemleak: unreferenced object 0xdf93c280 (size 64):
kmemleak:   backtrace:
kmemleak:     [<c00df6d4>] create_object+0x104/0x200
kmemleak:     [<c00d7638>] kmem_cache_alloc+0xe4/0xf4
kmemleak:     [<c000fc38>] omap_devinit_smartreflex+0x44/0x244
kmemleak:     [<c003a33c>] do_one_initcall+0x5c/0x1b8
kmemleak:     [<c00083fc>] kernel_init+0x94/0x110
kmemleak:     [<c003ba04>] kernel_thread_exit+0x0/0x8

The reason is that 'omap_devinit_smartreflex()' allocates 'sr_data',
then passes it to 'omap_device_build()', which 'kmemdup()'s it and
uses the copy. But 'omap_devinit_smartreflex()' never frees 'sr_data'.

This patch make 'sr_data' to be a stack variable, which eliminates
the memory leak and simplifies the code a bit.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>,
Cc: Peter p2 De Schrijver <peter.de-schrijver@nokia.com>
Cc: Nishanth Menon <nm@ti.com>

Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Acked-by: Nishanth Menon <nm@ti.com>
---
Changes from V1:
	rebased to latest pm-sr branch
	default of sr_data set to 0 to make it equivalent to kzalloc

NOTE: this probably should be squashed when being send upstream along with
rest of SR series

 arch/arm/mach-omap2/sr_device.c |   27 +++++++++------------------
 1 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index dbf7603..ecc9910 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -116,19 +116,12 @@ static void __init sr_set_nvalues(struct omap_sr_dev_data *dev_data,
 
 static int sr_dev_init(struct omap_hwmod *oh, void *user)
 {
-	struct omap_sr_data *sr_data;
+	struct omap_sr_data sr_data = {0};
 	struct omap_sr_dev_data *sr_dev_data;
 	struct omap_device *od;
 	char *name = "smartreflex";
 	static int i;
 
-	sr_data = kzalloc(sizeof(struct omap_sr_data), GFP_KERNEL);
-	if (!sr_data) {
-		pr_err("%s: Unable to allocate memory for %s sr_data.Error!\n",
-			__func__, oh->name);
-		return -ENOMEM;
-	}
-
 	sr_dev_data = (struct omap_sr_dev_data *)oh->dev_attr;
 	/*
 	 * OMAP3430 ES3.1 chips by default come with Efuse burnt
@@ -139,32 +132,30 @@ static int sr_dev_init(struct omap_hwmod *oh, void *user)
 	 */
 	if (cpu_is_omap343x()) {
 		if (omap_rev() == OMAP3430_REV_ES3_1)
-			sr_data->enable_on_init = true;
+			sr_data.enable_on_init = true;
 		else
-			sr_data->enable_on_init = false;
+			sr_data.enable_on_init = false;
 	} else {
-		sr_data->enable_on_init = false;
+		sr_data.enable_on_init = false;
 	}
-	sr_data->device_enable = omap_device_enable;
-	sr_data->device_shutdown = omap_device_shutdown;
-	sr_data->device_idle = omap_device_idle;
+	sr_data.device_enable = omap_device_enable;
+	sr_data.device_shutdown = omap_device_shutdown;
+	sr_data.device_idle = omap_device_idle;
 	sr_dev_data->volts_supported = omap_get_voltage_table(i,
 				&sr_dev_data->volt_data);
 	if (!sr_dev_data->volts_supported) {
 		pr_warning("%s: No Voltage table registerd fo VDD%d.Something \
 				really wrong\n\n", __func__, i + 1);
 		i++;
-		kfree(sr_data);
 		return 0;
 	}
-	sr_set_nvalues(sr_dev_data, sr_data);
-	od = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data),
+	sr_set_nvalues(sr_dev_data, &sr_data);
+	od = omap_device_build(name, i, oh, &sr_data, sizeof(sr_data),
 			       omap_sr_latency,
 			       ARRAY_SIZE(omap_sr_latency), 0);
 	if (IS_ERR(od)) {
 		pr_warning("%s: Could not build omap_device for %s: %s.\n\n",
 			__func__, name, oh->name);
-		kfree(sr_data);
 	}
 	i++;
 	return 0;
-- 
1.6.3.3


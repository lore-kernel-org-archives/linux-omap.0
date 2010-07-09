From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 1/2] omap3: sr: fix memory leak and simplify the code
Date: Fri,  9 Jul 2010 16:20:11 +0300
Message-ID: <1278681612-10521-1-git-send-email-dedekind1@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:55017 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755901Ab0GINYY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 09:24:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>, Peter p2 De Schrijver <peter.de-schrijver@nokia.com>

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

Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
---
 arch/arm/mach-omap2/sr_device.c |   27 +++++++++------------------
 1 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 24630ef..d1bb495 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -129,7 +129,7 @@ static int __init omap_devinit_smartreflex(void)
 	char *name = "smartreflex";
 
 	do {
-		struct omap_smartreflex_data *sr_data;
+		struct omap_smartreflex_data sr_data;
 		struct omap_smartreflex_dev_data *sr_dev_data;
 		struct omap_device *od;
 		struct omap_hwmod *oh;
@@ -140,15 +140,7 @@ static int __init omap_devinit_smartreflex(void)
 		if (!oh)
 			break;
 
-		sr_data = kzalloc(sizeof(struct omap_smartreflex_data),
-								GFP_KERNEL);
 		sr_dev_data = (struct omap_smartreflex_dev_data *)oh->dev_attr;
-		if (!sr_data) {
-			pr_warning("%s: could not find hwmod data for %d\n",
-					__func__, i + 1);
-			kfree(sr_data);
-			return -ENOMEM;
-		}
 
 		/*
 		 * OMAP3430 ES3.1 chips by default come with Efuse burnt
@@ -159,26 +151,25 @@ static int __init omap_devinit_smartreflex(void)
 		 */
 		if (cpu_is_omap343x()) {
 			if (omap_rev() == OMAP3430_REV_ES3_1)
-				sr_data->enable_on_init = true;
+				sr_data.enable_on_init = true;
 			else
-				sr_data->enable_on_init = false;
+				sr_data.enable_on_init = false;
 		} else {
-			sr_data->enable_on_init = false;
+			sr_data.enable_on_init = false;
 		}
-		sr_data->device_enable = omap_device_enable;
-		sr_data->device_shutdown = omap_device_shutdown;
-		sr_data->device_idle = omap_device_idle;
+		sr_data.device_enable = omap_device_enable;
+		sr_data.device_shutdown = omap_device_shutdown;
+		sr_data.device_idle = omap_device_idle;
 		omap_get_voltage_table(i, &sr_dev_data->volt_data,
 					&sr_dev_data->volts_supported);
-		sr_set_nvalues(sr_dev_data, sr_data);
+		sr_set_nvalues(sr_dev_data, &sr_data);
 
-		od = omap_device_build(name, i, oh, sr_data, sizeof(*sr_data),
+		od = omap_device_build(name, i, oh, &sr_data, sizeof(sr_data),
 				       omap_sr_latency,
 				       ARRAY_SIZE(omap_sr_latency), 0);
 		if (IS_ERR(od)) {
 			pr_warning("%s: Could not build omap_device %s:%s\n",
 				__func__, name, oh->name);
-			kfree(sr_data);
 		}
 		i++;
 	} while (1);
-- 
1.7.1.1


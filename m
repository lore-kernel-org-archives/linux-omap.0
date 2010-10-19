From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 5/5] arm: omap: 32k: move to omap_device_build
Date: Tue, 19 Oct 2010 12:22:16 +0300
Message-ID: <1287480136-2046-6-git-send-email-balbi@ti.com>
References: <1287480136-2046-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39053 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758119Ab0JSJWn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 05:22:43 -0400
In-Reply-To: <1287480136-2046-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

search on hwmod database and build omap_device
on the fly.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/devices.c |   53 +++++++++++++++++++++--------------------
 1 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index e64a78e..2d851b9 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -33,39 +33,40 @@
 #include "mux.h"
 #include "control.h"
 
-static struct resource omap_32k_resources[] = {
+struct omap_device_pm_latency omap_32k_latency[] = {
 	{
-		.flags		= IORESOURCE_MEM,
+		.deactivate_func	= omap_device_idle_hwmods,
+		.activate_func		= omap_device_enable_hwmods,
+		.flags			= OMAP_DEVICE_LATENCY_AUTO_ADJUST,
 	},
 };
 
-static struct platform_device omap_32k_device = {
-	.name			= "omap-counter-32k",
-	.id			= -1,
-	.num_resources		= ARRAY_SIZE(omap_32k_resources),
-	.resource		= omap_32k_resources,
-};
-
-static void omap_init_32k(void)
+static int __init omap_init_32k(void)
 {
-	if (cpu_is_omap2420()) {
-		omap_32k_resources[0].start = OMAP2420_32KSYNCT_BASE;
-		omap_32k_resources[0].end = OMAP2420_32KSYNCT_BASE + SZ_4K;
-	} else if (cpu_is_omap2430()) {
-		omap_32k_resources[0].start = OMAP2430_32KSYNCT_BASE;
-		omap_32k_resources[0].end = OMAP2430_32KSYNCT_BASE + SZ_4K;
-	} else if (cpu_is_omap34xx()) {
-		omap_32k_resources[0].start = OMAP3430_32KSYNCT_BASE;
-		omap_32k_resources[0].end = OMAP3430_32KSYNCT_BASE + SZ_4K;
-	} else if (cpu_is_omap44xx()) {
-		omap_32k_resources[0].start = OMAP4430_32KSYNCT_BASE;
-		omap_32k_resources[0].end = OMAP4430_32KSYNCT_BASE + SZ_4K;
-	} else {	/* not supported */
-		return;
+	struct omap_device	*od;
+	struct omap_hwmod	*oh;
+
+	int			id = -1;
+
+	const char		*oh_name = "counter_32k";
+	const char		*dev_name = "omap-counter-32k";
+
+	if (!cpu_class_is_omap2())
+		return 0;
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not lookup %s hwmod\n", oh_name);
+		return -ENODEV;
 	}
 
-	(void) platform_device_register(&omap_32k_device);
-};
+	od = omap_device_build(dev_name, id, oh, NULL, 0,
+			omap_32k_latency, ARRAY_SIZE(omap_32k_latency), 0);
+	WARN(IS_ERR(od), "Can't build omap device for %s:%s.\n",
+			dev_name, oh->name);
+
+	return 0;
+}
 
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 
-- 
1.7.3.1.120.g38a18


From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v7 2/3] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Wed, 5 Sep 2012 14:20:02 +0530
Message-ID: <c14607ff57fca419dc9d7e0beaea197e001f4e25.1346829351.git.afzal@ti.com>
References: <cover.1346829350.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55378 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757519Ab2IEIuP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Sep 2012 04:50:15 -0400
In-Reply-To: <cover.1346829350.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Create API for platforms to adapt GPMC to HWMOD

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index dbc1ebc..c45f185 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -29,11 +29,14 @@
 
 #include <plat/gpmc.h>
 #include <plat/sdrc.h>
+#include <plat/omap_device.h>
 
 #include "soc.h"
 
 #include "common.h"
 
+#define	DEVICE_NAME		"omap-gpmc"
+
 /* GPMC register offsets */
 #define GPMC_REVISION		0x00
 #define GPMC_SYSCONFIG		0x10
@@ -897,6 +900,29 @@ static int __init gpmc_init(void)
 }
 postcore_initcall(gpmc_init);
 
+static int __init omap_gpmc_init(void)
+{
+	struct omap_hwmod *oh;
+	struct platform_device *pdev;
+	char *oh_name = "gpmc";
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not look up %s\n", oh_name);
+		return -ENODEV;
+	}
+
+	pdev = omap_device_build(DEVICE_NAME, -1, oh, NULL, 0, NULL, 0, 0);
+	if (IS_ERR(pdev)) {
+		WARN(1, "Can't build omap_device for %s:%s.\n",
+						DEVICE_NAME, oh->name);
+		return PTR_ERR(pdev);
+	}
+
+	return 0;
+}
+postcore_initcall(omap_gpmc_init);
+
 static irqreturn_t gpmc_handle_irq(int irq, void *dev)
 {
 	int i;
-- 
1.7.1


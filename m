From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [RFC/PATCH v2 12/13] dt: omap4: enable dt support for i2c1 controller
Date: Tue, 23 Aug 2011 10:03:40 +0500
Message-ID: <1314074021-25186-13-git-send-email-manjugk@ti.com>
References: <1314074021-25186-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [117.192.64.96] ([117.192.64.96]:40465 "EHLO manju-desktop"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751502Ab1HWErn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 00:47:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca


Enable dt support for omap4 i2c1 controller and cleanup
legacy i2c device registration in omap4 generic board file.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
---
 arch/arm/mach-omap2/board-omap4-dt.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4-dt.c b/arch/arm/mach-omap2/board-omap4-dt.c
index a4d296c..9ade238 100644
--- a/arch/arm/mach-omap2/board-omap4-dt.c
+++ b/arch/arm/mach-omap2/board-omap4-dt.c
@@ -11,6 +11,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/i2c/twl.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
 
 #include <mach/omap4-common.h>
 #include <asm/mach/arch.h>
@@ -31,16 +33,23 @@ static struct twl4030_platform_data omap4_twldata = {
 	.irq_end	= TWL6030_IRQ_END,
 };
 
-static int __init omap4_i2c_init(void)
-{
-	omap4_pmic_init("twl6030", &omap4_twldata);
-	return 0;
-}
+struct of_dev_auxdata omap4_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA_ID_PDSIZE("ti,omap-i2c", 0x48070000, "i2c1", 1,\
+				&omap4_twldata, sizeof(omap4_twldata)),
+	{}
+};
+
+static struct of_device_id omap_dt_match_table[] __initdata = {
+	{ .compatible = "ti,omap4-l4-core", },
+	{}
+};
 
 static void __init omap4_init(void)
 {
-	omap4_i2c_init();
 	omap_serial_init();
+
+	of_platform_populate(NULL, omap_dt_match_table, omap4_auxdata_lookup,
+									 NULL);
 }
 
 static void __init omap4_map_io(void)
-- 
1.7.4.1


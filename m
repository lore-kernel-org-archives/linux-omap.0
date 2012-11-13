From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ARM: OMAP2+: omap_twl: Change TWL4030_MODULE_PM_RECEIVER to TWL_MODULE_PM_RECEIVER
Date: Tue, 13 Nov 2012 10:32:32 +0100
Message-ID: <1352799152-20980-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44414 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753330Ab2KMJcm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Nov 2012 04:32:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@ti.com>

To facilitate upcoming cleanup in twl stack.
No functional change.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 2bf35dc..018abb4 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -337,8 +337,8 @@ int __init omap3_twl_set_sr_bit(bool enable)
 	if (twl_sr_enable_autoinit)
 		pr_warning("%s: unexpected multiple calls\n", __func__);
 
-	ret = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &temp,
-					TWL4030_DCDC_GLOBAL_CFG);
+	ret = twl_i2c_read_u8(TWL_MODULE_PM_RECEIVER, &temp,
+			      TWL4030_DCDC_GLOBAL_CFG);
 	if (ret)
 		goto err;
 
@@ -347,8 +347,8 @@ int __init omap3_twl_set_sr_bit(bool enable)
 	else
 		temp &= ~SMARTREFLEX_ENABLE;
 
-	ret = twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, temp,
-				TWL4030_DCDC_GLOBAL_CFG);
+	ret = twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, temp,
+			       TWL4030_DCDC_GLOBAL_CFG);
 	if (!ret) {
 		twl_sr_enable_autoinit = true;
 		return 0;
-- 
1.8.0


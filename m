From: Roger Quadros <roger.quadros@nokia.com>
Subject: [RFC][PATCH 3/3] OMAP: DSS2: Use vdds_sdi regulator supply in SDI
Date: Fri, 12 Mar 2010 17:27:24 +0200
Message-ID: <1268407644-31230-4-git-send-email-roger.quadros@nokia.com>
References: <1268407644-31230-1-git-send-email-roger.quadros@nokia.com>
 <1268407644-31230-2-git-send-email-roger.quadros@nokia.com>
 <1268407644-31230-3-git-send-email-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:41352 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934328Ab0CLP23 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 10:28:29 -0500
In-Reply-To: <1268407644-31230-3-git-send-email-roger.quadros@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

From: Roger Quadros <roger.quadros@nokia.com>

This patch enables the use of vdds_sdi regulator in SDI subsystem.
We can disable the vdds_sdi voltage when not in use to save
power.

Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
---
 drivers/video/omap2/dss/sdi.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 45aab89..e816e80 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -23,13 +23,16 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/regulator/consumer.h>
 
 #include <plat/display.h>
+#include <plat/cpu.h>
 #include "dss.h"
 
 static struct {
 	bool skip_init;
 	bool update_enabled;
+	struct regulator *vdds_sdi_reg;
 } sdi;
 
 static void sdi_basic_init(void)
@@ -57,6 +60,12 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 		goto err0;
 	}
 
+	if (cpu_is_omap34xx()) {
+		r = regulator_enable(sdi.vdds_sdi_reg);
+		if (r)
+			goto err1;
+	}
+
 	/* In case of skip_init sdi_init has already enabled the clocks */
 	if (!sdi.skip_init)
 		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
@@ -118,10 +127,10 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	sdi.skip_init = 0;
 
 	return 0;
-err3:
-	dssdev->manager->disable(dssdev->manager);
 err2:
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	if (cpu_is_omap34xx())
+		regulator_enable(sdi.vdds_sdi_reg);
 err1:
 	omap_dss_stop_device(dssdev);
 err0:
@@ -137,6 +146,9 @@ void omapdss_sdi_display_disable(struct omap_dss_device *dssdev)
 
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
 
+	if (cpu_is_omap34xx())
+		regulator_enable(sdi.vdds_sdi_reg);
+
 	omap_dss_stop_device(dssdev);
 }
 EXPORT_SYMBOL(omapdss_sdi_display_disable);
@@ -144,6 +156,13 @@ EXPORT_SYMBOL(omapdss_sdi_display_disable);
 int sdi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("SDI init\n");
+	if (cpu_is_omap34xx()) {
+		sdi.vdds_sdi_reg = dss_get_vdds_sdi();
+		if (IS_ERR(sdi.vdds_sdi_reg)) {
+			DSSERR("can't get VDDS_SDI regulator\n");
+			return PTR_ERR(sdi.vdds_sdi_reg);
+		}
+	}
 
 	return 0;
 }
-- 
1.6.0.4


From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 05/23] OMAP: DSS2: Use vdds_sdi regulator supply in SDI
Date: Tue, 18 May 2010 15:34:56 +0300
Message-ID: <1274186114-26951-6-git-send-email-tomi.valkeinen@nokia.com>
References: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62494 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757502Ab0ERMgJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:36:09 -0400
In-Reply-To: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Cc: Roger Quadros <roger.quadros@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

From: Roger Quadros <roger.quadros@nokia.com>

This patch enables the use of vdds_sdi regulator in SDI subsystem.
We can disable the vdds_sdi voltage when not in use to save
power.

Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/sdi.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 3de3c1e..ee07a3c 100644
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
@@ -57,6 +60,10 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 		goto err0;
 	}
 
+	r = regulator_enable(sdi.vdds_sdi_reg);
+	if (r)
+		goto err1;
+
 	/* In case of skip_init sdi_init has already enabled the clocks */
 	if (!sdi.skip_init)
 		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
@@ -120,6 +127,7 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	return 0;
 err2:
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	regulator_disable(sdi.vdds_sdi_reg);
 err1:
 	omap_dss_stop_device(dssdev);
 err0:
@@ -135,6 +143,8 @@ void omapdss_sdi_display_disable(struct omap_dss_device *dssdev)
 
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
 
+	regulator_disable(sdi.vdds_sdi_reg);
+
 	omap_dss_stop_device(dssdev);
 }
 EXPORT_SYMBOL(omapdss_sdi_display_disable);
@@ -151,6 +161,11 @@ int sdi_init(bool skip_init)
 	/* we store this for first display enable, then clear it */
 	sdi.skip_init = skip_init;
 
+	sdi.vdds_sdi_reg = dss_get_vdds_sdi();
+	if (IS_ERR(sdi.vdds_sdi_reg)) {
+		DSSERR("can't get VDDS_SDI regulator\n");
+		return PTR_ERR(sdi.vdds_sdi_reg);
+	}
 	/*
 	 * Enable clocks already here, otherwise there would be a toggle
 	 * of them until sdi_display_enable is called.
-- 
1.7.0.4


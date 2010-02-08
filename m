From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 11/13] OMAP: DSS2: DSI: export dsi_vc_enable_hs()
Date: Mon,  8 Feb 2010 17:56:10 +0200
Message-ID: <1265644572-3578-12-git-send-email-tomi.valkeinen@nokia.com>
References: <1265644572-3578-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-2-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-3-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-4-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-5-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-6-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-7-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-8-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-9-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-10-git-send-email-tomi.valkeinen@nokia.com>
 <1265644572-3578-11-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:45714 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363Ab0BHPxw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:53:52 -0500
In-Reply-To: <1265644572-3578-11-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Rename and export dsi_vc_enable_hs() so that the display drivers can
control the mode of the DSI link.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/include/plat/display.h |    2 ++
 drivers/video/omap2/dss/dsi.c             |   13 ++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 47df5f6..8c3688b 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -575,4 +575,6 @@ int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
 #define to_dss_driver(x) container_of((x), struct omap_dss_driver, driver)
 #define to_dss_device(x) container_of((x), struct omap_dss_device, dev)
 
+void omapdss_dsi_vc_enable_hs(int channel, bool enable);
+
 #endif
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index e49f063..e003fe9 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1864,10 +1864,12 @@ static void dsi_vc_config_vp(int channel)
 }
 
 
-static void dsi_vc_enable_hs(int channel, bool enable)
+void omapdss_dsi_vc_enable_hs(int channel, bool enable)
 {
 	DSSDBG("dsi_vc_enable_hs(%d, %d)\n", channel, enable);
 
+	WARN_ON(!dsi_bus_is_locked());
+
 	dsi_vc_enable(channel, 0);
 	dsi_if_enable(0);
 
@@ -1878,6 +1880,7 @@ static void dsi_vc_enable_hs(int channel, bool enable)
 
 	dsi_force_tx_stop_mode_io();
 }
+EXPORT_SYMBOL(omapdss_dsi_vc_enable_hs);
 
 static void dsi_vc_flush_long_data(int channel)
 {
@@ -3275,7 +3278,7 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 	}
 
 	/* enable high-speed after initial config */
-	dsi_vc_enable_hs(0, 1);
+	omapdss_dsi_vc_enable_hs(0, 1);
 
 	return 0;
 err4:
@@ -3688,7 +3691,7 @@ static int dsi_display_run_test(struct omap_dss_device *dssdev, int test_num)
 	dsi_bus_lock();
 
 	/* run test first in low speed mode */
-	dsi_vc_enable_hs(0, 0);
+	omapdss_dsi_vc_enable_hs(0, 0);
 
 	if (dssdev->driver->run_test) {
 		r = dssdev->driver->run_test(dssdev, test_num);
@@ -3697,7 +3700,7 @@ static int dsi_display_run_test(struct omap_dss_device *dssdev, int test_num)
 	}
 
 	/* then in high speed */
-	dsi_vc_enable_hs(0, 1);
+	omapdss_dsi_vc_enable_hs(0, 1);
 
 	if (dssdev->driver->run_test) {
 		r = dssdev->driver->run_test(dssdev, test_num);
@@ -3706,7 +3709,7 @@ static int dsi_display_run_test(struct omap_dss_device *dssdev, int test_num)
 	}
 
 end:
-	dsi_vc_enable_hs(0, 1);
+	omapdss_dsi_vc_enable_hs(0, 1);
 
 	dsi_bus_unlock();
 
-- 
1.6.5


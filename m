From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 14/19] OMAP: DSS2: Taal: Implement configurable ESD interval
Date: Tue, 19 Apr 2011 12:22:17 +0300
Message-ID: <1303204942-25450-15-git-send-email-tomi.valkeinen@ti.com>
References: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:39273 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754456Ab1DSJXB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Apr 2011 05:23:01 -0400
In-Reply-To: <1303204942-25450-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

ESD check in Taal driver is currently on/off feature with hardcoded
interval. This patch changes it to a configurable interval, which can be
set from the board file.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c               |    2 +-
 arch/arm/plat-omap/include/plat/nokia-dsi-panel.h |    4 ++--
 drivers/video/omap2/displays/panel-taal.c         |   20 ++++++++++----------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 1503f0b..570e83f 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -753,7 +753,7 @@ static struct nokia_dsi_panel_data dsi1_panel = {
 		.reset_gpio	= 102,
 		.use_ext_te	= false,
 		.ext_te_gpio	= 101,
-		.use_esd_check	= false,
+		.esd_interval	= 0,
 		.set_backlight	= dsi1_panel_set_backlight,
 };
 
diff --git a/arch/arm/plat-omap/include/plat/nokia-dsi-panel.h b/arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
index 01ab657..aaa1c14 100644
--- a/arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
+++ b/arch/arm/plat-omap/include/plat/nokia-dsi-panel.h
@@ -8,7 +8,7 @@
  * @name: panel name
  * @use_ext_te: use external TE
  * @ext_te_gpio: external TE GPIO
- * @use_esd_check: perform ESD checks
+ * @esd_interval: interval of ESD checks, 0 = disabled (ms)
  * @max_backlight_level: maximum backlight level
  * @set_backlight: pointer to backlight set function
  * @get_backlight: pointer to backlight get function
@@ -21,7 +21,7 @@ struct nokia_dsi_panel_data {
 	bool use_ext_te;
 	int ext_te_gpio;
 
-	bool use_esd_check;
+	unsigned esd_interval;
 
 	int max_backlight_level;
 	int (*set_backlight)(struct omap_dss_device *dssdev, int level);
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index d68119e..cdb28a8 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -63,8 +63,6 @@
 #define DCS_GET_ID2		0xdb
 #define DCS_GET_ID3		0xdc
 
-#define TAAL_ESD_CHECK_PERIOD	msecs_to_jiffies(5000)
-
 static irqreturn_t taal_te_isr(int irq, void *data);
 static void taal_te_timeout_work_callback(struct work_struct *work);
 static int _taal_enable_te(struct omap_dss_device *dssdev, bool enable);
@@ -231,6 +229,7 @@ struct taal_data {
 
 	struct workqueue_struct *esd_wq;
 	struct delayed_work esd_work;
+	unsigned esd_interval;
 
 	struct panel_config *panel_config;
 };
@@ -700,6 +699,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 	}
 	td->dssdev = dssdev;
 	td->panel_config = panel_config;
+	td->esd_interval = panel_data->esd_interval;
 
 	mutex_init(&td->lock);
 
@@ -963,7 +963,6 @@ static void taal_power_off(struct omap_dss_device *dssdev)
 static int taal_enable(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
-	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	int r;
 
 	dev_dbg(&dssdev->dev, "enable\n");
@@ -984,9 +983,9 @@ static int taal_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err;
 
-	if (panel_data->use_esd_check)
+	if (td->esd_interval > 0)
 		queue_delayed_work(td->esd_wq, &td->esd_work,
-				TAAL_ESD_CHECK_PERIOD);
+				msecs_to_jiffies(td->esd_interval));
 
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
@@ -1056,7 +1055,6 @@ err:
 static int taal_resume(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
-	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	int r;
 
 	dev_dbg(&dssdev->dev, "resume\n");
@@ -1078,9 +1076,9 @@ static int taal_resume(struct omap_dss_device *dssdev)
 		dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 	} else {
 		dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-		if (panel_data->use_esd_check)
+		if (td->esd_interval > 0)
 			queue_delayed_work(td->esd_wq, &td->esd_work,
-					TAAL_ESD_CHECK_PERIOD);
+					msecs_to_jiffies(td->esd_interval));
 	}
 
 	mutex_unlock(&td->lock);
@@ -1523,7 +1521,8 @@ static void taal_esd_work(struct work_struct *work)
 
 	dsi_bus_unlock();
 
-	queue_delayed_work(td->esd_wq, &td->esd_work, TAAL_ESD_CHECK_PERIOD);
+	queue_delayed_work(td->esd_wq, &td->esd_work,
+		       msecs_to_jiffies(td->esd_interval));
 
 	mutex_unlock(&td->lock);
 	return;
@@ -1536,7 +1535,8 @@ err:
 
 	dsi_bus_unlock();
 
-	queue_delayed_work(td->esd_wq, &td->esd_work, TAAL_ESD_CHECK_PERIOD);
+	queue_delayed_work(td->esd_wq, &td->esd_work,
+		       msecs_to_jiffies(td->esd_interval));
 
 	mutex_unlock(&td->lock);
 }
-- 
1.7.1


From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 21/23] drm: omapdrm: panel-dsi-cm: block disable until update completed
Date: Tue,  8 Mar 2016 17:39:53 +0100
Message-ID: <1457455195-1938-22-git-send-email-sre@kernel.org>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

DSI hardware IPs seem to be a bit unhappy about
incomplete image transfers, so try to wait for
an update to finish before disabling the panel.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index c60bc3013ff4..ca7fba59c760 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -78,6 +78,9 @@ struct panel_drv_data {
 	atomic_t do_update;
 	int channel;
 
+	wait_queue_head_t update_wait;
+	atomic_t updating;
+
 	struct delayed_work te_timeout_work;
 
 	bool intro_printed;
@@ -845,6 +848,13 @@ static void dsicm_disable(struct omap_dss_device *dssdev)
 
 	dev_dbg(&ddata->pdev->dev, "disable\n");
 
+	r = wait_event_timeout(ddata->update_wait,
+				!atomic_read(&ddata->updating),
+				msecs_to_jiffies(250));
+	if (!r) {
+		dev_warn(&ddata->pdev->dev, "update did not finish, force disable!");
+	}
+
 	mutex_lock(&ddata->lock);
 
 	dsicm_cancel_ulps_work(ddata);
@@ -871,6 +881,9 @@ static void dsicm_framedone_cb(int err, void *data)
 
 	dev_dbg(&ddata->pdev->dev, "framedone, err %d\n", err);
 	in->ops.dsi->bus_unlock(ddata->in);
+
+	atomic_set(&ddata->updating, 0);
+	wake_up(&ddata->update_wait);
 }
 
 static irqreturn_t dsicm_te_isr(int irq, void *data)
@@ -885,6 +898,7 @@ static irqreturn_t dsicm_te_isr(int irq, void *data)
 	if (old) {
 		cancel_delayed_work(&ddata->te_timeout_work);
 
+		atomic_set(&ddata->updating, 1);
 		r = in->ops.dsi->update(in, ddata->channel, dsicm_framedone_cb,
 				ddata);
 		if (r)
@@ -943,6 +957,7 @@ static int dsicm_update(struct omap_dss_device *dssdev,
 				msecs_to_jiffies(250));
 		atomic_set(&ddata->do_update, 1);
 	} else {
+		atomic_set(&ddata->updating, 1);
 		r = in->ops.dsi->update(in, ddata->channel, dsicm_framedone_cb,
 				ddata);
 		if (r)
@@ -1317,6 +1332,9 @@ static int dsicm_probe(struct platform_device *pdev)
 	mutex_init(&ddata->lock);
 
 	atomic_set(&ddata->do_update, 0);
+	atomic_set(&ddata->updating, 0);
+
+	init_waitqueue_head(&ddata->update_wait);
 
 	if (gpio_is_valid(ddata->reset_gpio)) {
 		r = devm_gpio_request_one(dev, ddata->reset_gpio,
-- 
2.7.0

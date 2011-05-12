From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 1/7] OMAP: DSS2: DSI: Add extra omap_dss_device argument in functions exported by dsi
Date: Thu, 12 May 2011 17:26:24 +0530
Message-ID: <1305201390-9724-2-git-send-email-archit@ti.com>
References: <1305201390-9724-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33289 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755202Ab1ELLvv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 07:51:51 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4CBppPJ025523
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 06:51:51 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p4CBpoRw023675
	for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 06:51:50 -0500 (CDT)
In-Reply-To: <1305201390-9724-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Add pointer to omap_dss_device struct as an argument in the functions which
are exported to dsi panel drivers. This argument will tell the DSI driver
which DSI interface's data it has to choose.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |  120 ++++++++++++++--------------
 drivers/video/omap2/dss/dsi.c             |   48 +++++++-----
 include/video/omapdss.h                   |   35 +++++---
 3 files changed, 110 insertions(+), 93 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index be230b3..90d79c0 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -271,7 +271,7 @@ static int taal_dcs_read_1(struct taal_data *td, u8 dcs_cmd, u8 *data)
 	int r;
 	u8 buf[1];
 
-	r = dsi_vc_dcs_read(td->channel, dcs_cmd, buf, 1);
+	r = dsi_vc_dcs_read(td->dssdev, td->channel, dcs_cmd, buf, 1);
 
 	if (r < 0)
 		return r;
@@ -283,7 +283,7 @@ static int taal_dcs_read_1(struct taal_data *td, u8 dcs_cmd, u8 *data)
 
 static int taal_dcs_write_0(struct taal_data *td, u8 dcs_cmd)
 {
-	return dsi_vc_dcs_write(td->channel, &dcs_cmd, 1);
+	return dsi_vc_dcs_write(td->dssdev, td->channel, &dcs_cmd, 1);
 }
 
 static int taal_dcs_write_1(struct taal_data *td, u8 dcs_cmd, u8 param)
@@ -291,7 +291,7 @@ static int taal_dcs_write_1(struct taal_data *td, u8 dcs_cmd, u8 param)
 	u8 buf[2];
 	buf[0] = dcs_cmd;
 	buf[1] = param;
-	return dsi_vc_dcs_write(td->channel, buf, 2);
+	return dsi_vc_dcs_write(td->dssdev, td->channel, buf, 2);
 }
 
 static int taal_sleep_in(struct taal_data *td)
@@ -303,7 +303,7 @@ static int taal_sleep_in(struct taal_data *td)
 	hw_guard_wait(td);
 
 	cmd = DCS_SLEEP_IN;
-	r = dsi_vc_dcs_write_nosync(td->channel, &cmd, 1);
+	r = dsi_vc_dcs_write_nosync(td->dssdev, td->channel, &cmd, 1);
 	if (r)
 		return r;
 
@@ -409,7 +409,7 @@ static int taal_set_update_window(struct taal_data *td,
 	buf[3] = (x2 >> 8) & 0xff;
 	buf[4] = (x2 >> 0) & 0xff;
 
-	r = dsi_vc_dcs_write_nosync(td->channel, buf, sizeof(buf));
+	r = dsi_vc_dcs_write_nosync(td->dssdev, td->channel, buf, sizeof(buf));
 	if (r)
 		return r;
 
@@ -419,11 +419,11 @@ static int taal_set_update_window(struct taal_data *td,
 	buf[3] = (y2 >> 8) & 0xff;
 	buf[4] = (y2 >> 0) & 0xff;
 
-	r = dsi_vc_dcs_write_nosync(td->channel, buf, sizeof(buf));
+	r = dsi_vc_dcs_write_nosync(td->dssdev, td->channel, buf, sizeof(buf));
 	if (r)
 		return r;
 
-	dsi_vc_send_bta_sync(td->channel);
+	dsi_vc_send_bta_sync(td->dssdev, td->channel);
 
 	return r;
 }
@@ -507,7 +507,7 @@ static int taal_exit_ulps(struct omap_dss_device *dssdev)
 	if (r)
 		goto err;
 
-	omapdss_dsi_vc_enable_hs(td->channel, true);
+	omapdss_dsi_vc_enable_hs(dssdev, td->channel, true);
 
 	r = _taal_enable_te(dssdev, true);
 	if (r)
@@ -565,13 +565,13 @@ static int taal_bl_update_status(struct backlight_device *dev)
 
 	if (td->use_dsi_bl) {
 		if (td->enabled) {
-			dsi_bus_lock();
+			dsi_bus_lock(dssdev);
 
 			r = taal_wake_up(dssdev);
 			if (!r)
 				r = taal_dcs_write_1(td, DCS_BRIGHTNESS, level);
 
-			dsi_bus_unlock();
+			dsi_bus_unlock(dssdev);
 		} else {
 			r = 0;
 		}
@@ -632,13 +632,13 @@ static ssize_t taal_num_errors_show(struct device *dev,
 	mutex_lock(&td->lock);
 
 	if (td->enabled) {
-		dsi_bus_lock();
+		dsi_bus_lock(dssdev);
 
 		r = taal_wake_up(dssdev);
 		if (!r)
 			r = taal_dcs_read_1(td, DCS_READ_NUM_ERRORS, &errors);
 
-		dsi_bus_unlock();
+		dsi_bus_unlock(dssdev);
 	} else {
 		r = -ENODEV;
 	}
@@ -662,13 +662,13 @@ static ssize_t taal_hw_revision_show(struct device *dev,
 	mutex_lock(&td->lock);
 
 	if (td->enabled) {
-		dsi_bus_lock();
+		dsi_bus_lock(dssdev);
 
 		r = taal_wake_up(dssdev);
 		if (!r)
 			r = taal_get_id(td, &id1, &id2, &id3);
 
-		dsi_bus_unlock();
+		dsi_bus_unlock(dssdev);
 	} else {
 		r = -ENODEV;
 	}
@@ -728,7 +728,7 @@ static ssize_t store_cabc_mode(struct device *dev,
 	mutex_lock(&td->lock);
 
 	if (td->enabled) {
-		dsi_bus_lock();
+		dsi_bus_lock(dssdev);
 
 		if (!td->cabc_broken) {
 			r = taal_wake_up(dssdev);
@@ -740,7 +740,7 @@ static ssize_t store_cabc_mode(struct device *dev,
 				goto err;
 		}
 
-		dsi_bus_unlock();
+		dsi_bus_unlock(dssdev);
 	}
 
 	td->cabc_mode = i;
@@ -749,7 +749,7 @@ static ssize_t store_cabc_mode(struct device *dev,
 
 	return count;
 err:
-	dsi_bus_unlock();
+	dsi_bus_unlock(dssdev);
 	mutex_unlock(&td->lock);
 	return r;
 }
@@ -825,14 +825,14 @@ static ssize_t taal_store_ulps(struct device *dev,
 	mutex_lock(&td->lock);
 
 	if (td->enabled) {
-		dsi_bus_lock();
+		dsi_bus_lock(dssdev);
 
 		if (t)
 			r = taal_enter_ulps(dssdev);
 		else
 			r = taal_wake_up(dssdev);
 
-		dsi_bus_unlock();
+		dsi_bus_unlock(dssdev);
 	}
 
 	mutex_unlock(&td->lock);
@@ -876,9 +876,9 @@ static ssize_t taal_store_ulps_timeout(struct device *dev,
 
 	if (td->enabled) {
 		/* taal_wake_up will restart the timer */
-		dsi_bus_lock();
+		dsi_bus_lock(dssdev);
 		r = taal_wake_up(dssdev);
-		dsi_bus_unlock();
+		dsi_bus_unlock(dssdev);
 	}
 
 	mutex_unlock(&td->lock);
@@ -1165,7 +1165,7 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 
 	taal_hw_reset(dssdev);
 
-	omapdss_dsi_vc_enable_hs(td->channel, false);
+	omapdss_dsi_vc_enable_hs(dssdev, td->channel, false);
 
 	r = taal_sleep_out(td);
 	if (r)
@@ -1222,7 +1222,7 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 		td->intro_printed = true;
 	}
 
-	omapdss_dsi_vc_enable_hs(td->channel, true);
+	omapdss_dsi_vc_enable_hs(dssdev, td->channel, true);
 
 	return 0;
 err:
@@ -1281,11 +1281,11 @@ static int taal_enable(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
-	dsi_bus_lock();
+	dsi_bus_lock(dssdev);
 
 	r = taal_power_on(dssdev);
 
-	dsi_bus_unlock();
+	dsi_bus_unlock(dssdev);
 
 	if (r)
 		goto err;
@@ -1314,14 +1314,14 @@ static void taal_disable(struct omap_dss_device *dssdev)
 	taal_cancel_ulps_work(dssdev);
 	taal_cancel_esd_work(dssdev);
 
-	dsi_bus_lock();
+	dsi_bus_lock(dssdev);
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
 		taal_wake_up(dssdev);
 		taal_power_off(dssdev);
 	}
 
-	dsi_bus_unlock();
+	dsi_bus_unlock(dssdev);
 
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 
@@ -1345,13 +1345,13 @@ static int taal_suspend(struct omap_dss_device *dssdev)
 	taal_cancel_ulps_work(dssdev);
 	taal_cancel_esd_work(dssdev);
 
-	dsi_bus_lock();
+	dsi_bus_lock(dssdev);
 
 	r = taal_wake_up(dssdev);
 	if (!r)
 		taal_power_off(dssdev);
 
-	dsi_bus_unlock();
+	dsi_bus_unlock(dssdev);
 
 	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
 
@@ -1377,11 +1377,11 @@ static int taal_resume(struct omap_dss_device *dssdev)
 		goto err;
 	}
 
-	dsi_bus_lock();
+	dsi_bus_lock(dssdev);
 
 	r = taal_power_on(dssdev);
 
-	dsi_bus_unlock();
+	dsi_bus_unlock(dssdev);
 
 	if (r) {
 		dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
@@ -1402,7 +1402,7 @@ static void taal_framedone_cb(int err, void *data)
 {
 	struct omap_dss_device *dssdev = data;
 	dev_dbg(&dssdev->dev, "framedone, err %d\n", err);
-	dsi_bus_unlock();
+	dsi_bus_unlock(dssdev);
 }
 
 static irqreturn_t taal_te_isr(int irq, void *data)
@@ -1430,7 +1430,7 @@ static irqreturn_t taal_te_isr(int irq, void *data)
 	return IRQ_HANDLED;
 err:
 	dev_err(&dssdev->dev, "start update failed\n");
-	dsi_bus_unlock();
+	dsi_bus_unlock(dssdev);
 	return IRQ_HANDLED;
 }
 
@@ -1443,7 +1443,7 @@ static void taal_te_timeout_work_callback(struct work_struct *work)
 	dev_err(&dssdev->dev, "TE not received for 250ms!\n");
 
 	atomic_set(&td->do_update, 0);
-	dsi_bus_unlock();
+	dsi_bus_unlock(dssdev);
 }
 
 static int taal_update(struct omap_dss_device *dssdev,
@@ -1456,7 +1456,7 @@ static int taal_update(struct omap_dss_device *dssdev,
 	dev_dbg(&dssdev->dev, "update %d, %d, %d x %d\n", x, y, w, h);
 
 	mutex_lock(&td->lock);
-	dsi_bus_lock();
+	dsi_bus_lock(dssdev);
 
 	r = taal_wake_up(dssdev);
 	if (r)
@@ -1495,7 +1495,7 @@ static int taal_update(struct omap_dss_device *dssdev,
 	mutex_unlock(&td->lock);
 	return 0;
 err:
-	dsi_bus_unlock();
+	dsi_bus_unlock(dssdev);
 	mutex_unlock(&td->lock);
 	return r;
 }
@@ -1507,8 +1507,8 @@ static int taal_sync(struct omap_dss_device *dssdev)
 	dev_dbg(&dssdev->dev, "sync\n");
 
 	mutex_lock(&td->lock);
-	dsi_bus_lock();
-	dsi_bus_unlock();
+	dsi_bus_lock(dssdev);
+	dsi_bus_unlock(dssdev);
 	mutex_unlock(&td->lock);
 
 	dev_dbg(&dssdev->dev, "sync done\n");
@@ -1546,7 +1546,7 @@ static int taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 	if (td->te_enabled == enable)
 		goto end;
 
-	dsi_bus_lock();
+	dsi_bus_lock(dssdev);
 
 	if (td->enabled) {
 		r = taal_wake_up(dssdev);
@@ -1560,13 +1560,13 @@ static int taal_enable_te(struct omap_dss_device *dssdev, bool enable)
 
 	td->te_enabled = enable;
 
-	dsi_bus_unlock();
+	dsi_bus_unlock(dssdev);
 end:
 	mutex_unlock(&td->lock);
 
 	return 0;
 err:
-	dsi_bus_unlock();
+	dsi_bus_unlock(dssdev);
 	mutex_unlock(&td->lock);
 
 	return r;
@@ -1596,7 +1596,7 @@ static int taal_rotate(struct omap_dss_device *dssdev, u8 rotate)
 	if (td->rotate == rotate)
 		goto end;
 
-	dsi_bus_lock();
+	dsi_bus_lock(dssdev);
 
 	if (td->enabled) {
 		r = taal_wake_up(dssdev);
@@ -1610,12 +1610,12 @@ static int taal_rotate(struct omap_dss_device *dssdev, u8 rotate)
 
 	td->rotate = rotate;
 
-	dsi_bus_unlock();
+	dsi_bus_unlock(dssdev);
 end:
 	mutex_unlock(&td->lock);
 	return 0;
 err:
-	dsi_bus_unlock();
+	dsi_bus_unlock(dssdev);
 	mutex_unlock(&td->lock);
 	return r;
 }
@@ -1644,7 +1644,7 @@ static int taal_mirror(struct omap_dss_device *dssdev, bool enable)
 	if (td->mirror == enable)
 		goto end;
 
-	dsi_bus_lock();
+	dsi_bus_lock(dssdev);
 	if (td->enabled) {
 		r = taal_wake_up(dssdev);
 		if (r)
@@ -1657,12 +1657,12 @@ static int taal_mirror(struct omap_dss_device *dssdev, bool enable)
 
 	td->mirror = enable;
 
-	dsi_bus_unlock();
+	dsi_bus_unlock(dssdev);
 end:
 	mutex_unlock(&td->lock);
 	return 0;
 err:
-	dsi_bus_unlock();
+	dsi_bus_unlock(dssdev);
 	mutex_unlock(&td->lock);
 	return r;
 }
@@ -1692,7 +1692,7 @@ static int taal_run_test(struct omap_dss_device *dssdev, int test_num)
 		goto err1;
 	}
 
-	dsi_bus_lock();
+	dsi_bus_lock(dssdev);
 
 	r = taal_wake_up(dssdev);
 	if (r)
@@ -1708,11 +1708,11 @@ static int taal_run_test(struct omap_dss_device *dssdev, int test_num)
 	if (r)
 		goto err2;
 
-	dsi_bus_unlock();
+	dsi_bus_unlock(dssdev);
 	mutex_unlock(&td->lock);
 	return 0;
 err2:
-	dsi_bus_unlock();
+	dsi_bus_unlock(dssdev);
 err1:
 	mutex_unlock(&td->lock);
 	return r;
@@ -1742,7 +1742,7 @@ static int taal_memory_read(struct omap_dss_device *dssdev,
 			dssdev->panel.timings.x_res *
 			dssdev->panel.timings.y_res * 3);
 
-	dsi_bus_lock();
+	dsi_bus_lock(dssdev);
 
 	r = taal_wake_up(dssdev);
 	if (r)
@@ -1758,7 +1758,7 @@ static int taal_memory_read(struct omap_dss_device *dssdev,
 
 	taal_set_update_window(td, x, y, w, h);
 
-	r = dsi_vc_set_max_rx_packet_size(td->channel, plen);
+	r = dsi_vc_set_max_rx_packet_size(dssdev, td->channel, plen);
 	if (r)
 		goto err2;
 
@@ -1766,7 +1766,7 @@ static int taal_memory_read(struct omap_dss_device *dssdev,
 		u8 dcs_cmd = first ? 0x2e : 0x3e;
 		first = 0;
 
-		r = dsi_vc_dcs_read(td->channel, dcs_cmd,
+		r = dsi_vc_dcs_read(dssdev, td->channel, dcs_cmd,
 				buf + buf_used, size - buf_used);
 
 		if (r < 0) {
@@ -1792,9 +1792,9 @@ static int taal_memory_read(struct omap_dss_device *dssdev,
 	r = buf_used;
 
 err3:
-	dsi_vc_set_max_rx_packet_size(td->channel, 1);
+	dsi_vc_set_max_rx_packet_size(dssdev, td->channel, 1);
 err2:
-	dsi_bus_unlock();
+	dsi_bus_unlock(dssdev);
 err1:
 	mutex_unlock(&td->lock);
 	return r;
@@ -1813,11 +1813,11 @@ static void taal_ulps_work(struct work_struct *work)
 		return;
 	}
 
-	dsi_bus_lock();
+	dsi_bus_lock(dssdev);
 
 	taal_enter_ulps(dssdev);
 
-	dsi_bus_unlock();
+	dsi_bus_unlock(dssdev);
 	mutex_unlock(&td->lock);
 }
 
@@ -1837,7 +1837,7 @@ static void taal_esd_work(struct work_struct *work)
 		return;
 	}
 
-	dsi_bus_lock();
+	dsi_bus_lock(dssdev);
 
 	r = taal_wake_up(dssdev);
 	if (r) {
@@ -1879,7 +1879,7 @@ static void taal_esd_work(struct work_struct *work)
 			goto err;
 	}
 
-	dsi_bus_unlock();
+	dsi_bus_unlock(dssdev);
 
 	taal_queue_esd_work(dssdev);
 
@@ -1890,7 +1890,7 @@ err:
 
 	taal_panel_reset(dssdev);
 
-	dsi_bus_unlock();
+	dsi_bus_unlock(dssdev);
 
 	taal_queue_esd_work(dssdev);
 
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 162068f..6d71488 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -354,13 +354,13 @@ void dsi_restore_context(void)
 {
 }
 
-void dsi_bus_lock(void)
+void dsi_bus_lock(struct omap_dss_device *dssdev)
 {
 	down(&dsi.bus_lock);
 }
 EXPORT_SYMBOL(dsi_bus_lock);
 
-void dsi_bus_unlock(void)
+void dsi_bus_unlock(struct omap_dss_device *dssdev)
 {
 	up(&dsi.bus_lock);
 }
@@ -2473,7 +2473,8 @@ static int dsi_vc_config_vp(int channel)
 }
 
 
-void omapdss_dsi_vc_enable_hs(int channel, bool enable)
+void omapdss_dsi_vc_enable_hs(struct omap_dss_device *dssdev, int channel,
+		bool enable)
 {
 	DSSDBG("dsi_vc_enable_hs(%d, %d)\n", channel, enable);
 
@@ -2587,7 +2588,7 @@ static int dsi_vc_send_bta(int channel)
 	return 0;
 }
 
-int dsi_vc_send_bta_sync(int channel)
+int dsi_vc_send_bta_sync(struct omap_dss_device *dssdev, int channel)
 {
 	DECLARE_COMPLETION_ONSTACK(completion);
 	int r = 0;
@@ -2751,14 +2752,15 @@ static int dsi_vc_send_short(int channel, u8 data_type, u16 data, u8 ecc)
 	return 0;
 }
 
-int dsi_vc_send_null(int channel)
+int dsi_vc_send_null(struct omap_dss_device *dssdev, int channel)
 {
 	u8 nullpkg[] = {0, 0, 0, 0};
 	return dsi_vc_send_long(channel, DSI_DT_NULL_PACKET, nullpkg, 4, 0);
 }
 EXPORT_SYMBOL(dsi_vc_send_null);
 
-int dsi_vc_dcs_write_nosync(int channel, u8 *data, int len)
+int dsi_vc_dcs_write_nosync(struct omap_dss_device *dssdev, int channel,
+		u8 *data, int len)
 {
 	int r;
 
@@ -2780,15 +2782,16 @@ int dsi_vc_dcs_write_nosync(int channel, u8 *data, int len)
 }
 EXPORT_SYMBOL(dsi_vc_dcs_write_nosync);
 
-int dsi_vc_dcs_write(int channel, u8 *data, int len)
+int dsi_vc_dcs_write(struct omap_dss_device *dssdev, int channel, u8 *data,
+		int len)
 {
 	int r;
 
-	r = dsi_vc_dcs_write_nosync(channel, data, len);
+	r = dsi_vc_dcs_write_nosync(dssdev, channel, data, len);
 	if (r)
 		goto err;
 
-	r = dsi_vc_send_bta_sync(channel);
+	r = dsi_vc_send_bta_sync(dssdev, channel);
 	if (r)
 		goto err;
 
@@ -2807,22 +2810,24 @@ err:
 }
 EXPORT_SYMBOL(dsi_vc_dcs_write);
 
-int dsi_vc_dcs_write_0(int channel, u8 dcs_cmd)
+int dsi_vc_dcs_write_0(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd)
 {
-	return dsi_vc_dcs_write(channel, &dcs_cmd, 1);
+	return dsi_vc_dcs_write(dssdev, channel, &dcs_cmd, 1);
 }
 EXPORT_SYMBOL(dsi_vc_dcs_write_0);
 
-int dsi_vc_dcs_write_1(int channel, u8 dcs_cmd, u8 param)
+int dsi_vc_dcs_write_1(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
+		u8 param)
 {
 	u8 buf[2];
 	buf[0] = dcs_cmd;
 	buf[1] = param;
-	return dsi_vc_dcs_write(channel, buf, 2);
+	return dsi_vc_dcs_write(dssdev, channel, buf, 2);
 }
 EXPORT_SYMBOL(dsi_vc_dcs_write_1);
 
-int dsi_vc_dcs_read(int channel, u8 dcs_cmd, u8 *buf, int buflen)
+int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
+		u8 *buf, int buflen)
 {
 	u32 val;
 	u8 dt;
@@ -2835,7 +2840,7 @@ int dsi_vc_dcs_read(int channel, u8 dcs_cmd, u8 *buf, int buflen)
 	if (r)
 		goto err;
 
-	r = dsi_vc_send_bta_sync(channel);
+	r = dsi_vc_send_bta_sync(dssdev, channel);
 	if (r)
 		goto err;
 
@@ -2929,11 +2934,12 @@ err:
 }
 EXPORT_SYMBOL(dsi_vc_dcs_read);
 
-int dsi_vc_dcs_read_1(int channel, u8 dcs_cmd, u8 *data)
+int dsi_vc_dcs_read_1(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
+		u8 *data)
 {
 	int r;
 
-	r = dsi_vc_dcs_read(channel, dcs_cmd, data, 1);
+	r = dsi_vc_dcs_read(dssdev, channel, dcs_cmd, data, 1);
 
 	if (r < 0)
 		return r;
@@ -2945,12 +2951,13 @@ int dsi_vc_dcs_read_1(int channel, u8 dcs_cmd, u8 *data)
 }
 EXPORT_SYMBOL(dsi_vc_dcs_read_1);
 
-int dsi_vc_dcs_read_2(int channel, u8 dcs_cmd, u8 *data1, u8 *data2)
+int dsi_vc_dcs_read_2(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
+		u8 *data1, u8 *data2)
 {
 	u8 buf[2];
 	int r;
 
-	r = dsi_vc_dcs_read(channel, dcs_cmd, buf, 2);
+	r = dsi_vc_dcs_read(dssdev, channel, dcs_cmd, buf, 2);
 
 	if (r < 0)
 		return r;
@@ -2965,7 +2972,8 @@ int dsi_vc_dcs_read_2(int channel, u8 dcs_cmd, u8 *data1, u8 *data2)
 }
 EXPORT_SYMBOL(dsi_vc_dcs_read_2);
 
-int dsi_vc_set_max_rx_packet_size(int channel, u16 len)
+int dsi_vc_set_max_rx_packet_size(struct omap_dss_device *dssdev, int channel,
+		u16 len)
 {
 	return dsi_vc_send_short(channel, DSI_DT_SET_MAX_RET_PKG_SIZE,
 			len, 0);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index ab7d656..e8e27ca 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -214,18 +214,26 @@ int omap_rfbi_setup_te(enum omap_rfbi_te_mode mode,
 			     int hs_pol_inv, int vs_pol_inv, int extif_div);
 
 /* DSI */
-void dsi_bus_lock(void);
-void dsi_bus_unlock(void);
-int dsi_vc_dcs_write(int channel, u8 *data, int len);
-int dsi_vc_dcs_write_0(int channel, u8 dcs_cmd);
-int dsi_vc_dcs_write_1(int channel, u8 dcs_cmd, u8 param);
-int dsi_vc_dcs_write_nosync(int channel, u8 *data, int len);
-int dsi_vc_dcs_read(int channel, u8 dcs_cmd, u8 *buf, int buflen);
-int dsi_vc_dcs_read_1(int channel, u8 dcs_cmd, u8 *data);
-int dsi_vc_dcs_read_2(int channel, u8 dcs_cmd, u8 *data1, u8 *data2);
-int dsi_vc_set_max_rx_packet_size(int channel, u16 len);
-int dsi_vc_send_null(int channel);
-int dsi_vc_send_bta_sync(int channel);
+void dsi_bus_lock(struct omap_dss_device *dssdev);
+void dsi_bus_unlock(struct omap_dss_device *dssdev);
+int dsi_vc_dcs_write(struct omap_dss_device *dssdev, int channel, u8 *data,
+		int len);
+int dsi_vc_dcs_write_0(struct omap_dss_device *dssdev, int channel,
+		u8 dcs_cmd);
+int dsi_vc_dcs_write_1(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
+		u8 param);
+int dsi_vc_dcs_write_nosync(struct omap_dss_device *dssdev, int channel,
+		u8 *data, int len);
+int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
+		u8 *buf, int buflen);
+int dsi_vc_dcs_read_1(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
+		u8 *data);
+int dsi_vc_dcs_read_2(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
+		u8 *data1, u8 *data2);
+int dsi_vc_set_max_rx_packet_size(struct omap_dss_device *dssdev, int channel,
+		u16 len);
+int dsi_vc_send_null(struct omap_dss_device *dssdev, int channel);
+int dsi_vc_send_bta_sync(struct omap_dss_device *dssdev, int channel);
 
 /* Board specific data */
 struct omap_dss_board_info {
@@ -575,7 +583,8 @@ int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
 #define to_dss_driver(x) container_of((x), struct omap_dss_driver, driver)
 #define to_dss_device(x) container_of((x), struct omap_dss_device, dev)
 
-void omapdss_dsi_vc_enable_hs(int channel, bool enable);
+void omapdss_dsi_vc_enable_hs(struct omap_dss_device *dssdev, int channel,
+		bool enable);
 int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable);
 
 int omap_dsi_prepare_update(struct omap_dss_device *dssdev,
-- 
1.7.1


From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 15/23] OMAPDSS: RFBI: Add dssdev pointers as arguments to all exported functions
Date: Thu, 30 Aug 2012 17:10:37 +0530
Message-ID: <1346326845-16583-16-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
 <1346326845-16583-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34291 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754708Ab2H3LnO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 07:43:14 -0400
In-Reply-To: <1346326845-16583-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

All functions of an interface driver used by a panel driver should have an
omap_dss_device pointer as an argument. This may not be needed by some of the
interfaces now as driver data is globally visible in them. The correct way
to retrieve driver data is to extract the platform device from the output,
and then extract the driver data from the platform device.

Add dssdev arguments from functions used by panel drivers which currently miss
it. This will come to use when the RFBI functions retrieve the driver data
in the correct manner.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-n8x0.c |   55 ++++++++++++++++-------------
 drivers/video/omap2/dss/rfbi.c            |   25 +++++++------
 include/video/omapdss.h                   |   25 +++++++------
 3 files changed, 60 insertions(+), 45 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-n8x0.c b/drivers/video/omap2/displays/panel-n8x0.c
index 17ae85e..e3a8c44 100644
--- a/drivers/video/omap2/displays/panel-n8x0.c
+++ b/drivers/video/omap2/displays/panel-n8x0.c
@@ -88,27 +88,30 @@ struct panel_drv_data *get_drv_data(const struct omap_dss_device *dssdev)
 }
 
 
-static inline void blizzard_cmd(u8 cmd)
+static inline void blizzard_cmd(struct omap_dss_device *dssdev, u8 cmd)
 {
-	omap_rfbi_write_command(&cmd, 1);
+	omap_rfbi_write_command(dssdev, &cmd, 1);
 }
 
-static inline void blizzard_write(u8 cmd, const u8 *buf, int len)
+static inline void blizzard_write(struct omap_dss_device *dssdev, u8 cmd,
+		const u8 *buf, int len)
 {
-	omap_rfbi_write_command(&cmd, 1);
-	omap_rfbi_write_data(buf, len);
+	omap_rfbi_write_command(dssdev, &cmd, 1);
+	omap_rfbi_write_data(dssdev, buf, len);
 }
 
-static inline void blizzard_read(u8 cmd, u8 *buf, int len)
+static inline void blizzard_read(struct omap_dss_device *dssdev, u8 cmd,
+		u8 *buf, int len)
 {
-	omap_rfbi_write_command(&cmd, 1);
-	omap_rfbi_read_data(buf, len);
+	omap_rfbi_write_command(dssdev, &cmd, 1);
+	omap_rfbi_read_data(dssdev, buf, len);
 }
 
-static u8 blizzard_read_reg(u8 cmd)
+static u8 blizzard_read_reg(struct omap_dss_device *dssdev, u8 cmd)
 {
 	u8 data;
-	blizzard_read(cmd, &data, 1);
+
+	blizzard_read(dssdev, cmd, &data, 1);
 	return data;
 }
 
@@ -155,7 +158,7 @@ static void blizzard_ctrl_setup_update(struct omap_dss_device *dssdev,
 
 	omap_rfbi_configure(dssdev);
 
-	blizzard_write(BLIZZARD_INPUT_WIN_X_START_0, tmp, 18);
+	blizzard_write(dssdev, BLIZZARD_INPUT_WIN_X_START_0, tmp, 18);
 
 	omapdss_rfbi_set_pixel_size(dssdev, 16);
 	omapdss_rfbi_set_data_lines(dssdev, 16);
@@ -313,8 +316,8 @@ static int n8x0_panel_power_on(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_rfbi_en;
 
-	rev = blizzard_read_reg(BLIZZARD_REV_CODE);
-	conf = blizzard_read_reg(BLIZZARD_CONFIG);
+	rev = blizzard_read_reg(dssdev, BLIZZARD_REV_CODE);
+	conf = blizzard_read_reg(dssdev, BLIZZARD_CONFIG);
 
 	switch (rev & 0xfc) {
 	case 0x9c:
@@ -536,11 +539,11 @@ static int n8x0_panel_enable(struct omap_dss_device *dssdev)
 
 	mutex_lock(&ddata->lock);
 
-	rfbi_bus_lock();
+	rfbi_bus_lock(dssdev);
 
 	r = n8x0_panel_power_on(dssdev);
 
-	rfbi_bus_unlock();
+	rfbi_bus_unlock(dssdev);
 
 	if (r) {
 		mutex_unlock(&ddata->lock);
@@ -562,11 +565,11 @@ static void n8x0_panel_disable(struct omap_dss_device *dssdev)
 
 	mutex_lock(&ddata->lock);
 
-	rfbi_bus_lock();
+	rfbi_bus_lock(dssdev);
 
 	n8x0_panel_power_off(dssdev);
 
-	rfbi_bus_unlock();
+	rfbi_bus_unlock(dssdev);
 
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 
@@ -581,11 +584,11 @@ static int n8x0_panel_suspend(struct omap_dss_device *dssdev)
 
 	mutex_lock(&ddata->lock);
 
-	rfbi_bus_lock();
+	rfbi_bus_lock(dssdev);
 
 	n8x0_panel_power_off(dssdev);
 
-	rfbi_bus_unlock();
+	rfbi_bus_unlock(dssdev);
 
 	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
 
@@ -603,11 +606,11 @@ static int n8x0_panel_resume(struct omap_dss_device *dssdev)
 
 	mutex_lock(&ddata->lock);
 
-	rfbi_bus_lock();
+	rfbi_bus_lock(dssdev);
 
 	r = n8x0_panel_power_on(dssdev);
 
-	rfbi_bus_unlock();
+	rfbi_bus_unlock(dssdev);
 
 	if (r) {
 		mutex_unlock(&ddata->lock);
@@ -630,7 +633,9 @@ static void n8x0_panel_get_resolution(struct omap_dss_device *dssdev,
 
 static void update_done(void *data)
 {
-	rfbi_bus_unlock();
+	struct omap_dss_device *dssdev = (struct omap_dss_device *) data;
+
+	rfbi_bus_unlock(dssdev);
 }
 
 static int n8x0_panel_update(struct omap_dss_device *dssdev,
@@ -651,7 +656,7 @@ static int n8x0_panel_update(struct omap_dss_device *dssdev,
 	}
 
 	mutex_lock(&ddata->lock);
-	rfbi_bus_lock();
+	rfbi_bus_lock(dssdev);
 
 	blizzard_ctrl_setup_update(dssdev, x, y, w, h);
 
@@ -669,8 +674,8 @@ static int n8x0_panel_sync(struct omap_dss_device *dssdev)
 	dev_dbg(&dssdev->dev, "sync\n");
 
 	mutex_lock(&ddata->lock);
-	rfbi_bus_lock();
-	rfbi_bus_unlock();
+	rfbi_bus_lock(dssdev);
+	rfbi_bus_unlock(dssdev);
 	mutex_unlock(&ddata->lock);
 
 	return 0;
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 545e14f..b9d5b96 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -151,19 +151,20 @@ static void rfbi_runtime_put(void)
 	WARN_ON(r < 0 && r != -ENOSYS);
 }
 
-void rfbi_bus_lock(void)
+void rfbi_bus_lock(struct omap_dss_device *dssdev)
 {
 	down(&rfbi.bus_lock);
 }
 EXPORT_SYMBOL(rfbi_bus_lock);
 
-void rfbi_bus_unlock(void)
+void rfbi_bus_unlock(struct omap_dss_device *dssdev)
 {
 	up(&rfbi.bus_lock);
 }
 EXPORT_SYMBOL(rfbi_bus_unlock);
 
-void omap_rfbi_write_command(const void *buf, u32 len)
+void omap_rfbi_write_command(struct omap_dss_device *dssdev, const void *buf,
+		u32 len)
 {
 	switch (rfbi.parallelmode) {
 	case OMAP_DSS_RFBI_PARALLELMODE_8:
@@ -191,7 +192,7 @@ void omap_rfbi_write_command(const void *buf, u32 len)
 }
 EXPORT_SYMBOL(omap_rfbi_write_command);
 
-void omap_rfbi_read_data(void *buf, u32 len)
+void omap_rfbi_read_data(struct omap_dss_device *dssdev, void *buf, u32 len)
 {
 	switch (rfbi.parallelmode) {
 	case OMAP_DSS_RFBI_PARALLELMODE_8:
@@ -223,7 +224,8 @@ void omap_rfbi_read_data(void *buf, u32 len)
 }
 EXPORT_SYMBOL(omap_rfbi_read_data);
 
-void omap_rfbi_write_data(const void *buf, u32 len)
+void omap_rfbi_write_data(struct omap_dss_device *dssdev, const void *buf,
+		u32 len)
 {
 	switch (rfbi.parallelmode) {
 	case OMAP_DSS_RFBI_PARALLELMODE_8:
@@ -252,7 +254,8 @@ void omap_rfbi_write_data(const void *buf, u32 len)
 }
 EXPORT_SYMBOL(omap_rfbi_write_data);
 
-void omap_rfbi_write_pixels(const void __iomem *buf, int scr_width,
+void omap_rfbi_write_pixels(struct omap_dss_device *dssdev,
+		const void __iomem *buf, int scr_width,
 		u16 x, u16 y,
 		u16 w, u16 h)
 {
@@ -574,9 +577,10 @@ static int rfbi_convert_timings(struct rfbi_timings *t)
 }
 
 /* xxx FIX module selection missing */
-int omap_rfbi_setup_te(enum omap_rfbi_te_mode mode,
-			     unsigned hs_pulse_time, unsigned vs_pulse_time,
-			     int hs_pol_inv, int vs_pol_inv, int extif_div)
+int omap_rfbi_setup_te(struct omap_dss_device *dssdev,
+			enum omap_rfbi_te_mode mode, unsigned hs_pulse_time,
+			unsigned vs_pulse_time, int hs_pol_inv, int vs_pol_inv,
+			int extif_div)
 {
 	int hs, vs;
 	int min;
@@ -616,7 +620,8 @@ int omap_rfbi_setup_te(enum omap_rfbi_te_mode mode,
 EXPORT_SYMBOL(omap_rfbi_setup_te);
 
 /* xxx FIX module selection missing */
-int omap_rfbi_enable_te(bool enable, unsigned line)
+int omap_rfbi_enable_te(struct omap_dss_device *dssdev, bool enable,
+		unsigned line)
 {
 	u32 l;
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 29c1440..0e73ef8 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -238,18 +238,23 @@ struct rfbi_timings {
 	int converted;
 };
 
-void omap_rfbi_write_command(const void *buf, u32 len);
-void omap_rfbi_read_data(void *buf, u32 len);
-void omap_rfbi_write_data(const void *buf, u32 len);
-void omap_rfbi_write_pixels(const void __iomem *buf, int scr_width,
+void omap_rfbi_write_command(struct omap_dss_device *dssdev, const void *buf,
+		u32 len);
+void omap_rfbi_read_data(struct omap_dss_device *dssdev, void *buf, u32 len);
+void omap_rfbi_write_data(struct omap_dss_device *dssdev, const void *buf,
+		u32 len);
+void omap_rfbi_write_pixels(struct omap_dss_device *dssdev,
+		const void __iomem *buf, int scr_width,
 		u16 x, u16 y,
 		u16 w, u16 h);
-int omap_rfbi_enable_te(bool enable, unsigned line);
-int omap_rfbi_setup_te(enum omap_rfbi_te_mode mode,
-			     unsigned hs_pulse_time, unsigned vs_pulse_time,
-			     int hs_pol_inv, int vs_pol_inv, int extif_div);
-void rfbi_bus_lock(void);
-void rfbi_bus_unlock(void);
+int omap_rfbi_enable_te(struct omap_dss_device *dssdev, bool enable,
+		unsigned line);
+int omap_rfbi_setup_te(struct omap_dss_device *dssdev,
+			enum omap_rfbi_te_mode mode, unsigned hs_pulse_time,
+			unsigned vs_pulse_time, int hs_pol_inv, int vs_pol_inv,
+			int extif_div);
+void rfbi_bus_lock(struct omap_dss_device *dssdev);
+void rfbi_bus_unlock(struct omap_dss_device *dssdev);
 
 /* DSI */
 
-- 
1.7.9.5


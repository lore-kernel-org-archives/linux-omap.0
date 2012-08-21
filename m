From: Archit Taneja <archit@ti.com>
Subject: [PATCH 15/23] OMAPDSS: RFBI: Add output pointers as arguments to all exported functions
Date: Tue, 21 Aug 2012 11:28:22 +0530
Message-ID: <1345528711-27801-16-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60141 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317Ab2HUGBN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 02:01:13 -0400
In-Reply-To: <1345528711-27801-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com, sumit.semwal@ti.com, Archit Taneja <archit@ti.com>

All functions of an interface driver used by a panel driver should have an
omap_dss_output pointer as an argument. This may not be needed by some of the
interfaces now as driver data is globally visible in them. The correct way
to retrieve driver data is to extract the platform device from the output,
and then extract the driver data from the platform device.

Add output arguments from functions used by panel drivers which currently miss
it. This will come to use when the RFBI functions retrieve the driver data
in the correct manner.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-n8x0.c |   78 +++++++++++++++++++----------
 drivers/video/omap2/dss/rfbi.c            |   18 ++++---
 include/video/omapdss.h                   |   20 +++++---
 3 files changed, 74 insertions(+), 42 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-n8x0.c b/drivers/video/omap2/displays/panel-n8x0.c
index 3601c59..23fbb25 100644
--- a/drivers/video/omap2/displays/panel-n8x0.c
+++ b/drivers/video/omap2/displays/panel-n8x0.c
@@ -88,27 +88,34 @@ struct panel_drv_data *get_drv_data(const struct omap_dss_device *dssdev)
 }
 
 
-static inline void blizzard_cmd(u8 cmd)
+static inline void blizzard_cmd(struct omap_dss_device *dssdev, u8 cmd)
 {
-	omap_rfbi_write_command(&cmd, 1);
+	omap_rfbi_write_command(dssdev->output, &cmd, 1);
 }
 
-static inline void blizzard_write(u8 cmd, const u8 *buf, int len)
+static inline void blizzard_write(struct omap_dss_device *dssdev, u8 cmd,
+		const u8 *buf, int len)
 {
-	omap_rfbi_write_command(&cmd, 1);
-	omap_rfbi_write_data(buf, len);
+	struct omap_dss_output *out = dssdev->output;
+
+	omap_rfbi_write_command(out, &cmd, 1);
+	omap_rfbi_write_data(out, buf, len);
 }
 
-static inline void blizzard_read(u8 cmd, u8 *buf, int len)
+static inline void blizzard_read(struct omap_dss_device *dssdev, u8 cmd,
+		u8 *buf, int len)
 {
-	omap_rfbi_write_command(&cmd, 1);
-	omap_rfbi_read_data(buf, len);
+	struct omap_dss_output *out = dssdev->output;
+
+	omap_rfbi_write_command(out, &cmd, 1);
+	omap_rfbi_read_data(out, buf, len);
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
 
@@ -156,7 +163,7 @@ static void blizzard_ctrl_setup_update(struct omap_dss_device *dssdev,
 
 	omap_rfbi_configure(out);
 
-	blizzard_write(BLIZZARD_INPUT_WIN_X_START_0, tmp, 18);
+	blizzard_write(dssdev, BLIZZARD_INPUT_WIN_X_START_0, tmp, 18);
 
 	omapdss_rfbi_set_pixel_size(out, 16);
 	omapdss_rfbi_set_data_lines(out, 16);
@@ -318,8 +325,8 @@ static int n8x0_panel_power_on(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_rfbi_en;
 
-	rev = blizzard_read_reg(BLIZZARD_REV_CODE);
-	conf = blizzard_read_reg(BLIZZARD_CONFIG);
+	rev = blizzard_read_reg(dssdev, BLIZZARD_REV_CODE);
+	conf = blizzard_read_reg(dssdev, BLIZZARD_CONFIG);
 
 	switch (rev & 0xfc) {
 	case 0x9c:
@@ -536,17 +543,21 @@ static void n8x0_panel_remove(struct omap_dss_device *dssdev)
 static int n8x0_panel_enable(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = get_drv_data(dssdev);
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
 	dev_dbg(&dssdev->dev, "enable\n");
 
+	if (out == NULL)
+		return -ENODEV;
+
 	mutex_lock(&ddata->lock);
 
-	rfbi_bus_lock();
+	rfbi_bus_lock(out);
 
 	r = n8x0_panel_power_on(dssdev);
 
-	rfbi_bus_unlock();
+	rfbi_bus_unlock(out);
 
 	if (r) {
 		mutex_unlock(&ddata->lock);
@@ -563,16 +574,20 @@ static int n8x0_panel_enable(struct omap_dss_device *dssdev)
 static void n8x0_panel_disable(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = get_drv_data(dssdev);
+	struct omap_dss_output *out = dssdev->output;
 
 	dev_dbg(&dssdev->dev, "disable\n");
 
+	if (out == NULL)
+		return;
+
 	mutex_lock(&ddata->lock);
 
-	rfbi_bus_lock();
+	rfbi_bus_lock(out);
 
 	n8x0_panel_power_off(dssdev);
 
-	rfbi_bus_unlock();
+	rfbi_bus_unlock(out);
 
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 
@@ -582,16 +597,20 @@ static void n8x0_panel_disable(struct omap_dss_device *dssdev)
 static int n8x0_panel_suspend(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = get_drv_data(dssdev);
+	struct omap_dss_output *out = dssdev->output;
 
 	dev_dbg(&dssdev->dev, "suspend\n");
 
+	if (out == NULL)
+		return -ENODEV;
+
 	mutex_lock(&ddata->lock);
 
-	rfbi_bus_lock();
+	rfbi_bus_lock(out);
 
 	n8x0_panel_power_off(dssdev);
 
-	rfbi_bus_unlock();
+	rfbi_bus_unlock(out);
 
 	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
 
@@ -603,17 +622,21 @@ static int n8x0_panel_suspend(struct omap_dss_device *dssdev)
 static int n8x0_panel_resume(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = get_drv_data(dssdev);
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
 	dev_dbg(&dssdev->dev, "resume\n");
 
+	if (out == NULL)
+		return -ENODEV;
+
 	mutex_lock(&ddata->lock);
 
-	rfbi_bus_lock();
+	rfbi_bus_lock(out);
 
 	r = n8x0_panel_power_on(dssdev);
 
-	rfbi_bus_unlock();
+	rfbi_bus_unlock(out);
 
 	if (r) {
 		mutex_unlock(&ddata->lock);
@@ -636,7 +659,9 @@ static void n8x0_panel_get_resolution(struct omap_dss_device *dssdev,
 
 static void update_done(void *data)
 {
-	rfbi_bus_unlock();
+	struct omap_dss_device *dssdev = (struct omap_dss_device *) data;
+
+	rfbi_bus_unlock(dssdev->output);
 }
 
 static int n8x0_panel_update(struct omap_dss_device *dssdev,
@@ -661,11 +686,11 @@ static int n8x0_panel_update(struct omap_dss_device *dssdev,
 	}
 
 	mutex_lock(&ddata->lock);
-	rfbi_bus_lock();
+	rfbi_bus_lock(out);
 
 	blizzard_ctrl_setup_update(dssdev, x, y, w, h);
 
-	omap_rfbi_update(out, update_done, NULL);
+	omap_rfbi_update(out, update_done, dssdev);
 
 	mutex_unlock(&ddata->lock);
 
@@ -675,12 +700,13 @@ static int n8x0_panel_update(struct omap_dss_device *dssdev,
 static int n8x0_panel_sync(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = get_drv_data(dssdev);
+	struct omap_dss_output *out = dssdev->output;
 
 	dev_dbg(&dssdev->dev, "sync\n");
 
 	mutex_lock(&ddata->lock);
-	rfbi_bus_lock();
-	rfbi_bus_unlock();
+	rfbi_bus_lock(out);
+	rfbi_bus_unlock(out);
 	mutex_unlock(&ddata->lock);
 
 	return 0;
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index ca264e8..36bbe9a 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -149,19 +149,20 @@ static void rfbi_runtime_put(void)
 	WARN_ON(r < 0 && r != -ENOSYS);
 }
 
-void rfbi_bus_lock(void)
+void rfbi_bus_lock(struct omap_dss_output *out)
 {
 	down(&rfbi.bus_lock);
 }
 EXPORT_SYMBOL(rfbi_bus_lock);
 
-void rfbi_bus_unlock(void)
+void rfbi_bus_unlock(struct omap_dss_output *out)
 {
 	up(&rfbi.bus_lock);
 }
 EXPORT_SYMBOL(rfbi_bus_unlock);
 
-void omap_rfbi_write_command(const void *buf, u32 len)
+void omap_rfbi_write_command(struct omap_dss_output *out, const void *buf,
+		u32 len)
 {
 	switch (rfbi.parallelmode) {
 	case OMAP_DSS_RFBI_PARALLELMODE_8:
@@ -189,7 +190,7 @@ void omap_rfbi_write_command(const void *buf, u32 len)
 }
 EXPORT_SYMBOL(omap_rfbi_write_command);
 
-void omap_rfbi_read_data(void *buf, u32 len)
+void omap_rfbi_read_data(struct omap_dss_output *out, void *buf, u32 len)
 {
 	switch (rfbi.parallelmode) {
 	case OMAP_DSS_RFBI_PARALLELMODE_8:
@@ -221,7 +222,7 @@ void omap_rfbi_read_data(void *buf, u32 len)
 }
 EXPORT_SYMBOL(omap_rfbi_read_data);
 
-void omap_rfbi_write_data(const void *buf, u32 len)
+void omap_rfbi_write_data(struct omap_dss_output *out, const void *buf, u32 len)
 {
 	switch (rfbi.parallelmode) {
 	case OMAP_DSS_RFBI_PARALLELMODE_8:
@@ -250,7 +251,8 @@ void omap_rfbi_write_data(const void *buf, u32 len)
 }
 EXPORT_SYMBOL(omap_rfbi_write_data);
 
-void omap_rfbi_write_pixels(const void __iomem *buf, int scr_width,
+void omap_rfbi_write_pixels(struct omap_dss_output *out,
+		const void __iomem *buf, int scr_width,
 		u16 x, u16 y,
 		u16 w, u16 h)
 {
@@ -572,7 +574,7 @@ static int rfbi_convert_timings(struct rfbi_timings *t)
 }
 
 /* xxx FIX module selection missing */
-int omap_rfbi_setup_te(enum omap_rfbi_te_mode mode,
+int omap_rfbi_setup_te(struct omap_dss_output *out, enum omap_rfbi_te_mode mode,
 			     unsigned hs_pulse_time, unsigned vs_pulse_time,
 			     int hs_pol_inv, int vs_pol_inv, int extif_div)
 {
@@ -614,7 +616,7 @@ int omap_rfbi_setup_te(enum omap_rfbi_te_mode mode,
 EXPORT_SYMBOL(omap_rfbi_setup_te);
 
 /* xxx FIX module selection missing */
-int omap_rfbi_enable_te(bool enable, unsigned line)
+int omap_rfbi_enable_te(struct omap_dss_output *out, bool enable, unsigned line)
 {
 	u32 l;
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 723f091..b3faea7 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -239,18 +239,22 @@ struct rfbi_timings {
 	int converted;
 };
 
-void omap_rfbi_write_command(const void *buf, u32 len);
-void omap_rfbi_read_data(void *buf, u32 len);
-void omap_rfbi_write_data(const void *buf, u32 len);
-void omap_rfbi_write_pixels(const void __iomem *buf, int scr_width,
+void omap_rfbi_write_command(struct omap_dss_output *out, const void *buf,
+		u32 len);
+void omap_rfbi_read_data(struct omap_dss_output *out, void *buf, u32 len);
+void omap_rfbi_write_data(struct omap_dss_output *out, const void *buf,
+		u32 len);
+void omap_rfbi_write_pixels(struct omap_dss_output *out,
+		const void __iomem *buf, int scr_width,
 		u16 x, u16 y,
 		u16 w, u16 h);
-int omap_rfbi_enable_te(bool enable, unsigned line);
-int omap_rfbi_setup_te(enum omap_rfbi_te_mode mode,
+int omap_rfbi_enable_te(struct omap_dss_output *out, bool enable,
+		unsigned line);
+int omap_rfbi_setup_te(struct omap_dss_output *out, enum omap_rfbi_te_mode mode,
 			     unsigned hs_pulse_time, unsigned vs_pulse_time,
 			     int hs_pol_inv, int vs_pol_inv, int extif_div);
-void rfbi_bus_lock(void);
-void rfbi_bus_unlock(void);
+void rfbi_bus_lock(struct omap_dss_output *out);
+void rfbi_bus_unlock(struct omap_dss_output *out);
 
 /* DSI */
 
-- 
1.7.9.5


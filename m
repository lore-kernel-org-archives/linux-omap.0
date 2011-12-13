From: <mythripk@ti.com>
Subject: [PATCH 2/3] OMAPDSS: HDMI: HPD support added to HDMI driver
Date: Tue, 13 Dec 2011 18:54:57 +0530
Message-ID: <1323782698-24428-3-git-send-email-mythripk@ti.com>
References: <1323782698-24428-1-git-send-email-mythripk@ti.com>
 <1323782698-24428-2-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49276 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300Ab1LMNch (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Dec 2011 08:32:37 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id pBDDWYLn007552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 07:32:36 -0600
Received: from DBDE70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id pBDDWXbq012432
	for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 19:02:33 +0530 (IST)
In-Reply-To: <1323782698-24428-2-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

GPIO based handling of connect/disconnect of the HDMI cable
(Hot-plug detect)is added to the HDMI driver.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/dss.h  |    2 +
 drivers/video/omap2/dss/hdmi.c |   76 ++++++++++++++++++++++++++++++++++++++++
 include/video/omapdss.h        |    3 ++
 3 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 6308fc5..c1279a3 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -498,6 +498,8 @@ int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
 					struct omap_video_timings *timings);
 int omapdss_hdmi_read_edid(u8 *buf, int len);
 bool omapdss_hdmi_detect(void);
+int omapdss_hdmi_hpd_enable(struct omap_dss_device *dssdev);
+void omapdss_hdmi_hpd_disable(struct omap_dss_device *dssdev);
 int hdmi_panel_init(void);
 void hdmi_panel_exit(void);
 
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 36a7541..1fe8e84 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -67,9 +67,12 @@ static struct {
 	struct mutex lock;
 	struct omap_display_platform_data *pdata;
 	struct platform_device *pdev;
+	struct omap_dss_device *dssdev;
+
 	struct hdmi_ip_data ip_data;
 	int code;
 	int mode;
+	int hpd;
 
 	struct clk *sys_clk;
 } hdmi;
@@ -454,6 +457,32 @@ void hdmi_dump_regs(struct seq_file *s)
 	mutex_unlock(&hdmi.lock);
 }
 
+static int hdmi_get_current_hpd(void)
+{
+	return gpio_get_value(hdmi.dssdev->hpd_gpio);
+}
+
+static irqreturn_t hpd_enable_handler(int irq, void *ptr)
+{
+	DSSDBG("hpd enable %d\n", hdmi.hpd);
+
+	if (hdmi.hpd)
+		hdmi.dssdev->driver->default_enable(hdmi.dssdev);
+	else
+		hdmi.dssdev->driver->default_disable(hdmi.dssdev);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t hpd_irq_handler(int irq, void *ptr)
+{
+	hdmi.hpd = hdmi_get_current_hpd();
+
+	DSSDBG("hpd %d\n", hdmi.hpd);
+
+	return IRQ_WAKE_THREAD;
+}
+
 int omapdss_hdmi_read_edid(u8 *buf, int len)
 {
 	int r;
@@ -488,6 +517,41 @@ bool omapdss_hdmi_detect(void)
 	return r == 1;
 }
 
+void omapdss_hdmi_hpd_disable(struct omap_dss_device *dssdev)
+{
+	DSSDBG("Enter hdmi_hpd_disable\n");
+
+	if (hdmi.dssdev)
+		free_irq(gpio_to_irq(hdmi.dssdev->hpd_gpio), hpd_irq_handler);
+
+	mutex_unlock(&hdmi.lock);
+}
+
+int omapdss_hdmi_hpd_enable(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+
+	DSSDBG("ENTER hdmi_hpd_enable\n");
+
+	mutex_lock(&hdmi.lock);
+
+	r = request_threaded_irq(gpio_to_irq(hdmi.dssdev->hpd_gpio),
+			hpd_irq_handler, hpd_enable_handler,
+			IRQF_DISABLED | IRQF_TRIGGER_RISING |
+			IRQF_TRIGGER_FALLING, "hpd", NULL);
+	if (r < 0) {
+		pr_err("hdmi: request_irq %d failed\n",
+			gpio_to_irq(hdmi.dssdev->hpd_gpio));
+		return -EINVAL;
+	}
+
+	r = hdmi_get_current_hpd();
+
+	mutex_unlock(&hdmi.lock);
+
+	return r;
+}
+
 int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev)
 {
 	int r = 0;
@@ -733,12 +797,24 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 {
 	struct resource *hdmi_mem;
 	int r;
+	struct omap_dss_board_info *board_data;
 
 	hdmi.pdata = pdev->dev.platform_data;
 	hdmi.pdev = pdev;
 
 	mutex_init(&hdmi.lock);
 
+	/* save reference to HDMI device */
+	board_data = hdmi.pdata->board_data;
+	for (r = 0; r < board_data->num_devices; r++) {
+		if (board_data->devices[r]->type == OMAP_DISPLAY_TYPE_HDMI)
+			hdmi.dssdev = board_data->devices[r];
+	}
+	if (!hdmi.dssdev) {
+		DSSERR("can't get HDMI device\n");
+		return -EINVAL;
+	}
+
 	hdmi_mem = platform_get_resource(hdmi.pdev, IORESOURCE_MEM, 0);
 	if (!hdmi_mem) {
 		DSSERR("can't get IORESOURCE_MEM HDMI\n");
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index ffd5d42..82e2c3e 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -630,6 +630,9 @@ struct omap_dss_driver {
 
 	int (*read_edid)(struct omap_dss_device *dssdev, u8 *buf, int len);
 	bool (*detect)(struct omap_dss_device *dssdev);
+
+	int (*default_enable)(struct omap_dss_device *dssdev);
+	void (*default_disable)(struct omap_dss_device *dssdev);
 };
 
 int omap_dss_register_driver(struct omap_dss_driver *);
-- 
1.7.5.4


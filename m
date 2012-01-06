From: <mythripk@ti.com>
Subject: [PATCH v2 3/3] OMAPDSS: HDMI: HPD support added to HDMI driver
Date: Fri, 6 Jan 2012 18:14:37 +0530
Message-ID: <1325853877-6712-4-git-send-email-mythripk@ti.com>
References: <1325853877-6712-1-git-send-email-mythripk@ti.com>
 <1325853877-6712-2-git-send-email-mythripk@ti.com>
 <1325853877-6712-3-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59290 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754292Ab2AFMwH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Jan 2012 07:52:07 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q06Cq5XT029387
	for <linux-omap@vger.kernel.org>; Fri, 6 Jan 2012 06:52:06 -0600
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q06Cq4gK025619
	for <linux-omap@vger.kernel.org>; Fri, 6 Jan 2012 18:22:04 +0530 (IST)
In-Reply-To: <1325853877-6712-3-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

GPIO based handling of connect/disconnect of the HDMI cable
(Hot-plug detect)is added to the HDMI driver.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |    1 +
 drivers/video/omap2/dss/hdmi.c         |   49 ++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 544b172..ef3f666 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -477,6 +477,7 @@ static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
 	.audio_enable		=       ti_hdmi_4xxx_wp_audio_enable,
 #endif
 	.configure_range	=	ti_hdmi_4xxx_configure_range,
+	.notify_hpd		=	ti_hdmi_4xxx_notify_hpd,
 
 };
 
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 29de79f..4c3110d 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -66,6 +66,9 @@ static struct {
 	struct omap_display_platform_data *pdata;
 	struct platform_device *pdev;
 	struct hdmi_ip_data ip_data;
+	struct omap_dss_device *dssdev;
+
+	bool hpd;
 
 	struct clk *sys_clk;
 } hdmi;
@@ -461,6 +464,29 @@ void hdmi_dump_regs(struct seq_file *s)
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
+	hdmi.ip_data.ops->notify_hpd(&hdmi.ip_data, hdmi.hpd);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t hpd_irq_handler(int irq, void *ptr)
+{
+	if (hdmi.dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
+		hdmi.hpd = hdmi_get_current_hpd();
+		return IRQ_WAKE_THREAD;
+	}
+	return IRQ_HANDLED;
+}
+
 int omapdss_hdmi_read_edid(u8 *buf, int len)
 {
 	int r;
@@ -782,11 +808,22 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
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
 
 	hdmi_mem = platform_get_resource(hdmi.pdev, IORESOURCE_MEM, 0);
 	if (!hdmi_mem) {
@@ -810,6 +847,16 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
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
 	hdmi.ip_data.core_sys_offset = HDMI_CORE_SYS;
 	hdmi.ip_data.core_av_offset = HDMI_CORE_AV;
 	hdmi.ip_data.pll_offset = HDMI_PLLCTRL;
@@ -840,6 +887,8 @@ static int omapdss_hdmihw_remove(struct platform_device *pdev)
 	snd_soc_unregister_codec(&pdev->dev);
 #endif
 
+	free_irq(gpio_to_irq(hdmi.dssdev->hpd_gpio), hpd_irq_handler);
+
 	pm_runtime_disable(&pdev->dev);
 
 	hdmi_put_clocks();
-- 
1.7.5.4


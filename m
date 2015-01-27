From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 05/14] OMAPDSS: encoder-tpd12s015: Fix race issue with LS_OE
Date: Tue, 27 Jan 2015 12:50:33 +0200
Message-ID: <1422355842-11234-6-git-send-email-tomi.valkeinen@ti.com>
References: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60763 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755533AbbA0KvC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Jan 2015 05:51:02 -0500
In-Reply-To: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

A race issue has been observed with the encoder-tpd12s015 driver, which
leads to errors when trying to read EDID. This has only now been
observed, as OMAP4 and OMAP5 boards used SoC's GPIOs for LS_OE GPIO. On
dra7-evm boards, the LS_OE is behind a i2c controlled GPIO expander,
which increases the time to set the LS_OE.

This patch simplifies the handling of the LS_OE gpio in the driver by
removing the interrupt handling totally. The only time we actually need
to enable LS_OE is when we are reading the EDID, and thus we can just
set and clear the LS_OE gpio inside the read_edid() function.

This also has the additional benefit of very slightly decreasing the
power consumption.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../fbdev/omap2/displays-new/encoder-tpd12s015.c   | 57 ++++------------------
 1 file changed, 10 insertions(+), 47 deletions(-)

diff --git a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
index 7f3e11b16c86..990af6baeb0f 100644
--- a/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
+++ b/drivers/video/fbdev/omap2/displays-new/encoder-tpd12s015.c
@@ -29,33 +29,10 @@ struct panel_drv_data {
 	int hpd_gpio;
 
 	struct omap_video_timings timings;
-
-	struct completion hpd_completion;
 };
 
 #define to_panel_data(x) container_of(x, struct panel_drv_data, dssdev)
 
-static irqreturn_t tpd_hpd_irq_handler(int irq, void *data)
-{
-	struct panel_drv_data *ddata = data;
-	bool hpd;
-
-	hpd = gpio_get_value_cansleep(ddata->hpd_gpio);
-
-	dev_dbg(ddata->dssdev.dev, "hpd %d\n", hpd);
-
-	if (gpio_is_valid(ddata->ls_oe_gpio)) {
-		if (hpd)
-			gpio_set_value_cansleep(ddata->ls_oe_gpio, 1);
-		else
-			gpio_set_value_cansleep(ddata->ls_oe_gpio, 0);
-	}
-
-	complete_all(&ddata->hpd_completion);
-
-	return IRQ_HANDLED;
-}
-
 static int tpd_connect(struct omap_dss_device *dssdev,
 		struct omap_dss_device *dst)
 {
@@ -70,23 +47,10 @@ static int tpd_connect(struct omap_dss_device *dssdev,
 	dst->src = dssdev;
 	dssdev->dst = dst;
 
-	reinit_completion(&ddata->hpd_completion);
-
 	gpio_set_value_cansleep(ddata->ct_cp_hpd_gpio, 1);
 	/* DC-DC converter needs at max 300us to get to 90% of 5V */
 	udelay(300);
 
-	/*
-	 * If there's a cable connected, wait for the hpd irq to trigger,
-	 * which turns on the level shifters.
-	 */
-	if (gpio_get_value_cansleep(ddata->hpd_gpio)) {
-		unsigned long to;
-		to = wait_for_completion_timeout(&ddata->hpd_completion,
-				msecs_to_jiffies(250));
-		WARN_ON_ONCE(to == 0);
-	}
-
 	return 0;
 }
 
@@ -179,11 +143,20 @@ static int tpd_read_edid(struct omap_dss_device *dssdev,
 {
 	struct panel_drv_data *ddata = to_panel_data(dssdev);
 	struct omap_dss_device *in = ddata->in;
+	int r;
 
 	if (!gpio_get_value_cansleep(ddata->hpd_gpio))
 		return -ENODEV;
 
-	return in->ops.hdmi->read_edid(in, edid, len);
+	if (gpio_is_valid(ddata->ls_oe_gpio))
+		gpio_set_value_cansleep(ddata->ls_oe_gpio, 1);
+
+	r = in->ops.hdmi->read_edid(in, edid, len);
+
+	if (gpio_is_valid(ddata->ls_oe_gpio))
+		gpio_set_value_cansleep(ddata->ls_oe_gpio, 0);
+
+	return r;
 }
 
 static bool tpd_detect(struct omap_dss_device *dssdev)
@@ -309,8 +282,6 @@ static int tpd_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ddata);
 
-	init_completion(&ddata->hpd_completion);
-
 	if (dev_get_platdata(&pdev->dev)) {
 		r = tpd_probe_pdata(pdev);
 		if (r)
@@ -340,13 +311,6 @@ static int tpd_probe(struct platform_device *pdev)
 	if (r)
 		goto err_gpio;
 
-	r = devm_request_threaded_irq(&pdev->dev, gpio_to_irq(ddata->hpd_gpio),
-				 NULL, tpd_hpd_irq_handler,
-				 IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
-				 IRQF_ONESHOT, "hpd", ddata);
-	if (r)
-		goto err_irq;
-
 	dssdev = &ddata->dssdev;
 	dssdev->ops.hdmi = &tpd_hdmi_ops;
 	dssdev->dev = &pdev->dev;
@@ -365,7 +329,6 @@ static int tpd_probe(struct platform_device *pdev)
 
 	return 0;
 err_reg:
-err_irq:
 err_gpio:
 	omap_dss_put_device(ddata->in);
 	return r;
-- 
2.2.2


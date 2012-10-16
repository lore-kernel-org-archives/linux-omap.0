From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 6/6] OMAPDSS: HDMI: Create platform device to support audio
Date: Mon, 15 Oct 2012 20:27:19 -0500
Message-ID: <1350350839-30408-7-git-send-email-ricardo.neri@ti.com>
References: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44017 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755516Ab2JPB3o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Oct 2012 21:29:44 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9G1TiD3007243
	for <linux-omap@vger.kernel.org>; Mon, 15 Oct 2012 20:29:44 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9G1TipN015151
	for <linux-omap@vger.kernel.org>; Mon, 15 Oct 2012 20:29:44 -0500
In-Reply-To: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Creating the accessory devices, such as audio, from the HDMI driver
allows to regard HDMI as a single entity with audio an display
functionality. This intends to follow the design of drivers such
as MFD, in which a single entity handles the creation of the accesory
devices. Such devices are then used by domain-specific drivers; audio in
this case.

Also, this is in line with the DT implementation of HDMI, in which we will
have a single node to describe this feature of the OMAP SoC.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   68 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index e5be0a5..c62c5ab 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -60,6 +60,9 @@
 static struct {
 	struct mutex lock;
 	struct platform_device *pdev;
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+	struct platform_device *audio_pdev;
+#endif
 
 	struct hdmi_ip_data ip_data;
 
@@ -73,6 +76,13 @@ static struct {
 	struct omap_dss_output output;
 } hdmi;
 
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+#define HDMI_AUDIO_MEM_RESOURCE 0
+#define HDMI_AUDIO_DMA_RESOURCE 1
+static struct resource hdmi_aud_res[2];
+#endif
+
+
 /*
  * Logic for the below structure :
  * user enters the CEA or VESA timings by specifying the HDMI/DVI code.
@@ -765,6 +775,50 @@ static void hdmi_put_clocks(void)
 }
 
 #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+static int hdmi_probe_audio(struct platform_device *pdev)
+{
+	struct resource *res;
+
+	hdmi.audio_pdev = ERR_PTR(-EINVAL);
+
+	res = platform_get_resource(hdmi.pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		DSSERR("can't get IORESOURCE_MEM HDMI\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Pass this resource to audio_pdev.
+	 * Audio drivers should not remap it
+	 */
+	hdmi_aud_res[HDMI_AUDIO_MEM_RESOURCE].start = res->start;
+	hdmi_aud_res[HDMI_AUDIO_MEM_RESOURCE].end = res->end;
+	hdmi_aud_res[HDMI_AUDIO_MEM_RESOURCE].flags = IORESOURCE_MEM;
+
+	res = platform_get_resource(hdmi.pdev, IORESOURCE_DMA, 0);
+	if (!res) {
+		DSSERR("can't get IORESOURCE_DMA HDMI\n");
+		return -EINVAL;
+	}
+
+	/* Pass this resource to audio_pdev */
+	hdmi_aud_res[HDMI_AUDIO_DMA_RESOURCE].start = res->start;
+	hdmi_aud_res[HDMI_AUDIO_DMA_RESOURCE].end = res->end;
+	hdmi_aud_res[HDMI_AUDIO_DMA_RESOURCE].flags = IORESOURCE_DMA;
+
+	/* create platform device for HDMI audio driver */
+	hdmi.audio_pdev = platform_device_register_simple(
+							  "omap_hdmi_audio",
+							  -1, hdmi_aud_res,
+							   ARRAY_SIZE(hdmi_aud_res));
+	if (IS_ERR(hdmi.audio_pdev)) {
+		DSSERR("Can't instantiate hdmi-audio\n");
+		return PTR_ERR(hdmi.audio_pdev);
+	}
+
+	return 0;
+}
+
 int hdmi_compute_acr(u32 sample_freq, u32 *n, u32 *cts)
 {
 	u32 deep_color;
@@ -1044,6 +1098,11 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 		goto err_panel_init;
 	}
 
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+	r = hdmi_probe_audio(pdev);
+	if (r)
+		goto err_audio_dev;
+#endif
 	dss_debugfs_create_file("hdmi", hdmi_dump_regs);
 
 	hdmi_init_output(pdev);
@@ -1052,6 +1111,10 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	return 0;
 
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+err_audio_dev:
+	hdmi_panel_exit();
+#endif
 err_panel_init:
 	hdmi_put_clocks();
 	return r;
@@ -1066,6 +1129,11 @@ static int __exit hdmi_remove_child(struct device *dev, void *data)
 
 static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+	if (!IS_ERR(hdmi.audio_pdev))
+		platform_device_unregister(hdmi.audio_pdev);
+#endif
+
 	device_for_each_child(&pdev->dev, NULL, hdmi_remove_child);
 
 	dss_unregister_child_devices(&pdev->dev);
-- 
1.7.5.4


From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 7/7] OMAPDSS: HDMI: Create platform device for audio support
Date: Fri, 2 Nov 2012 18:31:48 -0600
Message-ID: <1351902708-866-8-git-send-email-ricardo.neri@ti.com>
References: <1351902708-866-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44982 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438Ab2KBXeO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Nov 2012 19:34:14 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id qA2NYDVi022254
	for <linux-omap@vger.kernel.org>; Fri, 2 Nov 2012 18:34:13 -0500
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id qA2NYDiD013403
	for <linux-omap@vger.kernel.org>; Fri, 2 Nov 2012 18:34:13 -0500
In-Reply-To: <1351902708-866-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: peter.ujfalusi@ti.com, s-guiriec@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Creating the accessory devices, such as audio, from the HDMI driver
allows to regard HDMI as a single entity with audio an display
functionality. This intends to follow the design of drivers such
as MFD, in which a single entity handles the creation of the accessory
devices. Such devices are then used by domain-specific drivers; audio in
this case.

Also, this is in line with the DT implementation of HDMI, in which we will
have a single node to describe this feature of the OMAP SoC.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |   62 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 4adf830..d6ce4c6 100644
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
 
@@ -766,6 +769,54 @@ static void hdmi_put_clocks(void)
 }
 
 #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+static int hdmi_probe_audio(struct platform_device *pdev)
+{
+	struct resource *res;
+	u32 port_offset, port_size;
+	struct resource aud_res[2] = {
+		DEFINE_RES_MEM(-1, -1),
+		DEFINE_RES_DMA(-1),
+	};
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
+	 * Pass DMA audio port to audio drivers.
+	 * Audio drivers should not ioremap it.
+	 */
+	hdmi.ip_data.ops->audio_get_dma_port(&port_offset, &port_size);
+
+	aud_res[0].start = res->start + port_offset;
+	aud_res[0].end = aud_res[0].start + port_size - 1;
+
+	res = platform_get_resource(hdmi.pdev, IORESOURCE_DMA, 0);
+	if (!res) {
+		DSSERR("can't get IORESOURCE_DMA HDMI\n");
+		return -EINVAL;
+	}
+
+	/* Pass the audio DMA request resource to audio drivers. */
+	aud_res[1].start = res->start;
+
+	/* create platform device for HDMI audio driver */
+	hdmi.audio_pdev = platform_device_register_simple(
+							  "omap_hdmi_audio",
+							  -1, aud_res,
+							   ARRAY_SIZE(aud_res));
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
@@ -1046,6 +1097,12 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	hdmi_probe_pdata(pdev);
 
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+	r = hdmi_probe_audio(pdev);
+	if (r)
+		DSSWARN("could not create platform device for audio");
+#endif
+
 	return 0;
 
 err_panel_init:
@@ -1062,6 +1119,11 @@ static int __exit hdmi_remove_child(struct device *dev, void *data)
 
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


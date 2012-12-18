From: Ricardo Neri <rneri@dextratech.com>
Subject: [PATCH v3 4/5] ARM: OMAP4+: HDMI: Relocate the device for audio interface
Date: Mon, 17 Dec 2012 19:30:42 -0600
Message-ID: <1355794243-32345-5-git-send-email-rneri@dextratech.com>
References: <1355794243-32345-1-git-send-email-rneri@dextratech.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from spamfilter.dextratech.com ([187.141.251.67]:42947 "EHLO
	mail.dextratech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737Ab2LRBmu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Dec 2012 20:42:50 -0500
In-Reply-To: <1355794243-32345-1-git-send-email-rneri@dextratech.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com, tony@atomide.com
Cc: peter.ujfalusi@ti.com, dzuniga@dextratech.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <rneri@dextratech.com>

The HDMI display and audio functionality share the same resources (e.g., register
spaces). The ASoC HDMI CPU-DAI driver needs access to some (but not all) the
resources of the dss_hdmi platform device. As such resources are within the
address space of omapdss_hdmi, it makes sense to have the DSS HDMI driver to
create the platform driver with the required resources.

Signed-off-by: Ricardo Neri <rneri@dextratech.com>
---
 arch/arm/mach-omap2/devices.c  |   24 ----------------
 drivers/video/omap2/dss/hdmi.c |   59 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 6d37438..9fdc1f9 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -352,29 +352,6 @@ static void __init omap_init_dmic(void)
 static inline void omap_init_dmic(void) {}
 #endif
 
-#if defined(CONFIG_SND_OMAP_SOC_OMAP_HDMI) || \
-		defined(CONFIG_SND_OMAP_SOC_OMAP_HDMI_MODULE)
-
-static void __init omap_init_hdmi_audio(void)
-{
-	struct omap_hwmod *oh;
-	struct platform_device *pdev;
-
-	oh = omap_hwmod_lookup("dss_hdmi");
-	if (!oh) {
-		printk(KERN_ERR "Could not look up dss_hdmi hw_mod\n");
-		return;
-	}
-
-	pdev = omap_device_build("omap-hdmi-audio",
-		-1, oh, NULL, 0, NULL, 0, 0);
-	WARN(IS_ERR(pdev),
-	     "Can't build omap_device for omap-hdmi-audio-dai.\n");
-}
-#else
-static inline void omap_init_hdmi_audio(void) {}
-#endif
-
 #if defined(CONFIG_SPI_OMAP24XX) || defined(CONFIG_SPI_OMAP24XX_MODULE)
 
 #include <linux/platform_data/spi-omap2-mcspi.h>
@@ -620,7 +597,6 @@ static int __init omap2_init_devices(void)
 	 */
 	omap_init_audio();
 	omap_init_camera();
-	omap_init_hdmi_audio();
 	omap_init_mbox();
 	/* If dtb is there, the devices will be created dynamically */
 	if (!of_have_populated_dt()) {
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 769d082..0dde2b5 100644
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
 
@@ -822,6 +825,51 @@ static void hdmi_put_clocks(void)
 }
 
 #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+static int hdmi_probe_audio(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct platform_device *aud_pdev;
+	struct resource aud_res[2] = {
+		DEFINE_RES_MEM(-1, -1),
+		DEFINE_RES_DMA(-1),
+	};
+
+	res = platform_get_resource(hdmi.pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		DSSERR("can't get IORESOURCE_MEM HDMI\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Pass this resource to audio drivers to find the DMA port address.
+	 * Audio drivers should not ioremap it.
+	 */
+	aud_res[0].start = res->start;
+	aud_res[0].end = res->end;
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
+	aud_pdev = platform_device_register_simple("omap-hdmi-audio",
+						   pdev->id, aud_res,
+						   ARRAY_SIZE(aud_res));
+	if (IS_ERR(aud_pdev)) {
+		DSSERR("Can't instantiate hdmi-audio\n");
+		return -ENODEV;
+	}
+
+	hdmi.audio_pdev = aud_pdev;
+
+	return 0;
+}
+
 int hdmi_compute_acr(u32 sample_freq, u32 *n, u32 *cts)
 {
 	u32 deep_color;
@@ -1111,6 +1159,12 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	hdmi_probe_pdata(pdev);
 
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+	r = hdmi_probe_audio(pdev);
+	if (r)
+		DSSWARN("could not create platform device for audio");
+#endif
+
 	return 0;
 
 err_panel_init:
@@ -1127,6 +1181,11 @@ static int __exit hdmi_remove_child(struct device *dev, void *data)
 
 static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+	if (hdmi.audio_pdev != NULL)
+		platform_device_unregister(hdmi.audio_pdev);
+#endif
+
 	device_for_each_child(&pdev->dev, NULL, hdmi_remove_child);
 
 	dss_unregister_child_devices(&pdev->dev);
-- 
1.7.10.4


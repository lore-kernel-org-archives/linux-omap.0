From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 1/2] ARM: OMAP2+: HDMI: Relocate audio platform device creation
Date: Thu, 15 Nov 2012 19:36:58 -0600
Message-ID: <1353029819-21809-2-git-send-email-ricardo.neri@ti.com>
References: <1353029819-21809-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55273 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab2KPBiQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 20:38:16 -0500
In-Reply-To: <1353029819-21809-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, tomi.valkeinen@ti.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

Creating the accessory devices (such as audio) from the HDMI driver,
allows to regard HDMI as a single entity with audio an display
functionality. This intends to follow the design of drivers such
as MFD-type, in which a single entity handles the creation of the accessory
devices. Such devices are then used by domain-specific drivers (audio in
this case). This is in line with the DT implementation of HDMI, in which
we will have a single node to describe this feature of the OMAP SoC. Otherwise,
we would need to have separate nodes for audio and video functionality.

Previously, the platform device for the audio driver was created in
arch/arm/mach-omap2/devices.c. Thus, this is removed.

Also, as the platform device for audio created by the OMAPDSS HDMI now provides
a resource for the DMA port for audio samples, we do not need to specify
any offset in the ASoC HDMI CPU DAI driver.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 arch/arm/mach-omap2/devices.c  |   14 ---------
 drivers/video/omap2/dss/hdmi.c |   62 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/omap/omap-hdmi.c     |    3 +-
 sound/soc/omap/omap-hdmi.h     |    2 -
 4 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index c8c2117..417a87d 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -362,20 +362,6 @@ static struct platform_device omap_hdmi_audio = {
 
 static void __init omap_init_hdmi_audio(void)
 {
-	struct omap_hwmod *oh;
-	struct platform_device *pdev;
-
-	oh = omap_hwmod_lookup("dss_hdmi");
-	if (!oh) {
-		printk(KERN_ERR "Could not look up dss_hdmi hw_mod\n");
-		return;
-	}
-
-	pdev = omap_device_build("omap-hdmi-audio-dai",
-		-1, oh, NULL, 0, NULL, 0, 0);
-	WARN(IS_ERR(pdev),
-	     "Can't build omap_device for omap-hdmi-audio-dai.\n");
-
 	platform_device_register(&omap_hdmi_audio);
 }
 #else
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 24a2eef..6d48026 100644
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
 
@@ -822,6 +825,54 @@ static void hdmi_put_clocks(void)
 }
 
 #if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+static int hdmi_probe_audio(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct platform_device *aud_pdev;
+	u32 port_offset, port_size;
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
+	aud_pdev = platform_device_register_simple("omap-hdmi-audio-dai",
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
@@ -1102,6 +1153,12 @@ static int __init omapdss_hdmihw_probe(struct platform_device *pdev)
 
 	hdmi_probe_pdata(pdev);
 
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+	r = hdmi_probe_audio(pdev);
+	if (r)
+		DSSWARN("could not create platform device for audio");
+#endif
+
 	return 0;
 
 err_panel_init:
@@ -1118,6 +1175,11 @@ static int __exit hdmi_remove_child(struct device *dev, void *data)
 
 static int __exit omapdss_hdmihw_remove(struct platform_device *pdev)
 {
+#if defined(CONFIG_OMAP4_DSS_HDMI_AUDIO)
+	if (hdmi.audio_pdev != NULL)
+		platform_device_unregister(hdmi.audio_pdev);
+#endif
+
 	device_for_each_child(&pdev->dev, NULL, hdmi_remove_child);
 
 	dss_unregister_child_devices(&pdev->dev);
diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index f59c69f..8034cf7 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -281,8 +281,7 @@ static __devinit int omap_hdmi_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	hdmi_data->dma_params.port_addr =  hdmi_rsrc->start
-		+ OMAP_HDMI_AUDIO_DMA_PORT;
+	hdmi_data->dma_params.port_addr =  hdmi_rsrc->start;
 
 	hdmi_rsrc = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	if (!hdmi_rsrc) {
diff --git a/sound/soc/omap/omap-hdmi.h b/sound/soc/omap/omap-hdmi.h
index 6ad2bf4..33d7a93 100644
--- a/sound/soc/omap/omap-hdmi.h
+++ b/sound/soc/omap/omap-hdmi.h
@@ -25,8 +25,6 @@
 #ifndef __OMAP_HDMI_H__
 #define __OMAP_HDMI_H__
 
-#define OMAP_HDMI_AUDIO_DMA_PORT 0x8c
-
 #define OMAP_HDMI_RATES	(SNDRV_PCM_RATE_32000 | \
 				SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 | \
 				SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 | \
-- 
1.7.5.4


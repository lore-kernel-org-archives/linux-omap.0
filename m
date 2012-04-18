From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 1/3] ARM: OMAP: devices: Register platform devices for HDMI audio
Date: Tue, 17 Apr 2012 19:40:44 -0500
Message-ID: <1334709646-8468-2-git-send-email-ricardo.neri@ti.com>
References: <1334709646-8468-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54513 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287Ab2DRAk6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Apr 2012 20:40:58 -0400
In-Reply-To: <1334709646-8468-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

Add platform registration for the devices HDMI audio support. The
omap-hdmi-audio-dai platform device is to be used by the ASoC HDMI
CPU DAI driver. The omap-hdmi-audio platform device is to be used
by the ASoC HDMI machine driver that links together the ASOC CPU DAI,
ASoC plaform and ASoC codec drivers.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 arch/arm/mach-omap2/devices.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index e433603..17dacef 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -355,6 +355,36 @@ static void __init omap_init_dmic(void)
 static inline void omap_init_dmic(void) {}
 #endif
 
+#if defined(CONFIG_SND_OMAP_SOC_OMAP_HDMI) || \
+		defined(CONFIG_SND_OMAP_SOC_OMAP_HDMI_MODULE)
+
+static struct platform_device omap_hdmi_audio = {
+	.name	= "omap-hdmi-audio",
+	.id	= -1,
+};
+
+static void __init omap_init_hdmi_audio(void)
+{
+	struct omap_hwmod *oh;
+	struct platform_device *pdev;
+
+	oh = omap_hwmod_lookup("dss_hdmi");
+	if (!oh) {
+		printk(KERN_ERR "Could not look up dss_hdmi hw_mod\n");
+		return;
+	}
+
+	pdev = omap_device_build("omap-hdmi-audio-dai",
+		-1, oh, NULL, 0, NULL, 0, 0);
+	WARN(IS_ERR(pdev),
+	     "Can't build omap_device for omap-hdmi-audio-dai.\n");
+
+	platform_device_register(&omap_hdmi_audio);
+}
+#else
+static inline void omap_init_hdmi_audio(void) {}
+#endif
+
 #if defined(CONFIG_SPI_OMAP24XX) || defined(CONFIG_SPI_OMAP24XX_MODULE)
 
 #include <plat/mcspi.h>
@@ -704,6 +734,7 @@ static int __init omap2_init_devices(void)
 	omap_init_mcpdm();
 	omap_init_dmic();
 	omap_init_camera();
+	omap_init_hdmi_audio();
 	omap_init_mbox();
 	omap_init_mcspi();
 	omap_init_pmu();
-- 
1.7.5.4


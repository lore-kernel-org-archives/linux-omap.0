From: Thomas Weber <swirl@gmx.li>
Subject: [PATCHv3 3/4] Add ASoC support for DevKit8000
Date: Wed, 10 Feb 2010 20:23:04 +0100
Message-ID: <1265829784-19224-1-git-send-email-swirl@gmx.li>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:40600 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751324Ab0BJTWx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Feb 2010 14:22:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, Thomas Weber <swirl@gmx.li>, felipe.balbi@nokia.com, tony@atomride.com, Tomi.Valkeinen@nokia.com, jhnikula@gmail.com, weber@corscience.de

This patch expands the omap3beagle sound soc for the
beagle board clone Devkit8000.

Change log
V2
	Expand omap3beagle sound soc for DevKit8000 support.
V3 
	Separate Kconfig for Devkit8000.

Signed-off-by: Thomas Weber <swirl@gmx.li>
---
 sound/soc/omap/Kconfig       |    8 ++++++++
 sound/soc/omap/Makefile      |    1 +
 sound/soc/omap/omap3beagle.c |    6 +++---
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 61952aa..8520b75 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -101,6 +101,14 @@ config SND_OMAP_SOC_OMAP3_BEAGLE
 	help
 	  Say Y if you want to add support for SoC audio on the Beagleboard.
 
+config SND_OMAP_SOC_DEVKIT8000
+	tristate "SoC Audio support for DevKit8000"
+	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_DEVKIT8000
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the DevKit8000
+
 config SND_OMAP_SOC_ZOOM2
 	tristate "SoC Audio support for Zoom2"
 	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_ZOOM2
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 19283e5..c8195c9 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -29,5 +29,6 @@ obj-$(CONFIG_SND_OMAP_SOC_AM3517EVM) += snd-soc-am3517evm.o
 obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
+obj-$(CONFIG_SND_OMAP_SOC_DEVKIT8000) += snd-soc-omap3beagle.o
 obj-$(CONFIG_SND_OMAP_SOC_ZOOM2) += snd-soc-zoom2.o
 obj-$(CONFIG_SND_OMAP_SOC_IGEP0020) += snd-soc-igep0020.o
diff --git a/sound/soc/omap/omap3beagle.c b/sound/soc/omap/omap3beagle.c
index d88ad5c..240e097 100644
--- a/sound/soc/omap/omap3beagle.c
+++ b/sound/soc/omap/omap3beagle.c
@@ -117,11 +117,11 @@ static int __init omap3beagle_soc_init(void)
 {
 	int ret;
 
-	if (!machine_is_omap3_beagle()) {
-		pr_debug("Not OMAP3 Beagle!\n");
+	if (!(machine_is_omap3_beagle() || machine_is_devkit8000())) {
+		pr_debug("Not OMAP3 Beagle or Devkit8000!\n");
 		return -ENODEV;
 	}
-	pr_info("OMAP3 Beagle SoC init\n");
+	pr_info("OMAP3 Beagle/Devkit8000 SoC init\n");
 
 	omap3beagle_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!omap3beagle_snd_device) {
-- 
1.6.4.4


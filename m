From: Thomas Weber <weber@corscience.de>
Subject: [PATCH V2 3/4] Add ASoC support for Devkit8000
Date: Thu,  4 Feb 2010 17:20:10 +0100
Message-ID: <1265300410-1892-1-git-send-email-weber@corscience.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:63621 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933273Ab0BDQUN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 11:20:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Weber <weber@corscience.de>, felipe.balbi@nokia.com, Tomi.Valkeinen@nokia.com, jhnikula@gmail.com, tony@atomide.com

This patch expands the omap3beagle sound soc for the
beagle board clone DevKit8000.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 sound/soc/omap/Kconfig       |    8 +++++---
 sound/soc/omap/omap3beagle.c |    6 +++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 61952aa..1cdd541 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -94,12 +94,14 @@ config SND_OMAP_SOC_OMAP3_PANDORA
 	  Say Y if you want to add support for SoC audio on the OMAP3 Pandora.
 
 config SND_OMAP_SOC_OMAP3_BEAGLE
-	tristate "SoC Audio support for OMAP3 Beagle"
-	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3_BEAGLE
+	tristate "SoC Audio support for OMAP3 Beagle and Devkit8000"
+	depends on TWL4030_CORE && SND_OMAP_SOC 
+	depends on (MACH_OMAP3_BEAGLE || MACH_DEVKIT8000)
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TWL4030
 	help
-	  Say Y if you want to add support for SoC audio on the Beagleboard.
+	  Say Y if you want to add support for SoC audio on the Beagleboard or 
+	  the clone Devkit8000.
 
 config SND_OMAP_SOC_ZOOM2
 	tristate "SoC Audio support for Zoom2"
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


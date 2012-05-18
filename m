From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 09/11] ASoC: OMAP: HDMI: Make build config options more generic
Date: Fri, 18 May 2012 01:42:41 -0500
Message-ID: <1337323363-11449-10-git-send-email-ricardo.neri@ti.com>
References: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40221 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759877Ab2ERGnW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 May 2012 02:43:22 -0400
In-Reply-To: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: x0055901@ti.com, peter.ujfalusi@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

Make Kconfig and Makefile more generic to encompass not only
OMAP4 but other OMAP processors featuring HDMI.

Also, relax the dependency list to depend only on any OMAP processor
supporting OMAP2_DSS and OMAP4_DSS_HDMI. As HDMI support for
future OMAP versions is added, the dependency list must change
accordingly.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/omap/Kconfig  |    6 +++---
 sound/soc/omap/Makefile |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 13afb2c..57a2fa7 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -109,9 +109,9 @@ config SND_OMAP_SOC_OMAP_ABE_TWL6040
 	  - PandaBoard (4430)
 	  - PandaBoardES (4460)
 
-config SND_OMAP_SOC_OMAP4_HDMI
-	tristate "SoC Audio support for Texas Instruments OMAP4 HDMI"
-	depends on SND_OMAP_SOC && OMAP4_DSS_HDMI && OMAP2_DSS && ARCH_OMAP4
+config SND_OMAP_SOC_OMAP_HDMI
+	tristate "SoC Audio support for Texas Instruments OMAP HDMI"
+	depends on SND_OMAP_SOC && OMAP4_DSS_HDMI && OMAP2_DSS
 	select SND_OMAP_SOC_HDMI
 	select SND_SOC_OMAP_HDMI_CODEC
 	select OMAP4_DSS_HDMI_AUDIO
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 1d656bc..b4ef308 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -41,4 +41,4 @@ obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
 obj-$(CONFIG_SND_OMAP_SOC_ZOOM2) += snd-soc-zoom2.o
 obj-$(CONFIG_SND_OMAP_SOC_IGEP0020) += snd-soc-igep0020.o
-obj-$(CONFIG_SND_OMAP_SOC_OMAP4_HDMI) += snd-soc-omap4-hdmi.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP_HDMI) += snd-soc-omap4-hdmi.o
-- 
1.7.5.4


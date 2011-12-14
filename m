From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 02/10] ASoC: OMAP4: Rename the sdp4430 machine driver
Date: Wed, 14 Dec 2011 11:46:55 +0200
Message-ID: <1323856022-24053-3-git-send-email-peter.ujfalusi@ti.com>
References: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:55575 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751956Ab1LNJtK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 04:49:10 -0500
Received: by laam7 with SMTP id m7so323368laa.21
        for <linux-omap@vger.kernel.org>; Wed, 14 Dec 2011 01:49:07 -0800 (PST)
In-Reply-To: <1323856022-24053-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

The same machine driver will support other boards
with similar audio configuration (OMAP4, ABE, twl6040).
Rename the driver to have more generic name.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/Kconfig                           |    2 +-
 sound/soc/omap/Makefile                          |    4 ++--
 sound/soc/omap/{sdp4430.c => omap-abe-twl6040.c} |    1 -
 3 files changed, 3 insertions(+), 4 deletions(-)
 rename sound/soc/omap/{sdp4430.c => omap-abe-twl6040.c} (99%)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index fb1bf25..4eae929 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -97,7 +97,7 @@ config SND_OMAP_SOC_SDP3430
 	  Say Y if you want to add support for SoC audio on Texas Instruments
 	  SDP3430.
 
-config SND_OMAP_SOC_SDP4430
+config SND_OMAP_SOC_OMAP_ABE_TWL6040
 	tristate "SoC Audio support for Texas Instruments SDP4430"
 	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_4430SDP
 	select SND_OMAP_SOC_DMIC
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 1fd723f..123ac18 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -20,7 +20,7 @@ snd-soc-overo-objs := overo.o
 snd-soc-omap3evm-objs := omap3evm.o
 snd-soc-am3517evm-objs := am3517evm.o
 snd-soc-sdp3430-objs := sdp3430.o
-snd-soc-sdp4430-objs := sdp4430.o
+snd-soc-omap-abe-twl6040-objs := omap-abe-twl6040.o
 snd-soc-omap3pandora-objs := omap3pandora.o
 snd-soc-omap3beagle-objs := omap3beagle.o
 snd-soc-zoom2-objs := zoom2.o
@@ -36,7 +36,7 @@ obj-$(CONFIG_SND_OMAP_SOC_OMAP2EVM) += snd-soc-omap2evm.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3EVM) += snd-soc-omap3evm.o
 obj-$(CONFIG_SND_OMAP_SOC_AM3517EVM) += snd-soc-am3517evm.o
 obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
-obj-$(CONFIG_SND_OMAP_SOC_SDP4430) += snd-soc-sdp4430.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP_ABE_TWL6040) += snd-soc-omap-abe-twl6040.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
 obj-$(CONFIG_SND_OMAP_SOC_ZOOM2) += snd-soc-zoom2.o
diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/omap-abe-twl6040.c
similarity index 99%
rename from sound/soc/omap/sdp4430.c
rename to sound/soc/omap/omap-abe-twl6040.c
index 3186e0a..67c1709 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/omap-abe-twl6040.c
@@ -275,4 +275,3 @@ module_exit(sdp4430_soc_exit);
 MODULE_AUTHOR("Misael Lopez Cruz <misael.lopez@ti.com>");
 MODULE_DESCRIPTION("ALSA SoC SDP4430");
 MODULE_LICENSE("GPL");
-
-- 
1.7.8


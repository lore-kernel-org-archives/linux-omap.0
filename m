From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ASoC: OMAP: Build config cleanup for McBSP
Date: Fri,  9 Mar 2012 10:51:18 +0200
Message-ID: <1331283078-14846-3-git-send-email-peter.ujfalusi@ti.com>
References: <1331283078-14846-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:55318 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753730Ab2CIIvf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 03:51:35 -0500
Received: by lbbgi4 with SMTP id gi4so288949lbb.20
        for <linux-omap@vger.kernel.org>; Fri, 09 Mar 2012 00:51:33 -0800 (PST)
In-Reply-To: <1331283078-14846-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grazvydas Ignotas <notasas@gmail.com>

The McBSP driver stack has been moved, and rewritten resulting a single
driver - selected by CONFIG_SND_OMAP_SOC_MCBSP. There is no longer need to
have CONFIG_OMAP_MCBSP anymore.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/Kconfig  |    6 ------
 sound/soc/omap/Makefile |    3 +--
 2 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 4bb7802..deafbfa 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -5,13 +5,8 @@ config SND_OMAP_SOC
 config SND_OMAP_SOC_DMIC
 	tristate
 
-config OMAP_MCBSP
-	tristate
-	depends on ARCH_OMAP
-
 config SND_OMAP_SOC_MCBSP
 	tristate
-	select OMAP_MCBSP
 
 config SND_OMAP_SOC_MCPDM
 	tristate
@@ -31,7 +26,6 @@ config SND_OMAP_SOC_N810
 config SND_OMAP_SOC_RX51
 	tristate "SoC Audio support for Nokia RX-51"
 	depends on SND_OMAP_SOC && MACH_NOKIA_RX51
-	select OMAP_MCBSP
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TLV320AIC3X
 	select SND_SOC_TPA6130A2
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 9f8fbd5..1d656bc 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -1,13 +1,12 @@
 # OMAP Platform Support
 snd-soc-omap-objs := omap-pcm.o
 snd-soc-omap-dmic-objs := omap-dmic.o
-snd-soc-omap-mcbsp-objs := omap-mcbsp.o
+snd-soc-omap-mcbsp-objs := omap-mcbsp.o mcbsp.o
 snd-soc-omap-mcpdm-objs := omap-mcpdm.o
 snd-soc-omap-hdmi-objs := omap-hdmi.o
 
 obj-$(CONFIG_SND_OMAP_SOC) += snd-soc-omap.o
 obj-$(CONFIG_SND_OMAP_SOC_DMIC) += snd-soc-omap-dmic.o
-obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 obj-$(CONFIG_SND_OMAP_SOC_MCBSP) += snd-soc-omap-mcbsp.o
 obj-$(CONFIG_SND_OMAP_SOC_MCPDM) += snd-soc-omap-mcpdm.o
 obj-$(CONFIG_SND_OMAP_SOC_HDMI) += snd-soc-omap-hdmi.o
-- 
1.7.8.5


From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 2/4] Audio: Modifying Kconfig/Makefile for AM3517 EVM
Date: Fri, 30 Oct 2009 00:22:39 +0530
Message-ID: <1256842359-30409-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34256 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755285AbZJ2Swm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 14:52:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: broonie@opensource.wolfsonmicro.com, tony@atomide.com, Anuj Aggarwal <anuj.aggarwal@ti.com>

Modifying the Kconfig and Makefile in sound/soc/omap folder
to add support for OMAP3517 / AM3517 EVM in Alsa SoC.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 sound/soc/omap/Kconfig  |    9 +++++++++
 sound/soc/omap/Makefile |    2 ++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 2dee983..6344456 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -55,6 +55,15 @@ config SND_OMAP_SOC_OMAP3EVM
 	help
 	  Say Y if you want to add support for SoC audio on the omap3evm board.
 
+config SND_OMAP_SOC_AM3517EVM
+	tristate "SoC Audio support for OMAP3517 / AM3517 EVM"
+	depends on SND_OMAP_SOC && MACH_OMAP3517EVM && I2C
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TLV320AIC23
+	help
+	  Say Y if you want to add support for SoC audio on the OMAP3517 / AM3517
+	  EVM.
+
 config SND_OMAP_SOC_SDP3430
 	tristate "SoC Audio support for Texas Instruments SDP3430"
 	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_3430SDP
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 02d6947..0c78ae4 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -12,6 +12,7 @@ snd-soc-osk5912-objs := osk5912.o
 snd-soc-overo-objs := overo.o
 snd-soc-omap2evm-objs := omap2evm.o
 snd-soc-omap3evm-objs := omap3evm.o
+snd-soc-am3517evm-objs := am3517evm.o
 snd-soc-sdp3430-objs := sdp3430.o
 snd-soc-omap3pandora-objs := omap3pandora.o
 snd-soc-omap3beagle-objs := omap3beagle.o
@@ -23,6 +24,7 @@ obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
 obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
 obj-$(CONFIG_MACH_OMAP2EVM) += snd-soc-omap2evm.o
 obj-$(CONFIG_MACH_OMAP3EVM) += snd-soc-omap3evm.o
+obj-$(CONFIG_MACH_OMAP3517EVM) += snd-soc-am3517evm.o
 obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
-- 
1.6.2.4


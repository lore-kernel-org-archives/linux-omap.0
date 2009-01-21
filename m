From: Steve Sakoman <sakoman@gmail.com>
Subject: [PATCH] ASoC: Complete Beagleboard support
Date: Tue, 20 Jan 2009 23:05:27 -0800
Message-ID: <5e088bd90901202305m26900888jcaa2b0ec57d3fab1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:50051 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbZAUHFa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Jan 2009 02:05:30 -0500
Received: by bwz14 with SMTP id 14so12111530bwz.13
        for <linux-omap@vger.kernel.org>; Tue, 20 Jan 2009 23:05:28 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap <linux-omap@vger.kernel.org>

Commit dc06102a0c8b5aa0dd7f9a40ce241e793c252a87 in the asoc tree
did not include the necessary Kconfig and Makefile changes.  This patch
completes the support for Beagleboard

Signed-off-by: Steve Sakoman <steve@sakoman.com>

---
 sound/soc/omap/Kconfig  |   10 ++++++++++
 sound/soc/omap/Makefile |    2 ++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 4f7f040..ccd8973 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -55,3 +55,13 @@ config SND_OMAP_SOC_OMAP3_PANDORA
 	select SND_SOC_TWL4030
 	help
 	  Say Y if you want to add support for SoC audio on the OMAP3 Pandora.
+
+config SND_OMAP_SOC_OMAP3_BEAGLE
+	tristate "SoC Audio support for OMAP3 Beagle"
+	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP3_BEAGLE
+	select SND_OMAP_SOC_MCBSP
+	select SND_SOC_TWL4030
+	help
+	  Say Y if you want to add support for SoC audio on the Beagleboard.
+
+
diff --git a/sound/soc/omap/Makefile b/sound/soc/omap/Makefile
index 76fedd9..0c9e4ac 100644
--- a/sound/soc/omap/Makefile
+++ b/sound/soc/omap/Makefile
@@ -12,6 +12,7 @@ snd-soc-overo-objs := overo.o
 snd-soc-omap2evm-objs := omap2evm.o
 snd-soc-sdp3430-objs := sdp3430.o
 snd-soc-omap3pandora-objs := omap3pandora.o
+snd-soc-omap3beagle-objs := omap3beagle.o

 obj-$(CONFIG_SND_OMAP_SOC_N810) += snd-soc-n810.o
 obj-$(CONFIG_SND_OMAP_SOC_OSK5912) += snd-soc-osk5912.o
@@ -19,3 +20,4 @@ obj-$(CONFIG_SND_OMAP_SOC_OVERO) += snd-soc-overo.o
 obj-$(CONFIG_MACH_OMAP2EVM) += snd-soc-omap2evm.o
 obj-$(CONFIG_SND_OMAP_SOC_SDP3430) += snd-soc-sdp3430.o
 obj-$(CONFIG_SND_OMAP_SOC_OMAP3_PANDORA) += snd-soc-omap3pandora.o
+obj-$(CONFIG_SND_OMAP_SOC_OMAP3_BEAGLE) += snd-soc-omap3beagle.o
-- 
1.5.6.3

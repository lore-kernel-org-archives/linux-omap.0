From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 9/9] ASoC: Kconfig: OMAP4: Enable support for PandaBoards
Date: Thu, 22 Dec 2011 21:34:34 +0200
Message-ID: <1324582474-18181-10-git-send-email-peter.ujfalusi@ti.com>
References: <1324582474-18181-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:32986 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755732Ab1LVTf5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 14:35:57 -0500
Received: by lahl5 with SMTP id l5so6386681lah.27
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 11:35:55 -0800 (PST)
In-Reply-To: <1324582474-18181-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

Enable ASoC audio support for OMAP4 based machines with
twl6040 codec via the omap-abe-twl6040 machine driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/Kconfig |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 98410b8..47b23fe 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -99,7 +99,7 @@ config SND_OMAP_SOC_SDP3430
 
 config SND_OMAP_SOC_OMAP_ABE_TWL6040
 	tristate "SoC Audio support for OMAP boards using ABE and twl6040 codec"
-	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_4430SDP
+	depends on TWL4030_CORE && SND_OMAP_SOC && ARCH_OMAP4
 	select SND_OMAP_SOC_DMIC
 	select SND_OMAP_SOC_MCPDM
 	select SND_SOC_TWL6040
@@ -108,6 +108,8 @@ config SND_OMAP_SOC_OMAP_ABE_TWL6040
 	  Say Y if you want to add support for SoC audio on OMAP boards using
 	  ABE and twl6040 codec. This driver currently supports:
 	  - SDP4430/Blaze boards
+	  - PandaBoard (4430)
+	  - PandaBoardES (4460)
 
 config SND_OMAP_SOC_OMAP4_HDMI
 	tristate "SoC Audio support for Texas Instruments OMAP4 HDMI"
-- 
1.7.8.1


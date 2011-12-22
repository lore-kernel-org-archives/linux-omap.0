From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 9/9] ASoC: Kconfig: OMAP4: Enable support for PandaBoards
Date: Thu, 22 Dec 2011 18:38:22 +0200
Message-ID: <1324571902-16918-10-git-send-email-peter.ujfalusi@ti.com>
References: <1324571902-16918-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:41010 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755428Ab1LVQi6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 11:38:58 -0500
Received: by mail-lpp01m010-f54.google.com with SMTP id l5so4388299lah.41
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 08:38:57 -0800 (PST)
In-Reply-To: <1324571902-16918-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Enable the ASoC audio support for PandaBoard family via
teh omap-abe-twl6040 machine driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/Kconfig |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 98410b8..2d19119 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -99,7 +99,8 @@ config SND_OMAP_SOC_SDP3430
 
 config SND_OMAP_SOC_OMAP_ABE_TWL6040
 	tristate "SoC Audio support for OMAP boards using ABE and twl6040 codec"
-	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP_4430SDP
+	depends on TWL4030_CORE && SND_OMAP_SOC
+	depends on MACH_OMAP_4430SDP || MACH_OMAP4_PANDA
 	select SND_OMAP_SOC_DMIC
 	select SND_OMAP_SOC_MCPDM
 	select SND_SOC_TWL6040
@@ -108,6 +109,8 @@ config SND_OMAP_SOC_OMAP_ABE_TWL6040
 	  Say Y if you want to add support for SoC audio on OMAP boards using
 	  ABE and twl6040 codec. This driver currently supports:
 	  - SDP4430/Blaze boards
+	  - PandaBoard (4430)
+	  - PandaBoardES (4460)
 
 config SND_OMAP_SOC_OMAP4_HDMI
 	tristate "SoC Audio support for Texas Instruments OMAP4 HDMI"
-- 
1.7.8.1


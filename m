From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/5] ASoC: omap-mcbsp: Use the new interface for configuring CLKR/FSR mux
Date: Thu, 22 Dec 2011 19:31:44 +0200
Message-ID: <1324575106-17172-4-git-send-email-peter.ujfalusi@ti.com>
References: <1324575106-17172-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:50929 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753226Ab1LVRcH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Dec 2011 12:32:07 -0500
Received: by lahd3 with SMTP id d3so1309327lah.5
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 09:31:57 -0800 (PST)
In-Reply-To: <1324575106-17172-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Switch using the new API to configure the 6 pin port's CLKR/FSR mux
configuration.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcbsp.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 0173719..b9b0a9b 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -575,22 +575,26 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
 	case OMAP_MCBSP_CLKR_SRC_CLKR:
 		if (cpu_class_is_omap1())
 			break;
-		omap2_mcbsp1_mux_clkr_src(CLKR_SRC_CLKR);
+		err = omap_mcbsp_6pin_src_mux(mcbsp_data->bus_id,
+						    CLKR_SRC_CLKR);
 		break;
 	case OMAP_MCBSP_CLKR_SRC_CLKX:
 		if (cpu_class_is_omap1())
 			break;
-		omap2_mcbsp1_mux_clkr_src(CLKR_SRC_CLKX);
+		err = omap_mcbsp_6pin_src_mux(mcbsp_data->bus_id,
+						    CLKR_SRC_CLKX);
 		break;
 	case OMAP_MCBSP_FSR_SRC_FSR:
 		if (cpu_class_is_omap1())
 			break;
-		omap2_mcbsp1_mux_fsr_src(FSR_SRC_FSR);
+		err = omap_mcbsp_6pin_src_mux(mcbsp_data->bus_id,
+						    FSR_SRC_FSR);
 		break;
 	case OMAP_MCBSP_FSR_SRC_FSX:
 		if (cpu_class_is_omap1())
 			break;
-		omap2_mcbsp1_mux_fsr_src(FSR_SRC_FSX);
+		err = omap_mcbsp_6pin_src_mux(mcbsp_data->bus_id,
+						    FSR_SRC_FSX);
 		break;
 	default:
 		err = -ENODEV;
-- 
1.7.8.1


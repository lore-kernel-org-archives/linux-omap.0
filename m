From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 6/9] ASoC: omap-mcbsp: Remove unused defines
Date: Mon, 13 Aug 2012 17:22:45 +0300
Message-ID: <1344867768-26335-7-git-send-email-peter.ujfalusi@ti.com>
References: <1344867768-26335-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:57440 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751227Ab2HMOWw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Aug 2012 10:22:52 -0400
Received: by obbta14 with SMTP id ta14so9102479obb.32
        for <linux-omap@vger.kernel.org>; Mon, 13 Aug 2012 07:22:51 -0700 (PDT)
In-Reply-To: <1344867768-26335-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

NUM_LINKS is no longer in use by the code.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 sound/soc/omap/omap-mcbsp.h |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/omap/omap-mcbsp.h
index baebcee..ba8386a 100644
--- a/sound/soc/omap/omap-mcbsp.h
+++ b/sound/soc/omap/omap-mcbsp.h
@@ -39,22 +39,6 @@ enum omap_mcbsp_div {
 	OMAP_MCBSP_CLKGDV,		/* Sample rate generator divider */
 };
 
-#if defined(CONFIG_SOC_OMAP2420)
-#define NUM_LINKS	2
-#endif
-#if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
-#undef  NUM_LINKS
-#define NUM_LINKS	3
-#endif
-#if defined(CONFIG_ARCH_OMAP4)
-#undef  NUM_LINKS
-#define NUM_LINKS	4
-#endif
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_OMAP2430)
-#undef  NUM_LINKS
-#define NUM_LINKS	5
-#endif
-
 int omap_mcbsp_st_add_controls(struct snd_soc_pcm_runtime *rtd);
 
 #endif
-- 
1.7.8.6


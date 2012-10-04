From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ASoC: omap-mcpdm: Remove OMAP revision check
Date: Thu,  4 Oct 2012 11:15:09 +0300
Message-ID: <1349338509-3440-3-git-send-email-peter.ujfalusi@ti.com>
References: <1349338509-3440-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:53057 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755330Ab2JDIOG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 04:14:06 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so192229oag.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Oct 2012 01:14:04 -0700 (PDT)
In-Reply-To: <1349338509-3440-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

The OMAP revision check is not needed since the watchdog bit is not in use
on 4430 ES1.0 and have no effect when we set the bit. The watchdog need to
be enabled on all other revisions.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcpdm.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index fdf655e..8f5edc8 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -40,7 +40,6 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include <plat/cpu.h>
 #include "omap-mcpdm.h"
 #include "omap-pcm.h"
 
@@ -258,14 +257,9 @@ static int omap_mcpdm_dai_startup(struct snd_pcm_substream *substream,
 	mutex_lock(&mcpdm->mutex);
 
 	if (!dai->active) {
-		/* Enable watch dog for ES above ES 1.0 to avoid saturation */
-		if (omap_rev() != OMAP4430_REV_ES1_0) {
-			u32 ctrl = omap_mcpdm_read(mcpdm, MCPDM_REG_CTRL);
+		u32 ctrl = omap_mcpdm_read(mcpdm, MCPDM_REG_CTRL);
 
-			omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL,
-					 ctrl | MCPDM_WD_EN);
-		}
-		omap_mcpdm_open_streams(mcpdm);
+		omap_mcpdm_write(mcpdm, MCPDM_REG_CTRL, ctrl | MCPDM_WD_EN);
 	}
 	mutex_unlock(&mcpdm->mutex);
 
-- 
1.7.12


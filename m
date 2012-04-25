From: Oleg Matcovschi <oleg.matcovschi@ti.com>
Subject: [PATCH v2] ASoC: omap-pcm: Free dma buffers in case of error.
Date: Tue, 24 Apr 2012 19:02:02 -0700
Message-ID: <1335319322-22336-1-git-send-email-oleg.matcovschi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60944 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063Ab2DYCDR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 22:03:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, lrg@ti.com, broonie@opensource.wolfsonmicro.com, perex@perex.cz, tiwai@suse.de, Oleg Matcovschi <oleg.matcovschi@ti.com>

Change-Id: I4ba9de0de4681332539246ccc5e11a7a8fb32e79
Signed-off-by: Oleg Matcovschi <oleg.matcovschi@ti.com>
---
v1:
 initial revision
v2:
 resending patch including maintainers

 sound/soc/omap/omap-pcm.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index a2a464f..380a5bd 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -414,6 +414,10 @@ static int omap_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	}
 
 out:
+	/* free preallocated buffers in case of error */
+	if (ret)
+		omap_pcm_free_dma_buffers(pcm);
+
 	return ret;
 }
 
-- 
1.7.4.1


From: Oleg Matcovschi <oleg.matcovschi@ti.com>
Subject: [PATCH] ASoC: omap-pcm: Free dma buffers in case of error.
Date: Wed, 18 Apr 2012 17:37:50 -0700
Message-ID: <1334795870-5726-1-git-send-email-oleg.matcovschi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34462 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370Ab2DSAiB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Apr 2012 20:38:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, Oleg Matcovschi <oleg.matcovschi@ti.com>

Signed-off-by: Oleg Matcovschi <oleg.matcovschi@ti.com>
---
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


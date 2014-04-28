From: Stefan Roese <sr@denx.de>
Subject: [PATCH 1/5] ASoC: Add support for machine specific trigger callback
Date: Mon, 28 Apr 2014 14:17:52 +0200
Message-ID: <1398687476-10829-1-git-send-email-sr@denx.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.183]:59617 "EHLO
	mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbaD1MXx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 08:23:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: broonie@kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

From: Jarkko Nikula <jarkko.nikula@bitmer.com>

Machine specific trigger callback allows to do final stream start/stop
related operations in a machine driver after setting up the codec, DMA and
DAI.

One example could be clock management for linked streams case where machine
driver can start/stop synchronously the linked streams.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Stefan Roese <sr@denx.de>
---
 sound/soc/soc-pcm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 2cedf09..a3a7021 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -819,6 +819,13 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		if (ret < 0)
 			return ret;
 	}
+
+	if (rtd->dai_link->ops && rtd->dai_link->ops->trigger) {
+		ret = rtd->dai_link->ops->trigger(substream, cmd);
+		if (ret < 0)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
1.9.1


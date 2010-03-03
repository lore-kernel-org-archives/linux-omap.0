From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCHv2 1/5] ASoC: core: fix tailing whitespace in soc_pcm_apply_symmetry
Date: Wed,  3 Mar 2010 15:08:04 +0200
Message-ID: <1267621689-30337-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34224 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753874Ab0CCNJT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Mar 2010 08:09:19 -0500
In-Reply-To: <1267621689-30337-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, tony@atomide.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, jhnikula@gmail.com, ext-eero.nurkkala@nokia.com

My editor removes the tailing spaces, which causes problems when
changing the soc-core.c
Removing the space.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/soc-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a03bac9..37c872e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -315,7 +315,7 @@ static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream)
 
 	if (codec_dai->symmetric_rates || cpu_dai->symmetric_rates ||
 	    machine->symmetric_rates) {
-		dev_dbg(card->dev, "Symmetry forces %dHz rate\n", 
+		dev_dbg(card->dev, "Symmetry forces %dHz rate\n",
 			machine->rate);
 
 		ret = snd_pcm_hw_constraint_minmax(substream->runtime,
-- 
1.7.0


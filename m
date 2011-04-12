From: Sanjeev Premi <premi@ti.com>
Subject: [PATCHv3] omap3: alsa-soc: Remove restrictive checks for cpu type
Date: Wed, 13 Apr 2011 02:03:13 +0530
Message-ID: <1302640393-21734-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45961 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757145Ab1DLUdk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Apr 2011 16:33:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: jhnikula@gmail.com, Sanjeev Premi <premi@ti.com>

Current checks for cpu type were too restrictive leading
to failures for other silicons in same family.

The problem was found while testing audio playback on
AM37x and AM35x processors. But should exist on OMAP36xx
as well.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 Changes in v3::
   None. Reposting[1] after subscribing to alsa-devel list

 Changes in v2:
   1) Added one more check to the changes.
   2) Updated commit message to use plurals.


 [1] http://marc.info/?l=linux-omap&m=130026430110592&w=2

 sound/soc/omap/omap-mcbsp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 2175f09..a88a0bf 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -146,7 +146,7 @@ static int omap_mcbsp_dai_startup(struct snd_pcm_substream *substream,
 	 * 2 channels (stereo): size is 128 / 2 = 64 frames (2 * 64 words)
 	 * 4 channels: size is 128 / 4 = 32 frames (4 * 32 words)
 	 */
-	if (cpu_is_omap343x() || cpu_is_omap44xx()) {
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
 		/*
 		* Rule for the buffer size. We should not allow
 		* smaller buffer than the FIFO size to avoid underruns
@@ -258,7 +258,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
-	if (cpu_is_omap343x()) {
+	if (cpu_is_omap34xx()) {
 		dma_data->set_threshold = omap_mcbsp_set_threshold;
 		/* TODO: Currently, MODE_ELEMENT == MODE_FRAME */
 		if (omap_mcbsp_get_dma_op_mode(bus_id) ==
-- 
1.7.2.2


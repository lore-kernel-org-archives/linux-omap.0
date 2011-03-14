From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] omap3: alsa-soc: Remove restrictive check for cpu type
Date: Mon, 14 Mar 2011 19:01:53 +0530
Message-ID: <1300109513-29002-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52144 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755545Ab1CNNcj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Mar 2011 09:32:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: Sanjeev Premi <premi@ti.com>

Current check for cpu type is too restrictive leading to
failures for other silicons in same family.

The problem was found while testing audio playback on
AM37x and AM35x processors. But should exist on OMAP36xx
as well.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 sound/soc/omap/omap-mcbsp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 2175f09..84d434a 100644
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
-- 
1.7.2.2


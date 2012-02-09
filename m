From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 3/3] OMAPDSS: HDMI: Modify logic to configure MCLK
Date: Wed, 8 Feb 2012 21:10:23 -0600
Message-ID: <1328757023-20543-4-git-send-email-ricardo.neri@ti.com>
References: <1328757023-20543-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45393 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757657Ab2BIDLB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 22:11:01 -0500
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q193B0uV016548
	for <linux-omap@vger.kernel.org>; Wed, 8 Feb 2012 21:11:00 -0600
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q193B0xg020261
	for <linux-omap@vger.kernel.org>; Wed, 8 Feb 2012 21:11:00 -0600 (CST)
In-Reply-To: <1328757023-20543-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: a0393947@ti.com, molnar@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

The MCLK mode defines a factor to divide the clock that is used to
generate the Audio Clock Regeneration packets, MCLK.

The divisor is not used when the CTS value is calculated by HW.
When the value is calculated by SW, it depends on the silicon
revision.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index b4c270e..04c83c8 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -692,13 +692,15 @@ static int hdmi_audio_hw_params(struct snd_pcm_substream *substream,
 	if (dss_has_feature(FEAT_HDMI_CTS_SWMODE)) {
 		core_cfg.aud_par_busclk = 0;
 		core_cfg.cts_mode = HDMI_AUDIO_CTS_MODE_SW;
-		core_cfg.use_mclk = false;
+		core_cfg.use_mclk = dss_has_feature(FEAT_HDMI_AUDIO_USE_MCLK);
 	} else {
 		core_cfg.aud_par_busclk = (((128 * 31) - 1) << 8);
 		core_cfg.cts_mode = HDMI_AUDIO_CTS_MODE_HW;
 		core_cfg.use_mclk = true;
-		core_cfg.mclk_mode = HDMI_AUDIO_MCLK_128FS;
 	}
+
+	if (core_cfg.use_mclk)
+		core_cfg.mclk_mode = HDMI_AUDIO_MCLK_128FS;
 	core_cfg.layout = HDMI_AUDIO_LAYOUT_2CH;
 	core_cfg.en_spdif = false;
 	/* Use sample frequency from channel status word */
-- 
1.7.0.4


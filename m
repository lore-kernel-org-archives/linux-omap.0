From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 03/10] OMAPDSS: HDMI: OMAP4: Correcty typo in I2S definitions
Date: Wed, 28 Mar 2012 16:38:18 -0600
Message-ID: <1332974305-4578-4-git-send-email-ricardo.neri@ti.com>
References: <1332974305-4578-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55857 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758934Ab2C1Wk6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Mar 2012 18:40:58 -0400
In-Reply-To: <1332974305-4578-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
index d6b49b6..9fa5cb1 100644
--- a/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
+++ b/drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
@@ -350,7 +350,7 @@ enum hdmi_audio_blk_strt_end_sig {
 
 enum hdmi_audio_i2s_config {
 	HDMI_AUDIO_I2S_WS_POLARITY_LOW_IS_LEFT = 0,
-	HDMI_AUDIO_I2S_WS_POLARIT_YLOW_IS_RIGHT = 1,
+	HDMI_AUDIO_I2S_WS_POLARITY_LOW_IS_RIGHT = 1,
 	HDMI_AUDIO_I2S_MSB_SHIFTED_FIRST = 0,
 	HDMI_AUDIO_I2S_LSB_SHIFTED_FIRST = 1,
 	HDMI_AUDIO_I2S_MAX_WORD_20BITS = 0,
-- 
1.7.0.4


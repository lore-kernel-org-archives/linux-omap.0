From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v2 02/13] OMAPDSS: hdmi.h: Add HDMI_AUDIO_LAYOUT_6CH enum value
Date: Fri, 27 Jun 2014 21:38:44 +0300
Message-ID: <63b36ec852ed284cdd110e211758d7f055853c44.1403894190.git.jsarha@ti.com>
References: <cover.1403894190.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44531 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbaF0SjT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jun 2014 14:39:19 -0400
In-Reply-To: <cover.1403894190.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com, jyri.sarha@iki.fi, Jyri Sarha <jsarha@ti.com>

The OMAP5 HDMI audio implementation needs HDMI_AUDIO_LAYOUT_6CH in
hdmi_core_audio_layout enum. I found the correct value from ti-linux
3.8 tree.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 262771b..1f01068 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -160,7 +160,8 @@ enum hdmi_audio_blk_strt_end_sig {
 
 enum hdmi_core_audio_layout {
 	HDMI_AUDIO_LAYOUT_2CH = 0,
-	HDMI_AUDIO_LAYOUT_8CH = 1
+	HDMI_AUDIO_LAYOUT_8CH = 1,
+	HDMI_AUDIO_LAYOUT_6CH = 2
 };
 
 enum hdmi_core_cts_mode {
-- 
1.7.9.5


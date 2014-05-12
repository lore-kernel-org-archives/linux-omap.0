From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 06/19] OMAPDSS: hdmi.h: Add HDMI_AUDIO_LAYOUT_6CH enum value
Date: Mon, 12 May 2014 12:12:17 +0300
Message-ID: <ce80f336399e8d28b62569e5fa5fe9f696266bfa.1399884780.git.jsarha@ti.com>
References: <cover.1399884780.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44727 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbaELJMv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 05:12:51 -0400
In-Reply-To: <cover.1399884780.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

The OMAP5 HDMI audio implementation needs HDMI_AUDIO_LAYOUT_6CH in
hdmi_core_audio_layout enum. I found the correct value from ti-linux
3.8 tree.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 drivers/video/fbdev/omap2/dss/hdmi.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
index 65bf072..ea4a168 100644
--- a/drivers/video/fbdev/omap2/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/dss/hdmi.h
@@ -159,7 +159,8 @@ enum hdmi_audio_blk_strt_end_sig {
 
 enum hdmi_core_audio_layout {
 	HDMI_AUDIO_LAYOUT_2CH = 0,
-	HDMI_AUDIO_LAYOUT_8CH = 1
+	HDMI_AUDIO_LAYOUT_8CH = 1,
+	HDMI_AUDIO_LAYOUT_6CH = 2
 };
 
 enum hdmi_core_cts_mode {
-- 
1.7.9.5


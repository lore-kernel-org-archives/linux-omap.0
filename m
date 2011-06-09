From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 28/28] OMAP: DSS2: DSS: Fix context save/restore
Date: Thu,  9 Jun 2011 16:56:50 +0300
Message-ID: <1307627810-3768-29-git-send-email-tomi.valkeinen@ti.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:39141 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757989Ab1FIN6K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 09:58:10 -0400
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The current method of saving and restoring the context could cause a
restore before saving, effectively "restoring" zero values to registers.

Add ctx_valid field to indicate if the saved context is valid and can be
restored.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 21c8389..5c6499a 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -74,6 +74,7 @@ static struct {
 	enum omap_dss_clk_source dispc_clk_source;
 	enum omap_dss_clk_source lcd_clk_source[MAX_DSS_LCD_MANAGERS];
 
+	bool		ctx_valid;
 	u32		ctx[DSS_SZ_REGS / sizeof(u32)];
 } dss;
 
@@ -109,12 +110,19 @@ static void dss_save_context(void)
 		SR(SDI_CONTROL);
 		SR(PLL_CONTROL);
 	}
+
+	dss.ctx_valid = true;
+
+	DSSDBG("context saved\n");
 }
 
 static void dss_restore_context(void)
 {
 	DSSDBG("dss_restore_context\n");
 
+	if (!dss.ctx_valid)
+		return;
+
 	RR(CONTROL);
 
 	if (dss_feat_get_supported_displays(OMAP_DSS_CHANNEL_LCD) &
@@ -122,6 +130,8 @@ static void dss_restore_context(void)
 		RR(SDI_CONTROL);
 		RR(PLL_CONTROL);
 	}
+
+	DSSDBG("context restored\n");
 }
 
 #undef SR
-- 
1.7.4.1


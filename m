From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 27/27] OMAP: DSS2: DSS: Fix context save/restore
Date: Fri,  3 Jun 2011 13:00:37 +0300
Message-ID: <1307095237-14805-28-git-send-email-tomi.valkeinen@ti.com>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:45533 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754392Ab1FCKCA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 06:02:00 -0400
In-Reply-To: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
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
index 91572b6..964eb08 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -77,6 +77,7 @@ static struct {
 	enum omap_dss_clk_source dispc_clk_source;
 	enum omap_dss_clk_source lcd_clk_source[MAX_DSS_LCD_MANAGERS];
 
+	bool		ctx_valid;
 	u32		ctx[DSS_SZ_REGS / sizeof(u32)];
 } dss;
 
@@ -112,12 +113,19 @@ static void dss_save_context(void)
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
@@ -125,6 +133,8 @@ static void dss_restore_context(void)
 		RR(SDI_CONTROL);
 		RR(PLL_CONTROL);
 	}
+
+	DSSDBG("context restored\n");
 }
 
 #undef SR
-- 
1.7.4.1


From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/13] OMAPDSS: DISPC: Flush posted writes when enabling outputs
Date: Thu, 24 Nov 2011 15:29:31 +0200
Message-ID: <1322141381-5395-4-git-send-email-tomi.valkeinen@ti.com>
References: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:58475 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755542Ab1KXNaA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 08:30:00 -0500
In-Reply-To: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Flush posted write in _enable_lcd_out() and _enable_digit_out(). This
ensures the the lcd/digit bit is written before the code starts waiting
for interrupts about enabling/disabling the output.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 5c81533..5bbd838 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1916,10 +1916,14 @@ static void dispc_disable_isr(void *data, u32 mask)
 
 static void _enable_lcd_out(enum omap_channel channel, bool enable)
 {
-	if (channel == OMAP_DSS_CHANNEL_LCD2)
+	if (channel == OMAP_DSS_CHANNEL_LCD2) {
 		REG_FLD_MOD(DISPC_CONTROL2, enable ? 1 : 0, 0, 0);
-	else
+		/* flush posted write */
+		dispc_read_reg(DISPC_CONTROL2);
+	} else {
 		REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 0, 0);
+		dispc_read_reg(DISPC_CONTROL);
+	}
 }
 
 static void dispc_mgr_enable_lcd_out(enum omap_channel channel, bool enable)
@@ -1967,6 +1971,8 @@ static void dispc_mgr_enable_lcd_out(enum omap_channel channel, bool enable)
 static void _enable_digit_out(bool enable)
 {
 	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 1, 1);
+	/* flush posted write */
+	dispc_read_reg(DISPC_CONTROL);
 }
 
 static void dispc_mgr_enable_digit_out(bool enable)
-- 
1.7.4.1


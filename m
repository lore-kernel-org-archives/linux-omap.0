From: Archit Taneja <archit@ti.com>
Subject: [PATCH v4 6/7] OMAP: DSS2: Use dss_features to handle DISPC bits removed on OMAP4
Date: Mon,  8 Nov 2010 17:54:24 +0530
Message-ID: <1289219065-1362-7-git-send-email-archit@ti.com>
References: <1289219065-1362-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40171 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469Ab0KHMYG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Nov 2010 07:24:06 -0500
In-Reply-To: <1289219065-1362-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

DISPC_CONFIG bits LCDENABLEPOL, LCDENABLESIGNAL, PCKFREEENABLE and FUNCGATED
have been removed from OMAP4, use dss_features to handle them correctly.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 967fa87..e34c129 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1942,6 +1942,9 @@ void dispc_enable_channel(enum omap_channel channel, bool enable)
 
 void dispc_lcd_enable_signal_polarity(bool act_high)
 {
+	if (!dss_has_feature(FEAT_LCDENABLEPOL))
+		return;
+
 	enable_clocks(1);
 	REG_FLD_MOD(DISPC_CONTROL(OMAP_DSS_CHANNEL_LCD),
 		act_high ? 1 : 0, 29, 29);
@@ -1950,6 +1953,9 @@ void dispc_lcd_enable_signal_polarity(bool act_high)
 
 void dispc_lcd_enable_signal(bool enable)
 {
+	if (!dss_has_feature(FEAT_LCDENABLESIGNAL))
+		return;
+
 	enable_clocks(1);
 	REG_FLD_MOD(DISPC_CONTROL(OMAP_DSS_CHANNEL_LCD),
 		enable ? 1 : 0, 28, 28);
@@ -1958,6 +1964,9 @@ void dispc_lcd_enable_signal(bool enable)
 
 void dispc_pck_free_enable(bool enable)
 {
+	if (!dss_has_feature(FEAT_PCKFREEENABLE))
+		return;
+
 	enable_clocks(1);
 	REG_FLD_MOD(DISPC_CONTROL(OMAP_DSS_CHANNEL_LCD),
 		enable ? 1 : 0, 27, 27);
@@ -3246,7 +3255,8 @@ static void _omap_dispc_initial_config(void)
 	dispc_write_reg(DISPC_SYSCONFIG, l);
 
 	/* FUNCGATED */
-	REG_FLD_MOD(DISPC_CONFIG(OMAP_DSS_CHANNEL_LCD), 1, 9, 9);
+	if (dss_has_feature(FEAT_FUNCGATED))
+		REG_FLD_MOD(DISPC_CONFIG(OMAP_DSS_CHANNEL_LCD), 1, 9, 9);
 
 	/* L3 firewall setting: enable access to OCM RAM */
 	/* XXX this should be somewhere in plat-omap */
-- 
1.7.0.4


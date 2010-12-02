From: Archit Taneja <archit@ti.com>
Subject: [PATCH v6 6/7] OMAP: DSS2: Use dss_features to handle DISPC bits removed on OMAP4
Date: Thu,  2 Dec 2010 16:57:13 +0530
Message-ID: <1291289235-12122-7-git-send-email-archit@ti.com>
References: <1291289235-12122-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43279 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755394Ab0LBL1o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Dec 2010 06:27:44 -0500
In-Reply-To: <1291289235-12122-1-git-send-email-archit@ti.com>
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
index fe41d89..6171bcc 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1922,6 +1922,9 @@ void dispc_enable_channel(enum omap_channel channel, bool enable)
 
 void dispc_lcd_enable_signal_polarity(bool act_high)
 {
+	if (!dss_has_feature(FEAT_LCDENABLEPOL))
+		return;
+
 	enable_clocks(1);
 	REG_FLD_MOD(DISPC_CONTROL, act_high ? 1 : 0, 29, 29);
 	enable_clocks(0);
@@ -1929,6 +1932,9 @@ void dispc_lcd_enable_signal_polarity(bool act_high)
 
 void dispc_lcd_enable_signal(bool enable)
 {
+	if (!dss_has_feature(FEAT_LCDENABLESIGNAL))
+		return;
+
 	enable_clocks(1);
 	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 28, 28);
 	enable_clocks(0);
@@ -1936,6 +1942,9 @@ void dispc_lcd_enable_signal(bool enable)
 
 void dispc_pck_free_enable(bool enable)
 {
+	if (!dss_has_feature(FEAT_PCKFREEENABLE))
+		return;
+
 	enable_clocks(1);
 	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 27, 27);
 	enable_clocks(0);
@@ -3246,7 +3255,8 @@ static void _omap_dispc_initial_config(void)
 	dispc_write_reg(DISPC_SYSCONFIG, l);
 
 	/* FUNCGATED */
-	REG_FLD_MOD(DISPC_CONFIG, 1, 9, 9);
+	if (dss_has_feature(FEAT_FUNCGATED))
+		REG_FLD_MOD(DISPC_CONFIG, 1, 9, 9);
 
 	/* L3 firewall setting: enable access to OCM RAM */
 	/* XXX this should be somewhere in plat-omap */
-- 
1.7.0.4


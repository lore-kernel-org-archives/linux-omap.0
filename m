From: Archit Taneja <archit@ti.com>
Subject: [PATCH v5 6/7] OMAP: DSS2: Use dss_features to handle DISPC bits removed on OMAP4
Date: Mon, 22 Nov 2010 12:53:04 +0530
Message-ID: <1290410585-29418-7-git-send-email-archit@ti.com>
References: <1290410585-29418-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58886 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab0KVHXn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 02:23:43 -0500
In-Reply-To: <1290410585-29418-1-git-send-email-archit@ti.com>
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
index 6c06160..ad8fbcc 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1965,6 +1965,9 @@ void dispc_enable_channel(enum omap_channel channel, bool enable)
 
 void dispc_lcd_enable_signal_polarity(bool act_high)
 {
+	if (!dss_has_feature(FEAT_LCDENABLEPOL))
+		return;
+
 	enable_clocks(1);
 	REG_FLD_MOD(DISPC_CONTROL, act_high ? 1 : 0, 29, 29);
 	enable_clocks(0);
@@ -1972,6 +1975,9 @@ void dispc_lcd_enable_signal_polarity(bool act_high)
 
 void dispc_lcd_enable_signal(bool enable)
 {
+	if (!dss_has_feature(FEAT_LCDENABLESIGNAL))
+		return;
+
 	enable_clocks(1);
 	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 28, 28);
 	enable_clocks(0);
@@ -1979,6 +1985,9 @@ void dispc_lcd_enable_signal(bool enable)
 
 void dispc_pck_free_enable(bool enable)
 {
+	if (!dss_has_feature(FEAT_PCKFREEENABLE))
+		return;
+
 	enable_clocks(1);
 	REG_FLD_MOD(DISPC_CONTROL, enable ? 1 : 0, 27, 27);
 	enable_clocks(0);
@@ -3289,7 +3298,8 @@ static void _omap_dispc_initial_config(void)
 	dispc_write_reg(DISPC_SYSCONFIG, l);
 
 	/* FUNCGATED */
-	REG_FLD_MOD(DISPC_CONFIG, 1, 9, 9);
+	if (dss_has_feature(FEAT_FUNCGATED))
+		REG_FLD_MOD(DISPC_CONFIG, 1, 9, 9);
 
 	/* L3 firewall setting: enable access to OCM RAM */
 	/* XXX this should be somewhere in plat-omap */
-- 
1.7.0.4


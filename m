From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 6/6] OMAP2+: hwmod: Fix the HW reset management
Date: Thu, 23 Jun 2011 23:00:42 +0200
Message-ID: <1308862842-3933-7-git-send-email-b-cousson@ti.com>
References: <1308862842-3933-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43090 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752990Ab1FWVBP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 17:01:15 -0400
In-Reply-To: <1308862842-3933-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

The HW reset must be de-assert after the clocks are enabled
but before waiting for the target to be ready. Otherwise the
reset might not work properly since the clock is not running
to proceed the reset.

De-assert the reset after _enable_clocks and before
_wait_target_ready.
Re-assert it only when the clocks are disabled.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index f401417..55ad6a5 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1250,15 +1250,6 @@ static int _enable(struct omap_hwmod *oh)
 
 	pr_debug("omap_hwmod: %s: enabling\n", oh->name);
 
-	/*
-	 * If an IP contains only one HW reset line, then de-assert it in order
-	 * to allow to enable the clocks. Otherwise the PRCM will return
-	 * Intransition status, and the init will failed.
-	 */
-	if ((oh->_state == _HWMOD_STATE_INITIALIZED ||
-	     oh->_state == _HWMOD_STATE_DISABLED) && oh->rst_lines_cnt == 1)
-		_deassert_hardreset(oh, oh->rst_lines[0].name);
-
 	/* Mux pins for device runtime if populated */
 	if (oh->mux && (!oh->mux->enabled ||
 			((oh->_state == _HWMOD_STATE_IDLE) &&
@@ -1268,6 +1259,15 @@ static int _enable(struct omap_hwmod *oh)
 	_add_initiator_dep(oh, mpu_oh);
 	_enable_clocks(oh);
 
+	/*
+	 * If an IP contains only one HW reset line, then de-assert it in order
+	 * to allow to enable the clocks. Otherwise the PRCM will return
+	 * Intransition status, and the init will failed.
+	 */
+	if ((oh->_state == _HWMOD_STATE_INITIALIZED ||
+	     oh->_state == _HWMOD_STATE_DISABLED) && oh->rst_lines_cnt == 1)
+		_deassert_hardreset(oh, oh->rst_lines[0].name);
+
 	r = _wait_target_ready(oh);
 	if (!r) {
 		oh->_state = _HWMOD_STATE_ENABLED;
@@ -1396,13 +1396,6 @@ static int _shutdown(struct omap_hwmod *oh)
 		_shutdown_sysc(oh);
 	}
 
-	/*
-	 * If an IP contains only one HW reset line, then assert it
-	 * before disabling the clocks and shutting down the IP.
-	 */
-	if (oh->rst_lines_cnt == 1)
-		_assert_hardreset(oh, oh->rst_lines[0].name);
-
 	/* clocks and deps are already disabled in idle */
 	if (oh->_state == _HWMOD_STATE_ENABLED) {
 		_del_initiator_dep(oh, mpu_oh);
@@ -1411,6 +1404,13 @@ static int _shutdown(struct omap_hwmod *oh)
 	}
 	/* XXX Should this code also force-disable the optional clocks? */
 
+	/*
+	 * If an IP contains only one HW reset line, then assert it
+	 * before disabling the clocks and shutting down the IP.
+	 */
+	if (oh->rst_lines_cnt == 1)
+		_assert_hardreset(oh, oh->rst_lines[0].name);
+
 	/* Mux pins to safe mode or use populated off mode values */
 	if (oh->mux)
 		omap_hwmod_mux(oh->mux, _HWMOD_STATE_DISABLED);
-- 
1.7.0.4


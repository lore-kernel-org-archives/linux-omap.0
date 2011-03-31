From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/9] OMAP: DSS2: remove non-working msleep(40) workaround
Date: Thu, 31 Mar 2011 13:10:59 +0300
Message-ID: <1301566266-11187-3-git-send-email-tomi.valkeinen@ti.com>
References: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:57500 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752503Ab1CaKL0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 06:11:26 -0400
In-Reply-To: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The sleep workaround for the problem described in the comment doesn't
really work. This patch removes the workaround, and improves the comment
about the bug, and proposes an userspace workaround.

omap_dss_set_manager() is called 6 times when loading omapdss and
omapfb, which means that 40ms * 6 = 240ms was spent sleeping when
booting up.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/overlay.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index f1aca6d..fcde51b 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -491,13 +491,18 @@ static int omap_dss_set_manager(struct omap_overlay *ovl,
 	ovl->manager = mgr;
 
 	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
-	/* XXX: on manual update display, in auto update mode, a bug happens
-	 * here. When an overlay is first enabled on LCD, then it's disabled,
-	 * and the manager is changed to TV, we sometimes get SYNC_LOST_DIGIT
-	 * errors. Waiting before changing the channel_out fixes it. I'm
-	 * guessing that the overlay is still somehow being used for the LCD,
-	 * but I don't understand how or why. */
-	msleep(40);
+	/* XXX: When there is an overlay on a DSI manual update display, and
+	 * the overlay is first disabled, then moved to tv, and enabled, we
+	 * seem to get SYNC_LOST_DIGIT error.
+	 *
+	 * Waiting doesn't seem to help, but updating the manual update display
+	 * after disabling the overlay seems to fix this. This hints that the
+	 * overlay is perhaps somehow tied to the LCD output until the output
+	 * is updated.
+	 *
+	 * Userspace workaround for this is to update the LCD after disabling
+	 * the overlay, but before moving the overlay to TV.
+	 */
 	dispc_set_channel_out(ovl->id, mgr->id);
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 
-- 
1.7.1


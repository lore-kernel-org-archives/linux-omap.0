From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/2] OMAPDSS: DPI: widen the pck search when using dss fck
Date: Thu, 11 Apr 2013 12:35:48 +0300
Message-ID: <1365672948-938-1-git-send-email-tomi.valkeinen@ti.com>
References: <1365672662-612-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56600 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753267Ab3DKJfw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Apr 2013 05:35:52 -0400
In-Reply-To: <1365672662-612-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

When not using DSI PLL to generate the pixel clock, but DSS FCK, the
possible pixel clock rates are rather limited. DSS FCK is currently used
on OMAP2 and OMAP3.

When using Beagleboard with a monitor that supports high resolutions,
the clock rates do not match (at least for me) for the monitor's pixel
clocks within the current threshold in the code, which is +/- 1MHz.

This patch widens the search up to +/- 15MHz. The search is done in
steps, i.e. it first tries to find a rather exact clock, than a bit less
exact, etc. so this should not change the cases where a clock was
already found.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index abe1a4e2..e93c4de 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -222,10 +222,10 @@ static bool dpi_dss_clk_calc(unsigned long pck, struct dpi_clk_calc_ctx *ctx)
 	 * DSS fck gives us very few possibilities, so finding a good pixel
 	 * clock may not be possible. We try multiple times to find the clock,
 	 * each time widening the pixel clock range we look for, up to
-	 * +/- 1MHz.
+	 * +/- ~15MHz.
 	 */
 
-	for (i = 0; i < 10; ++i) {
+	for (i = 0; i < 25; ++i) {
 		bool ok;
 
 		memset(ctx, 0, sizeof(*ctx));
-- 
1.7.10.4


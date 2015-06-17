From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/11] OMAPDSS: DISPC: fix 64 bit issue in 5-tap
Date: Wed, 17 Jun 2015 15:54:30 +0300
Message-ID: <1434545675-477-7-git-send-email-tomi.valkeinen@ti.com>
References: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40739 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755045AbbFQMy6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2015 08:54:58 -0400
In-Reply-To: <1434545675-477-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The DISPC driver uses 64 bit arithmetic to calculate the required clock
rate for scaling. The code does not seem to work correctly, and instead
calculates with 32 bit numbers, giving wrong result.

Fix the code by typecasting values to u64 first, so that the
calculations do happen in 64 bits.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 4488d9367bd3..2db1c986e989 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2166,7 +2166,7 @@ static unsigned long calc_core_clk_five_taps(unsigned long pclk,
 	if (height > out_height) {
 		unsigned int ppl = mgr_timings->x_res;
 
-		tmp = pclk * height * out_width;
+		tmp = (u64)pclk * height * out_width;
 		do_div(tmp, 2 * out_height * ppl);
 		core_clk = tmp;
 
@@ -2174,14 +2174,14 @@ static unsigned long calc_core_clk_five_taps(unsigned long pclk,
 			if (ppl == out_width)
 				return 0;
 
-			tmp = pclk * (height - 2 * out_height) * out_width;
+			tmp = (u64)pclk * (height - 2 * out_height) * out_width;
 			do_div(tmp, 2 * out_height * (ppl - out_width));
 			core_clk = max_t(u32, core_clk, tmp);
 		}
 	}
 
 	if (width > out_width) {
-		tmp = pclk * width;
+		tmp = (u64)pclk * width;
 		do_div(tmp, out_width);
 		core_clk = max_t(u32, core_clk, tmp);
 
-- 
2.1.4


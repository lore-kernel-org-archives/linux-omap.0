From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [RFC PATCH] clk: ti: set CLK_SET_RATE_NO_REPARENT for ti,mux-clock
Date: Tue, 17 Jun 2014 11:04:32 +0300
Message-ID: <1402992272-21413-2-git-send-email-tomi.valkeinen@ti.com>
References: <1402992272-21413-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40071 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755348AbaFQIFD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jun 2014 04:05:03 -0400
In-Reply-To: <1402992272-21413-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>, linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

When setting the rate of a clock, by default the clock framework will
change the parent of the clock to the most suitable one in
__clk_mux_determine_rate() (most suitable by looking at the clock rate).

This is a rather dangerous default, and causes problems on AM43x when
using display and ethernet. There are multiple ways to select the clock
muxes on AM43x, and some of those clock paths have the same source
clocks for display and ethernet. When changing the clock rate for the
display subsystem, the clock framework decides to change the display mux
from the dedicated display PLL to a shared PLL which is used by the
ethernet, and then changes the rate of the shared PLL, breaking the
ethernet.

As I don't think there ever is a case where we want the clock framework
to automatically change the parent clock of a clock mux, this patch sets
the CLK_SET_RATE_NO_REPARENT for all ti,mux-clocks.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/clk/ti/mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index 0197a478720c..e9d650e51287 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -160,7 +160,7 @@ static void of_mux_clk_setup(struct device_node *node)
 	u8 clk_mux_flags = 0;
 	u32 mask = 0;
 	u32 shift = 0;
-	u32 flags = 0;
+	u32 flags = CLK_SET_RATE_NO_REPARENT;
 
 	num_parents = of_clk_get_parent_count(node);
 	if (num_parents < 2) {
-- 
1.9.1


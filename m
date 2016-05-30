From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v1 01/14] clk: twl6040: Correct clk_ops
Date: Mon, 30 May 2016 11:55:09 +0300
Message-ID: <20160530085522.30398-2-peter.ujfalusi@ti.com>
References: <20160530085522.30398-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160530085522.30398-1-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: t-kristo-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Since the drover only supports prepare callbacks, the use of is_enabled is
not correct, it should be handling is_prepared.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
---
 drivers/clk/clk-twl6040.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-twl6040.c b/drivers/clk/clk-twl6040.c
index 697c66757400..e167e0bbaff5 100644
--- a/drivers/clk/clk-twl6040.c
+++ b/drivers/clk/clk-twl6040.c
@@ -34,7 +34,7 @@ struct twl6040_clk {
 	int enabled;
 };
 
-static int twl6040_bitclk_is_enabled(struct clk_hw *hw)
+static int twl6040_bitclk_is_prepared(struct clk_hw *hw)
 {
 	struct twl6040_clk *twl6040_clk = container_of(hw, struct twl6040_clk,
 						       mcpdm_fclk);
@@ -66,7 +66,7 @@ static void twl6040_bitclk_unprepare(struct clk_hw *hw)
 }
 
 static const struct clk_ops twl6040_mcpdm_ops = {
-	.is_enabled = twl6040_bitclk_is_enabled,
+	.is_prepared = twl6040_bitclk_is_prepared,
 	.prepare = twl6040_bitclk_prepare,
 	.unprepare = twl6040_bitclk_unprepare,
 };
-- 
2.8.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

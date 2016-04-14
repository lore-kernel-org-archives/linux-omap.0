From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 20/28] clk: ti: mux: export mux clock APIs locally
Date: Thu, 14 Apr 2016 14:08:09 +0300
Message-ID: <1460632097-25727-21-git-send-email-t-kristo@ti.com>
References: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460632097-25727-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

get_parent and set_parent are going to be required by the support of
module clocks, so export these locally.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 drivers/clk/ti/clock.h |    3 +++
 drivers/clk/ti/mux.c   |    4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 90f3f47..7eca8a1 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -224,6 +224,9 @@ extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_wait;
 extern const struct clk_ops ti_clk_divider_ops;
 extern const struct clk_ops ti_clk_mux_ops;
 
+u8 ti_clk_mux_get_parent(struct clk_hw *hw);
+int ti_clk_mux_set_parent(struct clk_hw *hw, u8 index);
+
 int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index 44777ab..57ff471 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -26,7 +26,7 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
-static u8 ti_clk_mux_get_parent(struct clk_hw *hw)
+u8 ti_clk_mux_get_parent(struct clk_hw *hw)
 {
 	struct clk_mux *mux = to_clk_mux(hw);
 	int num_parents = clk_hw_get_num_parents(hw);
@@ -63,7 +63,7 @@ static u8 ti_clk_mux_get_parent(struct clk_hw *hw)
 	return val;
 }
 
-static int ti_clk_mux_set_parent(struct clk_hw *hw, u8 index)
+int ti_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct clk_mux *mux = to_clk_mux(hw);
 	u32 val;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

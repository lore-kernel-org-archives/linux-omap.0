From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/2] clk: ti: divider: Provide error check for incoming
 parameters in set_rate
Date: Mon, 18 Aug 2014 11:56:54 -0500
Message-ID: <1408381015-16042-2-git-send-email-nm@ti.com>
References: <1408381015-16042-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1408381015-16042-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Check for valid parameters in check rate. Else, we end up getting errors
like:
[    0.000000] Division by zero in kernel.
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.17.0-rc1 #1
[    0.000000] [<c0015160>] (unwind_backtrace) from [<c0011978>] (show_stack+0x10/0x14)
[    0.000000] [<c0011978>] (show_stack) from [<c055f5f4>] (dump_stack+0x78/0x94)
[    0.000000] [<c055f5f4>] (dump_stack) from [<c02e17cc>] (Ldiv0+0x8/0x10)
[    0.000000] [<c02e17cc>] (Ldiv0) from [<c047d228>] (ti_clk_divider_set_rate+0x14/0x14c)
[    0.000000] [<c047d228>] (ti_clk_divider_set_rate) from [<c047a938>] (clk_change_rate+0x138/0x180)
[    0.000000] [<c047a938>] (clk_change_rate) from [<c047a908>] (clk_change_rate+0x108/0x180)

This occurs as part of the inital clock tree update of child clock nodes
where new_rate could be 0 for non functional clocks.

Fixes: b4761198bfaf296 ("CLK: ti: add support for ti divider-clock")
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/clk/ti/divider.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index e6aa10d..a837f70 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -211,11 +211,16 @@ static long ti_clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 static int ti_clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 				   unsigned long parent_rate)
 {
-	struct clk_divider *divider = to_clk_divider(hw);
+	struct clk_divider *divider;
 	unsigned int div, value;
 	unsigned long flags = 0;
 	u32 val;
 
+	if (!hw || !rate)
+		return -EINVAL;
+
+	divider = to_clk_divider(hw);
+
 	div = DIV_ROUND_UP(parent_rate, rate);
 	value = _get_val(divider, div);
 
-- 
1.7.9.5

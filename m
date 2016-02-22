From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCHv2] clk: ti: omap3+: dpll: use non-locking version of
 clk_get_rate
Date: Mon, 22 Feb 2016 14:05:14 -0800
Message-ID: <20160222220514.GZ4847@codeaurora.org>
References: <1455966777-30576-1-git-send-email-t-kristo@ti.com>
 <20160222165252.GF13417@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160222165252.GF13417@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tero Kristo <t-kristo@ti.com>, mturquette@baylibre.com, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/22, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [160220 03:12]:
> > As the code in this file is being executed within irq context in some
> > cases, we must avoid the clk_get_rate which uses mutex internally.
> > Switch the code to use clk_hw_get_rate instead which is non-locking.
> > 
> > This fixes an issue where PM runtime will hang the system if enabled
> > with a serial console before a suspend-resume cycle.
> 
> Can you please add the "Fixes: " line here?
> 
> And when applying, please tag this one Cc stable.
> 
> Other than that, please feel free to add:
> 
> Tested-by: Tony Lindgren <tony@atomide.com>
> 

This is what I got. "Fixes" should take care of stable.

From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH] clk: ti: omap3+: dpll: use non-locking version of
 clk_get_rate

As the code in this file is being executed within irq context in some
cases, we must avoid the clk_get_rate which uses mutex internally.
Switch the code to use clk_hw_get_rate instead which is non-locking.

This fixes an issue where PM runtime will hang the system if enabled
with a serial console before a suspend-resume cycle.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
Fixes: a53ad8ef3dcc ("clk: ti: Convert to clk_hw based provider APIs")
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/ti/dpll3xxx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
index 1c300388782b..cc739291a3ce 100644
--- a/drivers/clk/ti/dpll3xxx.c
+++ b/drivers/clk/ti/dpll3xxx.c
@@ -460,7 +460,8 @@ int omap3_noncore_dpll_enable(struct clk_hw *hw)
 
 	parent = clk_hw_get_parent(hw);
 
-	if (clk_hw_get_rate(hw) == clk_get_rate(dd->clk_bypass)) {
+	if (clk_hw_get_rate(hw) ==
+	    clk_hw_get_rate(__clk_get_hw(dd->clk_bypass))) {
 		WARN_ON(parent != __clk_get_hw(dd->clk_bypass));
 		r = _omap3_noncore_dpll_bypass(clk);
 	} else {
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

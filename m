From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] clk: ti: omap3+: dpll: use non-locking version of
 clk_get_rate
Date: Thu, 28 Jan 2016 09:22:16 -0800
Message-ID: <20160128172215.GD19432@atomide.com>
References: <1453981067-8618-1-git-send-email-t-kristo@ti.com>
 <56A9FED1.3090903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56A9FED1.3090903@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [160128 03:44]:
> On 01/28/2016 01:37 PM, Tero Kristo wrote:
> >As the code in this file is being executed within irq context in some
> >cases, we must avoid the clk_get_rate which uses mutex internally.
> >Switch the code to use clk_hw_get_rate instead which is non-locking.
> >
> >Signed-off-by: Tero Kristo <t-kristo@ti.com>
> 
> Ooops, sorry. Sent wrong version (read: old) of this patch, please ignore
> this one. Will re-send the correct version in a bit.

I think this is still needed as a fix for -rc cycle with cc: stable
as otherwise we have omap4 and 5 hang if PM runtime is enabled before
a suspend/resume cycle?

Regards,

Tony


> >  drivers/clk/ti/dpll3xxx.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> >diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
> >index f4dec00..7ed24bc 100644
> >--- a/drivers/clk/ti/dpll3xxx.c
> >+++ b/drivers/clk/ti/dpll3xxx.c
> >@@ -437,7 +437,8 @@ int omap3_noncore_dpll_enable(struct clk_hw *hw)
> >
> >  	parent = clk_hw_get_parent(hw);
> >
> >-	if (clk_hw_get_rate(hw) == clk_get_rate(dd->clk_bypass)) {
> >+	if (clk_hw_get_rate(hw) ==
> >+	    clk_hw_get_rate(__clk_get_hw(dd->clk_bypass))) {
> >  		WARN_ON(parent != __clk_get_hw(dd->clk_bypass));
> >  		r = _omap3_noncore_dpll_bypass(clk);
> >  	} else {
> >
> 

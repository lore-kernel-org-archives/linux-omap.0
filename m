From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCHv3 02/27] clk: ti: move generic OMAP DPLL implementation
 under drivers/clk
Date: Thu, 28 May 2015 15:03:27 -0700
Message-ID: <20150528220327.GF24204@codeaurora.org>
References: <1432566032-10860-1-git-send-email-t-kristo@ti.com>
 <1432566032-10860-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52401 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbbE1WD3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2015 18:03:29 -0400
Content-Disposition: inline
In-Reply-To: <1432566032-10860-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On 05/25, Tero Kristo wrote:
> @@ -281,7 +282,7 @@ unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk)
>   * be rounded, or the rounded rate upon success.
>   */
>  long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
> -		unsigned long *parent_rate)
> +			   unsigned long *parent_rate)
>  {
>  	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
>  	int m, n, r, scaled_max_m;
> @@ -310,7 +311,6 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
>  	dd->last_rounded_rate = 0;
>  
>  	for (n = dd->min_divider; n <= dd->max_divider; n++) {
> -
>  		/* Is the (input clk, divider) pair valid for the DPLL? */
>  		r = _dpll_test_fint(clk, n);
>  		if (r == DPLL_FINT_UNDERFLOW)
> @@ -367,4 +367,3 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
>  
>  	return dd->last_rounded_rate;
>  }
> -

It's a lot easier to see the cleanup that happened while copying
code over. Thanks.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

From: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCHv12 07/49] clk: divider: add support for low level ops
Date: Sun, 22 Dec 2013 18:52:35 +0100
Message-ID: <20131222175235.GC8064@book.gsilab.sittig.org>
References: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
 <1387557274-22583-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:45882 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136Ab3LVRwj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Dec 2013 12:52:39 -0500
Content-Disposition: inline
In-Reply-To: <1387557274-22583-7-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org

[ dropped devicetree, we're clock specific here ]

On Fri, Dec 20, 2013 at 18:34 +0200, Tero Kristo wrote:
> 
> Divider clock can now be registered to use low level register access ops.
> Preferred initialization method is via clock description.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/clk/clk-divider.c    |   22 +++++++++++++++++++---
>  include/linux/clk-provider.h |    4 ++++
>  2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index 8cfed5c..887e2d8 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -108,7 +108,12 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
>  	struct clk_divider *divider = to_clk_divider(hw);
>  	unsigned int div, val;
>  
> -	val = clk_readl(divider->reg) >> divider->shift;
> +	if (divider->ll_ops)
> +		val = divider->ll_ops->clk_readl(divider->reg);
> +	else
> +		val = clk_readl(divider->reg);

Should this not better always use an ll_ops structure, which
either is individual to the clock item, or is "global" for a
platform, yet can get re-registered at runtime (see the comment
on 06/49)?  And why are you referencing clk_readl() instead of
clk_readl_default() which you specifically have introduced in the
previous patch?  Adding a copy of the routine and using both the
copy and the original doesn't look right.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de

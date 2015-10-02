From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: ti: dflt: fix enable_reg validity check
Date: Fri, 2 Oct 2015 11:21:33 -0700
Message-ID: <20151002182133.GO12338@codeaurora.org>
References: <1443566267-50225-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1443566267-50225-1-git-send-email-s-anna@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@baylibre.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/29, Suman Anna wrote:
> diff --git a/drivers/clk/ti/clkt_dflt.c b/drivers/clk/ti/clkt_dflt.c
> index 90d7d8a21c49..1ddc288fce4e 100644
> --- a/drivers/clk/ti/clkt_dflt.c
> +++ b/drivers/clk/ti/clkt_dflt.c
> @@ -222,7 +222,7 @@ int omap2_dflt_clk_enable(struct clk_hw *hw)
>  		}
>  	}
>  
> -	if (unlikely(!clk->enable_reg)) {
> +	if (unlikely(IS_ERR(clk->enable_reg))) {

IS_ERR() already has an unlikely inside it, so the unlikely is
redundant here.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

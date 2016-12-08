From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: ti: dra7: fix "failed to lookup clock node
 gmac_gmii_ref_clk_div" boot message
Date: Thu, 8 Dec 2016 15:09:14 -0800
Message-ID: <20161208230914.GU5423@codeaurora.org>
References: <20161129230757.29183-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161129230757.29183-1-grygorii.strashko@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/29, Grygorii Strashko wrote:
> Prevent creating clk alias for non existing gmac_gmii_ref_clk_div clock and,
> this way, eliminate excessive error message during boot:
> 
>  "ti_dt_clocks_register: failed to lookup clock node gmac_gmii_ref_clk_div"
> 
> Fixes: c097338ebd3f ("ARM: dts: dra7: cpsw: fix clocks tree")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

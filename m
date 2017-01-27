From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] clk: ti: divider: Add the table parsing to get the best
 divider value
Date: Thu, 26 Jan 2017 16:03:16 -0800
Message-ID: <20170127000316.GK8801@codeaurora.org>
References: <1480669543-16197-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1480669543-16197-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: t-kristo@ti.com, mturquette@baylibre.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 12/02, Keerthy wrote:
> Currently the divider selection logic blindly divides the parent_rate
> by the clk rate and gives the divider value for the divider clocks
> which do not have the CLK_SET_RATE_PARENT flag set. Add the clk divider
> table parsing to get the closest divider available in the table
> provided via Device tree.
> 
> The code is pretty much taken from: drivers/clk/clk-divider.c.
> and used here to fix up the best divider selection logic.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Reported-by: Richard Woodruff <r-woodruff2@ti.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

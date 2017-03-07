From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 02/15] clk: ti: add support for automatic clock alias
 generation
Date: Tue, 7 Mar 2017 06:48:23 -0800
Message-ID: <20170307144823.GF10239@codeaurora.org>
References: <1486978511-29668-1-git-send-email-t-kristo@ti.com>
 <1486978511-29668-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1486978511-29668-3-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/13, Tero Kristo wrote:
> diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
> index 13c37f4..ac95fda 100644
> --- a/drivers/clk/ti/clock.h
> +++ b/drivers/clk/ti/clock.h
> @@ -16,6 +16,8 @@
>  #ifndef __DRIVERS_CLK_TI_CLOCK__
>  #define __DRIVERS_CLK_TI_CLOCK__
>  
> +#include <linux/clkdev.h>

What is this include for? Shouldn't this be in whatever C file is
using clkdev?


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

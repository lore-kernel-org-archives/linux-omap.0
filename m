From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCHv2 04/28] clk: ti: clkctrl: use fallback udelay approach
 if timekeeping is suspended
Date: Mon, 13 Nov 2017 18:06:43 -0800
Message-ID: <20171114020643.GU11955@codeaurora.org>
References: <1510218917-1725-1-git-send-email-t-kristo@ti.com>
 <1510218917-1725-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1510218917-1725-2-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: mturquette@baylibre.com, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 11/09, Tero Kristo wrote:
> In certain cases it is possible that the timekeeping has been suspended
> already when attempting to disable/enable a clkctrl clock. This will
> happen at least on am43xx platform when attempting to enable / disable
> the clockevent source itself, burping out a warning from timekeeping core.
> 
> The sequence of events leading to this:
> -> timekeeping_suspend()
>  -> clockevents_suspend()
>   -> omap_clkevt_idle()
>    -> omap_hwmod_idle()
>     -> _omap4_clkctrl_clk_disable()
>      -> _omap4_is_timeout()
> 
> Avoid the issue by checking if the timekeeping is suspended and using
> the fallback udelay approach for checking timeouts.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

No Cc on timekeeping maintainers, but OK.

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v5 6/7] clk: Make clk API return per-user struct clk
 instances
Date: Thu, 13 Nov 2014 23:06:46 -0800
Message-ID: <20141114070646.GA11808@codeaurora.org>
References: <1414666135-14313-1-git-send-email-tomeu.vizoso@collabora.com>
 <1414666135-14313-7-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414666135-14313-7-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Mike Turquette <mturquette@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 10/30, Tomeu Vizoso wrote:
> Moves clock state to struct clk_core, but takes care to change as little API as
> possible.
> 
> struct clk_hw still has a pointer to a struct clk, which is the
> implementation's per-user clk instance, for backwards compatibility.
> 
> The struct clk that clk_get_parent() returns isn't owned by the caller, but by
> the clock implementation, so the former shouldn't call clk_put() on it.
> 
> Because some boards in mach-omap2 still register clocks statically, their clock
> registration had to be updated to take into account that the clock information
> is stored in struct clk_core now.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

It would be good to have Russell at least ack the clkdev bits.
There's still more work to do in the future here, but

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

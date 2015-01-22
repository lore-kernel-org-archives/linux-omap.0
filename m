From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v12 3/6] clk: Make clk API return per-user struct clk
 instances
Date: Thu, 22 Jan 2015 14:42:51 -0800
Message-ID: <20150122224250.GP27202@codeaurora.org>
References: <1421943207-5180-1-git-send-email-tomeu.vizoso@collabora.com>
 <1421943207-5180-4-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1421943207-5180-4-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 01/22, Tomeu Vizoso wrote:
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
> 
> ---

My comment on v11 still stands about __clk_create_clk() in
clkdev.c, but otherwise I don't see problems. You can have my
reviewed-by anyway.

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

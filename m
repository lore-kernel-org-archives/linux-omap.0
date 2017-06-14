From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [GIT PULL] clk: ti: clkctrl support for 4.13 merge window
Date: Wed, 14 Jun 2017 10:32:37 -0700
Message-ID: <20170614173237.GB20170@codeaurora.org>
References: <6d66f78a-5d39-6396-c492-b79a687ce58a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6d66f78a-5d39-6396-c492-b79a687ce58a@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-clk <linux-clk@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On 06/08, Tero Kristo wrote:
> Hi Stephen, Mike,
> 
> This pull contains the v3 of the clkctrl base driver support posted
> couple of weeks back, with Tony's acks added to patch #2 and #4.
> 
> -Tero
> 

drivers/clk/ti/clkctrl.c:252
_ti_clkctrl_clk_register() warn: possible memory leak of 'clkctrl_clk'
drivers/clk/ti/clkctrl.c:264
_ti_clkctrl_clk_register() warn: possible memory leak of 'clkctrl_clk'
drivers/clk/ti/clkctrl.c:466
_ti_omap4_clkctrl_setup() warn: possible memory leak of 'clkctrl_clk'
drivers/clk/ti/clkctrl.c:473
_ti_omap4_clkctrl_setup() warn: possible memory leak of 'clkctrl_clk'

Can these be silenced with some follow up patch? I'll hold off on
the pull until you can take a look.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

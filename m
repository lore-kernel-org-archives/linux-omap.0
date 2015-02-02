From: Tony Lindgren <tony@atomide.com>
Subject: Re: Clock Regression in next-20150130 caused by cb75a8fcd14e
Date: Mon, 2 Feb 2015 08:18:59 -0800
Message-ID: <20150202161858.GH16250@atomide.com>
References: <20150131010443.GE16250@atomide.com>
 <20150201232636.421.58980@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150201232636.421.58980@quantum>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Mike Turquette <mturquette@linaro.org> [150201 15:29]:
> Quoting Tony Lindgren (2015-01-30 17:04:44)
> > Hi all,
> > 
> > Looks like commit cb75a8fcd14e ("clk: Add rate constraints to clocks")
> > causes a regression on at least omaps where the serial console either
> > does not show anything, or just prints garbage.
> > 
> > Reverting cb75a8fcd14e makes things work again on next-20150130.
> > 
> > Any ideas?
> 
> Stephen posted a patch[0] to fix this. I've squashed that into Tomeu's
> commit that you reference above and my Panda board is booting fine once
> again.
> 
> [0] http://lkml.kernel.org/r/<20150131013158.GA4323@codeaurora.org>
> 
> Please let me know if any other issues pop up. There are new WARNs for
> OMAP3+ boards introduced by a different patch from Tomeu, but this is
> really because the OMAP DPLL and FAPLL code are dereferencing struct clk
> pointers when they should not be and is a separate issue from the
> constraints patch (with a separate email thread).

Seems Linux next is broken again. Now we omaps get tons of:

clock: dpll_abe_ck failed transition to 'locked'
WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:925 clk_disable+0x28/0x34()

and 

WARNING: CPU: 0 PID: 1 at arch/arm/mach-omap2/dpll3xxx.c:436
omap3_noncore_dpll_enable+0xdc/0x10c()

Regards,

Tony

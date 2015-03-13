From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [Cocci] [PATCH v13 3/6] clk: Make clk API return per-user struct
 clk instances
Date: Fri, 13 Mar 2015 11:29:32 +0800
Message-ID: <20150313032931.GO20455@dragon>
References: <alpine.DEB.2.02.1502022230110.2045@localhost6.localdomain6>
 <54CFFBCF.90706@codeaurora.org>
 <20150202225036.421.43421@quantum>
 <54D0F179.1040906@gmail.com>
 <54D2AA9B.7010800@codeaurora.org>
 <54D3900A.9060200@gmail.com>
 <54D423C3.9030105@codeaurora.org>
 <54E3BA20.3080205@codeaurora.org>
 <20150312172006.GA18418@breakpoint.cc>
 <5501EC6C.5010100@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5501EC6C.5010100@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, Quentin Lambert <lambert.quentin@gmail.com>, Mike Turquette <mturquette@linaro.org>, Julia Lawall <julia.lawall@lip6.fr>, Paul Walmsley <paul@pwsan.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux-omap@vger.kernel.org, cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 12, 2015 at 12:43:40PM -0700, Stephen Boyd wrote:
> On 03/12/15 10:20, Sebastian Andrzej Siewior wrote:
> > On 2015-02-17 14:01:04 [-0800], Stephen Boyd wrote:
> >> diff = 
> >> --- arch/arm/mach-imx/mach-imx6q.c
> >> +++ /tmp/cocci-output-11792-b62223-mach-imx6q.c
> >> @@ -211,7 +211,6 @@ static void __init imx6q_1588_init(void)
> >>  	 * set bit IOMUXC_GPR1[21].  Or the PTP clock must be from pad
> >>  	 * (external OSC), and we need to clear the bit.
> >>  	 */
> >> -	clksel = ptp_clk == enet_ref ? IMX6Q_GPR1_ENET_CLK_SEL_ANATOP :
> >>  				       IMX6Q_GPR1_ENET_CLK_SEL_PAD;
> >>  	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
> >>  	if (!IS_ERR(gpr))
> > Any idea how to do the comparison here? Or should we rely that the bootloader
> > sets this properly (it managed already to select a frequency)? The phy has no
> > clock node in current DT's so we can check this.
> >
> 
> This has been fixed by adding a clk_is_match() helper and using that to
> compare instead of comparing raw pointers. It would be nice if we could
> replace the patch with something else that doesn't require this helper
> though. It looks like this is static board configuration, so I wonder
> why we didn't just have a DT property that indicates how the gpr should
> be configured for this particular board.

We did not add a DT property for it, because there was already enough
info (clock configuration) in DT for kernel to figure it out.

Shawn

From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [Cocci] [PATCH v13 3/6] clk: Make clk API return per-user struct
 clk instances
Date: Thu, 12 Mar 2015 18:20:07 +0100
Message-ID: <20150312172006.GA18418@breakpoint.cc>
References: <20150201212432.22722.70917@quantum>
 <54CFE1FE.7040404@codeaurora.org>
 <alpine.DEB.2.02.1502022230110.2045@localhost6.localdomain6>
 <54CFFBCF.90706@codeaurora.org>
 <20150202225036.421.43421@quantum>
 <54D0F179.1040906@gmail.com>
 <54D2AA9B.7010800@codeaurora.org>
 <54D3900A.9060200@gmail.com>
 <54D423C3.9030105@codeaurora.org>
 <54E3BA20.3080205@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54E3BA20.3080205@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>
Cc: Quentin Lambert <lambert.quentin@gmail.com>, Mike Turquette <mturquette@linaro.org>, Julia Lawall <julia.lawall@lip6.fr>, Paul Walmsley <paul@pwsan.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux-omap@vger.kernel.org, cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 2015-02-17 14:01:04 [-0800], Stephen Boyd wrote:
> diff = 
> --- arch/arm/mach-imx/mach-imx6q.c
> +++ /tmp/cocci-output-11792-b62223-mach-imx6q.c
> @@ -211,7 +211,6 @@ static void __init imx6q_1588_init(void)
>  	 * set bit IOMUXC_GPR1[21].  Or the PTP clock must be from pad
>  	 * (external OSC), and we need to clear the bit.
>  	 */
> -	clksel = ptp_clk == enet_ref ? IMX6Q_GPR1_ENET_CLK_SEL_ANATOP :
>  				       IMX6Q_GPR1_ENET_CLK_SEL_PAD;
>  	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
>  	if (!IS_ERR(gpr))

Any idea how to do the comparison here? Or should we rely that the bootloader
sets this properly (it managed already to select a frequency)? The phy has no
clock node in current DT's so we can check this.

Sebastian

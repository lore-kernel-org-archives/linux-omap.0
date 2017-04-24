From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 3/9] dt-bindings: clk: add omap4 clkctrl definitions
Date: Mon, 24 Apr 2017 14:49:36 -0700
Message-ID: <20170424214936.GF3780@atomide.com>
References: <1489741781-12816-1-git-send-email-t-kristo@ti.com>
 <1489741781-12816-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1489741781-12816-4-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tero,

* Tero Kristo <t-kristo@ti.com> [170317 02:12]:
> Contains offsets for all omap4 clkctrl main and optional clocks.

Can you please sort these by the clock controller instance and
add comments to this file to make easier to read?

This way it will be easy to see how the clocks are grouped
just by looking at this file :)

> --- /dev/null
> +++ b/include/dt-bindings/clock/omap4.h
...
> +#define OMAP4_CLKCTRL_OFFSET	0x20
> +#define OMAP4_CLKCTRL_INDEX(offset)	((offset) - OMAP4_CLKCTRL_OFFSET)
...

Something like below for example:

/* abe clocks */
#define OMAP4_L4_ABE_CLKCTRL    OMAP4_CLKCTRL_INDEX(0x20)
> +#define OMAP4_MCPDM_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x30)
> +#define OMAP4_DMIC_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x38)
> +#define OMAP4_MCASP_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x40)
> +#define OMAP4_MCBSP1_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x48)
> +#define OMAP4_MCBSP2_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x50)
> +#define OMAP4_MCBSP3_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x58)
> +#define OMAP4_SLIMBUS1_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x60)
> +#define OMAP4_TIMER5_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x68)
> +#define OMAP4_TIMER6_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x70)
> +#define OMAP4_TIMER7_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x78)
> +#define OMAP4_TIMER8_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x80)
> +#define OMAP4_WD_TIMER3_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x88)
...

/* l3_2 clocks */
> +#define OMAP4_L3_MAIN_2_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x20)
> +#define OMAP4_GPMC_CLKCTRL	OMAP4_CLKCTRL_INDEX(0x28)
...

Regards,

Tony

From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCHv3] Documentation: dt-bindings: Add binding documentation
 for TI clkctrl clocks
Date: Wed, 19 Apr 2017 09:55:22 -0700
Message-ID: <20170419165522.GL7065@codeaurora.org>
References: <20170123221702.18420-1-tony@atomide.com>
 <dca1ef84-77d1-2b58-7913-91f3b69fde6d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <dca1ef84-77d1-2b58-7913-91f3b69fde6d@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Michael Turquette <mturquette@baylibre.com>, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

On 02/13, Tero Kristo wrote:
> On 24/01/17 00:17, Tony Lindgren wrote:
> >Texas Instruments omap variant SoCs starting with omap4 have a clkctrl
> >clock controller instance for each interconnect target module. The clkctrl
> >controls functional and interface clocks for the module.
> >
> >The clkctrl clocks are currently handled by arch/arm/mach-omap2 hwmod code.
> >With this binding and a related clock device driver we can start moving the
> >clkctrl clock handling to live in drivers/clk/ti.
> >
> >Note that this binding allows keeping the clockdomain related parts out of
> >drivers/clock. The CLKCTCTRL and DYNAMICDEP registers can be handled by
> >a separate driver in drivers/soc/ti and genpd. If the clockdomain driver
> >needs to know it's clocks, we can just set the the clkctrl device
> >instances to be children of the related clockdomain device.
> >
> >Each clkctrl clock can have multiple optional gate clocks, and multiple
> >optional mux clocks. To represent this in device tree, it seems that
> >it is best done using four clock cells #clock-cells = <2> property.
> >
> >The reasons for using #clock-cells = <2> are:
> >
> >1. We need to specify the clkctrl offset from the instance base. Otherwise
> >   we end up with a large number of device tree nodes that need to be
> >   patched when new clocks are discovered in a clkctrl clock with minor
> >   hardware revision changes for example
> >
> >2. On omap5 CM_L3INIT_USB_HOST_HS_CLKCTRL has ten OPTFCLKEN bits. So we
> >   need to use a separate cell for optional gate clocks to avoid address
> >   space conflicts
> >
> >There is probably no need to list input clocks for each clkctrl clock
> >instance in the binding. If we want to add them, the standard clocks
> >binding can be used for that.
> >
> >For hardware reference, see omap4430 TRM "Table 3-1312. L4PER_CM2 Registers
> >Mapping Summary" for example. It shows one instance of a clkctrl clock
> >controller with multiple clkctrl registers.
> >
> >Cc: Paul Walmsley <paul@pwsan.com>
> >Acked-by: Rob Herring <robh@kernel.org>
> >Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> This binding works for me, so:
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>
> 

This wasn't in the TI clk PR. Shall I merge this to clk-next?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

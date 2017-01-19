From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCHv2] Documentation: dt-bindings: Add binding documentation
 for TI clkctrl clocks
Date: Thu, 19 Jan 2017 13:28:13 -0600
Message-ID: <20170119192813.xdt5jahffcdzmucu@rob-hp-laptop>
References: <20170117225302.10844-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170117225302.10844-1-tony@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 17, 2017 at 02:53:02PM -0800, Tony Lindgren wrote:
> Texas Instruments omap variant SoCs starting with omap4 have a clkctrl
> clock controller instance for each interconnect target module. The clkctrl
> controls functional and interface clocks for the module.
> 
> The clkctrl clocks are currently handled by arch/arm/mach-omap2 hwmod code.
> With this binding and a related clock device driver we can start moving the
> clkctrl clock handling to live in drivers/clk/ti.
> 
> Note that this binding allows keeping the clockdomain related parts out of
> drivers/clock. The CLKCTCTRL and DYNAMICDEP registers can be handled by
> a separate driver in drivers/soc/ti and genpd. If the clockdomain driver
> needs to know it's clocks, we can just set the the clkctrl device
> instances to be children of the related clockdomain device.
> 
> Each clkctrl clock can have multiple optional gate clocks, and multiple
> optional mux clocks. To represent this in device tree, it seems that
> it is best done using four clock cells #clock-cells = <4> property.
> 
> The reasons for using #clock-cells = <4> are:
> 
> 1. We need to specify the clkctrl offset from the instance base. Otherwise
>    we end up with a large number of device tree nodes that need to be
>    patched when new clocks are discovered in a clkctrl clock with minor
>    hardware revision changes for example
> 
> 2. On omap5 CM_L3INIT_USB_HOST_HS_CLKCTRL has ten OPTFCLKEN bits. So we
>    need to use a separate cell for optional gate clocks to avoid address
>    space conflicts
> 
> 3. Some clkctrl instances can also also optional mux clocks. To address
>    them properly we need also a separate cell for the optional mux
>    clock index
> 
> 4. The modulemode clock needs a flag passed to it for hardware or
>    software controlled mode
> 
> There is probably no need to list input clocks for each clkctrl clock
> instance in the binding. If we want to add them, the standard clocks
> binding can be used for that.
> 
> For hardware reference, see omap4430 TRM "Table 3-1312. L4PER_CM2 Registers
> Mapping Summary" for example. It shows one instance of a clkctrl clock
> controller with multiple clkctrl registers.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes from v1:
> 
> - Use #clock-cells to avoid address space conflicts
> 
> - Consider also optional mux clocks as pointed out by Tero
> 
> ---
>  .../devicetree/bindings/clock/ti-clkctrl.txt       | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti-clkctrl.txt

Acked-by: Rob Herring <robh@kernel.org>


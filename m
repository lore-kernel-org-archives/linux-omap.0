From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] reset: ti-rstctrl: use the reset-simple driver
Date: Thu, 8 Mar 2018 08:02:49 -0800
Message-ID: <20180308160249.GI5799@atomide.com>
References: <20180307182143.58383-1-tony@atomide.com>
 <20180308024806.vombsjullqw5gpmz@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180308024806.vombsjullqw5gpmz@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Mark Rutland <mark.rutland@arm.com>, Nishant Menon <nm@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Rob Herring <robh@kernel.org> [180308 02:49]:
> On Wed, Mar 07, 2018 at 10:21:43AM -0800, Tony Lindgren wrote:
> > +TI RSTCTRL Reset Controller
> > +
> > +Required properties:
> > +- compatible : "ti,rstctrl"
> > +- reg : Should contain 1 register ranges(address and length)
> > +- #reset-cells: 1
> > +
> > +Example:
> > +	prm_gfx: prm@1100 {
> > +		compatible = "simple-bus";
> 
> What's a PRM?

PRM is power and reset manager. There is one instance per
interconnect instance (clockdomain). PRM shows the status of
the connected devices in the interconnect, such as device
context lost and hardware wake-up dependencies. It also
contains a single reset controller register for external
accelerators such as DSP. The reset controller instance then
has 1 - 3 bits for external accelerator sub device resets.
Then there is a reset status register that shows the reset
reason for the external accelerator.

> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0 0x1100 0x100>;
> 
> And what else is in this range?

In PRM, there are also registers for each interconnect device
context lost and wake-up dependencies. We don't have a driver
for that yet, it's handled by the SoC init code currently.

Unlike the binding for reset controller, the binding for
wake-up dependencies and context lost should look similar
binding to the clkctrl clock binding we have. That's because
there are tons of those registers.

> > +
> > +		gfx_rstctrl: rstctrl@4 {
> > +			compatible = "ti,rstctrl";
> > +			reg = <0x4 0x4>;
> 
> Anytime I see a single register in DT I worry about scaling. How many of 
> these in an SoC?

There are not many instances of the reset controller. There
is one register per interconnect instance for external
accelerators, so about 3 - 10 reset controller registers
per SoC.

The reg offset above is wrong BTW, it should be 0x10 instead
of 0x4. So I need to update this patch for that at least.

Regards,

Tony

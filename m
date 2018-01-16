From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] reset: ti-rstctrl: use the reset-simple driver
Date: Tue, 16 Jan 2018 15:22:43 -0800
Message-ID: <20180116232243.GD4042@atomide.com>
References: <20180116011159.1386-1-tony@atomide.com>
 <1516095054.9022.1.camel@pengutronix.de>
 <20180116150314.GC4042@atomide.com>
 <d32d9836-5edd-d43d-547b-f22384950f2c@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d32d9836-5edd-d43d-547b-f22384950f2c-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Parsons <lost.distance-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nishant Menon <nm-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [180116 21:23]:
> While this adaptation is very simple for replacing the RSTCTRL registers
> from the hwmod data into an existing reset driver, I am afraid that it
> doesn't fit well when you want to use the reset API from client drivers.

Well the reset controller framework is the Linux API for client
drivers though so it already works well for the client drivers :)

> The RSTST is not accounted for (which is what we rely on for saying that
> a deassert is successful), and this is currently only replacing part of
> the omap4_prminst_{assert/deassert}_hardreset functionality, which in
> itself is only a small portion of what the current drivers use
> (omap_hwmod_{assert/deassert}_hardreset() functions.

Seems like that's a different set of patches as the RSTST
registers require some API changes to the reset controller
framework or runtime PM.

The RSTST registers mostly tell the device internal reset reason
like watchdog reset for an accelerator. I'm not sure how the
API for those would look like, do you have some ideas?

Hmm, aren't you currently just reading the RSTST registers
directly for remoteproc etc?

And then we also have the CONTEXT register that tells if module
context was lost during idle :) The API for that could simply be
bool device_context_lost(struct device *dev) to describe that
kind of reset. Or it could maybe also use reset_control_status()
that returns -ECONNRESET? But then what resets the context lost
state as we don't need to reset the device?

It almost seems like the RSTST and CONTEXT should be client device
PM state related registers instead of reset controller registers?
But if we figure out the API them, then accessing them could
be added for "ti,rstctrl" compatible with:

reg = <0x4 0x4>,
       0x14 0x4>,
       0x24 0x4>;
reg-names = "rstctrl", "rststs", "context";

Anyways, for managing various rstctrl bits and OCP softresets,
here's what I was thinking we can do:

1. We keep ocp softreset internal to the interconnect target module
   driver and if child device drivers really need to access that we
   can implement reset driver in the interconnect target module

2. For rstctrl bits that are for a whole interconnect target module
   we access them in the interconnect target module and the child
   device driver can then do device_reset(dev->parent) if needed

3. For child module specific rstctrl bits we can have the child
   devices map them directly in dts if the interconnect target
   module does not need to worry about them

I briefly tested this yesterday with am33xx sgx module just to
read some registers. Here are the dts nodes that I used for
reference, I'll be posting the related ti-sysc driver changes
after -rc1.

prm_gfx: prm@1100 {
	compatible = "simple-bus";
	#address-cells = <1>;
	#size-cells = <1>;
	ranges = <0 0x1100 0x100>;

	gfx_rstctrl: rstctrl@4 {
		compatible = "ti,rstctrl";
		reg = <0x4 0x4>;
		#reset-cells = <1>;
	};
};

target-module@56000000 {
	compatible = "ti,sysc-omap4", "ti,sysc";
	ti,hwmods = "gfx";
	reg = <0x5600fe00 0x4>,
	      <0x5600fe10 0x4>;
	reg-names = "rev", "sysc";
	ti,sysc-midle = <SYSC_IDLE_FORCE>,
			<SYSC_IDLE_NO>,
			<SYSC_IDLE_SMART>;
	ti,sysc-sidle = <SYSC_IDLE_FORCE>,
			<SYSC_IDLE_NO>,
			<SYSC_IDLE_SMART>;
	clocks = <&gfx_l3_clkctrl AM3_GFX_CLKCTRL 0>;
	clock-names = "fck";
	resets = <&gfx_rstctrl 0>;
	reset-names = "rstctrl";
	#address-cells = <1>;
	#size-cells = <1>;
	ranges = <0 0x56000000 0x1000000>;

	/*
	 * Closed source PowerVR driver, no child device
	 * binding or driver in mainline
	 */
};

So if we had a child device driver there and the gfx_rstctrl
had other child device specific reset bits, they could be
properties of the child device with resets = <&gfx_rstctrl 1>
and so on. So hopefully that clarifies how the client drivers
would use the resets?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

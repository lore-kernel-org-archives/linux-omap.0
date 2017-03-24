From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: bus: TI interconnect target module binding
Date: Thu, 23 Mar 2017 20:30:09 -0700
Message-ID: <20170324033008.GV10760@atomide.com>
References: <20170314212304.2875-1-tony@atomide.com>
 <20170324015523.dul3j4lc2nyrmvkl@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170324015523.dul3j4lc2nyrmvkl@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

* Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170323 18:57]:
> On Tue, Mar 14, 2017 at 02:23:04PM -0700, Tony Lindgren wrote:
> > +- clocks	shall contain the clocks managed by the interconnect target
> > +		module, typically at least the clkctrl clock of the module
> 
> Where do we document exactly how many clocks?

That's the clkctrl clock binding done earlier. Will add a note
about that.

> > +Example: Single instance of MUSB controller on omap4 using interconnect ranges:
> > +
> > +	target_module@2b000 {			/* 0x4a0ab000, ap 84 12.0 */
> 
> target-module@
> 
> This unit address doesn't look right?

Oh OK sure will update.

> > +		compatible = "ti,sysc-type1", "simple-bus";
> 
> Seems fairly complicated to claim "simple-bus"?

Hmm that allows to update the dts files and keep things working
with the current "ti,hwmods" property. Then the "ti,hwmods" can be
just removed to switch over to the new interconnect target driver.
So both legacy "simple-bus" + "ti,hwmods" will work and new
"ti,sysc-type1" and no "ti,hwmods". Or do you see some issues with
that approach?

> > +		#address-cells = <2>;
>
> The target module really needs 64-bits of address space? 

I guess not :)

> > +		#size-cells = <1>;
> > +		reg = <0x54 0x400 0x4
> > +		       0x54 0x404 0x4
> > +		       0x54 0x408 0x4
> > +		       0x54 0 0x001000>;
> 
> You have overlapping regions. Don't do that.

Yeah that can be left out for the interconnect target module if
we move some of the quirk handling for idling the unused child
devices into the child device drivers with the earlier proposed
status = "incomplete" stuff.

That way the interconnect target module does not have to access the
child IO range. The child will need the 0x54 0x1000 as a range
though, so it would roughly like this with #address-cells = <1>:

	target-module@2b000 {			/* 0x4a0ab000, ap 84 12.0 */
		compatible = "ti,sysc-type1", "simple-bus";
		#address-cells = <1>;
		#size-cells = <1>;
		reg = <0x54 0x400 0x4
		       0x54 0x404 0x4
		       0x54 0x408 0x4>;
		reg-names = "rev", "sysc", "syss";
		ranges = <0 0x54 0x001000>;
		clocks = <&cm_l3init_clkctrl OMAP4_OTG_CLKCTRL 0>;
		clock-names = "clkctrl";

		ti,sysc-has-autoidle;
		ti,sysc-has-enawakeup;
		ti,sysc-has-softreset;
		...

		usb_otg_hs: usb_otg_hs@0 {
			compatible = "ti,omap4-musb";
			reg = <0 0x7ff>;
			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIH>;
			...
		};
	};

Note how the ranges provided by the interconnect target module
still overlaps with the interconnect module control registers.
Does that look OK to you or do you have some better idea in mind
for dealing with that?

Splitting the child range into sections would break ioremap for all
drivers I believe.

> And for the first 3, if you have that much variation, maybe you need 
> more specific compatible strings?

The first three target module regions can be all over the map
within the child range unfortunately.. See for example just the
sysc registers below.

Regards,

Tony

8< ------------
$ git grep sysc_offs arch/arm/mach-omap2/*hwmod*data*.c | \
	cut -d'=' -f2 | sort | uniq
 0x0000,
 0x0004,
 0x0010,
 0x0014,
 0x002c,
 0x0034,
 0x0038,
 0x0054,
 0x0078,
 0x0084,
 0x008C,
 0x008c,
 0x010,
 0x0110,
 0x0210,
 0x0404,
 0x10,
 0x104,
 0x110,
 0x14,
 0x1fc10,
 0x1fe4,
 0x20,
 0x24,
 0x34,
 0x38,
 0x4,
 0x40,
 0x48,
 0x54,
 0x60,
 0x64,
 0x78,
 0x8,
 0x84,
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

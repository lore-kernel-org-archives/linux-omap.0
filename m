From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 11/17] ARM: dts: Add missing mcasp node for omap4
Date: Thu, 31 Aug 2017 07:44:25 -0700
Message-ID: <20170831144425.GP3930@atomide.com>
References: <20170830151953.30856-1-tony@atomide.com>
 <20170830151953.30856-12-tony@atomide.com>
 <aef213f9-723f-dbf9-f0d2-8b1dd8b1eae1@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <aef213f9-723f-dbf9-f0d2-8b1dd8b1eae1-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [170830 22:48]:
> On 2017-08-30 18:19, Tony Lindgren wrote:
> > diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> > --- a/arch/arm/boot/dts/omap4.dtsi
> > +++ b/arch/arm/boot/dts/omap4.dtsi
> > @@ -775,6 +775,15 @@
> >  			status = "disabled";
> >  		};
> >  
> > +		mcasp: mcasp@40128000 {
> > +			compatible = "ti,omap4-mcasp-audio";
> > +			reg = <0x40128000 0x400>, /* MPU private access */
> > +			      <0x49028000 0x400>; /* L3 Interconnect */
> > +			reg-names = "mpu", "dma";
> > +			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
> > +			ti,hwmods = "mcasp";
> > +		};
> 
> I would not do this. We don't support the NcASP on OMAP4 or OMAP5 for
> that matter.
> In theory it is the same IP as found in other SoCs, but in OMAP4 the TX
> path is disabled and (in theory) the i2s support is also a thing which
> is not supported - only DIT mode.
> We do not even have any hardware where it can be tested (Galaxy Nexus
> uses McASP for S/PDIF output when it is docked.
> For Android we have had omap-mcasp driver, but it is not upstream and is
> never will as if we are going to support McASP it should be done via the
> davinci-mcasp driver.

OK

> By adding the node we might give the impression that McASP on OMAP4/5 is
> usable, which is not.

OK. Yeah we need to make sure this is for the interconnect
target module, and not for it's child device(s) mcasp.

> On the other hand, the DT describes the HW, so it should be OK to add
> all peripherals even if there is no driver to support it. In this case
> the status = "disabled"; must be there.

Yeah well this is for the interconnect target module that we are
already accessing during init to idle it. But it's actually the
children of this node that should have the status = "disabled"!

I think we can solve your concernd by adding the generic minimal
binding and compatible properites for the interconnect target
module for which I already posted an RFC a while back.

So we can just use compatibles "ti,sysc-type1", "ti,sysc-type2"
and "ti,sysc-type3" as are going to need those anyways soonish.

So the McASP interconnect target module would just become:

	target_module@40128000 {
		compatible = "ti,sysc-type2";
		reg = <0x40128000 0x400>, /* MPU private access */
		      <0x49028000 0x400>; /* L3 Interconnect */
		reg-names = "mpu", "dma";
		ti,hwmods = "mcasp";
	};

And if there ever is a McASP driver, it can be a child of
this node. And eventually we will just drop ti,hwmods too.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

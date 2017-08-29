From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 08/17] ARM: dts: Add missing hsi node for omap4
Date: Tue, 29 Aug 2017 07:20:30 -0700
Message-ID: <20170829142029.GS6008@atomide.com>
References: <20170828211918.11573-1-tony@atomide.com>
 <20170828211918.11573-9-tony@atomide.com>
 <20170829091825.aye2ulcurnhs24uw@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170829091825.aye2ulcurnhs24uw@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> [170829 02:18]:
> Hi,
> 
> On Mon, Aug 28, 2017 at 02:19:09PM -0700, Tony Lindgren wrote:
> > On omap4 we're missing the hsi node with it's related "ti,hwmods"
> > property that the SoC interconnect code needs.
> > 
> > Note that this will only show up as a bug with "doesn't have
> > mpu register target base" boot errors when the legacy platform
> > data is removed.
> > 
> > Let's also update the binding accrodingly while at it.
> > 
> > Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/hsi/omap-ssi.txt | 6 +++++-
> >  arch/arm/boot/dts/omap4.dtsi                       | 9 +++++++++
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/hsi/omap-ssi.txt b/Documentation/devicetree/bindings/hsi/omap-ssi.txt
> > --- a/Documentation/devicetree/bindings/hsi/omap-ssi.txt
> > +++ b/Documentation/devicetree/bindings/hsi/omap-ssi.txt
> > @@ -4,7 +4,7 @@ OMAP Synchronous Serial Interface (SSI) controller implements a legacy
> >  variant of MIPI's High Speed Synchronous Serial Interface (HSI).
> >  
> >  Required properties:
> > -- compatible:		Should include "ti,omap3-ssi".
> > +- compatible:		Should include "ti,omap3-ssi" or "ti,omap4-hsi"
> >  - reg-names:		Contains the values "sys" and "gdd" (in this order).
> >  - reg:			Contains a matching register specifier for each entry
> >  			in reg-names.
> > @@ -38,6 +38,10 @@ Required Port sub-node properties:
> >  			property. If it's missing the port will not be
> >  			enabled.
> >  
> > +Optional properties:
> > +- ti,hwmods:		Shall contain TI interconnect module name if needed
> > +			by the SoC
> > +
> >  Example for Nokia N900:
> >  
> >  ssi-controller@48058000 {
> > diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> > --- a/arch/arm/boot/dts/omap4.dtsi
> > +++ b/arch/arm/boot/dts/omap4.dtsi
> > @@ -632,6 +632,15 @@
> >  			dma-names = "tx", "rx";
> >  		};
> >  
> > +		hsi: hsi@4a058000 {
> > +			compatible = "ti,omap4-hsi";
> > +			reg = <0x4a058000 0x4000>;
> > +			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
> > +				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
> > +			ti,hwmods = "hsi";
> > +		};
> > +
> 
> This does not follow the binding, which expects one subnode per
> port and splits memory areas + interrupts accordingly. Fortunately
> HSI is properly documented in the public OMAP4 TRM (in opposit to
> SSI, which is missing completly in OMAP3 TRM). I think the node
> should look like this:

OK sure let's add the subnodes too :)

> hsi: hsi@4a058000 {
>     compatible = "ti,omap4-hsi";
>     ti,hwmods = "hsi";
> 
>     reg = <0x4a058000 0x5000>,
>           <0x4a058000 0x1000>;
>     reg-names = "sys", "gdd";

The module size is 0x4000 in the hardware. Then there's the L4
interconnect registers at 0x5c000 0x1000:

	reg = <0x4a058000 0x4000>,
	      <0x4a05c000 0x1000>;
	reg-names = "sys", "gdd";

Hmm, what's the "gdd" name for? Probably it would be be to use "ta"
there for "target agent" as that's generic and available for every
module.

>     clocks = <&hsi_fck>;
>     clock-names = "hsi_fck";
> 
>     interrupts = <71>;
>     interrupt-names = "gdd_mpu";

And the interrupts need to be mapped for omap4. I'll post
v2 with the subnodes.

Regards,

Tony

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

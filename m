From: Benoit Parrot <bparrot@ti.com>
Subject: Re: [Patch 1/3] dt-bindings: media: ti-vpe: Document VPE driver
Date: Wed, 16 Oct 2019 08:22:39 -0500
Message-ID: <20191016132239.ufptwl44ktmhvylo@ti.com>
References: <20191009175628.20570-1-bparrot@ti.com>
 <20191009175628.20570-2-bparrot@ti.com>
 <20191015222947.GA13388@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191015222947.GA13388@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-media@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Rob Herring <robh@kernel.org> wrote on Tue [2019-Oct-15 17:29:47 -0500]:
> On Wed, Oct 09, 2019 at 12:56:26PM -0500, Benoit Parrot wrote:
> > Device Tree bindings for the Video Processing Engine (VPE) driver.
> > 
> > Signed-off-by: Benoit Parrot <bparrot@ti.com>
> > ---
> >  .../devicetree/bindings/media/ti-vpe.txt      | 48 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/ti-vpe.txt
> 
> Please convert to DT schema format.

I can do that.
Before posting/merging a .yaml, are we supposed to be able to pass these?
# make dt_binding_check
# make dtbs_check

Because currently with 5.4-rc3 these fails.

Is there a way to run these "test command" target a specific .yaml and not
the whole set?

> 
> > 
> > diff --git a/Documentation/devicetree/bindings/media/ti-vpe.txt b/Documentation/devicetree/bindings/media/ti-vpe.txt
> > new file mode 100644
> > index 000000000000..b2942fa8c3ea
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/ti-vpe.txt
> > @@ -0,0 +1,48 @@
> > +Texas Instruments DRA7x VIDEO PROCESSING ENGINE (VPE)
> > +------------------------------------------------------
> > +
> > +The Video Processing Engine (VPE) is a key component for image post
> > +processing applications. VPE consist of a single memory to memory
> > +path which can perform chroma up/down sampling, deinterlacing,
> > +scaling and color space conversion.
> > +
> > +Required properties:
> > +- compatible: must be "ti,vpe"
> 
> Needs to have SoC specific compatibles.

Yes, I'll fix that.

> 
> > +- reg:	physical base address and length of the registers set for the 4
> > +	memory regions required;
> > +- reg-names: name associated with the memory regions described is <reg>;
> 
> The names need to be documented.

Ok.

> 
> > +- interrupts: should contain IRQ line for VPE;
> > +
> > +Example:
> > +
> > +	target-module@1d0010 {                  /* 0x489d0000, ap 27 30.0 */
> > +		compatible = "ti,sysc-omap4", "ti,sysc";
> > +		reg = <0x1d0010 0x4>;
> > +		reg-names = "sysc";
> > +		ti,sysc-midle = <SYSC_IDLE_FORCE>,
> > +				<SYSC_IDLE_NO>,
> > +				<SYSC_IDLE_SMART>;
> > +		ti,sysc-sidle = <SYSC_IDLE_FORCE>,
> > +				<SYSC_IDLE_NO>,
> > +				<SYSC_IDLE_SMART>;
> > +		clocks = <&vpe_clkctrl DRA7_VPE_VPE_CLKCTRL 0>;
> > +		clock-names = "fck";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0x0 0x1d0000 0x10000>;
> 
> All this is outside the scope of this binding.

OK I was not sure if the whole interconnect thing was needed in the example
or not.

> 
> > +
> > +		vpe: vpe@0 {
> > +			compatible = "ti,vpe";
> > +			reg = <0x0000 0x120>,
> > +			      <0x0700 0x80>,
> > +			      <0x5700 0x18>,
> > +			      <0xd000 0x400>;
> > +			reg-names = "vpe_top",
> > +				    "sc",
> > +				    "csc",
> > +				    "vpdma";
> > +			interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
> 
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> 
> Not documented, nor needed as there are no child nodes.

Yeah, I'll remove that.

> 
> > +		};
> > +	};
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8598f49fa2c8..63dcda51f8ae 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16299,6 +16299,7 @@ W:	http://linuxtv.org/
> >  Q:	http://patchwork.linuxtv.org/project/linux-media/list/
> >  S:	Maintained
> >  F:	drivers/media/platform/ti-vpe/
> > +F:	Documentation/devicetree/bindings/media/ti-vpe.txt

Now with the dt_schemas, I noticed that the maintainer's name is part of
the yaml file. Do we still need to add this to the MAINTAINERS file as
well?

Benoit


> >  
> >  TI WILINK WIRELESS DRIVERS
> >  L:	linux-wireless@vger.kernel.org
> > -- 
> > 2.17.1
> > 

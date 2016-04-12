From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dts: dra7xx: Fix compatible string for PCF8575
 chip
Date: Tue, 12 Apr 2016 14:04:38 -0700
Message-ID: <20160412210438.GA5995@atomide.com>
References: <1458147150.20441.2.camel@codethink.co.uk>
 <56E9DED9.6020909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56E9DED9.6020909-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, CT kernel <linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [160316 15:34]:
> On 03/16/2016 11:52 AM, Ben Hutchings wrote:
> > The binding definition for the PCF857x GPIO expanders doesn't mention
> > a "ti,pcf8575" compatible string.  This is apparently because TI is
> > only a second source - there is no functional difference between
> > PCF8575 chips manufactured by TI and NXP, and the same board might be
> > populated with either depending on availability.
> > 
> > This is not a problem in practice because the I2C core uses
> > of_modalias_node() before matching drivers and this strips the
> > manufacturer name.
> > 
> 
> Yeah - thanks for catching this.. was planning on fixing this, but anyways..
> f56de327b4c4 ARM: dts: dra72-evm: Add extcon nodes for USB
> 87517d26d888 ARM: dts: dra7-evm: Add extcon nodes for USB
> 
> Are the patches that introduce the "ti," binding... Roger: since this is
> introduced by your patches... Ccying you as well. weird since checkpatch
> does not complain..
> 
> > Signed-off-by: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
> > ---
> > v2: Correct the claim that this is a practical problem.
> > 
> >  arch/arm/boot/dts/dra7-evm.dts  | 2 +-
> >  arch/arm/boot/dts/dra72-evm.dts | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> > index cfc24e52244e..3907c9d2c12e 100644
> > --- a/arch/arm/boot/dts/dra7-evm.dts
> > +++ b/arch/arm/boot/dts/dra7-evm.dts
> > @@ -539,7 +539,7 @@
> >  	};
> >  
> >  	pcf_gpio_21: gpio@21 {
> > -		compatible = "ti,pcf8575";
> > +		compatible = "nxp,pcf8575";
> >  		reg = <0x21>;
> >  		lines-initial-states = <0x1408>;
> >  		gpio-controller;
> > diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
> > index 00b12002c07c..7ec42bda3afb 100644
> > --- a/arch/arm/boot/dts/dra72-evm.dts
> > +++ b/arch/arm/boot/dts/dra72-evm.dts
> > @@ -422,7 +422,7 @@
> >  	};
> >  
> >  	pcf_gpio_21: gpio@21 {
> > -		compatible = "ti,pcf8575";
> > +		compatible = "nxp,pcf8575";
> >  		reg = <0x21>;
> >  		lines-initial-states = <0x1408>;
> >  		gpio-controller;
> > 
> > 
> > 
> 
> 
> While at it, do you want to fix up (+Seb):
> a) Documentation/devicetree/bindings/i2c/i2c-pxa-pci-ce4100.txt which
> also seems to refer to ti,pcf in example (introduced by df2634f43f51
> x86: dtb: Add a device tree for CE4100 )
> b) arch/x86/platform/ce4100/falconfalls.dts as well?

Applying this one with Roger's ack, seems like those should be
additional patches.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

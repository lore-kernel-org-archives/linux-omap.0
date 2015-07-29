From: Badola Nikhil <nikhil.badola-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 2/3] drivers: usb: dwc3: Add adjust_frame_length_quirk
Date: Wed, 29 Jul 2015 11:19:01 +0000
Message-ID: <SN1PR0301MB16293B756B29E7352BB6A83CF38C0@SN1PR0301MB1629.namprd03.prod.outlook.com>
References: <1437646295-1858-1-git-send-email-nikhil.badola@freescale.com>
 <20150723145532.GC21984@saruman.tx.rr.com>
 <20150723150844.GD21984@saruman.tx.rr.com>
 <SN1PR0301MB162948EF7089997EFE80CA22F38E0@SN1PR0301MB1629.namprd03.prod.outlook.com>
 <20150727150823.GB10703@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150727150823.GB10703-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: Felipe Balbi [mailto:balbi-l0cyMroinI0@public.gmane.org]
> Sent: Monday, July 27, 2015 8:38 PM
> To: Badola Nikhil-B46172
> Cc: balbi-l0cyMroinI0@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
> Subject: Re: [PATCH 2/3] drivers: usb: dwc3: Add adjust_frame_length_quirk
> 
> On Mon, Jul 27, 2015 at 06:56:48AM +0000, Badola Nikhil wrote:
> > > -----Original Message-----
> > > From: Felipe Balbi [mailto:balbi-l0cyMroinI0@public.gmane.org]
> > > Sent: Thursday, July 23, 2015 8:39 PM
> > > To: Felipe Balbi
> > > Cc: Badola Nikhil-B46172; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> > > usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> > > gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
> > > Subject: Re: [PATCH 2/3] drivers: usb: dwc3: Add
> > > adjust_frame_length_quirk
> > >
> > > Hi again,
> > >
> > > On Thu, Jul 23, 2015 at 09:55:32AM -0500, Felipe Balbi wrote:
> > > > > diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> > > > > index
> > > > > 0447788..b7a5119 100644
> > > > > --- a/drivers/usb/dwc3/core.h
> > > > > +++ b/drivers/usb/dwc3/core.h
> > > > > @@ -124,6 +124,7 @@
> > > > >  #define DWC3_GEVNTCOUNT(n)	(0xc40c + (n * 0x10))
> > > > >
> > > > >  #define DWC3_GHWPARAMS8		0xc600
> > > > > +#define DWC3_GFLADJ		0xc630
> > > > >
> > > > >  /* Device Registers */
> > > > >  #define DWC3_DCFG		0xc700
> > > > > @@ -234,6 +235,10 @@
> > > > >  /* Global HWPARAMS6 Register */
> > > > >  #define DWC3_GHWPARAMS6_EN_FPGA			(1 <<
> 7)
> > > > >
> > > > > +/* Global Frame Length Adjustment Register */
> > > > > +#define GFLADJ_30MHZ_REG_SEL		(1 << 7)
> > > >
> > > > always prepend with DWC3_ like *all* other macros in this file.
> > > >
> > > > Also, match docs to ease grepping. This should be called
> > > > DWC3_GFLADJ_30MHZ_SDBND_SEL
> >
> > GFLADJ_30MHZ_REG_SEL is the field's name in LS1021A Reference Manual
> > as well as dwc3 databook. Though DWC3_GFLADJ_30MHZ_SDBND_SEL
> seems
> > more relevant.
> 
> databook calls it GFLADJ_30MHZ_SDBND_SEL, I checked before sending my
> email.
> 
> > > yet another problem is that this register doesn't exist in *all*
> > > versions of DWC3. It was introduced in version 2.50a so the branch I
> > > typed above needs one extra check, and since it's getting so large,
> > > it deserves be factored out into its own function.
> > >
> > > static int dwc3_frame_length_adjustment(struct dwc3 *dwc, u32 fladj) {
> > > 	u32 reg;
> > > 	u32 dft;
> > >
> > > 	if (dwc->revision <= DWC3_REVISION_250A)
> > > 		return 0;
> > >
> > > 	if (fladj == 0)
> > > 		return 0;
> > >
> > > 	reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
> > > 	dft = reg & 0x3f; /* needs a mask macro */
> > >
> > > 	if (!dev_WARN_ONCE(dwc->dev, dft == fladj,
> > > 		"requested value same as default, ignoring\n")) {
> > > 		reg &= ~0x3f; /* needs a mask macro */
> > > 		reg |= DWC3_GFLADJ_30MHZ_SDBND_SEL |
> > > 			DWC3_GFLADJ_30MHZ(fladj_value);
> > >
> > > 		dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
> > > 	}
> > > }
> > >
> > > you really *MUST* check this sort of this out when writing patches.
> > > It's not only about *your* SoC. You gotta remember we have a ton of
> > > different users and those a prone to major grumpyness should a
> > > completely unrelated patch break their use case.
> > >
> > > You have access to the IP's documentation, and that contains the
> > > entire history of the IP itself, so it's easy to figure all of this
> > > out with a simple search in the documentation.
> > >
> > > One extra detail is that you were very careless when writing to the
> > > GFLADJ register too. You simply wrote your 30MHz sideband value,
> > > potentially clearing other bits which shouldn't be touched. That
> > > alone can add regressions.
> > >
> > > When resending, make sure all 3 patches reach linux-usb. I still
> > > can't find patch 3/3.
> > >
> >
> > Will take care of above scenarios and resend patches cc'ing linux-usb
> > in each of them.
> >
> > Regarding acceptance of the patch only when it's used in glue layer,
> > there is no freescale's glue layer present for dwc3 as of now.
> 
> if there is no glue layer, how are you testing your patch ?

We directly call dwc3_probe() . Please see usb node in file arch/arm/boot/dts/ls1021a.dtsi 
For your reference : 

usb3@3100000 {
                        compatible = "snps,dwc3";
                        reg = <0x0 0x3100000 0x0 0x10000>;
                        interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
                        dr_mode = "host";
                };

> 
> > Furthermore, there is not any platform specific code required in glue
> > layer apart from the ones present in dwc3/core.c.
> 
> sorry ? core.c is generic for all users, the glue layer should somewhat hide
> platform details such as clocks and PM. It's surprising if you don't need
> anything on that side.

We do not support power management for now. Also we are not sure
If we need clocks and will look into it when we start working on power management.
I would request you to accept this patch set (after modifications which you 
suggested) so that usb functionality doesn't break.
I will send an incremental patch to use this frame length adjust patch via glue layer
as soon as we introduce one. 
  
 



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

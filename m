From: Benoit Parrot <bparrot-l0cyMroinI0@public.gmane.org>
Subject: Re: [Patch 1/6] ARM: dts: DRA72: Add CAL dtsi node
Date: Fri, 13 Oct 2017 11:55:56 -0500
Message-ID: <20171013165555.GF25400@ti.com>
References: <20171012192719.15193-1-bparrot@ti.com>
 <20171012192719.15193-2-bparrot@ti.com>
 <20171013165408.GJ4394@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171013165408.GJ4394-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote on Fri [2017-Oct-13 09:54:09 -0700]:
> * Benoit Parrot <bparrot-l0cyMroinI0@public.gmane.org> [171012 12:29]:
> > This patch adds the required dtsi node to support the Camera
> > Adaptation Layer (CAL) for the DRA72 family of devices.
> > 
> > - Added CAL entry in dra72x.dtsi.
> > 
> > Signed-off-by: Benoit Parrot <bparrot-l0cyMroinI0@public.gmane.org>
> > ---
> >  arch/arm/boot/dts/dra72x.dtsi | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/dra72x.dtsi b/arch/arm/boot/dts/dra72x.dtsi
> > index 67107605fb4c..d0ba4f238084 100644
> > --- a/arch/arm/boot/dts/dra72x.dtsi
> > +++ b/arch/arm/boot/dts/dra72x.dtsi
> > @@ -17,6 +17,37 @@
> >  		interrupt-parent = <&wakeupgen>;
> >  		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
> >  	};
> > +
> > +	ocp {
> > +		cal: cal@4845b000 {
> > +			compatible = "ti,dra72-cal";
> > +			ti,hwmods = "cal";
> > +			reg = <0x4845B000 0x400>,
> > +			      <0x4845B800 0x40>,
> > +			      <0x4845B900 0x40>,
> > +			      <0x4A002e94 0x4>;
> 
> Care to fix the cAmelcasing here? All lower case hex is pretty much the
> standard with linux, so might as well lower case them all while at it.

Sure thing, I'll fix it.

Benoit

> 
> Regards,
> 
> Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

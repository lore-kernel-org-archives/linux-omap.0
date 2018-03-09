From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2] reset: ti-rstctrl: use the reset-simple driver
Date: Fri, 9 Mar 2018 07:10:58 -0800
Message-ID: <20180309151058.GQ5799@atomide.com>
References: <20180307182143.58383-1-tony@atomide.com>
 <20180308024806.vombsjullqw5gpmz@rob-hp-laptop>
 <20180308160249.GI5799@atomide.com>
 <CAL_JsqK4gLh17H+=5qPHB6Zd+s2Nn9mYQHbRsP=7DLFMTcstig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqK4gLh17H+=5qPHB6Zd+s2Nn9mYQHbRsP=7DLFMTcstig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Mark Rutland <mark.rutland@arm.com>, Nishant Menon <nm@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh@kernel.org> [180308 22:27]:
> On Thu, Mar 8, 2018 at 10:02 AM, Tony Lindgren <tony@atomide.com> wrote:
> > In PRM, there are also registers for each interconnect device
> > context lost and wake-up dependencies. We don't have a driver
> > for that yet, it's handled by the SoC init code currently.
> 
> Regardless of having/needing a driver, you should take a stab at doing
> the binding at least. It doesn't make sense to do the binding of the
> child without doing the parent.

Sure, we have already partial binding documentation for
PRM at Documentation/devicetree/bindings/arm/omap/prcm.txt.
I'll take a look at updating it for the reset controller.

> > Unlike the binding for reset controller, the binding for
> > wake-up dependencies and context lost should look similar
> > binding to the clkctrl clock binding we have. That's because
> > there are tons of those registers.
> >
> >> > +
> >> > +           gfx_rstctrl: rstctrl@4 {
> >> > +                   compatible = "ti,rstctrl";
> >> > +                   reg = <0x4 0x4>;
> >>
> >> Anytime I see a single register in DT I worry about scaling. How many of
> >> these in an SoC?
> >
> > There are not many instances of the reset controller. There
> > is one register per interconnect instance for external
> > accelerators, so about 3 - 10 reset controller registers
> > per SoC.
> 
> Okay, seems a reasonable number.
> 
> However, couldn't you just have PRM node(s) and have that register as
> a simple reset driver (along with anything else it handles).

We could have a driver for PRM, but I'm not sure if doing a
separate PRM driver helps much here. It seems like reset-simple
already does the job for most part and can be enhanced as
needed :)

The missing piece is how to get the extra pieces of information
to the consumer drivers.. That is the reset status and context
lost status of each device.

Regards,

Tony

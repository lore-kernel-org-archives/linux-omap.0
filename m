From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP5: Enable arch timer support
Date: Mon, 10 Sep 2012 18:31:02 +0530
Message-ID: <CAMQu2gxE8e9RBykLDyukZwV7dPKv3nG1vCynO1pijUBXBnyq8Q@mail.gmail.com>
References: <1344856045-15134-1-git-send-email-santosh.shilimkar@ti.com>
 <1344856045-15134-3-git-send-email-santosh.shilimkar@ti.com> <504DE165.4000208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:36393 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757737Ab2IJNBY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 09:01:24 -0400
Received: by iebc10 with SMTP id c10so5944243ieb.1
        for <linux-omap@vger.kernel.org>; Mon, 10 Sep 2012 06:01:23 -0700 (PDT)
In-Reply-To: <504DE165.4000208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.orig, tony@atomide.com

On Mon, Sep 10, 2012 at 6:17 PM, Benoit Cousson <b-cousson@ti.com> wrote:
>
> Hi Santosh,
>
> On 08/13/2012 01:07 PM, Santosh Shilimkar wrote:
> > Enable Cortex A15 generic timer support for OMAP5 based SOCs.
> > The CPU local timers run on the free running real time counter clock.
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> >  arch/arm/boot/dts/omap5.dtsi |    6 ++++++
> >  arch/arm/mach-omap2/Kconfig  |    1 +
> >  arch/arm/mach-omap2/timer.c  |    7 +++++++
> >  3 files changed, 14 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> > index 57e5270..9686056 100644
> > --- a/arch/arm/boot/dts/omap5.dtsi
> > +++ b/arch/arm/boot/dts/omap5.dtsi
> > @@ -73,6 +73,12 @@
> >                             <0x48212000 0x1000>;
> >               };
> >
> > +             arch-timer {
>
> arch-timer is the ARM specific name, so I guess here it should be named
> with the generic timer name.
>
is "local_timer" name fine then?

> > +                     compatible = "arm,armv7-timer";
> > +                     interrupts = <1 14 0x304>;
>
> Could you add some comment, because these hexa value are a little bit
> hard to understand.
>
OK. Will add some comments.

> > +                     clock-frequency = <6140000>;
> > +             };
> > +
>
> That node does not even have a base address?
> If this is located inside the MPU, it should not be in the OCP node.
>
Its inside MPU and Cp15 control based. No OCP node.

> Silly question: Don't we have one arch-timer per CPU?
>
It is per CPU just like A9 TWD

Regards
santosh

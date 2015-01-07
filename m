From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 0/5] irqchip: kill the GIC routable domain
Date: Wed, 7 Jan 2015 11:09:44 -0500
Message-ID: <20150107160944.GK24989@titan.lakedaemon.net>
References: <1417873576-10463-1-git-send-email-marc.zyngier@arm.com>
 <20141207171646.GA12049@kahuna>
 <20141207180322.GA15688@kahuna>
 <54856B21.6070104@arm.com>
 <20141208224116.GA2538@kahuna>
 <5486C6A6.8060702@arm.com>
 <20141209181719.GA2569@kahuna>
 <54874223.2000805@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63133 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753617AbbAGQKA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2015 11:10:00 -0500
Content-Disposition: inline
In-Reply-To: <54874223.2000805@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Nishanth Menon <nm@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stefan Agner <stefan@agner.ch>, Thomas Gleixner <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Dec 09, 2014 at 06:40:35PM +0000, Marc Zyngier wrote:
> On 09/12/14 18:17, Nishanth Menon wrote:
> > On 09:53-20141209, Marc Zyngier wrote:
> >> On 08/12/14 22:41, Nishanth Menon wrote:
> >>
> >>> Anyways.. The following diff[1] on top of your branch makes DRA7 work - I
> >>> assume you will squash as needed and repost with linux-omap mailing list
> >>> in CC.
> >>
> >> Brilliant. I'll squash that into my tree and repost at some point.
> > 
> > K, it will be nice to have a reflow of the series based on v3.19-rc1
> > since there are dts dependencies and we dont want folks to have
> > regressions on their platforms of choice..
> > 
> > Obviously, my tests are basic boot tests and should get a few weeks(as
> > you already mentioned) on linux-next to get properly soaked
> > 
> >>
> >>> I increased the scope of testing knowing that WUGEN is present in many
> >>> A9 based TI platforms as well.. and at least OMAP4 showed flakiness in
> >>> my testing.. Also a few notes:
> >>>
> >>> Stuff like: am437x is a bit questionable (interrupt-parent probably should be wugen?)
> >>> 175:          0       GIC  39  tps65218 
> >>>
> >>> OMAP5: (should be wugen?)
> >>> 308:       4323          0       GIC 106  OMAP UART2
> >>> 411:          0          0       GIC 151  twl6040
> >>> 405:          1          0       GIC  39  palmas
> >>
> >> Well, I can't really tell. Someone with access to the documentation
> >> should be able to find out.
> > 
> > AM437x: http://www.ti.com/lit/pdf/spruhl7
> > OMAP5: http://www.ti.com/lit/pdf/swpu249
> > 
> > yeah, we should be able to do them as well - trivially since they follow
> > the same structure as other SoCs without crossbar.
> 
> Done some stuff in that department.
> 
> >>
> >>> OMAP4 serial port is flaky -> not sure if it is due to routing of GIC to UART2 and not via WUGEN
> >>> IRQ branch: with my fix applied:
> >>> ---------------------------------
> >>
> >> [...]
> >>
> >>> 18: pandaboard-es:  Boot FAIL: http://slexy.org/raw/s20ty0Z6i5 (not expected)
> >>> 19: pandaboard-vanilla:  Boot FAIL: http://slexy.org/raw/s20BYfaMd2 (not expected)
> >>
> >> If I read the log correctly, the serial port stops responding after a while?
> > 
> > yeah - dug at the omap4 ones a bit, obviously once the deeper c states
> > are hit, we'd like wakeupgen to wakeup CPU else we will be "sluggish" in
> > the sense that the event is detected when some other wakeupgen enabled
> > interrupt takes place.
> 
> I realised that as well once I got a panda up and running.
> 
> > Adding the following makes my panda work fine.
> > 1: pandaboard-es:  Boot PASS: http://slexy.org/raw/s20o8DaBvh
> > 2: pandaboard-vanilla:  Boot PASS: http://slexy.org/raw/s222JndDdh
> > 
> > 
> > diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
> > index 1505135..8b6d50e 100644
> > --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
> > +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
> > @@ -371,8 +371,8 @@
> >  	twl: twl@48 {
> >  		reg = <0x48>;
> >  		/* IRQ# = 7 */
> > -		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
> > -		interrupt-parent = <&gic>;
> > +		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to wakeupgen to gic */
> > +		interrupt-parent = <&wakeupgen>;
> >  	};
> 
> [...]
> 
> I already fixed those in my tree, in a slightly different way: no need
> to have an interrupt parent at all, as we're going to inherit the
> default anyway.
> 
> I've pushed another version of the branch, with the crossbar rework
> sitting *before* the WUGEN hacks. That should hopefully make bisection work.
> 
> If you can give it a shake, that'd be most appreciated. I'll repost the
> branch in a couple of days.

Hmmm, I'm sensing a pattern here :)  My email, only to the MLs, was
messed up for a few days.  I probably missed it in there...

thx,

Jason.

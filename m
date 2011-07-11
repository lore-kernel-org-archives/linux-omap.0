From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 0/4] TWL external controller support
Date: Mon, 11 Jul 2011 21:11:14 +0900
Message-ID: <20110711121111.GL5092@opensource.wolfsonmicro.com>
References: <1310140588-26078-1-git-send-email-t-kristo@ti.com>
 <20110708162531.GE31978@legolas.emea.dhcp.ti.com>
 <20110709012407.GG18860@opensource.wolfsonmicro.com>
 <20110709104007.GM31978@legolas.emea.dhcp.ti.com>
 <20110709105649.GA17036@opensource.wolfsonmicro.com>
 <1310372591.4331.27.camel@sokoban>
 <20110711100509.GC5092@opensource.wolfsonmicro.com>
 <1310381339.4331.45.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:52091 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756292Ab1GKML0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 08:11:26 -0400
Content-Disposition: inline
In-Reply-To: <1310381339.4331.45.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, linux-omap@vger.kernel.org, "Girdwood, Liam" <lrg@ti.com>

On Mon, Jul 11, 2011 at 01:48:59PM +0300, Tero Kristo wrote:
> On Mon, 2011-07-11 at 12:05 +0200, Mark Brown wrote:

> > No.  Why do you want these regulators to have anything to do with the
> > TWL4030?

> So, a completely new driver should be made for these? The reason I
> wanted to put them within TWL4030 code is that they reside inside
> TWL4030, and there is already some code for accessing these regulators
> (in the standard I2C access method) from the twl-regulator.c.

Well, if they're not perceptibly part of the same chip from a control
point of view and need you to provide board specific callbacks it would
seem logical...

> > > configured from the TWL side. The voltage processor support is currently
> > > provided by the omap platform code, and regulator code knows nothing
> > > about this. It might also be possible to do compile time switch for the
> > > interface here if that is acceptable, however a runtime interface for
> > > doing this would provide more flexibility.

> > This isn't making much sense to me, what is the relationship between
> > this and the other regulators you're adding these bodge interfaces for?
> > Why would you want to switch between the two modes at runtime and how
> > would anyone take the decision to do so?

> Runtime switching would mostly be useful as a testing feature. In
> typical setup the configuration is just selected during boot time, and
> thats it. And normally we would just want to use the voltage processor
> interfaces to control these regulators.

It doesn't seem like a good idea to support that, then.  If there's no
benefit to switching dynamically we're just adding complexity to the
system which people will then spend time tweaking and making work
dealing with any robustness issues from managing the transitions.

> > If some of the TWL4030 regulators are controlled by something other than
> > the CPU in your system then the TWL4030 driver shouldn't be configured
> > to do anything with them except possibly provide read only access.

> I think this part I have not been too clear about... CPU is controlling
> the voltage level for these regulators, but the used hardware interface
> is different... and the CPU is giving a guideline that we should be
> using the nominal voltage level based on cpufreq setup, but the actual
> voltage set on the TWL chip is usually different.

Right, but from a software point of view the fact that we end up with
the same physical regulator is immaterial as you have to try *really*
hard to notice.

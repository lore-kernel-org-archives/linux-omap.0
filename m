From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [RFC 0/4] TWL external controller support
Date: Mon, 11 Jul 2011 13:48:59 +0300
Message-ID: <1310381339.4331.45.camel@sokoban>
References: <1310140588-26078-1-git-send-email-t-kristo@ti.com> <20110708162531.GE31978@legolas.emea.dhcp.ti.com> <20110709012407.GG18860@opensource.wolfsonmicro.com> <20110709104007.GM31978@legolas.emea.dhcp.ti.com> <20110709105649.GA17036@opensource.wolfsonmicro.com> <1310372591.4331.27.camel@sokoban> <20110711100509.GC5092@opensource.wolfsonmicro.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47112 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194Ab1GKKtF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jul 2011 06:49:05 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <20110711100509.GC5092@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, linux-omap@vger.kernel.org, "Girdwood, Liam" <lrg@ti.com>

On Mon, 2011-07-11 at 12:05 +0200, Mark Brown wrote:
> On Mon, Jul 11, 2011 at 11:23:11AM +0300, Tero Kristo wrote:
> > On Sat, 2011-07-09 at 12:56 +0200, Mark Brown wrote:
> > > On Sat, Jul 09, 2011 at 01:40:08PM +0300, Felipe Balbi wrote:
> 
> > > I'm completely unable to identify an issue in the framework that this
> > > patch addresses - the API already supports multiple devices supplying
> > > regulators, it's extremely difficult to understand what motivates the
> > > change.
> 
> > So if I understood the comments right, what you are saying is that I
> > should probably implement a new regulator subset for the twl-regulator.
> > I.e. we have currently TWL4030_ADJUSTABLE_LDO etc., so I could add a
> > TWL4030_ADJUSTABLE_SMPS for example. These regulators would then use the
> 
> No.  Why do you want these regulators to have anything to do with the
> TWL4030?

So, a completely new driver should be made for these? The reason I
wanted to put them within TWL4030 code is that they reside inside
TWL4030, and there is already some code for accessing these regulators
(in the standard I2C access method) from the twl-regulator.c.

> 
> > appropriate interface according to board specific setup. How would you
> > propose to use / register the alternate ops to access the omap_voltage
> > layer from here though for set/get voltage?
> 
> I have no visibility of the omap_voltage layer.  If it's peering into
> the internals of the regulator API or regulator drivers you've got a
> fairly serious abstraction problem that someone needs to fix...

At least currently it does not have any visibility to regulator
framework, and well, I am not too sure if it should.  It is providing
interfaces to control the voltage processor, for example to switch the
used nominal voltage level when cpufreq switches used OPP, the voltage
processor itself might be altering this nominal voltage level slightly
based on silicon statistics. The eventual target might be to make the
omap voltage control / processor code be a regulator driver itself.

> 
> > The main thing is that VDD1 and VDD2 regulators in TWL4030 can be
> > controlled through the typical TWL control interface (I2C), like the
> > rest of the TWL regulators, or it can be controlled through the voltage
> > processor interface which uses a dedicated I2C bus and is not accessible
> > to anything but the voltage processor. The used interface can be
> 
> That's not too unusual in hardware terms.
> 
> > configured from the TWL side. The voltage processor support is currently
> > provided by the omap platform code, and regulator code knows nothing
> > about this. It might also be possible to do compile time switch for the
> > interface here if that is acceptable, however a runtime interface for
> > doing this would provide more flexibility.
> 
> This isn't making much sense to me, what is the relationship between
> this and the other regulators you're adding these bodge interfaces for?
> Why would you want to switch between the two modes at runtime and how
> would anyone take the decision to do so?

Runtime switching would mostly be useful as a testing feature. In
typical setup the configuration is just selected during boot time, and
thats it. And normally we would just want to use the voltage processor
interfaces to control these regulators.

> 
> If some of the TWL4030 regulators are controlled by something other than
> the CPU in your system then the TWL4030 driver shouldn't be configured
> to do anything with them except possibly provide read only access.

I think this part I have not been too clear about... CPU is controlling
the voltage level for these regulators, but the used hardware interface
is different... and the CPU is giving a guideline that we should be
using the nominal voltage level based on cpufreq setup, but the actual
voltage set on the TWL chip is usually different.

-Tero



Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 


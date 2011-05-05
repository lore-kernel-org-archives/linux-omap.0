From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Common clock and dvfs
Date: Thu, 5 May 2011 00:25:30 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1105042327380.30136@utopia.booyaka.com>
References: <4DC07F10.6010305@ti.com> <4DC230E0.7090909@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40046 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384Ab1EEGZb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 02:25:31 -0400
In-Reply-To: <4DC230E0.7090909@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Colin Cross <ccross@google.com>, "Hilman, Kevin" <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Turquette, Mike" <mturquette@ti.com>, Thomas Gleixner <tglx@linutronix.de>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Mark Brown <broonie@sirena.org.uk>

On Thu, 5 May 2011, Cousson, Benoit wrote:

> Those kinds of exceptions are somehow the rules for an OMAP4 device. 
> Most scalable devices are using some internal dividers or even internal 
> PLL to control the scalable clock rate (DSS, HSI, MMC, McBSP... the 
> OMAP4430 Data Manual [1] is providing the various clock rate limitation 
> depending of the OPP). And none of these internal dividers are handled 
> by the clock fmwk today.

That's mostly because no one has taken the time to implement them, not 
really for any technical reason.

> For sure, it should be possible to extend the clock data with internal 
> devices clock nodes (like the UART baud rate divider for example), but 
> then we will have to handle a bunch of nodes that may not be always 
> available depending of device state. In order to do that, you have to 
> tie these clocks node to the device that contains them.

It's only necessary to do that for the device where the clock's control 
registers are located.  In many cases (almost all on OMAP), this is a 
different device from the device that the clock actually drives.

> And for the clocks that do not belong to any device, like most PRCM 
> source clocks or DPLL inside OMAP, we can easily define a PRCM device or 
> several CM (Clock Manager) devices that will handle all these clock 
> nodes.
> 
> > The proposed OMAP4 way (I believe, correct me if I am wrong) is to 
> > create a new api outside the clock api that calls into both the clock 
> > api and the regulator api in the correct order for each operation, 
> > using OPP to determine the voltage.  This has a few disadvantages 
> > (obviously, I am biased, having written the Tegra code) - clocks and 
> > voltages are tied to a device, which is not always the case for 
> > platforms outside of OMAP, and drivers must know if their hardware 
> > requires voltage scaling.  The clock api becomes unsafe to use on any 
> > device that requires dvfs, as it could change the frequency higher 
> > than the supported voltage.
> 
> You have to tie clock and voltage to a device. 

As you mentioned above, there are several clocks that aren't associated 
with any specific "device" outside of the clock itself, or which are 
associated with multiple devices.

> Most of the time a clock does not have any clear relation with a voltage 
> domain.  It can even cross power / voltage domain without any issue.

Each instance of a clock signal -- a conductor on a chip that carries an 
AC signal that is used to drive some gates -- can only be driven by 
one voltage rail.  How could it be otherwise?

In the unusual instances where a clock crosses voltage rails (by virtue of 
some gates between the rails that handle the translation) and it is 
important for Linux to know this, then in the Linux-OMAP code, the 
intention is for separate struct clks to be used for the clock signals on 
either side of the voltage rail crossing.

> The clock node itself does not know anything about the device and that's 
> why it should not be the proper structure to do DVFS.

What aspects of the device are you referring to that the clock node would 
need to know?

> OMAP moved away from using the clock nodes to represent IP blocks 
> because the clock abstraction was not enough to represent the way an IP 
> is interacting with clocks. That's why omap_hwmod was introduced to 
> represent an IP block.

omap_hwmod was introduced to represent IP blocks and their 
interconnection.  Separating IP block gating from individual clock gating 
was one part of this, but not the only one; and gating isn't really 
related to DVFS.

> Because the clock is not the central piece of the DVFS sequence, I don't 
> think it deserves to handle the whole sequence including voltage 
> scaling.
> 
> A change to a clock rate might trigger a voltage change, but the 
> opposite is true as well. A reduction of the voltage could trigger the 
> clock rate change inside all the devices that belong to the voltage 
> domain. Because of that, both fmwks are siblings. This is not a 
> parent-child relationship.

What's the use case for voltage reduction that isn't triggered by a clock 
rate reduction?

> Another important point is that in order to trigger a DVFS sequence you 
> have to do some voting to take into account shared clock and shared 
> voltage domains.
> 
> Moreover, playing directly with a clock rate is not necessarily 
> appropriate or sufficient for some devices. For example, the 
> interconnect should expose a BW knob instead of a clock rate one.  In 
> general, some more abstract information like BW, latency or performance 
> level (P-state) should be the ones to be exposed at driver level.

It's definitely true, that, say, the SDMA driver should not specify its 
interconnect bandwidth requirements in terms of an interconnect clock 
frequency.  It should specify some variant of bytes per second.  But 
that's only possible because the goal is to provide the interconnect 
driver with have enough information to convert the bandwidth constraint to 
a clock rate constraint.  The core code is not capable of translating 
bandwidth constraints for non-interconnect devices to clock rates in the 
general case.  That must be done by the device driver and/or device 
subsystem itself, which would provide a clock rate constraint to the core 
code.

> By exposing such knobs, the underlying DVFS fmwk will be able to do voting
> based on all the system constraints and then set the proper clock rate using
> clock fmwk if the divider is exposed as a clock node or let the driver convert
> the final device recommendation using whatever register that will adjust the
> critical clock path rate.


- Paul

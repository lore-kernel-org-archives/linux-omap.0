From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: Common clock and dvfs
Date: Thu, 05 May 2011 07:08:48 +0200
Message-ID: <4DC230E0.7090909@ti.com>
References: <4DC07F10.6010305@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51138 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085Ab1EEFJe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 May 2011 01:09:34 -0400
In-Reply-To: <4DC07F10.6010305@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Turquette, Mike" <mturquette@ti.com>, Thomas Gleixner <tglx@linutronix.de>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Mark Brown <broonie@sirena.org.uk>, Paul Walmsley <paul@pwsan.com>

(Cc folks with some DVFS interest)

Hi Colin,

On Fri, 22 Apr 2011, Colin Cross wrote:
> Now that we are approaching a common clock management implementation,
> I was thinking it might be the right place to put a common dvfs
> implementation as well.
>
> It is very common for SoC manufacturers to provide a table of the
> minimum voltage required on a voltage rail for a clock to run at a
> given frequency.  There may be multiple clocks in a voltage rail that
> each can specify their own minimum voltage, and one clock may affect
> multiple voltage rails.  I have seen two ways to handle keeping the
> clocks and voltages within spec:
>
> The Tegra way is to put everything dvfs related under the clock
> framework.  Enabling (or preparing, in the new clock world) or raising
> the frequency calls dvfs_set_rate before touching the clock, which
> looks up the required voltage on a voltage rail, aggregates it with
> the other voltage requests, and passes the minimum voltage required to
> the regulator api.  Disabling or unpreparing, or lowering the
> frequency changes the clock first, and then calls dvfs_set_rate.  For
> a generic implementation, an SoC would provide the clock/dvfs
> framework with a list of clocks, the voltages required for each
> frequency step on the clock, and the regulator name to change.  The
> frequency/voltage tables are similar to OPP, except that OPP gets
> voltages for a device instead of a clock.  In a few odd cases (Tegra
> always has a few odd cases), a clock that is internal to a device and
> not exposed to the clock framework (pclk output on the display, for
> example) has a voltage requirement, which requires some devices to
> manually call dvfs_set_rate directly, but with a common clock
> framework it would probably be possible for the display driver to
> export pclk as a real clock.

Those kinds of exceptions are somehow the rules for an OMAP4 device. 
Most scalable devices are using some internal dividers or even internal 
PLL to control the scalable clock rate (DSS, HSI, MMC, McBSP... the 
OMAP4430 Data Manual [1] is providing the various clock rate limitation 
depending of the OPP).
And none of these internal dividers are handled by the clock fmwk today.

For sure, it should be possible to extend the clock data with internal 
devices clock nodes (like the UART baud rate divider for example), but 
then we will have to handle a bunch of nodes that may not be always 
available depending of device state. In order to do that, you have to 
tie these clocks node to the device that contains them.

And for the clocks that do not belong to any device, like most PRCM 
source clocks or DPLL inside OMAP, we can easily define a PRCM device or 
several CM (Clock Manager) devices that will handle all these clock nodes.

> The proposed OMAP4 way (I believe, correct me if I am wrong) is to
> create a new api outside the clock api that calls into both the clock
> api and the regulator api in the correct order for each operation,
> using OPP to determine the voltage.  This has a few disadvantages
> (obviously, I am biased, having written the Tegra code) - clocks and
> voltages are tied to a device, which is not always the case for
> platforms outside of OMAP, and drivers must know if their hardware
> requires voltage scaling.  The clock api becomes unsafe to use on any
> device that requires dvfs, as it could change the frequency higher
> than the supported voltage.

You have to tie clock and voltage to a device. Most of the time a clock 
does not have any clear relation with a voltage domain. It can even 
cross power / voltage domain without any issue.
The efficiency of the DVFS technique is mainly due to the reduction of 
the voltage rail that supply a device. In order to achieve that you have 
to reduce the clock rate of one or several clocks nodes that supply the 
critical path inside the HW.

The clock node itself does not know anything about the device and that's 
why it should not be the proper structure to do DVFS.

OMAP moved away from using the clock nodes to represent IP blocks 
because the clock abstraction was not enough to represent the way an IP 
is interacting with clocks. That's why omap_hwmod was introduced to 
represent an IP block.

> Is the clock api the right place to do dvfs, or should the clock api
> be kept simple, and more complicated operations like dvfs be kept
> outside?

In term of SW layering, so far we have the clock fmwk and the regulator 
fmwk. Since DVFS is about both clock and voltage scaling, it makes more 
sense to me to handle DVFS on top of both existing fmwks. Let stick to 
the "do one thing and do it well" principle instead of hacking an 
existing fmwk with what I consider to be an unrelated functionality.

Moreover, the only exiting DVFS SW on Linux today is CPUFreq, so 
extending this fmwk to a devfreq kind of fwmk seems a more logical 
approach to me.

The important point is that IMO, the device should be the central 
component of any DVFS implementation. Both clock and voltage are just 
some device resources that have to change synchronously to reduce the 
power consumption of the device.

Because the clock is not the central piece of the DVFS sequence, I don't 
think it deserves to handle the whole sequence including voltage  scaling.

A change to a clock rate might trigger a voltage change, but the 
opposite is true as well. A reduction of the voltage could trigger the 
clock rate change inside all the devices that belong to the voltage domain.
Because of that, both fmwks are siblings. This is not a parent-child 
relationship.

Another important point is that in order to trigger a DVFS sequence you 
have to do some voting to take into account shared clock and shared 
voltage domains.

Moreover, playing directly with a clock rate is not necessarily 
appropriate or sufficient for some devices. For example, the 
interconnect should expose a BW knob instead of a clock rate one.
In general, some more abstract information like BW, latency or 
performance level (P-state) should be the ones to be exposed at driver 
level.

By exposing such knobs, the underlying DVFS fmwk will be able to do 
voting based on all the system constraints and then set the proper clock 
rate using clock fmwk if the divider is exposed as a clock node or let 
the driver convert the final device recommendation using whatever 
register that will adjust the critical clock path rate.

Regards,
Benoit


[1] http://focus.ti.com/pdfs/wtbu/OMAP4430_ES2.x_DM_Public_Book_vC.pdf

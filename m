From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: Common clock and dvfs
Date: Thu, 05 May 2011 23:08:22 +0200
Message-ID: <4DC311C6.7090707@ti.com>
References: <4DC07F10.6010305@ti.com>	<4DC230E0.7090909@ti.com> <BANLkTi=gP80iiJTECUoc+36z_1J68ALJNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57279 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753152Ab1EEVJF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 May 2011 17:09:05 -0400
In-Reply-To: <BANLkTi=gP80iiJTECUoc+36z_1J68ALJNA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Turquette, Mike" <mturquette@ti.com>, Thomas Gleixner <tglx@linutronix.de>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Mark Brown <broonie@sirena.org.uk>, Paul Walmsley <paul@pwsan.com>

On 5/5/2011 8:11 AM, Colin Cross wrote:
> On Wed, May 4, 2011 at 10:08 PM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> (Cc folks with some DVFS interest)
>>
>> Hi Colin,
>>
>> On Fri, 22 Apr 2011, Colin Cross wrote:
>>>
>>> Now that we are approaching a common clock management implementation,
>>> I was thinking it might be the right place to put a common dvfs
>>> implementation as well.
>>>
>>> It is very common for SoC manufacturers to provide a table of the
>>> minimum voltage required on a voltage rail for a clock to run at a
>>> given frequency.  There may be multiple clocks in a voltage rail that
>>> each can specify their own minimum voltage, and one clock may affect
>>> multiple voltage rails.  I have seen two ways to handle keeping the
>>> clocks and voltages within spec:
>>>
>>> The Tegra way is to put everything dvfs related under the clock
>>> framework.  Enabling (or preparing, in the new clock world) or raising
>>> the frequency calls dvfs_set_rate before touching the clock, which
>>> looks up the required voltage on a voltage rail, aggregates it with
>>> the other voltage requests, and passes the minimum voltage required to
>>> the regulator api.  Disabling or unpreparing, or lowering the
>>> frequency changes the clock first, and then calls dvfs_set_rate.  For
>>> a generic implementation, an SoC would provide the clock/dvfs
>>> framework with a list of clocks, the voltages required for each
>>> frequency step on the clock, and the regulator name to change.  The
>>> frequency/voltage tables are similar to OPP, except that OPP gets
>>> voltages for a device instead of a clock.  In a few odd cases (Tegra
>>> always has a few odd cases), a clock that is internal to a device and
>>> not exposed to the clock framework (pclk output on the display, for
>>> example) has a voltage requirement, which requires some devices to
>>> manually call dvfs_set_rate directly, but with a common clock
>>> framework it would probably be possible for the display driver to
>>> export pclk as a real clock.
>>
>> Those kinds of exceptions are somehow the rules for an OMAP4 device. Most
>> scalable devices are using some internal dividers or even internal PLL to
>> control the scalable clock rate (DSS, HSI, MMC, McBSP... the OMAP4430 Data
>> Manual [1] is providing the various clock rate limitation depending of the
>> OPP).
>> And none of these internal dividers are handled by the clock fmwk today.
>>
>> For sure, it should be possible to extend the clock data with internal
>> devices clock nodes (like the UART baud rate divider for example), but then
>> we will have to handle a bunch of nodes that may not be always available
>> depending of device state. In order to do that, you have to tie these clocks
>> node to the device that contains them.
>
> I agree there are cases where the clock framework may not be a fit for
> a specific divider, but it would be simple to export the same
> dvfs_set_rate functions that the generic clk_set_rate calls, and allow
> drivers that need to scale their own clocks to take advantage of the
> common tables.
>
>> And for the clocks that do not belong to any device, like most PRCM source
>> clocks or DPLL inside OMAP, we can easily define a PRCM device or several CM
>> (Clock Manager) devices that will handle all these clock nodes.
>>
>>> The proposed OMAP4 way (I believe, correct me if I am wrong) is to
>>> create a new api outside the clock api that calls into both the clock
>>> api and the regulator api in the correct order for each operation,
>>> using OPP to determine the voltage.  This has a few disadvantages
>>> (obviously, I am biased, having written the Tegra code) - clocks and
>>> voltages are tied to a device, which is not always the case for
>>> platforms outside of OMAP, and drivers must know if their hardware
>>> requires voltage scaling.  The clock api becomes unsafe to use on any
>>> device that requires dvfs, as it could change the frequency higher
>>> than the supported voltage.
>>
>> You have to tie clock and voltage to a device. Most of the time a clock does
>> not have any clear relation with a voltage domain. It can even cross power /
>> voltage domain without any issue.
>> The efficiency of the DVFS technique is mainly due to the reduction of the
>> voltage rail that supply a device. In order to achieve that you have to
>> reduce the clock rate of one or several clocks nodes that supply the
>> critical path inside the HW.
>
> A clock crossing a voltage domain is not a problem, a single clock can
> have relationships to multiple regulators.  But a clock does not need
> to be tied to a device.  From the silicon perspective, it doesn't
> matter how you divide up the devices in the kernel, a clock is just a
> line toggling at a rate, and the maximum speed it can toggle is
> determined by the silicon it feeds and the voltage that silicon is
> operating at.  If a device can be turned on or off, that's a clock
> gate, and the line downstream from the clock gate is a separate clock.

Fully agree.

Just to clarify the terminology, I'm using device to represent the IP 
block as well. The mapping is not necessarily one to one, but for most 
relevant IPs this is mostly true. In our case, the hwmod will represent 
the HW device.

My point is that a Soc with just clocks and voltage domains will be 
pretty useless.
We do have as well a bunch of IPs that are represented by devices, and 
these IPs are the relevant piece of HW we have to managed.

Clocks and voltages are just some resources needed by an IP to work 
properly.
Hence the importance of the device.

>> The clock node itself does not know anything about the device and that's why
>> it should not be the proper structure to do DVFS.
>
> One of us is confused here.  The clock node does not know about the
> device, and it doesn't need to.  All the clock needs to know is that
> the manufacturer has specified that for a single node to toggle at
> some rate, a voltage rail must be set some minimum voltage.  The
> devices are irrelevant.

The manufacturer will specify the IP (represented by a device) 
characteristics in term of voltage rails, clock input, IRQ...
This is all about the IP, the clock is just a parameter.

The clock itself even tied with a voltage domain is of no use if not 
connected to an IP.

The DSP DPLL that belongs to the IVA voltage domain can probably run up 
to 2 GHz at 1.1v without any issue.
As soon as you connect that clock to the DSP... suddenly you cannot run 
the DPLL anymore at that rate. You have to reduce it to 400MHz.
The constraint is purely due the the IP connected to that clock.

Imagine now a new release of the SoC (ES2.0 for Ex) with an updated DSP 
block that can run at 500MHz... Same clock tree, same voltage domain 
partitioning but because of the new IP version, you can run faster...

What piece of HW is really relevant in that change? It is neither the 
clock nor the voltage domain. It is only the device that have to update 
its requirement toward its resources suppliers.

> Imagine a chip where a clock can feed devices A, B, and C.  If the
> devices are always clocked at the same rate, and can't gate their
> clocks, the minimum voltage that can be applied to a rail is
> determined ONLY by the rate of the clock.
> If device A can be disabled, with its clock gated, then the devices no
> longer share a clock.  Device A is controlled by clock 1, and devices
> B and C are controlled by clock 2, where clock 2 is the parent of
> clock 1, and clock 1 is just a "clock gate" building block from the
> generic clock code.  If clock 1 is enabled, both clock 1 and clock 2
> apply their own, independent minimum voltage requirements on a
> regulator.

As previously explained, a clock node cannot have any voltage 
requirement toward a voltage domain. It will depend of the devices 
supplied by this clock node. Only the HW device can have frequency 
requirement and voltage requirement according to its HW characteristics.

> If clock 1 is disabled, only the voltage requirement of
> clock 2 is applied.  No knowledge of the device is required, only the
> voltage requirement for the toggling rate at each node, and each node
> can be 0, 1, or more devices.
>
>> OMAP moved away from using the clock nodes to represent IP blocks because
>> the clock abstraction was not enough to represent the way an IP is
>> interacting with clocks. That's why omap_hwmod was introduced to represent
>> an IP block.
>
> omap_hwmod is entirely omap specific, and any generic solution cannot
> be based on it.

For the moment, because it is a fairly new design, but nothing should 
prevent us to make it generic if this abstraction is relevant for other SoC.

>>> Is the clock api the right place to do dvfs, or should the clock api
>>> be kept simple, and more complicated operations like dvfs be kept
>>> outside?
>>
>> In term of SW layering, so far we have the clock fmwk and the regulator
>> fmwk. Since DVFS is about both clock and voltage scaling, it makes more
>> sense to me to handle DVFS on top of both existing fmwks. Let stick to the
>> "do one thing and do it well" principle instead of hacking an existing fmwk
>> with what I consider to be an unrelated functionality.
>
> There are two reasons I hate putting DVFS above the clock framework.
>
> First, it breaks existing users of the clock api.  Any driver that
> calls the clock api directly risks raising the frequency above the
> silicon specs.  Instead, you introduce a new api, something like
> dvfs_set_rate(struct device, frequency), which takes the same
> arguments as the clock api, except a device instead of a clock, which
> I have already argued against.  If needs the same arguments to run,
> and it provides a superset of the functionality, and it is trivial to
> fall back to the old behavior if the clock is not a dvfs clock, why
> does it need a new api?

Because it does not have the same purpose.

And it does not break the user of the clock API. It is even the 
opposite. You are breaking the expectation of the current user of the 
clock API. Adding DVFS under the clock set_rate will completely change 
the behaviour of an existing API.
A set_rate call that use to last a couple of micro second and that was 
atomic will last potentially 10ms because a voltage change sequence will 
be done under the hood. I think this is quite a huge side effect that an 
user of that API might not expect at all.

Just because of that, I think it worth having another API.

>> Moreover, the only exiting DVFS SW on Linux today is CPUFreq, so extending
>> this fmwk to a devfreq kind of fwmk seems a more logical approach to me.
>
> I think this is where we disagree most.  CPUFreq is NOT a DVFS
> implementation.  It is a frequency scaling implementation only.

I don't think we have such a strong disagreement here. I do agree that 
CPUFreq is not a full DFVS implementation.
It is indeed more focused on the governor / decision part.
The interesting part is the CPUFreq driver layer part that is for my 
point of view the missing layer we have between the decision layer and 
the clock / regulator fmwk.

> If it
> happens to scale the voltage, it is only because that is the logical
> place to do it.  Every CPUFreq driver that scales the voltage has to
> look like this:
>
> pick the cpu frequency
> if the frequency is increasing, raise the voltage based on the new frequency
> set the cpu frequency
> if the frequency is decreasing, lower the voltage based on the new frequency
>
> Note that the last 3 lines are a completely generic clock-based
> voltage scaling, and could be moved into the dvfs api under the clock
> api.

Except in the ACPI world... That does not have necessarily a clock fmwk.

>> The important point is that IMO, the device should be the central component
>> of any DVFS implementation. Both clock and voltage are just some device
>> resources that have to change synchronously to reduce the power consumption
>> of the device.
>
> The don't just have to change synchronously, one exactly determines
> the other.

No not necessarily, there is a big difference between the clock / 
voltage you can use based on the actual constraints and the ones you 
actually use.

A set_rate user does expect the rate to be changed or to fail.
A DVFS constraint will be expressed using some kind of set_minimum_rate 
API that will just give the minimum clock frequency value that will 
allow the device to work properly for the expected task.
The real frequency will change based on the various constraint the 
system have. And that can change whenever someone change any constraint 
in the system.
A user might require only 200MHz for the DSP for example, but if at 
least one other device inside the DSP voltage domain does require the 
highest voltage, there is no point reducing the DSP frequency. It is 
much more efficient to run it at 400MHz whenever this is possible.
That's why we do need another API, because the set_rate API is the one 
that will effectively change the frequency.

Most driver / user should use this kind of set_minimum_rate API and not 
the set_rate.
Most of the time they do not care or should not care about the exact 
clock rate. they just have to ensure that the clock will run at the 
sufficient rate to do its work properly.

> Given a table from the manufacturer, and a clock
> frequency, you can always set the voltage rails correctly.

I do agree, my point is just that this should be a HW device related table.

>> Because the clock is not the central piece of the DVFS sequence, I don't
>> think it deserves to handle the whole sequence including voltage  scaling.
>>
>> A change to a clock rate might trigger a voltage change, but the opposite is
>> true as well. A reduction of the voltage could trigger the clock rate change
>> inside all the devices that belong to the voltage domain.
>> Because of that, both fmwks are siblings. This is not a parent-child
>> relationship.
> In what case would you ever trigger a voltage change first?  Devices
> never care about their voltage, they only care about how fast they can
> run.  The only case I can think of is thermal throttling, but could
> just as well be implemented as lowering the clock frequency to allow
> the voltage to drop.

Devices will indeed never care about voltage directly, but that will 
happen indirectly because of:
- voltage domains dependency: Changing the MPU or IVA voltage domain 
might force the CORE voltage to increase its voltage due to HW 
limitation. We cannot have the CPU at 1GHz while the interconnect is at 
the lowest OPP.
- voltage domain increase due to one device frequency increase might 
force the other voltage domain devices to increase their frequency.
- Thermal management might be a good example as well, but in general 
changing the main contributors frequency (MPU, GPU) should be enough.

In both cases, the indirect voltage change will trigger potentially 
frequency change.

vdd1 <--> vdd2
   |         |
   +----+    +----+
   |    |    |    |
devA devB devC devD

With such partitioning, an increase of devA OPP, will increase vdd1 that 
will trigger an increase of vdd2 that will then broadcast to devices 
that belong to it. devC and devD might or not increase their frequency 
to reduce the energy consumption.
Any devices like processors that can run fast and idle must run at the 
max frequency allowed by the current voltage.

>> Another important point is that in order to trigger a DVFS sequence you have
>> to do some voting to take into accountn shared clock and shared voltage
>> domains.
> This is conflating frequency selection with voltage selection.  The
> voltage only depends on the maximum clock that is voted, and the
> voltage is always a minimum voltage, so other clocks in the same
> voltage domain can request a higher voltage, which needs to be handled
> by the regulator api.
>
>> Moreover, playing directly with a clock rate is not necessarily appropriate
>> or sufficient for some devices. For example, the interconnect should expose
>> a BW knob instead of a clock rate one.
>> In general, some more abstract information like BW, latency or performance
>> level (P-state) should be the ones to be exposed at driver level.
> Yes, but again you are conflating frequency selection with voltage
> selection.  BW, latency, and performance are all knobs that will
> determine one or more clock frequencies, but the voltage is determined
> only from those final clock frequencies.

Not I'm not, I do agree with your point. the final frequency will indeed 
allow to chose the proper voltage. I do not have any confusion about that.

My whole point is that the freq <-> voltage dependency is bi-directional 
as explained before, that's why you do need an intermediate layer that 
will select both freq and voltage depending of the various constraints.

> I agree there is a need for
> some sort of governor above the clock api, but that governor generally
> does not need to know voltages.

It is not necessarily a governor but more some kind of QoS at device 
level. Exposing a clock set_rate on a input clock to a driver is, in 
general, not very good since it might make the driver platform 
dependent. Whereas exposing some abstract QoS APIs will avoid a driver 
to use directly a low level clock set_rate API.

> It may be useful to expose power
> numbers for the different clock frequencies to it, so it knows what
> the best clock frequencies to select are based on power vs.
> performance.
>
>> By exposing such knobs, the underlying DVFS fmwk will be able to do voting
>> based on all the system constraints and then set the proper clock rate using
>> clock fmwk if the divider is exposed as a clock node or let the driver
>> convert the final device recommendation using whatever register that will
>> adjust the critical clock path rate.
> Note that you only referred to setting clock registers - the governor
> has no need to directly modify voltages.

You're right, let's rephrase:
...using whatever register that will adjust the critical clock path rate 
and then change the voltage if needed.

I do not have any disagreement with you on that point. A freq change 
might trigger a voltage change. But a voltage change might trigger as 
well a frequency change to another clock.
That's why a parent-child relationship does not seems appropriate here 
for my point of view.


Regards,
Benoit


From: Colin Cross <ccross@google.com>
Subject: Re: Common clock and dvfs
Date: Wed, 4 May 2011 23:11:53 -0700
Message-ID: <BANLkTi=gP80iiJTECUoc+36z_1J68ALJNA@mail.gmail.com>
References: <4DC07F10.6010305@ti.com>
	<4DC230E0.7090909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:57803 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702Ab1EEGL7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 02:11:59 -0400
Received: from wpaz1.hot.corp.google.com (wpaz1.hot.corp.google.com [172.24.198.65])
	by smtp-out.google.com with ESMTP id p456BusT030614
	for <linux-omap@vger.kernel.org>; Wed, 4 May 2011 23:11:56 -0700
Received: from ywo7 (ywo7.prod.google.com [10.192.15.7])
	by wpaz1.hot.corp.google.com with ESMTP id p456Bt8b015040
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Wed, 4 May 2011 23:11:55 -0700
Received: by ywo7 with SMTP id 7so930203ywo.39
        for <linux-omap@vger.kernel.org>; Wed, 04 May 2011 23:11:55 -0700 (PDT)
In-Reply-To: <4DC230E0.7090909@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Turquette, Mike" <mturquette@ti.com>, Thomas Gleixner <tglx@linutronix.de>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Mark Brown <broonie@sirena.org.uk>, Paul Walmsley <paul@pwsan.com>

On Wed, May 4, 2011 at 10:08 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> (Cc folks with some DVFS interest)
>
> Hi Colin,
>
> On Fri, 22 Apr 2011, Colin Cross wrote:
>>
>> Now that we are approaching a common clock management implementation=
,
>> I was thinking it might be the right place to put a common dvfs
>> implementation as well.
>>
>> It is very common for SoC manufacturers to provide a table of the
>> minimum voltage required on a voltage rail for a clock to run at a
>> given frequency. =A0There may be multiple clocks in a voltage rail t=
hat
>> each can specify their own minimum voltage, and one clock may affect
>> multiple voltage rails. =A0I have seen two ways to handle keeping th=
e
>> clocks and voltages within spec:
>>
>> The Tegra way is to put everything dvfs related under the clock
>> framework. =A0Enabling (or preparing, in the new clock world) or rai=
sing
>> the frequency calls dvfs_set_rate before touching the clock, which
>> looks up the required voltage on a voltage rail, aggregates it with
>> the other voltage requests, and passes the minimum voltage required =
to
>> the regulator api. =A0Disabling or unpreparing, or lowering the
>> frequency changes the clock first, and then calls dvfs_set_rate. =A0=
=46or
>> a generic implementation, an SoC would provide the clock/dvfs
>> framework with a list of clocks, the voltages required for each
>> frequency step on the clock, and the regulator name to change. =A0Th=
e
>> frequency/voltage tables are similar to OPP, except that OPP gets
>> voltages for a device instead of a clock. =A0In a few odd cases (Teg=
ra
>> always has a few odd cases), a clock that is internal to a device an=
d
>> not exposed to the clock framework (pclk output on the display, for
>> example) has a voltage requirement, which requires some devices to
>> manually call dvfs_set_rate directly, but with a common clock
>> framework it would probably be possible for the display driver to
>> export pclk as a real clock.
>
> Those kinds of exceptions are somehow the rules for an OMAP4 device. =
Most
> scalable devices are using some internal dividers or even internal PL=
L to
> control the scalable clock rate (DSS, HSI, MMC, McBSP... the OMAP4430=
 Data
> Manual [1] is providing the various clock rate limitation depending o=
f the
> OPP).
> And none of these internal dividers are handled by the clock fmwk tod=
ay.
>
> For sure, it should be possible to extend the clock data with interna=
l
> devices clock nodes (like the UART baud rate divider for example), bu=
t then
> we will have to handle a bunch of nodes that may not be always availa=
ble
> depending of device state. In order to do that, you have to tie these=
 clocks
> node to the device that contains them.

I agree there are cases where the clock framework may not be a fit for
a specific divider, but it would be simple to export the same
dvfs_set_rate functions that the generic clk_set_rate calls, and allow
drivers that need to scale their own clocks to take advantage of the
common tables.

> And for the clocks that do not belong to any device, like most PRCM s=
ource
> clocks or DPLL inside OMAP, we can easily define a PRCM device or sev=
eral CM
> (Clock Manager) devices that will handle all these clock nodes.
>
>> The proposed OMAP4 way (I believe, correct me if I am wrong) is to
>> create a new api outside the clock api that calls into both the cloc=
k
>> api and the regulator api in the correct order for each operation,
>> using OPP to determine the voltage. =A0This has a few disadvantages
>> (obviously, I am biased, having written the Tegra code) - clocks and
>> voltages are tied to a device, which is not always the case for
>> platforms outside of OMAP, and drivers must know if their hardware
>> requires voltage scaling. =A0The clock api becomes unsafe to use on =
any
>> device that requires dvfs, as it could change the frequency higher
>> than the supported voltage.
>
> You have to tie clock and voltage to a device. Most of the time a clo=
ck does
> not have any clear relation with a voltage domain. It can even cross =
power /
> voltage domain without any issue.
> The efficiency of the DVFS technique is mainly due to the reduction o=
f the
> voltage rail that supply a device. In order to achieve that you have =
to
> reduce the clock rate of one or several clocks nodes that supply the
> critical path inside the HW.

A clock crossing a voltage domain is not a problem, a single clock can
have relationships to multiple regulators.  But a clock does not need
to be tied to a device.  From the silicon perspective, it doesn't
matter how you divide up the devices in the kernel, a clock is just a
line toggling at a rate, and the maximum speed it can toggle is
determined by the silicon it feeds and the voltage that silicon is
operating at.  If a device can be turned on or off, that's a clock
gate, and the line downstream from the clock gate is a separate clock.

> The clock node itself does not know anything about the device and tha=
t's why
> it should not be the proper structure to do DVFS.

One of us is confused here.  The clock node does not know about the
device, and it doesn't need to.  All the clock needs to know is that
the manufacturer has specified that for a single node to toggle at
some rate, a voltage rail must be set some minimum voltage.  The
devices are irrelevant.

Imagine a chip where a clock can feed devices A, B, and C.  If the
devices are always clocked at the same rate, and can't gate their
clocks, the minimum voltage that can be applied to a rail is
determined ONLY by the rate of the clock.
If device A can be disabled, with its clock gated, then the devices no
longer share a clock.  Device A is controlled by clock 1, and devices
B and C are controlled by clock 2, where clock 2 is the parent of
clock 1, and clock 1 is just a "clock gate" building block from the
generic clock code.  If clock 1 is enabled, both clock 1 and clock 2
apply their own, independent minimum voltage requirements on a
regulator.  If clock 1 is disabled, only the voltage requirement of
clock 2 is applied.  No knowledge of the device is required, only the
voltage requirement for the toggling rate at each node, and each node
can be 0, 1, or more devices.

> OMAP moved away from using the clock nodes to represent IP blocks bec=
ause
> the clock abstraction was not enough to represent the way an IP is
> interacting with clocks. That's why omap_hwmod was introduced to repr=
esent
> an IP block.

omap_hwmod is entirely omap specific, and any generic solution cannot
be based on it.

>> Is the clock api the right place to do dvfs, or should the clock api
>> be kept simple, and more complicated operations like dvfs be kept
>> outside?
>
> In term of SW layering, so far we have the clock fmwk and the regulat=
or
> fmwk. Since DVFS is about both clock and voltage scaling, it makes mo=
re
> sense to me to handle DVFS on top of both existing fmwks. Let stick t=
o the
> "do one thing and do it well" principle instead of hacking an existin=
g fmwk
> with what I consider to be an unrelated functionality.

There are two reasons I hate putting DVFS above the clock framework.

=46irst, it breaks existing users of the clock api.  Any driver that
calls the clock api directly risks raising the frequency above the
silicon specs.  Instead, you introduce a new api, something like
dvfs_set_rate(struct device, frequency), which takes the same
arguments as the clock api, except a device instead of a clock, which
I have already argued against.  If needs the same arguments to run,
and it provides a superset of the functionality, and it is trivial to
fall back to the old behavior if the clock is not a dvfs clock, why
does it need a new api?

> Moreover, the only exiting DVFS SW on Linux today is CPUFreq, so exte=
nding
> this fmwk to a devfreq kind of fwmk seems a more logical approach to =
me.

I think this is where we disagree most.  CPUFreq is NOT a DVFS
implementation.  It is a frequency scaling implementation only.  If it
happens to scale the voltage, it is only because that is the logical
place to do it.  Every CPUFreq driver that scales the voltage has to
look like this:

pick the cpu frequency
if the frequency is increasing, raise the voltage based on the new freq=
uency
set the cpu frequency
if the frequency is decreasing, lower the voltage based on the new freq=
uency

Note that the last 3 lines are a completely generic clock-based
voltage scaling, and could be moved into the dvfs api under the clock
api.

> The important point is that IMO, the device should be the central com=
ponent
> of any DVFS implementation. Both clock and voltage are just some devi=
ce
> resources that have to change synchronously to reduce the power consu=
mption
> of the device.

The don't just have to change synchronously, one exactly determines
the other.  Given a table from the manufacturer, and a clock
frequency, you can always set the voltage rails correctly.

> Because the clock is not the central piece of the DVFS sequence, I do=
n't
> think it deserves to handle the whole sequence including voltage =A0s=
caling.
>
> A change to a clock rate might trigger a voltage change, but the oppo=
site is
> true as well. A reduction of the voltage could trigger the clock rate=
 change
> inside all the devices that belong to the voltage domain.
> Because of that, both fmwks are siblings. This is not a parent-child
> relationship.
In what case would you ever trigger a voltage change first?  Devices
never care about their voltage, they only care about how fast they can
run.  The only case I can think of is thermal throttling, but could
just as well be implemented as lowering the clock frequency to allow
the voltage to drop.

> Another important point is that in order to trigger a DVFS sequence y=
ou have
> to do some voting to take into account shared clock and shared voltag=
e
> domains.
This is conflating frequency selection with voltage selection.  The
voltage only depends on the maximum clock that is voted, and the
voltage is always a minimum voltage, so other clocks in the same
voltage domain can request a higher voltage, which needs to be handled
by the regulator api.

> Moreover, playing directly with a clock rate is not necessarily appro=
priate
> or sufficient for some devices. For example, the interconnect should =
expose
> a BW knob instead of a clock rate one.
> In general, some more abstract information like BW, latency or perfor=
mance
> level (P-state) should be the ones to be exposed at driver level.
Yes, but again you are conflating frequency selection with voltage
selection.  BW, latency, and performance are all knobs that will
determine one or more clock frequencies, but the voltage is determined
only from those final clock frequencies.  I agree there is a need for
some sort of governor above the clock api, but that governor generally
does not need to know voltages.  It may be useful to expose power
numbers for the different clock frequencies to it, so it knows what
the best clock frequencies to select are based on power vs.
performance.

> By exposing such knobs, the underlying DVFS fmwk will be able to do v=
oting
> based on all the system constraints and then set the proper clock rat=
e using
> clock fmwk if the divider is exposed as a clock node or let the drive=
r
> convert the final device recommendation using whatever register that =
will
> adjust the critical clock path rate.
Note that you only referred to setting clock registers - the governor
has no need to directly modify voltages.

> Regards,
> Benoit
>
>
> [1] http://focus.ti.com/pdfs/wtbu/OMAP4430_ES2.x_DM_Public_Book_vC.pd=
f
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

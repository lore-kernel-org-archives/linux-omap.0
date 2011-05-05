From: Colin Cross <ccross@google.com>
Subject: Re: Common clock and dvfs
Date: Thu, 5 May 2011 16:15:57 -0700
Message-ID: <BANLkTik+LRWvJzppof1zngdrZEPXzMc_UQ@mail.gmail.com>
References: <4DC07F10.6010305@ti.com>
	<4DC230E0.7090909@ti.com>
	<BANLkTi=gP80iiJTECUoc+36z_1J68ALJNA@mail.gmail.com>
	<4DC311C6.7090707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:47130 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab1EEXQP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 19:16:15 -0400
Received: from kpbe11.cbf.corp.google.com (kpbe11.cbf.corp.google.com [172.25.105.75])
	by smtp-out.google.com with ESMTP id p45NG493001594
	for <linux-omap@vger.kernel.org>; Thu, 5 May 2011 16:16:04 -0700
Received: from gwb1 (gwb1.prod.google.com [10.200.2.1])
	by kpbe11.cbf.corp.google.com with ESMTP id p45NFkC0017760
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Thu, 5 May 2011 16:15:57 -0700
Received: by gwb1 with SMTP id 1so1338033gwb.8
        for <linux-omap@vger.kernel.org>; Thu, 05 May 2011 16:15:57 -0700 (PDT)
In-Reply-To: <4DC311C6.7090707@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Turquette, Mike" <mturquette@ti.com>, Thomas Gleixner <tglx@linutronix.de>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Mark Brown <broonie@sirena.org.uk>, Paul Walmsley <paul@pwsan.com>

On Thu, May 5, 2011 at 2:08 PM, Cousson, Benoit <b-cousson@ti.com> wrot=
e:
> On 5/5/2011 8:11 AM, Colin Cross wrote:
>>
>> On Wed, May 4, 2011 at 10:08 PM, Cousson, Benoit<b-cousson@ti.com> =A0=
wrote:
>>>
>>> (Cc folks with some DVFS interest)
>>>
>>> Hi Colin,
>>>
>>> On Fri, 22 Apr 2011, Colin Cross wrote:
>>>>
>>>> Now that we are approaching a common clock management implementati=
on,
>>>> I was thinking it might be the right place to put a common dvfs
>>>> implementation as well.
>>>>
>>>> It is very common for SoC manufacturers to provide a table of the
>>>> minimum voltage required on a voltage rail for a clock to run at a
>>>> given frequency. =A0There may be multiple clocks in a voltage rail=
 that
>>>> each can specify their own minimum voltage, and one clock may affe=
ct
>>>> multiple voltage rails. =A0I have seen two ways to handle keeping =
the
>>>> clocks and voltages within spec:
>>>>
>>>> The Tegra way is to put everything dvfs related under the clock
>>>> framework. =A0Enabling (or preparing, in the new clock world) or r=
aising
>>>> the frequency calls dvfs_set_rate before touching the clock, which
>>>> looks up the required voltage on a voltage rail, aggregates it wit=
h
>>>> the other voltage requests, and passes the minimum voltage require=
d to
>>>> the regulator api. =A0Disabling or unpreparing, or lowering the
>>>> frequency changes the clock first, and then calls dvfs_set_rate. =A0=
=46or
>>>> a generic implementation, an SoC would provide the clock/dvfs
>>>> framework with a list of clocks, the voltages required for each
>>>> frequency step on the clock, and the regulator name to change. =A0=
The
>>>> frequency/voltage tables are similar to OPP, except that OPP gets
>>>> voltages for a device instead of a clock. =A0In a few odd cases (T=
egra
>>>> always has a few odd cases), a clock that is internal to a device =
and
>>>> not exposed to the clock framework (pclk output on the display, fo=
r
>>>> example) has a voltage requirement, which requires some devices to
>>>> manually call dvfs_set_rate directly, but with a common clock
>>>> framework it would probably be possible for the display driver to
>>>> export pclk as a real clock.
>>>
>>> Those kinds of exceptions are somehow the rules for an OMAP4 device=
=2E Most
>>> scalable devices are using some internal dividers or even internal =
PLL to
>>> control the scalable clock rate (DSS, HSI, MMC, McBSP... the OMAP44=
30
>>> Data
>>> Manual [1] is providing the various clock rate limitation depending=
 of
>>> the
>>> OPP).
>>> And none of these internal dividers are handled by the clock fmwk t=
oday.
>>>
>>> For sure, it should be possible to extend the clock data with inter=
nal
>>> devices clock nodes (like the UART baud rate divider for example), =
but
>>> then
>>> we will have to handle a bunch of nodes that may not be always avai=
lable
>>> depending of device state. In order to do that, you have to tie the=
se
>>> clocks
>>> node to the device that contains them.
>>
>> I agree there are cases where the clock framework may not be a fit f=
or
>> a specific divider, but it would be simple to export the same
>> dvfs_set_rate functions that the generic clk_set_rate calls, and all=
ow
>> drivers that need to scale their own clocks to take advantage of the
>> common tables.
>>
>>> And for the clocks that do not belong to any device, like most PRCM
>>> source
>>> clocks or DPLL inside OMAP, we can easily define a PRCM device or s=
everal
>>> CM
>>> (Clock Manager) devices that will handle all these clock nodes.
>>>
>>>> The proposed OMAP4 way (I believe, correct me if I am wrong) is to
>>>> create a new api outside the clock api that calls into both the cl=
ock
>>>> api and the regulator api in the correct order for each operation,
>>>> using OPP to determine the voltage. =A0This has a few disadvantage=
s
>>>> (obviously, I am biased, having written the Tegra code) - clocks a=
nd
>>>> voltages are tied to a device, which is not always the case for
>>>> platforms outside of OMAP, and drivers must know if their hardware
>>>> requires voltage scaling. =A0The clock api becomes unsafe to use o=
n any
>>>> device that requires dvfs, as it could change the frequency higher
>>>> than the supported voltage.
>>>
>>> You have to tie clock and voltage to a device. Most of the time a c=
lock
>>> does
>>> not have any clear relation with a voltage domain. It can even cros=
s
>>> power /
>>> voltage domain without any issue.
>>> The efficiency of the DVFS technique is mainly due to the reduction=
 of
>>> the
>>> voltage rail that supply a device. In order to achieve that you hav=
e to
>>> reduce the clock rate of one or several clocks nodes that supply th=
e
>>> critical path inside the HW.
>>
>> A clock crossing a voltage domain is not a problem, a single clock c=
an
>> have relationships to multiple regulators. =A0But a clock does not n=
eed
>> to be tied to a device. =A0From the silicon perspective, it doesn't
>> matter how you divide up the devices in the kernel, a clock is just =
a
>> line toggling at a rate, and the maximum speed it can toggle is
>> determined by the silicon it feeds and the voltage that silicon is
>> operating at. =A0If a device can be turned on or off, that's a clock
>> gate, and the line downstream from the clock gate is a separate cloc=
k.
>
> Fully agree.
>
> Just to clarify the terminology, I'm using device to represent the IP=
 block
> as well. The mapping is not necessarily one to one, but for most rele=
vant
> IPs this is mostly true. In our case, the hwmod will represent the HW
> device.
Lets be clearer.  "struct device" means the kernel's view of a single
device, and "IP block" means a piece of silicon, and avoid "device"
completely.

> My point is that a Soc with just clocks and voltage domains will be p=
retty
> useless.
> We do have as well a bunch of IPs that are represented by devices, an=
d these
> IPs are the relevant piece of HW we have to managed.
>
> Clocks and voltages are just some resources needed by an IP to work
> properly.
> Hence the importance of the device.
I agree that an IP block needs a clock, but I disagree that (in most
cases), an IP block needs a voltage directly.  In 99% of cases, the
voltage is relevant to all the silicon connected to a clock node, and
not to a specific IP block.

>>> The clock node itself does not know anything about the device and t=
hat's
>>> why
>>> it should not be the proper structure to do DVFS.
>>
>> One of us is confused here. =A0The clock node does not know about th=
e
>> device, and it doesn't need to. =A0All the clock needs to know is th=
at
>> the manufacturer has specified that for a single node to toggle at
>> some rate, a voltage rail must be set some minimum voltage. =A0The
>> devices are irrelevant.
>
> The manufacturer will specify the IP (represented by a device)
> characteristics in term of voltage rails, clock input, IRQ...
> This is all about the IP, the clock is just a parameter.
No, TI may specify the voltage and clock input for a device, but
nVidia specifies a clock node and a voltage.  One is going to need to
be converted to the other.

> The clock itself even tied with a voltage domain is of no use if not
> connected to an IP.
Clocks are always tied to IP - that's what clk_get(struct device *,
const char *con_id) is for.

> The DSP DPLL that belongs to the IVA voltage domain can probably run =
up to 2
> GHz at 1.1v without any issue.
> As soon as you connect that clock to the DSP... suddenly you cannot r=
un the
> DPLL anymore at that rate. You have to reduce it to 400MHz.
> The constraint is purely due the the IP connected to that clock.

I think we have another terminology issue.  A two wires in the silicon
are only the same "clock node" if they always toggle at the same rate.
 If one wire can be disabled while the other one is enabled (the DSP
clock and the DPLL, in your example), they are not the same node.  The
DSP clock is a child of the DPLL clock.

Maintaining the relationships between multiple clocks is clearly
necessary, but voltages are irrelevant in your example.  It doesn't
matter that the DPLL can run really fast, the constraint is that the
DSP clock is limiting it.  This would have to be handled by "devfreq",
but devfreq would set the DPLL to 400 MHz, and DVFS would lower its
constraint on the IVA voltage.

> Imagine now a new release of the SoC (ES2.0 for Ex) with an updated D=
SP
> block that can run at 500MHz... Same clock tree, same voltage domain
> partitioning but because of the new IP version, you can run faster...
>
> What piece of HW is really relevant in that change? It is neither the=
 clock
> nor the voltage domain. It is only the device that have to update its
> requirement toward its resources suppliers.
I agree, and devfreq will need to have knowledge of struct devices,
but, once again, voltage is irrelevant here.

>> Imagine a chip where a clock can feed devices A, B, and C. =A0If the
>> devices are always clocked at the same rate, and can't gate their
>> clocks, the minimum voltage that can be applied to a rail is
>> determined ONLY by the rate of the clock.
>> If device A can be disabled, with its clock gated, then the devices =
no
>> longer share a clock. =A0Device A is controlled by clock 1, and devi=
ces
>> B and C are controlled by clock 2, where clock 2 is the parent of
>> clock 1, and clock 1 is just a "clock gate" building block from the
>> generic clock code. =A0If clock 1 is enabled, both clock 1 and clock=
 2
>> apply their own, independent minimum voltage requirements on a
>> regulator.
>
> As previously explained, a clock node cannot have any voltage require=
ment
> toward a voltage domain. It will depend of the devices supplied by th=
is
> clock node. Only the HW device can have frequency requirement and vol=
tage
> requirement according to its HW characteristics.
I think this disagreement is related to our conflicting definitions of
clock node.  The PLL that feeds multiple IP blocks is one clock node,
which may have no voltage constraints at all.  Each IP block that is
connected to the PLL has it's own clock gates (in the PRCM, for OMAP),
so each IP block has its own clock node, represented by a struct clk
whose parent is the struct clk of the PLL, and each of those clock
nodes may have voltage constraints.  Note that there is no mention of
"struct device" - those IP blocks may not have a struct device.  A
cpufreq driver has no struct device, but it could have a struct clk *,
and want the voltage to scale when it updates that clock.

>> If clock 1 is disabled, only the voltage requirement of
>> clock 2 is applied. =A0No knowledge of the device is required, only =
the
>> voltage requirement for the toggling rate at each node, and each nod=
e
>> can be 0, 1, or more devices.
>>
>>> OMAP moved away from using the clock nodes to represent IP blocks b=
ecause
>>> the clock abstraction was not enough to represent the way an IP is
>>> interacting with clocks. That's why omap_hwmod was introduced to
>>> represent
>>> an IP block.
>>
>> omap_hwmod is entirely omap specific, and any generic solution canno=
t
>> be based on it.
>
> For the moment, because it is a fairly new design, but nothing should
> prevent us to make it generic if this abstraction is relevant for oth=
er SoC.

That's not how you design abstractions.  You can't abstract one case,
without considering other SoCs, and then make it generic if it fits
other SoCs - it will never fit other SoCs.  You have to consider all
the cases you want it to cover, and design an abstraction that makes
sense for the superset.  OPP is an example of what happens when you
design a generic API based off a TI TRM - you end up with something
that is irrelevant to half the other SoCs.

>>>> Is the clock api the right place to do dvfs, or should the clock a=
pi
>>>> be kept simple, and more complicated operations like dvfs be kept
>>>> outside?
>>>
>>> In term of SW layering, so far we have the clock fmwk and the regul=
ator
>>> fmwk. Since DVFS is about both clock and voltage scaling, it makes =
more
>>> sense to me to handle DVFS on top of both existing fmwks. Let stick=
 to
>>> the
>>> "do one thing and do it well" principle instead of hacking an exist=
ing
>>> fmwk
>>> with what I consider to be an unrelated functionality.
>>
>> There are two reasons I hate putting DVFS above the clock framework.
>>
>> First, it breaks existing users of the clock api. =A0Any driver that
>> calls the clock api directly risks raising the frequency above the
>> silicon specs. =A0Instead, you introduce a new api, something like
>> dvfs_set_rate(struct device, frequency), which takes the same
>> arguments as the clock api, except a device instead of a clock, whic=
h
>> I have already argued against. =A0If needs the same arguments to run=
,
>> and it provides a superset of the functionality, and it is trivial t=
o
>> fall back to the old behavior if the clock is not a dvfs clock, why
>> does it need a new api?
>
> Because it does not have the same purpose.
>
> And it does not break the user of the clock API. It is even the oppos=
ite.
> You are breaking the expectation of the current user of the clock API=
=2E
> Adding DVFS under the clock set_rate will completely change the behav=
iour of
> an existing API.
> A set_rate call that use to last a couple of micro second and that wa=
s
> atomic will last potentially 10ms because a voltage change sequence w=
ill be
> done under the hood. I think this is quite a huge side effect that an=
 user
> of that API might not expect at all.
Not true.  It has recently been clarified that clk_set_rate is a
sleepable call, and it is likely that future calls to clk_set_rate in
a generic implementation will take a global or semi-global mutex.

> Just because of that, I think it worth having another API.
What happens when a common driver, something like EHCI, or an 8250
driver, calls clk_enable?  If the clock, or one of its parents, has a
voltage constraint, it gets undefined behavior when it operates the
silicon out of spec.  You are requiring every call to clk_* from a
driver that is shared across SoCs to be updated to use dvfs_*, and
dvfs_* to be implemented on every SoC that uses those drivers.  And
your new API takes the exact same arguments as the old api - some sort
of token, and a frequency.

>>> Moreover, the only exiting DVFS SW on Linux today is CPUFreq, so
>>> extending
>>> this fmwk to a devfreq kind of fwmk seems a more logical approach t=
o me.
>>
>> I think this is where we disagree most. =A0CPUFreq is NOT a DVFS
>> implementation. =A0It is a frequency scaling implementation only.
>
> I don't think we have such a strong disagreement here. I do agree tha=
t
> CPUFreq is not a full DFVS implementation.
> It is indeed more focused on the governor / decision part.
> The interesting part is the CPUFreq driver layer part that is for my =
point
> of view the missing layer we have between the decision layer and the =
clock /
> regulator fmwk.
>
>> If it
>> happens to scale the voltage, it is only because that is the logical
>> place to do it. =A0Every CPUFreq driver that scales the voltage has =
to
>> look like this:
>>
>> pick the cpu frequency
>> if the frequency is increasing, raise the voltage based on the new
>> frequency
>> set the cpu frequency
>> if the frequency is decreasing, lower the voltage based on the new
>> frequency
>>
>> Note that the last 3 lines are a completely generic clock-based
>> voltage scaling, and could be moved into the dvfs api under the cloc=
k
>> api.
>
> Except in the ACPI world... That does not have necessarily a clock fm=
wk.
If it doesn't have a clock framework, how is it relevant to this discus=
sion?

>>> The important point is that IMO, the device should be the central
>>> component
>>> of any DVFS implementation. Both clock and voltage are just some de=
vice
>>> resources that have to change synchronously to reduce the power
>>> consumption
>>> of the device.
>>
>> The don't just have to change synchronously, one exactly determines
>> the other.
>
> No not necessarily, there is a big difference between the clock / vol=
tage
> you can use based on the actual constraints and the ones you actually=
 use.
Agree - and devices need to be able to specify constraints on the
minimum frequency, and some sort of governor needs to decide what the
best frequency is to use.  That's a perfectly reasonable job for
devfreq.

> A set_rate user does expect the rate to be changed or to fail.
> A DVFS constraint will be expressed using some kind of set_minimum_ra=
te API
> that will just give the minimum clock frequency value that will allow=
 the
> device to work properly for the expected task.
> The real frequency will change based on the various constraint the sy=
stem
> have. And that can change whenever someone change any constraint in t=
he
> system.
> A user might require only 200MHz for the DSP for example, but if at l=
east
> one other device inside the DSP voltage domain does require the highe=
st
> voltage, there is no point reducing the DSP frequency. It is much mor=
e
> efficient to run it at 400MHz whenever this is possible.
> That's why we do need another API, because the set_rate API is the on=
e that
> will effectively change the frequency.
>
> Most driver / user should use this kind of set_minimum_rate API and n=
ot the
> set_rate.
> Most of the time they do not care or should not care about the exact =
clock
> rate. they just have to ensure that the clock will run at the suffici=
ent
> rate to do its work properly.
>
>> Given a table from the manufacturer, and a clock
>> frequency, you can always set the voltage rails correctly.
>
> I do agree, my point is just that this should be a HW device related =
table.
A constraint in TI land may always be on an IP block (i assume that's
what you mean by HW device), but it could also be a constraint on a
cluster of IP blocks, or it could be a constraint on an IP block that
doesn't have a struct device, for example the CPU.  So you can't use
struct device as the token you use to look up in the table.

>>> Because the clock is not the central piece of the DVFS sequence, I =
don't
>>> think it deserves to handle the whole sequence including voltage
>>> =A0scaling.
>>>
>>> A change to a clock rate might trigger a voltage change, but the op=
posite
>>> is
>>> true as well. A reduction of the voltage could trigger the clock ra=
te
>>> change
>>> inside all the devices that belong to the voltage domain.
>>> Because of that, both fmwks are siblings. This is not a parent-chil=
d
>>> relationship.
>>
>> In what case would you ever trigger a voltage change first? =A0Devic=
es
>> never care about their voltage, they only care about how fast they c=
an
>> run. =A0The only case I can think of is thermal throttling, but coul=
d
>> just as well be implemented as lowering the clock frequency to allow
>> the voltage to drop.
>
> Devices will indeed never care about voltage directly, but that will =
happen
> indirectly because of:
> - voltage domains dependency: Changing the MPU or IVA voltage domain =
might
> force the CORE voltage to increase its voltage due to HW limitation. =
We
> cannot have the CPU at 1GHz while the interconnect is at the lowest O=
PP.
> - voltage domain increase due to one device frequency increase might =
force
> the other voltage domain devices to increase their frequency.
> - Thermal management might be a good example as well, but in general
> changing the main contributors frequency (MPU, GPU) should be enough.
>
> In both cases, the indirect voltage change will trigger potentially
> frequency change.
>
> vdd1 <--> vdd2
> =A0| =A0 =A0 =A0 =A0 |
> =A0+----+ =A0 =A0+----+
> =A0| =A0 =A0| =A0 =A0| =A0 =A0|
> devA devB devC devD
>
> With such partitioning, an increase of devA OPP, will increase vdd1 t=
hat
> will trigger an increase of vdd2 that will then broadcast to devices =
that
> belong to it. devC and devD might or not increase their frequency to =
reduce
> the energy consumption.
> Any devices like processors that can run fast and idle must run at th=
e max
> frequency allowed by the current voltage.
This is a good point, and its a tough problem to solve.  Do you have
any numbers on the power savings here?  In some cases it may be
beneficial, but if you have to disable auto idle on the IP blocks for
any reason (HW bug, etc), you end up wasting power.

I think you can still implement this with devfreq and the half of OPP
I don't dislike.  Your example starts and ends with a clock, but
passes through voltages.  Why not take the voltages out of the
equation, and simplify TI's OPP table to: CPU frequency 1GHz, set
minimum GPU frequency high.

You could also implement this by having devfreq register notifiers
with the regulator API - when the voltage increases on a regulator,
increase the rates of the clocks that can benefit from the higher
voltage.  On the surface, this seems like duplicating code, but with
the right exports from the dvfs api, devfreq could easily query the
best voltage to use without duplicating the voltage table.  The end
result is that the decision making is split - the decision on the
voltage to use for the clock, which is a hard requirement of the
silicon, is made based on the clock, but the decision on the best
clock to use for the voltage, which is an optimization, is made at a
higher level by devfreq.  The biggest advantage of this split is that
all the existing APIs continue to work - setting a clock with
clk_set_rate will get the right voltage, setting a voltage directly
with regulator_set_voltage will trigger a clock frequency increase.

Until a case appears that requires increasing clock frequencies based
on a voltage change that was not triggered by another clock, I don't
think the complexity of the regulator notifier solution is necessary,
and OPPs would be trivial to use for now.

>>> Another important point is that in order to trigger a DVFS sequence=
 you
>>> have
>>> to do some voting to take into accountn shared clock and shared vol=
tage
>>> domains.
>>
>> This is conflating frequency selection with voltage selection. =A0Th=
e
>> voltage only depends on the maximum clock that is voted, and the
>> voltage is always a minimum voltage, so other clocks in the same
>> voltage domain can request a higher voltage, which needs to be handl=
ed
>> by the regulator api.
>>
>>> Moreover, playing directly with a clock rate is not necessarily
>>> appropriate
>>> or sufficient for some devices. For example, the interconnect shoul=
d
>>> expose
>>> a BW knob instead of a clock rate one.
>>> In general, some more abstract information like BW, latency or
>>> performance
>>> level (P-state) should be the ones to be exposed at driver level.
>>
>> Yes, but again you are conflating frequency selection with voltage
>> selection. =A0BW, latency, and performance are all knobs that will
>> determine one or more clock frequencies, but the voltage is determin=
ed
>> only from those final clock frequencies.
>
> Not I'm not, I do agree with your point. the final frequency will ind=
eed
> allow to chose the proper voltage. I do not have any confusion about =
that.
>
> My whole point is that the freq <-> voltage dependency is bi-directio=
nal as
> explained before, that's why you do need an intermediate layer that w=
ill
> select both freq and voltage depending of the various constraints.
OK, I see your point on the bidirectional relationship.  But I don't
think it is a symmetric bidirectional relationship - one direction is
a requirement for correct operation, the other is an optimization, and
an optimization that will not apply equally to all platforms.

>> I agree there is a need for
>> some sort of governor above the clock api, but that governor general=
ly
>> does not need to know voltages.
>
> It is not necessarily a governor but more some kind of QoS at device =
level.
> Exposing a clock set_rate on a input clock to a driver is, in general=
, not
> very good since it might make the driver platform dependent. Whereas
> exposing some abstract QoS APIs will avoid a driver to use directly a=
 low
> level clock set_rate API.
Yes - a perfect job for devfreq.

>> It may be useful to expose power
>> numbers for the different clock frequencies to it, so it knows what
>> the best clock frequencies to select are based on power vs.
>> performance.
>>
>>> By exposing such knobs, the underlying DVFS fmwk will be able to do
>>> voting
>>> based on all the system constraints and then set the proper clock r=
ate
>>> using
>>> clock fmwk if the divider is exposed as a clock node or let the dri=
ver
>>> convert the final device recommendation using whatever register tha=
t will
>>> adjust the critical clock path rate.
>>
>> Note that you only referred to setting clock registers - the governo=
r
>> has no need to directly modify voltages.
>
> You're right, let's rephrase:
> ...using whatever register that will adjust the critical clock path r=
ate and
> then change the voltage if needed.
>
> I do not have any disagreement with you on that point. A freq change =
might
> trigger a voltage change. But a voltage change might trigger as well =
a
> frequency change to another clock.
> That's why a parent-child relationship does not seems appropriate her=
e for
> my point of view.
>
>
> Regards,
> Benoit
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

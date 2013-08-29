From: Vaibhav Bedia <vaibhav.bedia@gmail.com>
Subject: Re: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Thu, 29 Aug 2013 16:09:40 -0400
Message-ID: <CANacCWzK1w9+XKEoUfS4ZB7QGxi_0JkVWBLs_wsaUjrzW2QB+A@mail.gmail.com>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
	<1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
	<CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
	<87txiasqhk.fsf@linaro.org>
	<CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
	<87ppsw7cgq.fsf@linaro.org>
	<CA+Bv8XbxV=BFjcSsUMX2pz9LeCkSwrjzZmj_=YbHGzyfbLXmaQ@mail.gmail.com>
	<874na8xqfl.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:45570 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756570Ab3H2UJm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 16:09:42 -0400
In-Reply-To: <874na8xqfl.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Russ Dill <Russ.Dill@ti.com>, devicetree@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mark Brown <broonie@kernel.org>, =?ISO-8859-1?Q?Jan_L=FCbbe?= <jlu@pengutronix.de>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Thu, Aug 29, 2013 at 3:11 PM, Kevin Hilman <khilman@linaro.org> wrote:
[...]

First of all, apologies for jumping in here. Now that i am not
actively involved in
AM335x/AM437x stuff i wasn't actively following all the discussion here.

Looking at the lists now i just wanted to mention a few things so that we can
agree on the approach to be taken here.

>>>>>
>>>>> So, why/how was the decision made to use the M3 instead of the MPU
>>>>> running from SRAM?
>>>>>
>>>>> As a firmware minimalist, I obviously prefer to do this from the MPU
>>>>> side.  But also, because the M3 is reset every suspend sequence, this
>>>>> becomes rather heavy to do from the M3.
>>>>
>>>> After the feedback Vaibhav Bedia received on v2 of his suspend/resume
>>>> patchset for am335x, he decided to move many of the operations from
>>>> sleep33xx.S into the M3 firmware.
>>>>
>>>> See the commit message here:
>>>> http://arago-project.org/git/projects/?p=am33x-cm3.git;a=commit;h=a972ce2f6
>>>
>>> Was this feedback on the public lists?  That patch has never been posted
>>> to linux-omap AFAICT.
>>>
>>>> I need to wait until after the PLLs are put into bypass, which is now
>>>> done in the M3 firmware. It also ends up being a lot easier to write
>>>> the I2C writer code there in C rather than in assembly in sleep33xx.S.
>>>
>>> hmm, (carefully) written functions in C can still be copied to SRAM.  I
>>> dont' see that as an obstacle.
>>>
>>>>> Currently voltage scaling is only being proposed for suspend in this
>>>>> series, but in theory it's possible from idle as well.  Doing this from
>>>>> the MPU/SRAM seems much better suited for idle.
>>>>
>>>> The M3 firmware will also handle any cpuidle modes deeper than just
>>>> putting SDRAM into self refresh. This is actually the only way of
>>>> doing things like turning the MPU domain off on am335x.
>>>
>>> Yes, it will have to handle the MPU/interconnect off parts but other
>>> than that, that's the only thing it *has* to do (well, and handle wakeup
>>> from the deep state.)  The rest of the stuff being piled into the M3 is
>>> a result of software/firmware design decisions AFAICT.  As I predicted
>>> when I first saw this SoC design, the firmware is getting bigger and
>>> bigger.  Initially it was argued that it would be tiny, and only handle
>>> the things it had to do.  Now it's growing due to "convenience".  IMO,
>>> this is a bad trend, and one that will make this code more and more
>>> difficult to maintain upstream (assuming that's a goal.)
>>
>> Do you mean upstream as in the firmware upstream, or upstream as in
>> the kernel upstream? Upstream kernel is really easy to maintain
>> because sleep33xx.S just puts the SDRAM into self-refresh.
>
> I mean making the kernel "simple" at the price of more complicated (and
> much less reviewed) firmware code is a bad trend.  I understand the
> desire to move this stuff into firmware and bypass the kernel review
> process, but I predict it will backfire.
>
>> The code to perform these transitions is going to exist, either in
>> kernel or in firmware. If you are looking for this to be maintainable
>> C code that is copied into SRAM, it will need to be built much like a
>> firmware, with it's elf sections being copied into SRAM properly.
>
> You're making it too complicated.  No need for ELF, etc.
>
> So the argument for moving much of the stuff from the kernel (in the
> patch you referenced above) was that the "assembly code is quite big and
> folks have found it hard to review and fixup issues in this dense piece
> of code."  (interestingly, it was moved to firmware where it will see
> even less review, but that's off topic.)
>
> My idea was that if reviewing assembly is the issue, why not carefully
> write a self-contained C function that can be copied to SRAM.  It might
> need a little stub in SRAM to setup the stack etc., but it should be
> quite doable.  That eliminates the problem cited as the reason for the
> move to M3.
>
>> I'm not sure how much it complicates things, but the code needs to be
>> able to run with the MMU on and MMU off. The C code would be a
>> minimalized duplication of much of what is already in
>> mach-omap2. Because you are proposing to split this up between A8 and
>> M3, much of that code would then be duplicated again within the M3
>> firmware.
>>
>> And don't forget that am335x is just the first platform with such a PM scheme.
>
> IMO, all the more reason to handle it in Linux, not in platform-specific firmware.
>
>> Because the M3 firmware already has to manage power domains, hwmods,
>> plls, and clockdomains, adding or removing which ones it handles
>> doesn't really change the size or complexity of the firmware.
>
> No, but it significantly complicates its interaction with Linux, which
> also has to know about all these things already.  IMO, as I've stated
> from the very beginning of this SoC, there should be a very clean split.
> M3 should only handle the minimum, what the MPU simply cannot do
> (MPU/interconnect off, wakeup).  MPU/Linux should handle the rest.
>
>> In fact, because so much of the code is common code, moving this into
>> kernel would just mean making two copies of the firmware with
>> different steps to be run, one for the A8 SRAM, one for the M3.
>
> Maybe I'm getting confused, but the more you talk about the linux and
> the firmware doing the same code, the more I think the firmware is
> (trying) to do too much.  If this is going to be understandable (and
> maintainable), there needs to be a clean split of roles between the MPU
> and the M3.
>

In the past i tried to keep the firmware as minimal as possible and pushed
back all efforts to push unnecessary stuff in there. Like Kevin, i too was of
the opinion that we need to do whatever's possible in the kernel.

Sadly, things just got a point where it made much more sense (technically
as well as non-technically) to just put the low level stuff in the M3.

1. In addition to the Linux support, we have non-OS based code for AM335x
(and AM437x) which in the past just had to duplicate whatever was done
in the Linux. Being a different codebase the non-OS guys have their own
set of challenges and we had to at times sit through and debug issues in
one codebase while the other was working fine. Ideally these things should
never come up but sadly they do and we need to solve them.

We also have people trying to implement this thing on different sort of
OS environments and they also end up debugging the same set of issues.

With only a handful of folks able to spend time debugging issues 'do everything
in Linux and expect others to copy it' model doesn't scale up. Keeping
things in the
firmware with the code available online helps do away with the
'developer scalability'
problem and if one looks at things differently enables code-reuse at
the same time.

Moreover, when the code was finally moved to M3, AFAICT we had validated
all supported combinations (DDR2, DDR3, DDR3 with VTT, DDR3 without VTT
control) that TI hardware guys could throw at us.Yes there could be stupid bugs
lurking in the code since it wasn't reviewed as much as i would have
liked but we
have something which proves the functionality to be used as the base.

2. As has been already been pointed out by Russ, on AM335x this step needs
to be done very late in the suspend process (the last stage actually). On the
next SoC there are other complications related to security which enforce this
step must be done from the M3. So trying to keep it in M3 for both AM335x
and AM437x helps avoid the code churn that will happen if we were to do
this differently on two SoCs which have similar PM architectures.

Morevoer, all the suggestions on how to keep the code in Linux working
around the
complications due to the main memory not being accessible will need to
be replicated
on the non-Linux s/w stacks and that's just make it more difficult for them.

3. Moving this to M3 leaves the option open to try out some crazy stuff for
power optimizations wherein the CORE voltage is lowered even below OPP50.
This is yet to be proved in h/w so one can ignore this for now but yes it's a
possibility.

Regards,
Vaibhav

[1] http://www.ti.com/tool/starterware-sitara

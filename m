From: Vaibhav Bedia <vaibhav.bedia@gmail.com>
Subject: Re: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Fri, 30 Aug 2013 13:57:03 -0400
Message-ID: <CANacCWyvsTFNrpKtzRwGuxMegP=hRUjiDcayMpAjGBOxqV_2JQ@mail.gmail.com>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
	<1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
	<CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
	<87txiasqhk.fsf@linaro.org>
	<CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
	<87ppsw7cgq.fsf@linaro.org>
	<CA+Bv8XbxV=BFjcSsUMX2pz9LeCkSwrjzZmj_=YbHGzyfbLXmaQ@mail.gmail.com>
	<874na8xqfl.fsf@linaro.org>
	<CANacCWzK1w9+XKEoUfS4ZB7QGxi_0JkVWBLs_wsaUjrzW2QB+A@mail.gmail.com>
	<87hae8tc6e.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:52925 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756540Ab3H3R5F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Aug 2013 13:57:05 -0400
In-Reply-To: <87hae8tc6e.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Russ Dill <Russ.Dill@ti.com>, devicetree@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Mark Brown <broonie@kernel.org>, =?ISO-8859-1?Q?Jan_L=FCbbe?= <jlu@pengutronix.de>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On Thu, Aug 29, 2013 at 5:33 PM, Kevin Hilman <khilman@linaro.org> wrote:
[...]
>>>
>>> Maybe I'm getting confused, but the more you talk about the linux and
>>> the firmware doing the same code, the more I think the firmware is
>>> (trying) to do too much.  If this is going to be understandable (and
>>> maintainable), there needs to be a clean split of roles between the MPU
>>> and the M3.
>>>
>>
>> In the past i tried to keep the firmware as minimal as possible and pushed
>> back all efforts to push unnecessary stuff in there. Like Kevin, i too was of
>> the opinion that we need to do whatever's possible in the kernel.
>>
>> Sadly, things just got a point where it made much more sense (technically
>> as well as non-technically) to just put the low level stuff in the M3.
>>
>> 1. In addition to the Linux support, we have non-OS based code for AM335x
>> (and AM437x) which in the past just had to duplicate whatever was done
>> in the Linux. Being a different codebase the non-OS guys have their own
>> set of challenges and we had to at times sit through and debug issues in
>> one codebase while the other was working fine. Ideally these things should
>> never come up but sadly they do and we need to solve them.
>>
>> We also have people trying to implement this thing on different sort of
>> OS environments and they also end up debugging the same set of issues.
>>
>> With only a handful of folks able to spend time debugging issues 'do everything
>> in Linux and expect others to copy it' model doesn't scale up. Keeping
>> things in the
>> firmware with the code available online helps do away with the
>> 'developer scalability'
>> problem and if one looks at things differently enables code-reuse at
>> the same time.
>
> Yes, yes, this is the classic argument for a HAL, and making that case has always
> gone over well in the kernel. ;)
>

If the carefully crafted C code with a bit of linker magic thrown in
works, that's great
but for anyone without the generic Linux code in general and the Linux community
to go to with queries will have a tough time getting it done. TI
non-OS code has been
implemented from scratch and one of the purposes is to keep things as simple
as possible for folks. I know it's all non-technical stuff and most
likely i am a bit
biased but just a different POV from someone who spent hours debugging
'this works
and that doesn't' kind of issues. Trying to wrap your head around
random s/w stacks
and figuring out what needs to be changed is not pretty IMHO :\

>> Moreover, when the code was finally moved to M3, AFAICT we had validated
>> all supported combinations (DDR2, DDR3, DDR3 with VTT, DDR3 without VTT
>> control) that TI hardware guys could throw at us.Yes there could be stupid bugs
>> lurking in the code since it wasn't reviewed as much as i would have
>> liked but we
>> have something which proves the functionality to be used as the base.
>
> I don't follow the argument here.  You mean it was validated *before*
> moving it to the M3, or after?  Either way, I'm how that makes a case
> for moving it to the M3.  Surely if it was on the MPU, it would also
> have been validated, no?
>

At least i did all the validation without the VDD_CORE changes. The point i was
trying to make is that we are not trying to hide bugs in there, if
that's one of the
concerns. Just trying to make it simple (subjective, i know) for others to use.

>> 2. As has been already been pointed out by Russ, on AM335x this step needs
>> to be done very late in the suspend process (the last stage
>> actually).
>
> late, yes.  But *technically*, it can still be done from the MPU.
>
>> On the next SoC there are other complications related to security
>> which enforce this step must be done from the M3.
>
> Aha!  So far, the first technical reason I've seen.  Can you elaborate?
> Exactly which step has to be done from the M3, and why can't the MPU do
> it?  And could it be done more simply by putting *only* the parts needed
> on the M3 and not letting it snowball into a pile of stuff?
>

Sent out another mail for this.

Regards,
Vaibhav

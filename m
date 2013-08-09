From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCHv3 8/9] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Fri, 09 Aug 2013 09:12:55 -0700
Message-ID: <87wqnu9720.fsf@kernel.org>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<1375811376-49985-9-git-send-email-d-gerlach@ti.com>
	<CA+Bv8XbK+=pvG+bbvfCtS2Rtg-YoAhuUbWjSro9m4xWjw=Cr8A@mail.gmail.com>
	<52038E88.2050604@ti.com> <5203B336.90102@ti.com>
	<5203C211.7040207@ti.com> <87iozfga1t.fsf@kernel.org>
	<52040E67.4050402@ti.com> <87pptndbtj.fsf@kernel.org>
	<520506B6.7060806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:37923 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933942Ab3HIQM7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Aug 2013 12:12:59 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so732891pdj.4
        for <linux-omap@vger.kernel.org>; Fri, 09 Aug 2013 09:12:58 -0700 (PDT)
In-Reply-To: <520506B6.7060806@ti.com> (Nishanth Menon's message of "Fri, 9
	Aug 2013 10:11:50 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russ Dill <russ.dill@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Tony Lingren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>

Nishanth Menon <nm@ti.com> writes:

> On 08/08/2013 06:04 PM, Kevin Hilman wrote:
>> Nishanth Menon <nm@ti.com> writes:
>>
>>> On 08/08/2013 04:14 PM, Kevin Hilman wrote:
>>>> Dave Gerlach <d-gerlach@ti.com> writes:
>>>>
>>>>> On 08/08/2013 10:03 AM, Santosh Shilimkar wrote:
>>>>>> $subject and patch don't match.
>>>>>>
>>>>>> On Thursday 08 August 2013 08:26 AM, Nishanth Menon wrote:
>>>>>>> On 08/08/2013 03:45 AM, Russ Dill wrote:
>>>>>>>>      In reference to
>>>>>>>> the M3 handling it, the M3 wouldn't know which devices have a driver
>>>>>>>> bound and which don't.
>>>>>>> Does it need to? M3 firmware can pretty much define "I will force
>>>>>>> the device into low power state, and if the drivers dont handle
>>>>>>> things properly, fix the darned driver". M3 behavior should be
>>>>>>> considered as a "hardware" as far as Linux running on MPU is
>>>>>>> concerned, and firmware helps change the behavior by accounting for
>>>>>>> SoC quirks. *if* we have ability to handle this in the firmware,
>>>>>>> there is no need to carry this in Linux.
>>>>>>>
>>>>>> I agree with Nishant. I don't like this patch and IIRC, I gave same
>>>>>> comment in the last version. Linux need not know about all such firmware
>>>>>> quirks. Also all these M3 specific stuff, should be done somewhere
>>>>>> else. Probably having a small M3 driver won't be a bad idea.
>>>>>
>>>>> I am not opposed to doing it this way and letting the M3 firmware
>>>>> handle idling these modules, however the one concern raised in the
>>>>> last series is that an approach that does not acknowledge drivers will
>>>>> hide driver PM bugs. I suppose as long as I make sure to document that
>>>>> the devices are being idled by the M3 firmware this may not be an
>>>>> issue. I will look into implementing this.
>>>>
>>>> No, please don't start idling devices in firmware that are otherwise
>>>> managed by Linux.  Keep the firmware simple and dumb.  Linux is managing
>>>> these devices, it should manage their bugs too.
>>>
>>>>
>>>> This is not just about idling devices.  This is about handling broken IP
>>>> blocks whose power-on reset state does not allow the the powerdomain to
>>>> reach its target state.  That's just bad hardware design.
>>>
>>> Right, this is where M3 can help -> provide a consistent state for
>>> linux kernel to work with. by the fact that we want to keep majority
>>> of the power code inside master CPU, we are just letting M3 help us
>>> with nothing major at all..
>>
>> heh, I would say HW design bugs like this are more than "nothing major
>> at all." :)
>>
>>> tiny stuff like these can help "fix" the hardware design quirks by
>>> hiding it behind the firmware and modifying the hardware behavior.
>>
>> I disagree here.  I'm a firmware minimalist, and hiding bugs like this
>> in the firmware is wrong when Linux is otherwise managing these devices.
>> It also imposes criteria on the firmware of future SoCs that doesn't
>> belong there either.  IMO, the only stuff the firmware should do is what
>> Linux *cannot* do.
>>
>> Remember, this only needs to happen when there isn't a driver for these
>> devices.  Should we communicate to the firmware that the OS has no
>> driver, so please enable the hack?  I think not.
>
> My view is that the M3 should *ignore* the presence/existence of MPU's
> drivers. M3 will do whatever to force the system to go to suspend once
> notified - this saves us the prehistoric perpetual trouble when
> drivers have bugs (which get exposed in weird usage scenarios) in
> production systems, we dont get any hardware help to fix them up while
> attempting low power states and system never really hits low power
> state. This was always because OMAP and it's derivatives have been
> "democratic" in power management - if every hardware block achieves
> proper state, then we achieve a system-wide low power state.
>
>>
>>> I know it breaks the purity of role, but as the
>>> next evolution, we might want to consider M3 something like an
>>> "accelerator" for power management activity.. (not saying it is that
>>> fast.. but conceptually).
>>
>> Yes, it breaks the purity of role, and makes it hard to maintain and
>> extend to future SoCs.  As a maintainer, that's a red flag.  IMO, the
>> roles need to be kept clear.  The M3 manages some devices and the
>> interconnect that MPU/Linux cannot, the rest are managed by Linux.
>
> suspend is a very controlled state as against cpuidle where driver
> knowledge is necessary and in fact mandatory. drivers are supposed to
> release their resources - and even though we test the hell out of
> them, we do have paths untrodden when it comes to production systems.

Since folks don't seem to care about idle for AM33xx (starting with the
hw designers, from what I can tell), you have the luxury of thinking
only about suspend, where firmware can be heavy handed and force things
into submission.  Unfortunately, with cpuidle, life is not that easy and
you have to have cooperation of the device drivers.  Coordinating that
with firmware is not so simple, to put it mildly.

Any SW/firmware design that does not account for *both* static PM
(suspend/resume) and dynamic PM (runtime PM + CPUidle) is not long-term
maintainable, and thus ready for mainline IMO.  (BTW, this is another
theme from previous reviews of this series.)

> I think the insight we have about the hardware make us(linux folks)
> want to own the decision making process on the master MPU - I mean,
> *nobody*(including me) wants to trust a "firmware" - that word is
> almost synonymous with "unspeakable horror".
>
> If on the other hand, we had a non-programmable hardware which would
> force all systems to achieve off mode (imagine having a PRCM which was
> really capable of doing it), we would have probably not had to deal
> with those pesky "stuck-in-transition" and other variants of issues
> (where MPU went to low power state, but core refused to go down -
> resulting in 200mA+ power instead of the <1mA we expected to see).
>
> I consider M3 to power management similar to what Neon is to ARM. I
> mean, I would even love a PMIC which is completely reprogrammable
> (where I could define the registers in s/w)!
>
> My personal thought is that (if possible):
> a) we should try to make the source firmware visible to everyone who
> has a stake on it.
> b) If (a) is possible, then we should see how we can consider M3 as an
> extension to Linux power strategy, rather than a "necessary burden" to
> carry around.
>
> In this particular case. (a) is done see [1]. So, why not (b)? A
> synergy does not necessarily mean "purity of role" is broken. it is
> just another way of doing the job.
>
> While, I personally dont think [1] is public enough, we can try to
> work through those current constraints to ensure everything is
> synergistic.
>
> in other words, this is not a "Graphics" or "Multimedia" or even few
> "BIOS" kind of "hidden firmware you cannot do anything about" scenario
> - 
> here, *we* have the choice.
>
> [1] http://arago-project.org/git/projects/?p=am33x-cm3.git;a=summary
>>
>>>> That being said, IMO, the kernel (specifically omap_device) should
>>>> handle this, and it should be rather easy to do in the omap_device layer
>>>> and keep the SoC suspend/resume core code simple and ignorant of these
>>>> "quirks."
>>>>
>>>> AFAICT, there's no reason these quirks need to be dealt with immediatly
>>>> on suspend.  A slight delay should be fine, as long as it's before the
>>>> next suspend/idle attempt, right?
>>>>
>>>> Given that, what we need to do (and by we, I mean you) is to flag all
>>>> broken IP blocks, and let omap_device handle them in a suspend/resume
>>>> notifier (c.f. register_pm_notifier() and PM_POST_SUSPEND.)
>>>
>>> yes - that is the alternate that comes to mind.
>>
>> In the earlier reviews of this series (many months ago now), I
>> complained about the presence of this device specific handling in the
>> core MPU PM code.  I'm somewhat troubled by the fact that nobody explored
>> alternatives that so easily come to mind.
>
> Just spoke to Dave in person a few mins back, and he is going to go
> through all the previous mail chains and attempt to be thorough again
> - 
> seems like going through a written list of pending actions completely
> missed many key aspects of prior reviews :). Apologies on this.

Thanks.

Since he's inherited this series Dave gets a get out of jail free
card... this time.  Next time, I expect I might be grumpier.

Kevin

From: Russ Dill <russ.dill@gmail.com>
Subject: Re: [PATCHv3 8/9] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Fri, 9 Aug 2013 15:28:37 -0700
Message-ID: <CA+Bv8XabqNkQzjD93kQZvjdozxjAntNRkY3uCOv0n05UzJ=Zug@mail.gmail.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<1375811376-49985-9-git-send-email-d-gerlach@ti.com>
	<CA+Bv8XbK+=pvG+bbvfCtS2Rtg-YoAhuUbWjSro9m4xWjw=Cr8A@mail.gmail.com>
	<52038E88.2050604@ti.com>
	<5203B336.90102@ti.com>
	<5203C211.7040207@ti.com>
	<87iozfga1t.fsf@kernel.org>
	<52040E67.4050402@ti.com>
	<87pptndbtj.fsf@kernel.org>
	<520506B6.7060806@ti.com>
	<87wqnu9720.fsf@kernel.org>
	<52051A9B.1060606@ti.com>
	<87bo5661sv.fsf@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43]:47504 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031336Ab3HIW2i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Aug 2013 18:28:38 -0400
Received: by mail-qe0-f43.google.com with SMTP id k5so2621999qej.2
        for <linux-omap@vger.kernel.org>; Fri, 09 Aug 2013 15:28:37 -0700 (PDT)
In-Reply-To: <87bo5661sv.fsf@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Tony Lingren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>

On Fri, Aug 9, 2013 at 1:34 PM, Kevin Hilman <khilman@linaro.org> wrote:
> Nishanth Menon <nm@ti.com> writes:
>
>> On 08/09/2013 11:12 AM, Kevin Hilman wrote:
>>> Nishanth Menon <nm@ti.com> writes:
>>>
>>>> On 08/08/2013 06:04 PM, Kevin Hilman wrote:
>>>>> Nishanth Menon <nm@ti.com> writes:
>>>>>
>>>>>> On 08/08/2013 04:14 PM, Kevin Hilman wrote:
>>>>>>> Dave Gerlach <d-gerlach@ti.com> writes:
>>>>>>>
>>>>>>>> On 08/08/2013 10:03 AM, Santosh Shilimkar wrote:
>>>>>>>>> $subject and patch don't match.
>>>>>>>>>
>>>>>>>>> On Thursday 08 August 2013 08:26 AM, Nishanth Menon wrote:
>>>>>>>>>> On 08/08/2013 03:45 AM, Russ Dill wrote:
>>>>>>>>>>>       In reference to
>>>>>>>>>>> the M3 handling it, the M3 wouldn't know which devices have a driver
>>>>>>>>>>> bound and which don't.
>>>>>>>>>> Does it need to? M3 firmware can pretty much define "I will force
>>>>>>>>>> the device into low power state, and if the drivers dont handle
>>>>>>>>>> things properly, fix the darned driver". M3 behavior should be
>>>>>>>>>> considered as a "hardware" as far as Linux running on MPU is
>>>>>>>>>> concerned, and firmware helps change the behavior by accounting for
>>>>>>>>>> SoC quirks. *if* we have ability to handle this in the firmware,
>>>>>>>>>> there is no need to carry this in Linux.
>>>>>>>>>>
>>>>>>>>> I agree with Nishant. I don't like this patch and IIRC, I gave same
>>>>>>>>> comment in the last version. Linux need not know about all such firmware
>>>>>>>>> quirks. Also all these M3 specific stuff, should be done somewhere
>>>>>>>>> else. Probably having a small M3 driver won't be a bad idea.
>>>>>>>>
>>>>>>>> I am not opposed to doing it this way and letting the M3 firmware
>>>>>>>> handle idling these modules, however the one concern raised in the
>>>>>>>> last series is that an approach that does not acknowledge drivers will
>>>>>>>> hide driver PM bugs. I suppose as long as I make sure to document that
>>>>>>>> the devices are being idled by the M3 firmware this may not be an
>>>>>>>> issue. I will look into implementing this.
>>>>>>>
>>>>>>> No, please don't start idling devices in firmware that are otherwise
>>>>>>> managed by Linux.  Keep the firmware simple and dumb.  Linux is managing
>>>>>>> these devices, it should manage their bugs too.
>>>>>>
>>>>>>>
>>>>>>> This is not just about idling devices.  This is about handling broken IP
>>>>>>> blocks whose power-on reset state does not allow the the powerdomain to
>>>>>>> reach its target state.  That's just bad hardware design.
>>>>>>
>>>>>> Right, this is where M3 can help -> provide a consistent state for
>>>>>> linux kernel to work with. by the fact that we want to keep majority
>>>>>> of the power code inside master CPU, we are just letting M3 help us
>>>>>> with nothing major at all..
>>>>>
>>>>> heh, I would say HW design bugs like this are more than "nothing major
>>>>> at all." :)
>>>>>
>>>>>> tiny stuff like these can help "fix" the hardware design quirks by
>>>>>> hiding it behind the firmware and modifying the hardware behavior.
>>>>>
>>>>> I disagree here.  I'm a firmware minimalist, and hiding bugs like this
>>>>> in the firmware is wrong when Linux is otherwise managing these devices.
>>>>> It also imposes criteria on the firmware of future SoCs that doesn't
>>>>> belong there either.  IMO, the only stuff the firmware should do is what
>>>>> Linux *cannot* do.
>>>>>
>>>>> Remember, this only needs to happen when there isn't a driver for these
>>>>> devices.  Should we communicate to the firmware that the OS has no
>>>>> driver, so please enable the hack?  I think not.
>>>>
>>>> My view is that the M3 should *ignore* the presence/existence of MPU's
>>>> drivers. M3 will do whatever to force the system to go to suspend once
>>>> notified - this saves us the prehistoric perpetual trouble when
>>>> drivers have bugs (which get exposed in weird usage scenarios) in
>>>> production systems, we dont get any hardware help to fix them up while
>>>> attempting low power states and system never really hits low power
>>>> state. This was always because OMAP and it's derivatives have been
>>>> "democratic" in power management - if every hardware block achieves
>>>> proper state, then we achieve a system-wide low power state.
>>>>
>>>>>
>>>>>> I know it breaks the purity of role, but as the
>>>>>> next evolution, we might want to consider M3 something like an
>>>>>> "accelerator" for power management activity.. (not saying it is that
>>>>>> fast.. but conceptually).
>>>>>
>>>>> Yes, it breaks the purity of role, and makes it hard to maintain and
>>>>> extend to future SoCs.  As a maintainer, that's a red flag.  IMO, the
>>>>> roles need to be kept clear.  The M3 manages some devices and the
>>>>> interconnect that MPU/Linux cannot, the rest are managed by Linux.
>>>>
>>>> suspend is a very controlled state as against cpuidle where driver
>>>> knowledge is necessary and in fact mandatory. drivers are supposed to
>>>> release their resources - and even though we test the hell out of
>>>> them, we do have paths untrodden when it comes to production systems.
>>>
>>> Since folks don't seem to care about idle for AM33xx (starting with the
>>> hw designers, from what I can tell), you have the luxury of thinking
>>> only about suspend, where firmware can be heavy handed and force things
>>> into submission.  Unfortunately, with cpuidle, life is not that easy and
>>> you have to have cooperation of the device drivers.  Coordinating that
>>> with firmware is not so simple, to put it mildly.
>>>
>>> Any SW/firmware design that does not account for *both* static PM
>>> (suspend/resume) and dynamic PM (runtime PM + CPUidle) is not long-term
>>> maintainable, and thus ready for mainline IMO.  (BTW, this is another
>>> theme from previous reviews of this series.)
>>
>> I completely agree with you.  But is'nt the specific suspend state we
>> are attempting to achieve on AM335x just tooo expensive latency wise
>> for being even considered for cpuidle?
>>
>> I am sure you recollect the latencies involved in OMAP3 OFF mode Vs
>> OMAP4+ OFF mode - which basically kicked out OFF mode from OMAP4
>> cpuidle C states? - it was practically useless
>>
>> in this *specific* power state we are attempting, we do a bunch of i2c
>> operations, etc, in short something that cannot even be considered for
>> cpuidle.
>>
>> Considering this, we can consider the same only for suspend path -
>> hence allowing firmware to do more here.
>>
>>
>> This does not conflict with cpuidle (which controls MPU) or runtime PM
>> (which kicks in once you have drivers active, but if drivers get
>> active, we dont need to deal with this crap).
>>
>> Dont you think this helps the specific case to move this into firmware
>> rather than into omap_device?
>
> No, I don't.
>
> That means the firmware design is based on several assumptions about
> what Linux can and can't do in idle, and then imposing that on future
> Linux designs as well.  I dont' buy it.
>
> Kevin

I was taking a look at this situation, figuring that the
suspend/resume callbacks in omap_device might be the right place to do
it, and came across this:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=72bb6f9b51c82c820ddef892455a85b115460904

Under what situations would the driver callbacks be present if probe
fails? I'm looking at really_probe in drivers/base/dd.c, and if probe
fails, dev->driver is set to NULL. What was the condition this was
protecting against?

Also, by modifying _od_suspend_noirq, can we force idle unbound omap
device? Would we need a new omap_hwmod flag to check which devices
should be force idled if no driver is bound?

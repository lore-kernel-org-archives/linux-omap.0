From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCHv3 8/9] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Thu, 08 Aug 2013 16:04:08 -0700
Message-ID: <87pptndbtj.fsf@kernel.org>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
	<1375811376-49985-9-git-send-email-d-gerlach@ti.com>
	<CA+Bv8XbK+=pvG+bbvfCtS2Rtg-YoAhuUbWjSro9m4xWjw=Cr8A@mail.gmail.com>
	<52038E88.2050604@ti.com> <5203B336.90102@ti.com>
	<5203C211.7040207@ti.com> <87iozfga1t.fsf@kernel.org>
	<52040E67.4050402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:53866 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966339Ab3HHXEN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Aug 2013 19:04:13 -0400
Received: by mail-pb0-f53.google.com with SMTP id up15so3988910pbc.26
        for <linux-omap@vger.kernel.org>; Thu, 08 Aug 2013 16:04:12 -0700 (PDT)
In-Reply-To: <52040E67.4050402@ti.com> (Nishanth Menon's message of "Thu, 8
	Aug 2013 16:32:23 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russ Dill <russ.dill@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Tony Lingren <tony@atomide.com>, Benoit Cousson <benoit.cousson@linaro.org>

Nishanth Menon <nm@ti.com> writes:

> On 08/08/2013 04:14 PM, Kevin Hilman wrote:
>> Dave Gerlach <d-gerlach@ti.com> writes:
>>
>>> On 08/08/2013 10:03 AM, Santosh Shilimkar wrote:
>>>> $subject and patch don't match.
>>>>
>>>> On Thursday 08 August 2013 08:26 AM, Nishanth Menon wrote:
>>>>> On 08/08/2013 03:45 AM, Russ Dill wrote:
>>>>>>     In reference to
>>>>>> the M3 handling it, the M3 wouldn't know which devices have a driver
>>>>>> bound and which don't.
>>>>> Does it need to? M3 firmware can pretty much define "I will force
>>>>> the device into low power state, and if the drivers dont handle
>>>>> things properly, fix the darned driver". M3 behavior should be
>>>>> considered as a "hardware" as far as Linux running on MPU is
>>>>> concerned, and firmware helps change the behavior by accounting for
>>>>> SoC quirks. *if* we have ability to handle this in the firmware,
>>>>> there is no need to carry this in Linux.
>>>>>
>>>> I agree with Nishant. I don't like this patch and IIRC, I gave same
>>>> comment in the last version. Linux need not know about all such firmware
>>>> quirks. Also all these M3 specific stuff, should be done somewhere
>>>> else. Probably having a small M3 driver won't be a bad idea.
>>>
>>> I am not opposed to doing it this way and letting the M3 firmware
>>> handle idling these modules, however the one concern raised in the
>>> last series is that an approach that does not acknowledge drivers will
>>> hide driver PM bugs. I suppose as long as I make sure to document that
>>> the devices are being idled by the M3 firmware this may not be an
>>> issue. I will look into implementing this.
>>
>> No, please don't start idling devices in firmware that are otherwise
>> managed by Linux.  Keep the firmware simple and dumb.  Linux is managing
>> these devices, it should manage their bugs too.
>
>>
>> This is not just about idling devices.  This is about handling broken IP
>> blocks whose power-on reset state does not allow the the powerdomain to
>> reach its target state.  That's just bad hardware design.
>
> Right, this is where M3 can help -> provide a consistent state for
> linux kernel to work with. by the fact that we want to keep majority
> of the power code inside master CPU, we are just letting M3 help us
> with nothing major at all.. 

heh, I would say HW design bugs like this are more than "nothing major
at all." :)  

> tiny stuff like these can help "fix" the hardware design quirks by
> hiding it behind the firmware and modifying the hardware behavior.

I disagree here.  I'm a firmware minimalist, and hiding bugs like this
in the firmware is wrong when Linux is otherwise managing these devices.
It also imposes criteria on the firmware of future SoCs that doesn't
belong there either.  IMO, the only stuff the firmware should do is what
Linux *cannot* do.

Remember, this only needs to happen when there isn't a driver for these
devices.  Should we communicate to the firmware that the OS has no
driver, so please enable the hack?  I think not.

> I know it breaks the purity of role, but as the
> next evolution, we might want to consider M3 something like an
> "accelerator" for power management activity.. (not saying it is that
> fast.. but conceptually).

Yes, it breaks the purity of role, and makes it hard to maintain and
extend to future SoCs.  As a maintainer, that's a red flag.  IMO, the
roles need to be kept clear.  The M3 manages some devices and the
interconnect that MPU/Linux cannot, the rest are managed by Linux.

>> That being said, IMO, the kernel (specifically omap_device) should
>> handle this, and it should be rather easy to do in the omap_device layer
>> and keep the SoC suspend/resume core code simple and ignorant of these
>> "quirks."
>>
>> AFAICT, there's no reason these quirks need to be dealt with immediatly
>> on suspend.  A slight delay should be fine, as long as it's before the
>> next suspend/idle attempt, right?
>>
>> Given that, what we need to do (and by we, I mean you) is to flag all
>> broken IP blocks, and let omap_device handle them in a suspend/resume
>> notifier (c.f. register_pm_notifier() and PM_POST_SUSPEND.)
>
> yes - that is the alternate that comes to mind.

In the earlier reviews of this series (many months ago now), I
complained about the presence of this device specific handling in the
core MPU PM code.  I'm somewhat troubled by the fact that nobody explored
alternatives that so easily come to mind.

Kevin

From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 4/5] usb: musb: dsps: add support for suspend and resume
Date: Mon, 25 Nov 2013 21:54:56 +0100
Message-ID: <5293B920.30401@gmail.com>
References: <1385408393-19707-1-git-send-email-zonque@gmail.com> <1385408393-19707-5-git-send-email-zonque@gmail.com> <20131125194804.GB18046@saruman.home> <5293AD40.6060607@gmail.com> <20131125200853.GG18046@saruman.home> <5293B28F.9010506@gmail.com> <20131125204641.GM18046@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:54319 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022Ab3KYUy7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 15:54:59 -0500
In-Reply-To: <20131125204641.GM18046@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: bigeasy@linutronix.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de

On 11/25/2013 09:46 PM, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Nov 25, 2013 at 09:26:55PM +0100, Daniel Mack wrote:
>> On 11/25/2013 09:08 PM, Felipe Balbi wrote:
>>> On Mon, Nov 25, 2013 at 09:04:16PM +0100, Daniel Mack wrote:
>>>>>> diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virthub.c
>>>>>> index e977441..24e46c0 100644
>>>>>> --- a/drivers/usb/musb/musb_virthub.c
>>>>>> +++ b/drivers/usb/musb/musb_virthub.c
>>>>>> @@ -109,7 +109,7 @@ void musb_port_suspend(struct musb *musb, bool do_suspend)
>>>>>>  	}
>>>>>>  }
>>>>>>  
>>>>>> -static void musb_port_reset(struct musb *musb, bool do_reset)
>>>>>> +void musb_port_reset(struct musb *musb, bool do_reset)
>>>>>
>>>>> NAK, this should not be called from the glue layers at all. If anything
>>>>> call from musb_core's resume callback. That will only be called after
>>>>> parent's resume has been called anyway.
>>>>
>>>> Given that this driver is successfully used with suspend/resume on other
>>>> platforms without that reset, but it's clearly needed for dsps, I'm
>>>> fairly sure this should be a glue-layer specific thing. Hence the change.
>>>>
>>>> I think it'll break things on other platforms if we unconditionally
>>>> reset the port after resume, but I can't test it. Anyone?
>>>
>>> your original commit log only says "we need to issue port reset" but it
>>> never explains why. It could very well be you just found a device which
>>> needs to be reset when coming out of suspend and it misses a quirk flag ?
>>
>> I think I can really rule that out, as I tested with multiple USB sticks
>> and also tested the same sticks on other embedded platforms.
>>
>>> In any case, those functions should never be called by the glue, if
>>> reset needs to be called, it must be called by musb-hdrc.ko, if you need
>>> a flag, pass a flag but I need a really good explanation in your commit
>>> log of why that's necessary.
>>
>> Well, if I'd only knew exactly why. All these patches are really the
>> result of many days of trial and error, with multiple drivers (musb,
>> cppi41, ...) involved. And as I said - I have no documentation of the
>> musb core itself.
>>
>> So yes, I can do it the other way around and pass a flag, but what I
>> can't provide is a good explanantion why the dsps glue behaves
>> differently here than others. I'm curious myself, and all I know is that
>> with this reset in place, things work as expected on AM33xx.
> 
> ok, then let's pass a flag. Meanwhile I'll try to figure out internally
> why we need that reset.

Well, we don't need a reset, I wasn't quite precise here. What we need
is to manually *de*assert the reset when we resume. Note the 'false'
flag that is passed to musb_port_reset().

> As Alan said, usb-persist should already for a
> bus-reset when resuming, right ?

The explicit un-reset is really needed, otherwise the port will
reenumerate the device, and a previously mounted filesystem will become
invalid of course. The log looks like this in that case:

[   17.045641] PM: resume of devices complete after 166.084 msecs
[   17.056461] PM: Sending message for resetting M3 state machine
[   17.063451] Restarting tasks ... [   17.071767] usb 1-1: USB
disconnect, device number 2
done.
[   17.403402] usb 1-1: new high-speed USB device number 3 using musb-hdrc
[   17.766959] usb 1-1: New USB device found, idVendor=058f, idProduct=6387
[   17.774849] usb 1-1: New USB device strings: Mfr=1, Product=2,
SerialNumber=3



Thanks,
Daniel


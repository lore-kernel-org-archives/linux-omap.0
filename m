From: Tim Nordell <tim.nordell@logicpd.com>
Subject: Re: [RFC 2/5] OMAP: mux: Make low level function private
Date: Sat, 25 Sep 2010 01:48:53 -0500
Message-ID: <i7k5v3$nkc$1@dough.gmane.org>
References: <1285319748-28976-1-git-send-email-b-cousson@ti.com> <1285319748-28976-3-git-send-email-b-cousson@ti.com> <AANLkTikN8M+6Q0cDdp29mnQdtqSwL4Zp5Kpoz8TL+WHu@mail.gmail.com> <4C9D3942.8080600@logicpd.com> <62d32f04402a5bf019e754bd15a70069@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:50690 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752802Ab0IYGsN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 25 Sep 2010 02:48:13 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1OzOYO-0003hN-8w
	for linux-omap@vger.kernel.org; Sat, 25 Sep 2010 08:48:12 +0200
Received: from c-24-118-192-33.hsd1.mn.comcast.net ([24.118.192.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sat, 25 Sep 2010 08:48:12 +0200
Received: from tim.nordell by c-24-118-192-33.hsd1.mn.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sat, 25 Sep 2010 08:48:12 +0200
In-Reply-To: <62d32f04402a5bf019e754bd15a70069@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On 09/24/10 19:07, Anand Gadiyar wrote:
>> -----Original Message-----
>> From: Tim Nordell [mailto:tim.nordell@logicpd.com]
>> Sent: Saturday, September 25, 2010 5:20 AM
>> To: Gadiyar, Anand
>> Cc: Benoit Cousson; linux-omap@vger.kernel.org; Tony
>> Lindgren; Paul Walmsley; Kevin Hilman
>> Subject: Re: [RFC 2/5] OMAP: mux: Make low level function private
>>
>> On 09/24/10 18:09, Gadiyar, Anand wrote:
>>> On Fri, Sep 24, 2010 at 2:45 PM, Benoit Cousson
>> <b-cousson@ti.com>  wrote:
>>>> omap_mux_read / omap_mux_write should not be accessed directly
>>>> outside the mux framework.
>>>> Do we really have use case that require dynamic mux change beside
>>>> GPIO?
>>>>
>>>
>>> Only case I can think of is for any workarounds for issues
>> that turn up.
>>> No such cases exist today on OMAP3 at least, and none are likely to
>>> appear in future (I hope). So your assumption is valid.
>>>
>>
>> We have a use-case here - granted the code currently is a complete hack
>> and not something clean enough for the mainline kernel.
>>
>> We recently rediscovered the USB3320 PHY suspend issue that is in the
>> errata on the OMAP35x platform (Advisory 3.1.1.193) and we came up with
>> a workaround for it (despite the errata saying there isn't any) where
>> essentially we do:
>>
>> 1) Allow the EHCI controller to suspend the PHY as normal
>> 2) Cut the power to the USB host controller using power domains.  This
>> resets the logic states in the USB host controller so that it is usable
>> again.
>> 3) Remux all the pins talking to the PHY into GPIO mode
>> 4) Monitor said pins for changes in status to know when a remote wakeup
>> request occurs
>> 5) Remux pins back to USB PHY mode
>> 6) Reenable power to the USB host controller and reinitialize registers
>
> We've tried this technique before - you still need to re-enumerate after
> the resume, right? So you might as well just power down the PHY and
> you should be able to recover.
>
> Ajay Gupta did a lot of work on this - not sure if this worked well. We
> basically gave up on this interoperability issue and decided to work
> around it in newer silicon. 3630 ES1.1 and later has suspend-resume
> working with the SMSC PHY.

So, currently our patch to our local kernel essentially the downstream 
device is reset-resumed.  We needed to be able to support USB suspend 
with it waking up when a device is plugged into our USB port.  Since we 
allow the PHY to suspend (rather than holding it in reset) and we're 
monitoring the PHY pins via GPIO we can wake up the USB subsystem when 
device is plugged into the system.

It works well enough that the USB subsystem comes up immediately after 
we plug in a device, and that it supports suspension without a device. 
I've even done some tests where I did a remote wakeup with a HID device 
(mouse button clicks) and some of the time the device would end up being 
reenumerated, and sometimes a reset-resume, so our current hack isn't 
perfect, but it does allow what we were mainly aiming for - being able 
to wake up the USB subsystem when a device is plugged in.  That actually 
is working quite well with our current hack.  I should note that our 
hardware has a permanent hub downstream of the USB3320 phy - not sure if 
this makes any difference in terms of the behavior of the PHY and doing 
GPIO against it.

And yes, you're right that newer silicon might work better with the PHY, 
but we also had hardware that was designed with the problematic PHY 
before we were aware of the errata.  Having something that performs the 
minimum functionality we needed is better than nothing.

- Tim


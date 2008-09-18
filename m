From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: OMAP support in mainline?
Date: Thu, 18 Sep 2008 14:24:47 +0300
Message-ID: <20080918112447.GE28615@gandalf.research.nokia.com>
References: <87tzcgi1gv.fsf@nokia.com> <20080916232505.GC25885@atomide.com> <20080917082043.04c94e2d.jarkko.nikula@nokia.com> <200809162255.00918.david-b@pacbell.net> <9934E327-66E0-48DF-9FB6-FFF828E5358B@student.utwente.nl> <5e088bd90809170524s6cfae9b9ye1379f11afb5bb79@mail.gmail.com> <8192948C-751F-4C1C-B382-E381F903CC46@student.utwente.nl> <20080918095537.GD28615@gandalf.research.nokia.com> <DC3E0288-2605-450F-9E54-9B170B7669C9@student.utwente.nl>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:41730 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbYIRLZ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 07:25:27 -0400
Content-Disposition: inline
In-Reply-To: <DC3E0288-2605-450F-9E54-9B170B7669C9@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Koen Kooi <k.kooi@student.utwente.nl>
Cc: felipe.balbi@nokia.com, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Thu, Sep 18, 2008 at 01:16:55PM +0200, ext Koen Kooi wrote:
>
> Op 18 sep 2008, om 11:55 heeft Felipe Balbi het volgende geschreven:
>
>> On Wed, Sep 17, 2008 at 03:23:49PM +0200, ext Koen Kooi wrote:
>>>
>>> Op 17 sep 2008, om 14:24 heeft Steve Sakoman het volgende geschreven:
>>>
>>>> On Wed, Sep 17, 2008 at 12:16 AM, Koen Kooi <k.kooi@student.utwente.nl>
>>>> wrote:
>>>>
>>>>> And they aren't working too well with current l-o git either with MUSB
>>>>> being
>>>>> broken. There's a patch to fix client mode, but host mode still isn't
>>>>> working.
>>>>
>>>> Host mode musb is working just fine on Overo with the "set
>>>> transceiver" patch.  Not sure why you are having trouble with Beagle
>>>> (and can't check since I don't have my Beagle board with me at the
>>>> moment)
>>>
>>> I should clarify: OTG mode with a host cable doesn't work in .27rc, it 
>>> does
>>> work in 2.6.26. I haven't tried specifying pure hostmode, only OTG.
>>> I would try it on the evm as well, but that is having serious irq issues
>>> with .27rc, pressing a key on the keypad triggers an irq overrun, 
>>> ethernet
>>> gives an oops on boot when trying to register and irq etc,etc. 2.6.27 is
>>> looking really, really bad on omap3 at the moment.
>>
>> Yeah, we lost some musb history when it went to mainline. I didn't test
>> this patch yet cuz I've been quite busy at work, but it should make
>> beagle work. Could you tell me if makes it work ?
>>
>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
>> index 9d2dcb1..f7fe91e 100644
>> --- a/drivers/usb/musb/omap2430.c
>> +++ b/drivers/usb/musb/omap2430.c
>> @@ -215,12 +215,14 @@ void musb_platform_set_mode(struct musb *musb, u8 
>> musb_mode)
>>
>> int __init musb_platform_init(struct musb *musb)
>> {
>> +       struct otg_transceiver *xceiv = otg_get_transceiver();
>>        u32 l;
>>
>> #if defined(CONFIG_ARCH_OMAP2430)
>>        omap_cfg_reg(AE5_2430_USB0HS_STP);
>> #endif
>>
>> +       memcpy(musb->xceiv, xceiv, sizeof(*xceiv));
>>        musb_platform_resume(musb);
>>
>>        l = omap_readl(OTG_SYSCONFIG);
>>
>
> That looks like 
> http://gitweb.openembedded.net/?p=org.openembedded.dev.git;a=blob;f=packages/linux/linux-omap/musb-mru-otgfix.diff;h=767858b8b1580ed7cd67d8e7627301600dda111c;hb=d733dd05e030a67dfbf4540fa1a041adccbe4ffc 
> which doesn't work for me :(

I got a report from another beagle user that this patch of mine is helping.
Well, if I have extra time I'll try it out on my 3430sdp and beagle ;-)

> And, no, I'm not going to try omapzoom stuff, I want it working on the 
> canonical linux-omap kernel, not some corporate version with god knows how 
> many hacks.

That was just a suggestion. We're just trying to narrow down the issues.
If it works with omapzoom.org, then we just diff both drivers and get
the fix to l-o as well ;-)

-- 
balbi

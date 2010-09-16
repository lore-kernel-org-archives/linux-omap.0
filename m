From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH] overo twl4030: fix twl4030 IRQ (used for usb otg detection)
Date: Thu, 16 Sep 2010 05:56:52 -0700
Message-ID: <AANLkTi=jyrLHTKSP1UTxNzri2EHvkt8iXT1cW8LKNNM6@mail.gmail.com>
References: <4C90F46D.2020902@artecdesign.ee>
	<AANLkTimG7i72PdjaX-2_EqhJkZBFm==StMJZKkzywCf=@mail.gmail.com>
	<20100916060731.GB3393@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:63893 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581Ab0IPM45 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 08:56:57 -0400
Received: by wyf22 with SMTP id 22so1295130wyf.19
        for <linux-omap@vger.kernel.org>; Thu, 16 Sep 2010 05:56:56 -0700 (PDT)
In-Reply-To: <20100916060731.GB3393@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Anti Sullin <anti.sullin@artecdesign.ee>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>

On Wed, Sep 15, 2010 at 11:07 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Wed, Sep 15, 2010 at 04:28:57PM -0500, Steve Sakoman wrote:
>>
>> On Wed, Sep 15, 2010 at 9:29 AM, Anti Sullin <anti.sullin@artecdesign.ee>
>> wrote:
>>>
>>> I was not getting OTG USB vbus/id pin change interrupts on Gumstix Overo
>>> and the reason was a mis-configured irq. I added some more checks to
>>> avoid
>>> having a non-bootable kernel on boards with bootloaders that have wrong
>>> pinmux.
>>> The changes of twl4030 should be tested on other boards too.
>>>
>>> ---
>>> Gumstix Overo has TPS65950 (TWL4030) IRQ1 connected to GPIO112.
>>
>> I don't think that this change should be made.
>>
>>> From what I understand from my discussions with Gumstix, early
>>
>> versions of the Overo COM used GPIO112 as indicated above.
>>
>> However all fab revisions >=2516 use GPIO0, so the code is correct for
>> current and future versions of Overo COMs (as is the bootloader
>> pinmuxing).
>>
>> In fact, future versions of Overo will use GPIO112 for a revision ID.
>>
>> Not an ideal situation, but I think we should leave things as they are
>> since it matches current and future production.
>>
>> People with older boards will certainly need to use this patch to get
>> vbus/id interrupts.
>
> it would be better to get all boards working. Can't you use
> ATAG_REVISION or system_rev to differentiate the board revisions and
> change gpio number accordingly ??

Agreed.  Gumstix doesn't provide an easy way of determining the layout
revision via software (the boards are marked with the rev number, but
that doesn't do much good!).

I'm investigating methods to figure this out, but haven't yet found
anything reliable.  When I do I'll post a patch.

Steve

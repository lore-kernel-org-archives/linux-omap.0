From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] overo twl4030: fix twl4030 IRQ (used for usb otg
 detection)
Date: Thu, 16 Sep 2010 09:07:31 +0300
Message-ID: <20100916060731.GB3393@legolas.emea.dhcp.ti.com>
References: <4C90F46D.2020902@artecdesign.ee>
 <AANLkTimG7i72PdjaX-2_EqhJkZBFm==StMJZKkzywCf=@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53689 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab0IPGH5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 02:07:57 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimG7i72PdjaX-2_EqhJkZBFm==StMJZKkzywCf=@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: Anti Sullin <anti.sullin@artecdesign.ee>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>

On Wed, Sep 15, 2010 at 04:28:57PM -0500, Steve Sakoman wrote:
>On Wed, Sep 15, 2010 at 9:29 AM, Anti Sullin <anti.sullin@artecdesign.ee> wrote:
>> I was not getting OTG USB vbus/id pin change interrupts on Gumstix Overo
>> and the reason was a mis-configured irq. I added some more checks to avoid
>> having a non-bootable kernel on boards with bootloaders that have wrong pinmux.
>> The changes of twl4030 should be tested on other boards too.
>>
>> ---
>> Gumstix Overo has TPS65950 (TWL4030) IRQ1 connected to GPIO112.
>
>I don't think that this change should be made.
>
>>From what I understand from my discussions with Gumstix, early
>versions of the Overo COM used GPIO112 as indicated above.
>
>However all fab revisions >=2516 use GPIO0, so the code is correct for
>current and future versions of Overo COMs (as is the bootloader
>pinmuxing).
>
>In fact, future versions of Overo will use GPIO112 for a revision ID.
>
>Not an ideal situation, but I think we should leave things as they are
>since it matches current and future production.
>
>People with older boards will certainly need to use this patch to get
>vbus/id interrupts.

it would be better to get all boards working. Can't you use
ATAG_REVISION or system_rev to differentiate the board revisions and
change gpio number accordingly ??

-- 
balbi

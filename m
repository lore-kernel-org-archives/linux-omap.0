From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [GIT PULL] USB patches for next merge window
Date: Tue, 24 May 2011 14:14:37 +0200
Message-ID: <4DDBA12D.1030004@ti.com>
References: <20110518110353.GH13908@legolas.emea.dhcp.ti.com> <20110518114242.GI13908@legolas.emea.dhcp.ti.com> <20110523061346.GD3095@legolas.emea.dhcp.ti.com> <20110523101515.8c47e7a2.jhnikula@gmail.com> <20110523081524.GL3095@legolas.emea.dhcp.ti.com> <20110524085244.GE30799@atomide.com> <20110524100455.GA14371@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39490 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753771Ab1EXMOn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 May 2011 08:14:43 -0400
In-Reply-To: <20110524100455.GA14371@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Jarkko Nikula <jhnikula@gmail.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On 5/24/2011 12:04 PM, Balbi, Felipe wrote:
> Hi,
>
> On Tue, May 24, 2011 at 11:52:45AM +0300, Tony Lindgren wrote:
>> * Felipe Balbi<balbi@ti.com>  [110523 11:11]:
>>> On Mon, May 23, 2011 at 10:15:15AM +0300, Jarkko Nikula wrote:
>>>> On Mon, 23 May 2011 09:14:38 +0300
>>>> Felipe Balbi<balbi@ti.com>  wrote:
>>>>
>>>>> a gentle ping here too. Without this we will have regressions on
>>>>> ehci/ohci as the pm_runtime patches have gone in via Samuel.
>>>>>
>>>> Does this mean that those regressions happened already when those
>>>> patches were made if there is pull request dependency?
>>>
>>> not really, no.
>>>
>>>> Remember bisectability is important. And very important if you are
>>>> bisecting something else but which is dependent on this as then you
>>>> could mark wrong good/bad points or not able to determine.
>>>
>>> True, true... I just wanted to avoid conflicts as much as possible so
>>> arch/arm/*omap*/ goes through Tony, and drivers/mfd/* goes through
>>> Samuel.
>>>
>>> pm_rutime and hwmod conversion aren't really that tightly coupled. As
>>> long as the arch code is in place, we can do pm_runtime at any time. Not
>>> sure if it's true the other way around. But one thing is for sure, if
>>> this pull request isn't taken, then I guess clocks won't enable on
>>> omap-usbhs...
>>
>> Looks like these patches are missing acks from Benoit and Paul?
>> I'd rather not pull them in without the acks. Note that we have
>> a very short merge window this time, so let's see if we can still
>> get them in.
>
> Ok... let's see if they'll Ack the patches which have been floating
> around. [1], [2] and [3] are the patches which need Ack.
>
> [1] http://marc.info/?l=linux-omap&m=130512838504191&w=2
> [2] http://marc.info/?l=linux-omap&m=130512862104681&w=2
> [3] http://marc.info/?l=linux-omap&m=130512812503806&w=2

Considering that:
1) Neither Paul not myself are in Cc of any of these patches
2) the subject start with "arm: omap: usb..."

It will be quite hard (at least for me) to detect patches that require 
my attention.
Throwing a bottle into the sea is probably a much more efficient method 
to ensure people attention :-)

I'll have a look, but after a quick check the OMAP4 hwmod already 
contains some order issue and maybe some naming convention as well.

Regards,
Benoit




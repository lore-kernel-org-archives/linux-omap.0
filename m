From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] ARM: OMAP: USB: fix warning on EHCI PHY reset path
Date: Wed, 09 May 2012 09:25:05 +0300
Message-ID: <4FAA0DC1.40008@compulab.co.il>
References: <Pine.LNX.4.44L0.1205071046350.1602-100000@iolanthe.rowland.org> <4FA8D108.7090004@compulab.co.il> <20120508162436.GA10200@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:35812
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758132Ab2EIGZM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 02:25:12 -0400
In-Reply-To: <20120508162436.GA10200@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, balbi@ti.com, Keshava Munegowda <Keshava_mgowda@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

On 05/08/12 19:24, Greg Kroah-Hartman wrote:
> On Tue, May 08, 2012 at 10:53:44AM +0300, Igor Grinberg wrote:
>> On 05/07/12 17:48, Alan Stern wrote:
>>> On Mon, 7 May 2012, Igor Grinberg wrote:
>>>
>>>> On 05/07/12 17:04, Alan Stern wrote:
>>>>> On Sun, 6 May 2012, Igor Grinberg wrote:
>>>>>
>>>>>> Hi Alan,
>>>>>
>>>>> ...
>>>>>
>>>>>> Sorry, for being jumpy...
>>>>>> Samuel has not answered yet (it has been more then two weeks already)
>>>>>> and I'd like this to go into 3.5.
>>>>>> Also, the dependency patch is already in Linus' tree. It has been merged with
>>>>>> fixes (I thought it will happen only during the merge window...).
>>>>>>
>>>>>> Can you, please take this one?
>>>>>
>>>>> No, I can't, sorry.  It has to be accepted by Greg KH.
>>>>
>>>> Hmm... I don't mind it be that way, but I'd like to understand:
>>>>
>>>> # scripts/get_maintainer.pl -f drivers/usb/host/ehci-omap.c
>>>> Alan Stern <stern@rowland.harvard.edu> (maintainer:USB EHCI DRIVER)
>>>> Felipe Balbi <balbi@ti.com> (maintainer:OMAP USB SUPPORT)
>>>> Greg Kroah-Hartman <gregkh@suse.de> (supporter:USB SUBSYSTEM)
>>>> linux-usb@vger.kernel.org (open list:USB EHCI DRIVER)
>>>> linux-omap@vger.kernel.org (open list:OMAP USB SUPPORT)
>>>> linux-kernel@vger.kernel.org (open list)
>>>>
>>>> This makes you the USB EHCI maintainer, right?
>>>
>>> Right.
>>>
>>>> I just want to understand...
>>>> Do you need also ack from Greg to take something to your tree
>>>> for being applied in the next merge window?
>>>
>>> No.  I don't takes patches at all, and in fact I don't even have a git
>>> directory or a login account at kernel.org.  All my work goes through
>>> Greg; I submit or acknowledge patches and he merges them.
>>
>> Ah, I see. Thanks for the explanation.
>> So currently, I need to do something like this:
>>
>> Greg,
>>
>> This patch has been acked by Alan and Felipe, can you please apply it
>> for the merge window (which is close as I understand from Linus':
>> "We've never been closer to a 3.4 release").
> 
> Ok, but it's fallen out of my email archive (I only keep the past month
> around), so can you please resend it, with Alan and Felipe's acks, so I
> can apply it?

Yep, will shortly do.

Thanks


-- 
Regards,
Igor.

From: Alexander Shishkin <virtuoso@slind.org>
Subject: Re: linux-omap git tree updated to v2.6.32-rc1, important changes,
	please read
Date: Wed, 30 Sep 2009 20:02:44 +0300
Message-ID: <71a0d6ff0909301002k7e56b7falfdc8d5e445487d29@mail.gmail.com>
References: <20090928190404.GE18957@atomide.com>
	 <94a0d4530909291024kcac6b20m727b2908b2a76b88@mail.gmail.com>
	 <20090929182639.GA16865@atomide.com> <4AC37F0E.8010206@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f211.google.com ([209.85.219.211]:46616 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708AbZI3RCm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Sep 2009 13:02:42 -0400
Received: by ewy7 with SMTP id 7so6642370ewy.17
        for <linux-omap@vger.kernel.org>; Wed, 30 Sep 2009 10:02:45 -0700 (PDT)
In-Reply-To: <4AC37F0E.8010206@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

2009/9/30 Roger Quadros <ext-roger.quadros@nokia.com>:
> ext Tony Lindgren wrote:
>>
>> * Felipe Contreras <felipe.contreras@gmail.com> [090929 10:24]:
>>>
>>> On Mon, Sep 28, 2009 at 10:04 PM, Tony Lindgren <tony@atomide.com> wrote:
>>>>
>>>> Hi all,
>>>>
>>>> I've updated our linux-omap tree to v2.6.32-rc1. I've also
>>>> added a branch omap-2.6.31 for the old code.
>>>>
>>>> This time I also nuked the remaining omap legacy code we
>>>> still had lurking around :) The commits at the end of this
>>>> mail describe what I did first as commits, then I merged
>>>> everything to be the same as the mainline v2.6.32-rc1.
>>>>
>>>> So currently the linux-omap master branch is:
>>>>
>>>> v2.6.32-rc1 + omap-fixes + ehci + cbus
>>>>
>>>> The new model is that I'll be resetting the linux-omap master
>>>> branch to mainline at each -rc, then merge in our various
>>>> upstream queues back in again.
>>>
>>> Excellent! I was wondering why this wasn't being done. I certainly
>>> hope linus' 2.6.32 will work on omap right away.
>>
>> Yeah, let's hope Tomi gets in the DSS2 code too.
>>
>>>
>>> Anyway, I haven't been able to make 2.6.31 boot on beagleboard, and
>>> other people report similar issues:
>>> http://www.spinics.net/lists/linux-omap/msg17968.html
>>>
>>> Have you got 2.6.32-rc1 (+fixes) to boot?
>>
>> Hmm, looks like it's musb again. This is what I get on my
>> overo after applying the DEBUG_LL hack from omap-debug branch:
>
> i've just sent a fix for this musb problem. patch is labelled "twl4030: Fix
> boot with twl4030 usb transceiver enabled"

I can't quite locate it in linux-usb archives (or anywhere within
google's reach). Could you sand it here or provide a link?

Regards,
--
Alex

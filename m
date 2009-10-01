From: Alexander Shishkin <virtuoso@slind.org>
Subject: Re: linux-omap git tree updated to v2.6.32-rc1, important changes,
	please read
Date: Thu, 1 Oct 2009 10:58:12 +0300
Message-ID: <71a0d6ff0910010058m6f9f4fc0o70ef0d2020e170b3@mail.gmail.com>
References: <20090928190404.GE18957@atomide.com>
	 <94a0d4530909291024kcac6b20m727b2908b2a76b88@mail.gmail.com>
	 <20090929182639.GA16865@atomide.com> <4AC37F0E.8010206@nokia.com>
	 <71a0d6ff0909301002k7e56b7falfdc8d5e445487d29@mail.gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB030A2741E2@dbde02.ent.ti.com>
	 <20090930173132.GN16865@atomide.com> <4AC45A87.20605@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:14905 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755679AbZJAH6J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 03:58:09 -0400
Received: by ey-out-2122.google.com with SMTP id 4so637089eyf.19
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 00:58:12 -0700 (PDT)
In-Reply-To: <4AC45A87.20605@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, "Gadiyar, Anand" <gadiyar@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

2009/10/1 Roger Quadros <ext-roger.quadros@nokia.com>:
> ext Tony Lindgren wrote:
>>
>> * Gadiyar, Anand <gadiyar@ti.com> [090930 10:05]:
>>>>>>>
>>>>>>> Anyway, I haven't been able to make 2.6.31 boot on beagleboard, and
>>>>>>> other people report similar issues:
>>>>>>> http://www.spinics.net/lists/linux-omap/msg17968.html
>>>>>>>
>>>>>>> Have you got 2.6.32-rc1 (+fixes) to boot?
>>>>>>
>>>>>> Hmm, looks like it's musb again. This is what I get on my
>>>>>> overo after applying the DEBUG_LL hack from omap-debug branch:
>>>>>
>>>>> i've just sent a fix for this musb problem. patch is labelled "twl4030:
>>>>> Fix
>>>>> boot with twl4030 usb transceiver enabled"
>>>>
>>>> I can't quite locate it in linux-usb archives (or anywhere within
>>>> google's reach). Could you sand it here or provide a link?
>>>>
>>> Here you go. Patchwork rocks!
>>>
>>> <http://patchwork.kernel.org/patch/50721/>
>>>
>>
>> Great, thanks. Roger, please send your fix to Samuel for merging.
>>
>> Meanwhile, I'll apply it into fixes-testing while waiting for it
>> to get to mainline via Samuel.
>>
>> Regards,
>>
>> Tony
>
> OK Tony, I'll do that.

It doesn't crash any more, but I fail to get it to work either:
/sys/devices/platform/musb_hdrc/mode always says b_idle no matter what
I do and the host never attempts to enumerate it (I have a g_ether
statically compiled in for a gadget). Hints greatly appreciated.

Regards,
--
Alex

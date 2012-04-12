From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Thu, 12 Apr 2012 13:05:19 -0600
Message-ID: <4F87276F.6070504@mlbassoc.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com> <4F859C5D.3090400@mlbassoc.com> <87hawqt6vt.fsf@ti.com> <4F86B227.90802@mlbassoc.com> <87aa2hjavi.fsf@ti.com> <4F86F4B2.3080101@mlbassoc.com> <87aa2ganwj.fsf@ti.com> <4F870C6D.3030203@mlbassoc.com> <877gxk962e.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([64.234.241.98]:53902 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144Ab2DLTFX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Apr 2012 15:05:23 -0400
In-Reply-To: <877gxk962e.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>

On 2012-04-12 12:08, Kevin Hilman wrote:
> Gary Thomas<gary@mlbassoc.com>  writes:
>
>> On 2012-04-12 10:57, Kevin Hilman wrote:
>>> +Felipe for EHCI question
>>>
>>> Gary Thomas<gary@mlbassoc.com>   writes:
>>>
>>> [...]
>>>
>>>> This worked a treat, thanks.  My network performance is better
>>>> now, but still not what it was.  The same TFTP transfer now takes
>>>> 71 seconds, so about 50% slower than on the 3.0 kernel.  Applying the
>>>> second [unnamed] patch (arch/arm/mach-omap2/cpuidle34xx.c) made no difference.
>>>
>>> And does a CONFIG_PM=n kernel get you back to your v3.0 performance?
>>
>> Correct.
>>
>
> OK, I just tried your TFTP experiment on a 3530/Overo board with the
> same smsc911x NIC that has GPIO interrupts, and I don't see much
> difference between a PM-enabled v3.0 and a PM-enabled v3.3.
>
> Are you TFTP'ing the file to an MMC filesystem?    Can you try to a
> ramdisk[1]?  If you're using MMC, it could be MMC driver changes since
> v3.0 that are actually causing your performance hit.

I'm testing to a ramdisk, so we're on the same page.

Could you send me your config file so I can compare?  Maybe I have something
"dumb" in my settings that aggravates things.

Also, what's your performance on 3.4-rc2?  The linux-media tree I started
from is a bit post v3.3, so there might be something else causing this.

>
> In my experiment, I TFTP'd a 24Mb file to a ramdisk, to make sure no
> other drivers were invovled, and didn't see any major differences
> between v3.0, v3.3, and v3.3 CONFIG_PM disabled.
>
> Below are my results.  As you can see, all the results seem to be pretty
> close to the same.  This test was not on a controlled, isolated network,
> so the differences are probably explained by other network activity:
>
> - v3.0 vanilla: PM enabled, CPUidle enabled
>    - Received 25362406 bytes in 35.5 seconds
>    - Received 25362406 bytes in 44.9 seconds
>    - Received 25362406 bytes in 49.0 seconds
>    - Received 25362406 bytes in 36.2 seconds
>    - Received 25362406 bytes in 56.3 seconds
>    - Received 25362406 bytes in 65.2 seconds
>    - Received 25362406 bytes in 37.0 seconds
>
> - v3.3: PM enabled, CPUidle enabled
>   + GPIO fix (my for_3.4/fixes/gpio branch)
>   + smsc911x regulator boot fix (Tony's omap/fix-smsc911x-regulator branch)
>    - Received 25362406 bytes in 32.1 seconds
>    - Received 25362406 bytes in 29.8 seconds
>    - Received 25362406 bytes in 33.5 seconds
>    - Received 25362406 bytes in 44.5 seconds
>    - Received 25362406 bytes in 39.2 seconds
>    - Received 25362406 bytes in 57.0 seconds
>    - Received 25362406 bytes in 49.6 seconds
>
> - v3.3: CONFIG_PM=n + branches above
>   + fix from Grazvydas for !CONFIG_PM case: [PATCH] ARM: OMAP: sram: fix BUG in dpll code for !PM case
>   + disable CONFIG_OMAP_WATCHDOG which fails to boot when CONFIG_PM=y
>    - Received 25362406 bytes in 34.1 seconds
>    - Received 25362406 bytes in 33.9 seconds
>    - Received 25362406 bytes in 34.9 seconds
>    - Received 25362406 bytes in 37.8 seconds
>    - Received 25362406 bytes in 40.0 seconds
>    - Received 25362406 bytes in 37.6 seconds
>    - Received 25362406 bytes in 34.4 seconds
>
>
> Kevin
>
> [1] simple steps to make a ramdisk
> mkfs.ext2 /dev/ram0
> mkdir /tmp/rd
> mount /dev/ram0 /tmp/rd
> cd /tmp/rd
> <then TFTP file here>

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

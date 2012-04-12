From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Thu, 12 Apr 2012 09:28:50 -0600
Message-ID: <4F86F4B2.3080101@mlbassoc.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com> <4F859C5D.3090400@mlbassoc.com> <87hawqt6vt.fsf@ti.com> <4F86B227.90802@mlbassoc.com> <87aa2hjavi.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([64.234.241.98]:50382 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934343Ab2DLP3H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Apr 2012 11:29:07 -0400
In-Reply-To: <87aa2hjavi.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On 2012-04-12 08:14, Kevin Hilman wrote:
> Gary Thomas<gary@mlbassoc.com>  writes:
>
>> On 2012-04-11 13:17, Kevin Hilman wrote:
>>> Gary Thomas<gary@mlbassoc.com>   writes:
>>>
>>> [...]
>>>
>>>> I fear I'm seeing similar problems with 3.3.  I have my board (similar
>>>> to the BeagleBoard) ported to 3.0 and 3.3.  I'm seeing terrible network
>>>> performance on 3.3.  For example, if I use TFTP to download a large file
>>>> (~35MB), I get this:
>>>>     3.0:  42.5 sec
>>>>     3.3: 625.0 sec
>>>> That's a factor of 15 worse!
>>>
>>> This might not be the same problem.  What is the NIC being used, and
>>> does it have GPIO interrupts?
>>
>> My board uses SMSC911x with GPIO interrupt signal.
>
> OK, then your problem is almost certainly solved by my GPIO triggering
> fix, and not related to Grazvytas' problem.
>
>>>
>>> If it's using GPIO interrupts, then you likely need this patch from
>>> mainline (v3.4-rc1)
>>
>> I tried to just pick up the patch you [sort of] quoted below, but had
>> a hard time applying it to my kernel. I've tried to just pick up the
>> latest files from the mainline kernel, but so far I've nothing that
>> builds
>
> Oh, right.  Sorry about that.  Yeah, that patch actually has
> dependencies on other GPIO changes that were queued for v3.4 (and not in
> v3.3.)
>
> If you're on v3.3, just pull the branch below[1] which is based on
> v3.3-rc2.  Pulling that into a v3.3 should build just fine.
>
> Kevin
>
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/fixes/gpio

This worked a treat, thanks.  My network performance is better
now, but still not what it was.  The same TFTP transfer now takes
71 seconds, so about 50% slower than on the 3.0 kernel.  Applying the
second [unnamed] patch (arch/arm/mach-omap2/cpuidle34xx.c) made no difference.

I am interested in having PM working as I'm designing a battery powered
portable unit, so I need to keep pursuing this.

Note: I noticed that when I built with CONFIG_PM off and no other
changes, my EHCI USB didn't work properly.  Should this be the case?

Thanks again for your help


-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

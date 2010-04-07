From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: linux-omap-pm troubles on Gumstix Overo
Date: Wed, 07 Apr 2010 15:01:50 -0700
Message-ID: <87ochuapm9.fsf@deeprootsystems.com>
References: <4BBBF808.80000@gmail.com> <87tyrnfe8c.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f193.google.com ([209.85.222.193]:59472 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755960Ab0DGWBy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 18:01:54 -0400
Received: by pzk31 with SMTP id 31so1655494pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 07 Apr 2010 15:01:53 -0700 (PDT)
In-Reply-To: <87tyrnfe8c.fsf@deeprootsystems.com> (Kevin Hilman's message of "Wed\, 07 Apr 2010 08\:56\:35 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Tseng <tsenpet09@gmail.com>
Cc: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Peter Tseng <tsenpet09@gmail.com> writes:
>
>> Hey there,
>>
>> My name's Peter and I'm working with the linux-omap-pm kernel on the
>> Gumstix Overo board for an academic project.
>>
>> Back when the linux-omap-pm branch was still on 2.6.33-rc8, I could
>> compile and run the kernel on the Overo without any problems. Suspend to
>> memory (via mem > /sys/power/state) worked just fine. Unfortunately,
>> ever since 2.6.34-rcX releases started coming out, I have been running
>> into problems:
>>

[...]

>>
>> I have no idea if it simply hangs here, or it is working and simply not
>> printing anything to the serial console. (If it helps at all, the
>> processor *seems* warm, but I cannot be sure of this).
>
> What's your commandline?
>
> Can you try enabling CONFIG_DEBUG_LL=y and and CONFIG_EARLY_PRINTK=y
> and append 'earlyprintk' on the kernel command line.
>
> This will hopefully give more detailed reasons for the dump.
>
> I seem to have corrupted the flash on my overo so it's not booting
> currently, but the current PM branch kernel does boot fine on my
> beagle C3.

OK, after some more digging, the Overo was hitting the same boot
problem I've been trying to track on Zoom3.  I have now fixed this and
the PM branch omap3_pm_defconfig should boot again for Overo and
Zoom3.

I've updated the PM branch now which includes a fix for a problem
introduced in in 2.6.34 due to early enabling of interrupts (see
details on LKML[1]).  Interstingly, this was seen on PM branch where I
use the SLUB allocator by default, and not on l-o master where the
SLAB allocator is still used by default.

Please pull a fresh PM branch and see if you get it booting on Overo.

Thanks,

Kevin


[1] http://lkml.org/lkml/2010/4/7/301

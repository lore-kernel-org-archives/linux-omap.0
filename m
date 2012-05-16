From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv5 3/8] ARM: OMAP4460: Workaround for ROM bug because of CA9 r2pX gic control register change
Date: Wed, 16 May 2012 09:51:57 -0700
Message-ID: <87mx586pci.fsf@ti.com>
References: <1336989796-26594-1-git-send-email-t-kristo@ti.com>
	<1336989796-26594-4-git-send-email-t-kristo@ti.com>
	<87zk99ce5q.fsf@ti.com> <4FB3707B.2080200@ti.com>
	<4FB39C5A.5080404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:48504 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758138Ab2EPQv5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 12:51:57 -0400
Received: by dadv2 with SMTP id v2so1526433dad.18
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 09:51:56 -0700 (PDT)
In-Reply-To: <4FB39C5A.5080404@ti.com> (Santosh Shilimkar's message of "Wed,
	16 May 2012 17:53:54 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Kevin,
>
> On Wednesday 16 May 2012 02:46 PM, Santosh Shilimkar wrote:
>> On Wednesday 16 May 2012 03:14 AM, Kevin Hilman wrote:
>>> Santosh,
>>>
>>> Tero Kristo <t-kristo@ti.com> writes:
>>>
>>>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>>
>>>> GIC distributor control register has changed between CortexA9 r1pX and
>>>> r2pX. The Control Register secure banked version is now composed of 2
>>>> bits:
>>>>      bit 0 == Secure Enable
>>>>      bit 1 == Non-Secure Enable
>>>> The Non-Secure banked register has not changed. 
>>>
>>> For those without the r1pX TRM handy, please include what this look like
>>> before (presumably 1 bit?)  The changelog and in-code comments should
>>> both be enhanced.
>>>
>> You are right. There was only one bit previously which was used for
>> secure/non-secure mode. So ROM over-writes the non-secure bit
>> accidentally.
>> 
>>>> Since the ROM Code is based on the r1pX GIC, the CPU1 GIC restoration
>>>> will cause a problem to CPU0 Non-Secure SW.
>>>
>>> Please describe the problem, so we can better understand the specifics
>>> of the workaround.
>>>
> Below is the updated changelog.

Much better, thanks.  But it still took me several reads to fully
understand.  Maybe it's because the cold I have is stuffing up my head,
so it takes me awhile to understand...  Anyways, some minor comments to
help clarify...

Sorry to be so picky about changelogs, but this is a really nasty bug,
and the workaround has some rather important side effects, so I want the
description of the bug and the workaround to be well described.

> --------------
> ARM: OMAP4460: Workaround for ROM bug because of CA9 r2pX gic control
> register change
>
> With MPUSS programmed to OSWR(Open Switch retention), GIC context is
> lost. On the CPU wakeup paths, ROM code gets executed which will setup
> GIC secure configurations and restore the GIC context if it was saved
> based on SAR_BACKUP_STATUS.
>
> The ROM Code GIC distributor restoration is split in two parts:
> CPU specific register done by each CPU and common register done by
> only one CPU. If the GIC Distributor Control Register = 1, the
> second CPU will not do the common GIC restoration.

s/second CPU/second CPU to wake up/

> GIC distributor control register has changed between CortexA9 r1pX and
> r2pX. The Control Register secure banked version is now composed of 2
> bits vs only one bit before r1px:

before r1pX?  

>      bit 0 == Secure Enable
>      bit 1 == Non-Secure Enable

And what did this look like for r1pX?    Presumably bit0 was non-secure
enable?

> Hence the value of Control register will be 3 and not 1 as the r1pX
> based ROM code expects. 

Why will it be 3?

Will it be 3 on GP devices?

> So he CPU1 on it's wakeup ROM code path, will

s/it's/its/

> go to the GIC initialization procedure and will so reset the full GIC
> and NS GIC distributor Enable bit will get cleared.

This is where it's confusing.

On r2pX, NS enable bit is bit 1.  It's not mentioned here, but I'm
assuming that it's bit 0 on r1pX, right? (I can't seem to find an r1pX
TRM)

Since ROM code is r1pX-based, I would assume that it would continue to
clear bit 0, which is only now the secure enable bit?

Or, is it the case that ROM code clears all the bits?  That should be described.

> Since the GIC distributor gets disabled in a live system, CPU1 will
> hang because the interrupts stop firing.
>      1) Before doing the CPU1 wakeup, CPU0 must disable
>         the GIC distributor and wait for it to be enabled.

what does 'disable GIC distributor' mean.  secure? non-secure? both?

>      2) CPU1 must re-enable the GIC distributor on
>         it's wakeup path.

Describe why this works.  e.g. because it cause ROM code to skip its
broken restore path.

> With this procedure, the GIC configuration done between the
> CPU0 wakeup and CPU1 wakeup will not be lost but during this
> short windows, the CPU0 will not receive interrupts.
>
> The BUG is applicable to only OMAP4460(r2pX) devices.
> OMAP4470(r2Px), ROM code is fixed for this BUG.

OMAP4470 (also r2pX) is not affected by this bug because ROM code has
been fixed.

Kevin

> ----------------
>
> Let me know if it clarifies the issue ?
>
> Regards
> Santosh
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM branch updated to v2.6.35, SRF dropped
Date: Thu, 05 Aug 2010 15:45:30 -0700
Message-ID: <87tyn8ptkl.fsf@deeprootsystems.com>
References: <8739uu9em0.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0323E6947D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:41062 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934761Ab0HEWpd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Aug 2010 18:45:33 -0400
Received: by pxi14 with SMTP id 14so2694389pxi.19
        for <linux-omap@vger.kernel.org>; Thu, 05 Aug 2010 15:45:32 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0323E6947D@dbde02.ent.ti.com>
	(Rajendra Nayak's message of "Thu, 5 Aug 2010 19:51:13 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Nayak, Rajendra" <rnayak@ti.com> writes:

>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
>> Sent: Thursday, August 05, 2010 4:21 AM
>> To: linux-omap@vger.kernel.org
>> Subject: PM branch updated to v2.6.35, SRF dropped
>> 
>> Hello,
>> 
>
> Hi Kevin,
>
> Can you pull in this patch into your branch as well?
> http://marc.info/?l=linux-usb&m=127858711304301&w=2
> Without this multi-omap build seems to be broken.

Done.

> Also with omap_4430sdp_defconfig, I see these compile errors
> arch/arm/kernel/entry-armv.S: Assembler messages:
> arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ipi r0,r6,r5,lr'
> arch/arm/kernel/entry-armv.S:48: Error: bad instruction `test_for_ipi r0,r6,r5,lr'
> make[1]: *** [arch/arm/kernel/entry-armv.o] Error 1
> make: *** [arch/arm/kernel] Error 2
>
> Doing a git log on entry-armv.S shows me a top commit which might
> be an issue if conflicts are'nt resolved well.
>
> commit 7b70c4275f28702b76b273c8534c38f8313812e9
> Merge: ceb0885... a20df56...
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Sat Jul 31 14:20:16 2010 +0100
>
>     Merge branch 'devel-stable' into devel
>
>     Conflicts:
>         arch/arm/kernel/entry-armv.S
>         arch/arm/kernel/setup.c
>         arch/arm/mm/init.c
>
> Maybe this is an issue in Tony's for-next as well. Haven't tested
> it though.

Yeah, I'm guessing this an issue in for-next, and probably l-o master
too.

Kevin

>
>> It's been a while since a PM branch update, thanks to a nice summer
>> vacation for me. :)
>> 
>> The PM branch has now been updated to v2.6.35 plus Tony's for-next
>> branch.  
>> 
>> This is mostly a rebase, but the most important change is that I'm
>> finally dropping SRF as promised[1].  The new DVFS 
>> infrastructure is now
>> in the RFC/PATCH phase so I'm no longer going to keep dragging SRF
>> along.  Note that this means that ***DVFS no longer works in 
>> the PM branch***. 
>> If this bothers you, then please consider helping review and test the
>> new DVFS infrastructure recently posted by Thara so we can 
>> get the new,
>> upstream-ready DVFS code upstream ASAP.
>> 
>> I've only tested the new PM branch on a couple boards to avoid any
>> further delay getting this version out, update, so hopefully 
>> others will
>> help test.
>> 
>> I've tested RET on idle & suspend, OFF in idle & suspend on:
>> 
>> 3430/omap3evm: works
>> 
>> 3630/Zoom3: works
>> - Known problem: console hangs on UART wakeup when  wakeups 
>> are enabled using
>>   echo enabled > 
>> /sys/devices/platform/serial8250.0/tty/ttyS0/power/wakeup
>>   but I haven't debugged this further.
>> 
>> Kevin
>> 
>> 
>> [1] http://marc.info/?l=linux-omap&m=127206504624556&w=2
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 

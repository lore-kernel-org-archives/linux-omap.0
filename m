From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/5] OMAP1/2/3/4: DEBUG_LL: cleanup
Date: Thu, 27 Aug 2009 16:29:35 +0300
Message-ID: <873a7dwfk0.fsf@deeprootsystems.com>
References: <1250877324-10494-1-git-send-email-vikram.pandita@ti.com>
	<4A8FA4E7.9020206@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F9A44895@dbde02.ent.ti.com>
	<87hbvtfw8g.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F9A44CAC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:63408 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbZH0N3h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Aug 2009 09:29:37 -0400
Received: by bwz19 with SMTP id 19so960483bwz.37
        for <linux-omap@vger.kernel.org>; Thu, 27 Aug 2009 06:29:38 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F9A44CAC@dbde02.ent.ti.com> (Vikram Pandita's message of "Thu\, 27 Aug 2009 18\:34\:54 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

"Pandita, Vikram" <vikram.pandita@ti.com> writes:

>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>"Pandita, Vikram" <vikram.pandita@ti.com> writes:
>>
>>>>Vikram Pandita wrote:
>>>>> This patch cleans up the DEBUG_LL infrastructure for omap boards.
>>>>
>>> Could you give reference to this code on DaVinci?
>>
>>http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git;a=blobdiff;f=arch/arm/mach-
>>davinci/include/mach/uncompress.h;h=0f1f12b67875f86232c0e06e1a687a6d7f19b18a;hp=1e27475f9a2322f1a4f61
>>e25fd1a1e5858e29fc2;hb=bb9647f44b091ebff17f400bb2a468c7e419f3ac;hpb=0dc6306a65f30c0483cfed9b3e8ee1eb3
>>d093e84
>>
>>> Yes this is doable, but the question is, how do we pass these
>>> variables to the kernel start: arch/arm/kernel/head.S
>>> First stage, arch/arm/boot/compressed/head.S gets the arch type ->
>>> shift/uart-addr. Fine.  This stage ends with relocated code over
>>> righting the decompressor.
>>> Second stage, arch/arm/kernel/head.S now starts.
>>> I am not sure how to share the data from Stage 1 in this stage?
>>
>>This is already taken care of.
>>
>>The zImage boot passes the machine-type in a register, then
>>arch/arm/kernel/head.S uses that to decide which machine to start.
>>This is where the MACHINE_START/MACHINE_END macros come in to
>>define the machine-specific hooks called at boot time.
>
> Yes. I agree. I have reviewed that path.
>
>>
>>You should use one of the early machine hooks (probably .map_io)
>>to to set the UART base and shift for the board.
>
> I am looking at even earlier than that.

OK

> The idea is to write to phys_io and io_pg_offset from kernel/head.S
> very early based on the uart address found in compressed/misc.c
>
> To make map_io writable, I will have to change the MACHINE_START to
> remove the const.  It so happens that Russell has defined
> MACHINE_START to be a const.
>
> Not sure is removing const from MACHINE_START is acceptable?

we'll find out after you post for RFC.

> I can have a sample implementation and post to get review comments.
>
>>
>>The catch is that between the start of the head.S code and the
>>mach->map_io hook, printascii() may be called and use the debug
>>macros to try to print out chars.  Care must be taken that
>>if the UART is not yet known/defined, nothing is printed.
>
> That is easy and can be taken care of.
>

ok, I look forward to seeing how you handle this.

Kevin


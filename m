From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 1/5] OMAP1/2/3/4: DEBUG_LL: cleanup
Date: Thu, 27 Aug 2009 18:34:54 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F9A44CAC@dbde02.ent.ti.com>
References: <1250877324-10494-1-git-send-email-vikram.pandita@ti.com>
	<4A8FA4E7.9020206@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F9A44895@dbde02.ent.ti.com>
 <87hbvtfw8g.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48037 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbZH0NFT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Aug 2009 09:05:19 -0400
In-Reply-To: <87hbvtfw8g.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>



>-----Original Message-----
>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>"Pandita, Vikram" <vikram.pandita@ti.com> writes:
>
>>>Vikram Pandita wrote:
>>>> This patch cleans up the DEBUG_LL infrastructure for omap boards.
>>>
>>
>> Could you give reference to this code on DaVinci?
>
>http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git;a=blobdiff;f=arch/arm/mach-
>davinci/include/mach/uncompress.h;h=0f1f12b67875f86232c0e06e1a687a6d7f19b18a;hp=1e27475f9a2322f1a4f61
>e25fd1a1e5858e29fc2;hb=bb9647f44b091ebff17f400bb2a468c7e419f3ac;hpb=0dc6306a65f30c0483cfed9b3e8ee1eb3
>d093e84
>
>>
>> Yes this is doable, but the question is, how do we pass these variables to the kernel start:
>> arch/arm/kernel/head.S
>>
>> First stage, arch/arm/boot/compressed/head.S gets the arch type -> shift/uart-addr. Fine.
>> This stage ends with relocated code over righting the decompressor.
>>
>> Second stage, arch/arm/kernel/head.S now starts.
>>
>> I am not sure how to share the data from Stage 1 in this stage?
>
>This is already taken care of.
>
>The zImage boot passes the machine-type in a register, then
>arch/arm/kernel/head.S uses that to decide which machine to start.
>This is where the MACHINE_START/MACHINE_END macros come in to
>define the machine-specific hooks called at boot time.

Yes. I agree. I have reviewed that path.

>
>You should use one of the early machine hooks (probably .map_io)
>to to set the UART base and shift for the board.

I am looking at even earlier than that.

The idea is to write to phys_io and io_pg_offset from kernel/head.S very early 
based on the uart address found in compressed/misc.c 

To make map_io writable, I will have to change the MACHINE_START to remove the const.
It so happens that Russell has defined MACHINE_START to be a const.

Not sure is removing const from MACHINE_START is acceptable?

I can have a sample implementation and post to get review comments.

>
>The catch is that between the start of the head.S code and the
>mach->map_io hook, printascii() may be called and use the debug
>macros to try to print out chars.  Care must be taken that
>if the UART is not yet known/defined, nothing is printed.

That is easy and can be taken care of.

>
>Kevin
>


From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/5] OMAP1/2/3/4: DEBUG_LL: cleanup
Date: Thu, 27 Aug 2009 12:21:19 +0300
Message-ID: <87hbvtfw8g.fsf@deeprootsystems.com>
References: <1250877324-10494-1-git-send-email-vikram.pandita@ti.com>
	<4A8FA4E7.9020206@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F9A44895@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:48863 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbZH0JV0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Aug 2009 05:21:26 -0400
Received: by bwz19 with SMTP id 19so826880bwz.37
        for <linux-omap@vger.kernel.org>; Thu, 27 Aug 2009 02:21:27 -0700 (PDT)
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F9A44895@dbde02.ent.ti.com> (Vikram Pandita's message of "Thu\, 27 Aug 2009 08\:08\:14 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

"Pandita, Vikram" <vikram.pandita@ti.com> writes:

>>Vikram Pandita wrote:
>>> This patch cleans up the DEBUG_LL infrastructure for omap boards.
>>
>>Thanks Vikram, this is indeed in need of some cleanup.  But I have some
>>comments about the approach taken.
>>
>>This approach still doesn't solve one of the fundamental problems with
>>the current implementation.  It prevents using a single kernel across
>>multiple boards.  If we could drop the compile-time decision in favor of
>>a runtime one based on machine-type, we could use a single base
>>defconfig that would be able to be tested on all omap3 boards for example.
>>
>>For the zImage UART output (uncompress.h) there is a global variable
>>__machine_arch_type which could be used to check the board type and set
>>variable for UART base and shift.  We do this on DaVinci.
>
> Could you give reference to this code on DaVinci?

http://git.kernel.org/?p=linux/kernel/git/khilman/linux-davinci.git;a=blobdiff;f=arch/arm/mach-davinci/include/mach/uncompress.h;h=0f1f12b67875f86232c0e06e1a687a6d7f19b18a;hp=1e27475f9a2322f1a4f61e25fd1a1e5858e29fc2;hb=bb9647f44b091ebff17f400bb2a468c7e419f3ac;hpb=0dc6306a65f30c0483cfed9b3e8ee1eb3d093e84

>
> Yes this is doable, but the question is, how do we pass these variables to the kernel start:
> arch/arm/kernel/head.S
>
> First stage, arch/arm/boot/compressed/head.S gets the arch type -> shift/uart-addr. Fine.
> This stage ends with relocated code over righting the decompressor.
>
> Second stage, arch/arm/kernel/head.S now starts.
>
> I am not sure how to share the data from Stage 1 in this stage?

This is already taken care of.

The zImage boot passes the machine-type in a register, then
arch/arm/kernel/head.S uses that to decide which machine to start. 
This is where the MACHINE_START/MACHINE_END macros come in to
define the machine-specific hooks called at boot time.

You should use one of the early machine hooks (probably .map_io)
to to set the UART base and shift for the board.

The catch is that between the start of the head.S code and the
mach->map_io hook, printascii() may be called and use the debug
macros to try to print out chars.  Care must be taken that
if the UART is not yet known/defined, nothing is printed.

Kevin


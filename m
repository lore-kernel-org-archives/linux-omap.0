From: Eino-Ville Talvala <talvala@stanford.edu>
Subject: Re: ARM CROSS COMPILATION
Date: Thu, 17 Dec 2009 22:37:58 -0800
Message-ID: <4B2B2346.6000104@stanford.edu>
References: <4ad3b6300912172220v5d6af078n302284331cc4345a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.Stanford.EDU ([171.67.219.81]:51232 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751530AbZLRGhp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 01:37:45 -0500
In-Reply-To: <4ad3b6300912172220v5d6af078n302284331cc4345a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Niamathullah sharief <omapsha@gmail.com>
Cc: linux-omap@vger.kernel.org

On 12/17/2009 10:20 PM, Niamathullah sharief wrote:
> Hello,
> I am trying to compile my kernel for ARM Processor. when i do that i
> am getting some following error. I didnt find what will be the
> problem.
>
>   
Hi,
> root@ariem-desktop:/home/ariem/Desktop/kernels/linux-2.6.28-006rc8#
> make CROSS_COMPILE=/home/ariem/CodeSourcery/Sourcery_G++_Lite/bin/arm-none-linux-gnueabi-
> uImage
>   CHK     include/linux/version.h
> make[1]: `include/asm-arm/mach-types.h' is up to date.
>   CHK     include/linux/utsrelease.h
>   SYMLINK include/asm -> include/asm-arm
>   CALL    scripts/checksyscalls.sh
> <stdin>:1097:2: warning: #warning syscall fadvise64 not implemented
> <stdin>:1265:2: warning: #warning syscall migrate_pages not implemented
> <stdin>:1321:2: warning: #warning syscall pselect6 not implemented
> <stdin>:1325:2: warning: #warning syscall ppoll not implemented
> <stdin>:1365:2: warning: #warning syscall epoll_pwait not implemented
>   CC      init/main.o
> /tmp/cczCT0T5.s: Assembler messages:
> /tmp/cczCT0T5.s:255: Error: selected processor does not support `cpsie i'
> /tmp/cczCT0T5.s:704: Error: selected processor does not support `cpsid i'
> /tmp/cczCT0T5.s:712: Error: selected processor does not support `cpsid i'
> /tmp/cczCT0T5.s:726: Error: selected processor does not support `cpsid i'
> /tmp/cczCT0T5.s:740: Error: selected processor does not support `cpsid i'
> /tmp/cczCT0T5.s:812: Error: selected processor does not support `cpsid i'
> /tmp/cczCT0T5.s:837: Error: selected processor does not support `cpsie i'
> make[1]: *** [init/main.o] Error 1
> make: *** [init] Error 2
> root@ariem-desktop:/home/ariem/Desktop/kernels/linux-2.6.28-006rc8#
>
> Kindly help me
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   
Unless you're using an OMAP-based ARM processor, this is probably not
the right list to be asking this.  You're also not giving sufficient
information for anyone to help you much - what processor and what
hardware platform are you compiling for?

In any case, have you run the proper defconfig for your board - see, for
example, the discussion below:

http://linux.omap.com/pipermail/linux-omap-open-source/2007-August/010792.html

Good luck!

Eino-Ville Talvala
Computer Graphics Lab
Stanford University

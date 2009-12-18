From: Niamathullah sharief <omapsha@gmail.com>
Subject: ARM CROSS COMPILATION
Date: Fri, 18 Dec 2009 11:50:01 +0530
Message-ID: <4ad3b6300912172220v5d6af078n302284331cc4345a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:42708 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbZLRGUC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 01:20:02 -0500
Received: by pwj9 with SMTP id 9so1742422pwj.21
        for <linux-omap@vger.kernel.org>; Thu, 17 Dec 2009 22:20:01 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,
I am trying to compile my kernel for ARM Processor. when i do that i
am getting some following error. I didnt find what will be the
problem.


root@ariem-desktop:/home/ariem/Desktop/kernels/linux-2.6.28-006rc8#
make CROSS_COMPILE=/home/ariem/CodeSourcery/Sourcery_G++_Lite/bin/arm-none-linux-gnueabi-
uImage
  CHK     include/linux/version.h
make[1]: `include/asm-arm/mach-types.h' is up to date.
  CHK     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-arm
  CALL    scripts/checksyscalls.sh
<stdin>:1097:2: warning: #warning syscall fadvise64 not implemented
<stdin>:1265:2: warning: #warning syscall migrate_pages not implemented
<stdin>:1321:2: warning: #warning syscall pselect6 not implemented
<stdin>:1325:2: warning: #warning syscall ppoll not implemented
<stdin>:1365:2: warning: #warning syscall epoll_pwait not implemented
  CC      init/main.o
/tmp/cczCT0T5.s: Assembler messages:
/tmp/cczCT0T5.s:255: Error: selected processor does not support `cpsie i'
/tmp/cczCT0T5.s:704: Error: selected processor does not support `cpsid i'
/tmp/cczCT0T5.s:712: Error: selected processor does not support `cpsid i'
/tmp/cczCT0T5.s:726: Error: selected processor does not support `cpsid i'
/tmp/cczCT0T5.s:740: Error: selected processor does not support `cpsid i'
/tmp/cczCT0T5.s:812: Error: selected processor does not support `cpsid i'
/tmp/cczCT0T5.s:837: Error: selected processor does not support `cpsie i'
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2
root@ariem-desktop:/home/ariem/Desktop/kernels/linux-2.6.28-006rc8#

Kindly help me

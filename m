From: Niamathullah sharief <omapsha@gmail.com>
Subject: ARM tollchain support
Date: Tue, 15 Dec 2009 18:21:43 +0530
Message-ID: <4ad3b6300912150451k34f8367eg4141f80c79f66413@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:32833 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbZLOMvp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 07:51:45 -0500
Received: by pwj9 with SMTP id 9so2600048pwj.21
        for <linux-omap@vger.kernel.org>; Tue, 15 Dec 2009 04:51:43 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,
    I am trying to install ARM tollchain in my GCC. But i am not
getting to install correctly. When i try to compile an u boot image i
am getting the following errors in last few lines ..


make[1]: Leaving directory `/home/ariem/Desktop/u-boot-200901-lange51/tools'
make -C examples all
make[1]: execvp: /home/ariem/CodeSourcery/Sourcery_G++_Lite/lib/gcc:
Permission denied
make[1]: Entering directory `/home/ariem/Desktop/u-boot-200901-lange51/examples'
/bin/sh: /home/ariem/CodeSourcery/Sourcery_G++_Lite/lib/gcc: is a directory
dirname: missing operand
Try `dirname --help' for more information.
/bin/sh: /home/ariem/CodeSourcery/Sourcery_G++_Lite/lib/gcc: is a directory
dirname: missing operand
Try `dirname --help' for more information.
/home/ariem/CodeSourcery/Sourcery_G++_Lite/lib/gcc  -Os
-fno-strict-aliasing -fno-common -ffixed-r8 -msoft-float
-D__KERNEL__ -DTEXT_BASE=0x97800000
-I/home/ariem/Desktop/u-boot-200901-lange51/include -fno-builtin
-ffreestanding -nostdinc -isystem  -pipe  -DCONFIG_ARM -D__ARM__
-Wall -Wstrict-prototypes  -c -o hello_world.o hello_world.c
make[1]: execvp: /home/ariem/CodeSourcery/Sourcery_G++_Lite/lib/gcc:
Permission denied
make[1]: *** [hello_world.o] Error 127
make[1]: Leaving directory `/home/ariem/Desktop/u-boot-200901-lange51/examples'
make: *** [examples] Error 2
ariem@ariem-desktop:~/Desktop/u-boot-200901-lange51$


what will be the error. can anyone tell me. i think the path exported
is wrong. please help me

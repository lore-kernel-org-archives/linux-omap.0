From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: ARM tollchain support
Date: Tue, 15 Dec 2009 18:27:25 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BC2406DF@dbde02.ent.ti.com>
References: <4ad3b6300912150451k34f8367eg4141f80c79f66413@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40573 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753560AbZLOM5c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 07:57:32 -0500
In-Reply-To: <4ad3b6300912150451k34f8367eg4141f80c79f66413@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Niamathullah sharief <omapsha@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> Niamathullah sharief
> Sent: Tuesday, December 15, 2009 6:22 PM
> To: linux-omap@vger.kernel.org
> Subject: ARM tollchain support
> 
> Hello,
>     I am trying to install ARM tollchain in my GCC. But i am not
> getting to install correctly. When i try to compile an u boot image i
> am getting the following errors in last few lines ..
> 
> 
> make[1]: Leaving directory `/home/ariem/Desktop/u-boot-200901-lange51/tools'
> make -C examples all
> make[1]: execvp: /home/ariem/CodeSourcery/Sourcery_G++_Lite/lib/gcc:
> Permission denied
> make[1]: Entering directory `/home/ariem/Desktop/u-boot-200901-lange51/examples'
> /bin/sh: /home/ariem/CodeSourcery/Sourcery_G++_Lite/lib/gcc: is a directory
> dirname: missing operand
> Try `dirname --help' for more information.
> /bin/sh: /home/ariem/CodeSourcery/Sourcery_G++_Lite/lib/gcc: is a directory
> dirname: missing operand
> Try `dirname --help' for more information.
> /home/ariem/CodeSourcery/Sourcery_G++_Lite/lib/gcc  -Os
> -fno-strict-aliasing -fno-common -ffixed-r8 -msoft-float
> -D__KERNEL__ -DTEXT_BASE=0x97800000
> -I/home/ariem/Desktop/u-boot-200901-lange51/include -fno-builtin
> -ffreestanding -nostdinc -isystem  -pipe  -DCONFIG_ARM -D__ARM__
> -Wall -Wstrict-prototypes  -c -o hello_world.o hello_world.c
> make[1]: execvp: /home/ariem/CodeSourcery/Sourcery_G++_Lite/lib/gcc:
> Permission denied
> make[1]: *** [hello_world.o] Error 127
> make[1]: Leaving directory `/home/ariem/Desktop/u-boot-200901-lange51/examples'
> make: *** [examples] Error 2
> ariem@ariem-desktop:~/Desktop/u-boot-200901-lange51$
> 
> 
> what will be the error. can anyone tell me. i think the path exported
> is wrong. please help me
How are you exporting the path ? Can you copy paste that here

From: Deepthi Kiran <Deepthi_Kiran@mindtree.com>
Subject: RE: ZOOM2 doesn't boot on upstream kernel
Date: Wed, 21 Dec 2011 11:04:08 +0000
Message-ID: <344AB47D0320634EAA28597AB40FCE1A074AF258@MTW02MBX03.mindtree.com>
References: <AANLkTilypMkwLYcpFCI5ZwSKOGHIAwDI7Bp9IdN9UAv_@mail.gmail.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030DED31F3@dbde02.ent.ti.com>
 <AANLkTikkCeusIKA2KyRcVWbxVXKmLA8-_RfC2A4u3ySM@mail.gmail.com>
 <A24693684029E5489D1D202277BE894456224D59@dlee02.ent.ti.com>
 <loom.20111216T082358-46@post.gmane.org> <20111216205302.GN32251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from Transportmtw02.mindtree.com ([119.226.208.136]:47736 "EHLO
	transportmtw01.mindtree.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750909Ab1LULJm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Dec 2011 06:09:42 -0500
In-Reply-To: <20111216205302.GN32251@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thanks for ur response,

Iam using omap 3430 processor for the custom board, for 32 kernel  tty port of console was ttyO3 only, I have enabled DEBUG_LL also, and I am using putc function of uncompress.h file to print early prints. Iam suppose to work on the custom board in which UART address and data lines are made reverse, so if the address is 0x01 then I need to send address as 0x04 and simillary data, so I can not use direct early prink . So in the putc function, Iam reversing the address and data and trying to print. Control is not even coming up to start_kernel of init/main.c,I think after uncompressing and relocating of the kernel, it is struck..
I tried directly on zoom2 board also, noting was happening. One more thing I observed was I used Panda configuration and changed MACH_ZOOM3 and tried on zoom3 board, kernel at least booted on zoom3 board.
Do we have any specific 35 kernel tested for zoom2 or zoom3, if so please let me know the path..


-----Original Message-----
From: Tony Lindgren [mailto:tony@atomide.com]
Sent: Saturday, December 17, 2011 2:23 AM
To: Deepthi Kiran
Cc: linux-omap@vger.kernel.org
Subject: Re: ZOOM2 doesn't boot on upstream kernel

Hi,

* deepthi <deepthi_kiran@mindtree.com> [111215 23:03]:
>
> Hi,
>
> We are trying to boot 35 kernel on zoom2,I tried with android_zoom3
> config and choosing MACH as zoom2 and also with omap_zoom2_defconfig,
> kernel is not booting at all,it is struck after Starting kernel ...
>
> Uncompressing Linux...
>  done, booting the kernel.
>
> I have taken the omap4 panda release kernel for gingerbread.
> Image name it is showing as Linux-2.6.35.7-00371-gcfb80c7-di
>
> Please let me know Which kernel we have to take for zoom2 35.
> I have tried with following bootargs
> setenv bootargs console=ttyS3,115200n8 mem=256M  root=/dev/mmcblk0p2
> rootdelay=1 init=/init omap_vout.video1_numbuffers=6
> omap_vout.vid1_static_vrfb_alloc=y
> omapfb.vram=0:4M

Can you please enable CONFIG_DEBUG_LL and CONFIG_EARLY_PRINTK in your .config? Then also append earlyprintk to the bootargs above. Then you should see more info on what goes wrong.

> I even tried with ttyO3 also.
> What should be the exact console should it be ttyO0?

I'm suspecting you should use ttyS0 as the console instead of ttyS3? That's at least what I have on my zoom3 board with the extra debug board.

You should use ttyO for the omap ports, but zoom debug board has external 8250 ftdi ports, so those show up as ttyS and not ttyO.

Regards,

Tony

________________________________

http://www.mindtree.com/email/disclaimer.html

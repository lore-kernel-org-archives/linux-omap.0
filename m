From: Tony Lindgren <tony@atomide.com>
Subject: Re: ZOOM2 doesn't boot on upstream kernel
Date: Fri, 16 Dec 2011 12:53:02 -0800
Message-ID: <20111216205302.GN32251@atomide.com>
References: <AANLkTilypMkwLYcpFCI5ZwSKOGHIAwDI7Bp9IdN9UAv_@mail.gmail.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030DED31F3@dbde02.ent.ti.com>
 <AANLkTikkCeusIKA2KyRcVWbxVXKmLA8-_RfC2A4u3ySM@mail.gmail.com>
 <A24693684029E5489D1D202277BE894456224D59@dlee02.ent.ti.com>
 <loom.20111216T082358-46@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:30923 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932757Ab1LPUxF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 15:53:05 -0500
Content-Disposition: inline
In-Reply-To: <loom.20111216T082358-46@post.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: deepthi <deepthi_kiran@mindtree.com>
Cc: linux-omap@vger.kernel.org

Hi,

* deepthi <deepthi_kiran@mindtree.com> [111215 23:03]:
> 
> Hi,
> 
> We are trying to boot 35 kernel on zoom2,I tried with android_zoom3 config and
> choosing MACH as zoom2 and also with omap_zoom2_defconfig, kernel is not booting
> at all,it is struck after 
> Starting kernel ...
> 
> Uncompressing Linux...
>  done, booting the kernel.
> 
> I have taken the omap4 panda release kernel for gingerbread.
> Image name it is showing as Linux-2.6.35.7-00371-gcfb80c7-di
> 
> Please let me know Which kernel we have to take for zoom2 35.
> I have tried with following bootargs
> setenv bootargs console=ttyS3,115200n8 mem=256M  root=/dev/mmcblk0p2 rootdelay=1
> init=/init omap_vout.video1_numbuffers=6 omap_vout.vid1_static_vrfb_alloc=y
> omapfb.vram=0:4M

Can you please enable CONFIG_DEBUG_LL and CONFIG_EARLY_PRINTK
in your .config? Then also append earlyprintk to the bootargs
above. Then you should see more info on what goes wrong.

> I even tried with ttyO3 also.
> What should be the exact console should it be ttyO0?

I'm suspecting you should use ttyS0 as the console instead
of ttyS3? That's at least what I have on my zoom3 board
with the extra debug board.

You should use ttyO for the omap ports, but zoom debug board
has external 8250 ftdi ports, so those show up as ttyS and
not ttyO.

Regards,

Tony

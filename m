From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3 0/5] OMAP: VRFB: convert to platform device
Date: Wed, 17 Oct 2012 11:29:26 -0700
Message-ID: <20121017182926.GW15569@atomide.com>
References: <1350469102-24888-1-git-send-email-tomi.valkeinen@ti.com>
 <507E87B7.3070707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:64725 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932419Ab2JQS32 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 14:29:28 -0400
Content-Disposition: inline
In-Reply-To: <507E87B7.3070707@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com

* Tomi Valkeinen <tomi.valkeinen@ti.com> [121017 03:27]:
> Hi Tony,
> 
> I have pushed this vrfb series and the omapdss version series to:
> 
> git://gitorious.org/linux-omap-dss2/linux.git 3.8/dss-version

I used this branch up to commit 35f70935c64ae229ebd1fc65398ec68d4d803712,
but left out the x86 compile changes as those seem unrelated to the plat
issue.

> git://gitorious.org/linux-omap-dss2/linux.git 3.8/vrfb-conversion

And then I merged in this branch. I have the merged branch at
omap-for-v3.8/cleanup-headers-dss.
 
> If they look ok to you and we don't get any other comments, I think
> these branches can be considered stable and you can pull them.

Thanks yes let's consider those frozen and if something needs to
be fixed it should be done on top of those commits.
 
> After these are merged:
> 
> $ git grep -E "(plat/)|(mach/)" drivers/video/omap2/
> drivers/video/omap2/omapfb/omapfb-ioctl.c:#include <plat/vram.h>
> drivers/video/omap2/omapfb/omapfb-main.c:#include <plat/vram.h>
> drivers/video/omap2/vram.c:#include <plat/vram.h>
> 
> So the vram stuff should be the only omap dependency left in omapdss and
> omapfb. I'll start working on that soon.

OK thanks a lot. Then there's also the two vout files that
you may already have patches for:

drivers/media/platform/omap/omap_vout.c
drivers/media/platform/omap/omap_voutlib.c

Regards,

Tony

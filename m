From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 8/8] ARM: OMAP: Move plat/dmtimer.h to
 plat-omap/dmtimer.h
Date: Tue, 13 Nov 2012 15:34:56 -0800
Message-ID: <20121113233455.GN6801@atomide.com>
References: <1352830403-1706-1-git-send-email-jon-hunter@ti.com>
 <1352830403-1706-9-git-send-email-jon-hunter@ti.com>
 <20121113222613.GM6801@atomide.com>
 <50A2CF9C.1040902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:18926 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752146Ab2KMXe6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Nov 2012 18:34:58 -0500
Content-Disposition: inline
In-Reply-To: <50A2CF9C.1040902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [121113 14:56]:
> 
> On 11/13/2012 04:26 PM, Tony Lindgren wrote:
> > * Jon Hunter <jon-hunter@ti.com> [121113 10:15]:
> >> Move plat/dmtimer.h to plat-omap/dmtimer.h in order to support a single
> >> zImage for ARM devices.
> > 
> > Let's skip this one for now as it turns out this solution won't
> > work either for multiplatform without adding nasty hacks to
> > arch/arm/Makefile to include arch/arm/plat-omap.
> > 
> > Sorry I don't have any real solution in mind other than making
> > the remaining dmtimer.h users to use Linux generic timer functions,
> > or pass the dmtimer functions in platform_data for now.
> 
> Ok, no problem. Are you happy with the others?

The others look OK to me thanks.
 
> One thing that we could do, is not include the dmtimer driver in the
> multi-platform build for now. I believe that only the dsp/iva/gfx is
> using this driver currently.

Looks like the users are drivers/staging/tidspbridge and
drivers/media/rc/ir-rx51.c. Both could use platform_data pointers
for now, but that really just postpones the problem.
 
> I believe that there are some issues with building the kernel without
> the dmtimer and so I can look into fixing that.

We can include it from <plat/dmtimer.h> for arch/arm/*omap*/*
code, but not for drivers.
 
> Is there a way to not include dmtimer with multi-platform but still
> enable in omap2plus_defconfig? Or are we planning to kill
> omap2plus_defconfig too?

We'll be keeping omap2plus_defconfig, but once we enable multiplatform
support there's really no reason to go back.

Regards,

Tony

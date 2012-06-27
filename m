From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2] ARM: OMAP4470: Fix OMAP4470 boot failure
Date: Wed, 27 Jun 2012 08:12:53 -0700
Message-ID: <20120627151252.GM3483@atomide.com>
References: <1340645903-28550-1-git-send-email-jon-hunter@ti.com>
 <4FE8AACA.5030207@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:21983 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755735Ab2F0PMz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 11:12:55 -0400
Content-Disposition: inline
In-Reply-To: <4FE8AACA.5030207@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [120625 11:20]:
> Adding linux-arm ML.
> 
> Jon
> 
> On 06/25/2012 12:38 PM, Jon Hunter wrote:
> > OMAP4470 currently fails to boot, printing various messages such as ...
> > 
> > omap_hwmod: mpu: cannot clk_get main_clk dpll_mpu_m2_ck
> > omap_hwmod: mpu: cannot _init_clocks
> > ------------[ cut here ]------------
> > WARNING: at arch/arm/mach-omap2/omap_hwmod.c:2062 _init+0x2a0/0x2e4()
> > omap_hwmod: mpu: couldn't init clocks
> > Modules linked in:
> > [<c001c7fc>] (unwind_backtrace+0x0/0xf4) from [<c0043c64>] (warn_slowpath_common+0x4c/0x64)
> > [<c0043c64>] (warn_slowpath_common+0x4c/0x64) from [<c0043d10>] (warn_slowpath_fmt+0x30/0x40)
> > [<c0043d10>] (warn_slowpath_fmt+0x30/0x40) from [<c0674208>] (_init+0x2a0/0x2e4)
> > [<c0674208>] (_init+0x2a0/0x2e4) from [<c067428c>] (omap_hwmod_setup_one+0x40/0x60)
> > [<c067428c>] (omap_hwmod_setup_one+0x40/0x60) from [<c0674280>] (omap_hwmod_setup_one+0x34/0x60)
> > [<c0674280>] (omap_hwmod_setup_one+0x34/0x60) from [<c06726f4>] (omap_dm_timer_init_one+0x30/0x250)
> > [<c06726f4>] (omap_dm_timer_init_one+0x30/0x250) from [<c0672930>] (omap2_gp_clockevent_init+0x1c/0x108)
> > [<c0672930>] (omap2_gp_clockevent_init+0x1c/0x108) from [<c0672c60>] (omap4_timer_init+0x10/0x5c)
> > [<c0672c60>] (omap4_timer_init+0x10/0x5c) from [<c066c418>] (time_init+0x20/0x30)
> > [<c066c418>] (time_init+0x20/0x30) from [<c0668814>] (start_kernel+0x1b0/0x304)
> > [<c0668814>] (start_kernel+0x1b0/0x304) from [<80008044>] (0x80008044)
> > ---[ end trace 1b75b31a2719ed1c ]---
> > 
> > The problem is that currently none of the clocks are being registered for
> > OMAP4470 devices and so on boot-up no clocks can be found and the kernel panics.
> > 
> > This fix allows the kernel to boot without failure using a simple RAMDISK file
> > system on OMAP4470 blaze board.
> > 
> > V2:
> > - Per feedback from Paul and Benoit the 4470 clock data is incomplete for new
> >   modules such as the 2D graphics block that has been added to the 4470.
> >   Therefore add a warning to indicate that the clock data is incomplete.

Thanks adding into fixes.

Tony

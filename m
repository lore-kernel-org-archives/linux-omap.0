From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [RFC] ARM: OMAP4470: Fix OMAP4470 boot failure
Date: Thu, 7 Jun 2012 18:04:27 -0500
Message-ID: <4FD1337B.80804@ti.com>
References: <1339110048-13677-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33296 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758176Ab2FGXEV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 19:04:21 -0400
In-Reply-To: <1339110048-13677-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, linux-omap <linux-omap@vger.kernel.org>


On 06/07/2012 06:00 PM, Jon Hunter wrote:
> OMAP4470 currently fails to boot, printing various messages such as ...
> 
> omap_hwmod: mpu: cannot clk_get main_clk dpll_mpu_m2_ck
> omap_hwmod: mpu: cannot _init_clocks
> ------------[ cut here ]------------
> WARNING: at arch/arm/mach-omap2/omap_hwmod.c:2062 _init+0x2a0/0x2e4()
> omap_hwmod: mpu: couldn't init clocks
> Modules linked in:
> [<c001c7fc>] (unwind_backtrace+0x0/0xf4) from [<c0043c64>] (warn_slowpath_common+0x4c/0x64)
> [<c0043c64>] (warn_slowpath_common+0x4c/0x64) from [<c0043d10>] (warn_slowpath_fmt+0x30/0x40)
> [<c0043d10>] (warn_slowpath_fmt+0x30/0x40) from [<c0674208>] (_init+0x2a0/0x2e4)
> [<c0674208>] (_init+0x2a0/0x2e4) from [<c067428c>] (omap_hwmod_setup_one+0x40/0x60)
> [<c067428c>] (omap_hwmod_setup_one+0x40/0x60) from [<c0674280>] (omap_hwmod_setup_one+0x34/0x60)
> [<c0674280>] (omap_hwmod_setup_one+0x34/0x60) from [<c06726f4>] (omap_dm_timer_init_one+0x30/0x250)
> [<c06726f4>] (omap_dm_timer_init_one+0x30/0x250) from [<c0672930>] (omap2_gp_clockevent_init+0x1c/0x108)
> [<c0672930>] (omap2_gp_clockevent_init+0x1c/0x108) from [<c0672c60>] (omap4_timer_init+0x10/0x5c)
> [<c0672c60>] (omap4_timer_init+0x10/0x5c) from [<c066c418>] (time_init+0x20/0x30)
> [<c066c418>] (time_init+0x20/0x30) from [<c0668814>] (start_kernel+0x1b0/0x304)
> [<c0668814>] (start_kernel+0x1b0/0x304) from [<80008044>] (0x80008044)
> ---[ end trace 1b75b31a2719ed1c ]---
> 
> The problem is that currently none of the clocks are being registered for
> OMAP4470 devices and so on boot-up no clocks can be found and the kernel panics.
> 
> This fix always the kernel to boot without failure using a simple RAMDISK file

I am embarrassed to say that English is my first language and the above
should read "this fix ALLOWS" :-)

Jon

From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 0/8] OMAP2+: hwmod/clockevent: allow late-init of individual
 hwmods
Date: Wed, 23 Feb 2011 15:28:40 +0100
Message-ID: <4D651998.3040002@ti.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55330 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589Ab1BWO2q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 09:28:46 -0500
In-Reply-To: <20110223070455.5874.51326.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Gopinath, Thara" <thara@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

Hi Paul,

On 2/23/2011 8:11 AM, Paul Walmsley wrote:
> Hello,
> 
> This series adds the ability to late-initialize individual
> hwmods.  The goal here is for clockevent (and eventually
> clocksource) hwmods to be late-initialized individually, and
> right before they are needed, in the timer init code.  Then
> omap_hwmod_late_init(), which late-inits the rest of the hwmods,
> is intended to run as an initcall -- much later in the boot
> process.
> 
> This series includes the OMAP2/3 hwmod data for the GPTIMERs that
> Tarun posted earlier.  This data is necessary for this new code
> to avoid warnings during boot.
> 
> Boot-tested on N800, OMAP34xx Beagleboard and OMAP4430ES2 Panda.

I'm testing it on 4430sdp, and I have the following warning:

[    0.000000] omap_hwmod: dpll_mpu_m2_ck: missing clockdomain for dpll_mpu_m2_ck.
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: at arch/arm/mach-omap2/timer-gp.c:157 omap2_gp_timer_init+0x80/0x190()
[    0.000000] timer-gp: omap_dm_timer_set_source() failed
[    0.000000] Modules linked in:
[    0.000000] [<c0062a6c>] (unwind_backtrace+0x0/0xec) from [<c009422c>] (warn_slowpath_common+0x4c/0x64)
[    0.000000] [<c009422c>] (warn_slowpath_common+0x4c/0x64) from [<c00942c4>] (warn_slowpath_fmt+0x2c/0x3c)
[    0.000000] [<c00942c4>] (warn_slowpath_fmt+0x2c/0x3c) from [<c0010e30>] (omap2_gp_timer_init+0x80/0x190)
[    0.000000] [<c0010e30>] (omap2_gp_timer_init+0x80/0x190) from [<c000c0dc>] (time_init+0x20/0x30)
[    0.000000] [<c000c0dc>] (time_init+0x20/0x30) from [<c0008cbc>] (start_kernel+0x1a4/0x30c)
[    0.000000] [<c0008cbc>] (start_kernel+0x1a4/0x30c) from [<80008038>] (0x80008038)
[    0.000000] ---[ end trace 1b75b31a2719ed1c ]---
[    0.000000] OMAP clockevent source: GPTIMER1 at 32768 Hz

Regards,
Benoit

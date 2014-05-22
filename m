From: Tony Lindgren <tony@atomide.com>
Subject: Re: Locking problem during N900 shutdown with power management
 patchset
Date: Wed, 21 May 2014 17:12:19 -0700
Message-ID: <20140522001218.GF14520@atomide.com>
References: <20140521235436.GB29118@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:49415 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752323AbaEVAM0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2014 20:12:26 -0400
Content-Disposition: inline
In-Reply-To: <20140521235436.GB29118@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [140521 16:55]:
> Hi Tony,
> 
> Now that I have added the dma fix in addition to the idle support
> patchset I can do clean shutdowns (versus removing battery :)) and
> see the following final warning during shutdown:
> 
> [ 3724.136474] reboot: Power down
> [ 3724.139770] ------------[ cut here ]------------
> [ 3724.144683] WARNING: CPU: 0 PID: 3076 at kernel/locking/lockdep.c:2742 lockdep_trace_alloc+0xd8/0xf8()
> [ 3724.154510] DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))
> [ 3724.160217] Modules linked in:
> [ 3724.163665] CPU: 0 PID: 3076 Comm: halt Not tainted 3.15.0-rc5-00035-gf6796c0 #89
> [ 3724.171630] [<c0014cdc>] (unwind_backtrace) from [<c0011924>] (show_stack+0x10/0x14)
> [ 3724.179840] [<c0011924>] (show_stack) from [<c056baf0>] (dump_stack+0x80/0x9c)
> [ 3724.187499] [<c056baf0>] (dump_stack) from [<c003fc44>] (warn_slowpath_common+0x68/0x8c)
> [ 3724.196044] [<c003fc44>] (warn_slowpath_common) from [<c003fcfc>] (warn_slowpath_fmt+0x30/0x40)
> [ 3724.205261] [<c003fcfc>] (warn_slowpath_fmt) from [<c00855cc>] (lockdep_trace_alloc+0xd8/0xf8)
> [ 3724.214385] [<c00855cc>] (lockdep_trace_alloc) from [<c0111e80>] (__kmalloc_track_caller+0x38/0x184)
> [ 3724.224060] [<c0111e80>] (__kmalloc_track_caller) from [<c00f0e1c>] (kmemdup+0x1c/0x38)
> [ 3724.232543] [<c00f0e1c>] (kmemdup) from [<c0383a70>] (regmap_bulk_write+0xf8/0x19c)
> [ 3724.240661] [<c0383a70>] (regmap_bulk_write) from [<c038df6c>] (twl_i2c_write+0x48/0x8c)
> [ 3724.249237] [<c038df6c>] (twl_i2c_write) from [<c038fb48>] (twl4030_power_off+0x20/0x40)
> [ 3724.257781] [<c038fb48>] (twl4030_power_off) from [<c000f394>] (machine_power_off+0x24/0x2c)
> [ 3724.266723] [<c000f394>] (machine_power_off) from [<c00640d4>] (SyS_reboot+0xf0/0x1dc)
> [ 3724.275115] [<c00640d4>] (SyS_reboot) from [<c000e6a0>] (ret_fast_syscall+0x0/0x48)
> [ 3724.283203] ---[ end trace b06de91d3cd82ea1 ]---
> 
> Is this already being worked on or should I try to trace the
> problem?

Hmm yeah good to hear the shutdown works.. Not working on that one,
so go for it if you have a chance.

Regards,

Tony

From: Joel Fernandes <joelf@ti.com>
Subject: Re: L3 custom error from dmtimer.c
Date: Mon, 21 Apr 2014 10:40:07 -0500
Message-ID: <53553BD7.5090907@ti.com>
References: <CAGhQ9VwTqsxYk2f7dhH-M+afHJiFNdeUTK=5EYw-OCN3s88z9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42864 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbaDUPkM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Apr 2014 11:40:12 -0400
In-Reply-To: <CAGhQ9VwTqsxYk2f7dhH-M+afHJiFNdeUTK=5EYw-OCN3s88z9Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joachim Eastwood <manabian@gmail.com>, Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On 04/19/2014 05:25 PM, Joachim Eastwood wrote:
> Hello,
> 
> Playing around with an old OMAP pwm driver from NeilBrown. I get the
> following warning:
> [ 0.979522] omap-pwm omap-pwm.14: omap_dm_timer_set_load
> [ 0.979553] ------------[ cut here ]------------
> [ 0.979583] WARNING: CPU: 0 PID: 0 at drivers/bus/omap_l3_noc.c:113
> l3_interrupt_handler+0xf4/0x154()
> [ 0.979583] L3 custom error: MASTER:MPU TARGET:L4 PER2
> [ 0.979614] Modules linked in:
> [ 0.979614] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 3.15.0-rc1-00370-gd9d79f4b7b7d-dirty #65
> [ 0.979644] [<c0014f48>] (unwind_backtrace) from [<c0011c2c>]
> (show_stack+0x10/0x14)
> [ 0.979675] [<c0011c2c>] (show_stack) from [<c05ad3bc>] (dump_stack+0x84/0x94)
> [ 0.979705] [<c05ad3bc>] (dump_stack) from [<c0036ba8>]
> (warn_slowpath_common+0x70/0x8c)
> [ 0.979705] omap-pwm omap-pwm.14: omap_dm_timer_set_match
> [ 0.979736] [<c0036ba8>] (warn_slowpath_common) from [<c0036bf4>]
> (warn_slowpath_fmt+0x30/0x40)
> [ 0.979736] [<c0036bf4>] (warn_slowpath_fmt) from [<c0286c90>]
> (l3_interrupt_handler+0xf4/0x154)
> [ 0.979766] [<c0286c90>] (l3_interrupt_handler) from [<c0085d1c>]
> (handle_irq_event_percpu+0x54/0x1cc)
> [ 0.979766] [<c0085d1c>] (handle_irq_event_percpu) from [<c0085ed0>]
> (handle_irq_event+0x3c/0x5c)
> [ 0.979797] [<c0085ed0>] (handle_irq_event) from [<c0088ed0>]
> (handle_fasteoi_irq+0xac/0x1a0)
> [ 0.979797] [<c0088ed0>] (handle_fasteoi_irq) from [<c00853fc>]
> (generic_handle_irq+0x2c/0x3c)
> [ 0.979827] [<c00853fc>] (generic_handle_irq) from [<c000eb20>]
> (handle_IRQ+0x40/0x90)
> [ 0.979827] [<c000eb20>] (handle_IRQ) from [<c0008594>]
> (gic_handle_irq+0x2c/0x5c)
> [ 0.979858] [<c0008594>] (gic_handle_irq) from [<c05b4a44>]
> (__irq_svc+0x44/0x58)
> [ 0.979858] Exception stack(0xc0889f58 to 0xc0889fa0)
> [ 0.979858] 9f40: 00000001 00000001
> [ 0.979888] 9f60: 00000000 c0893678 c0888000 c0888000 c08e75a4
> c0890548 c0888000 ee7ffc00
> [ 0.979888] omap-pwm omap-pwm.14: load value: 0xfffd11fe (-192002),
> match value: 0xfffffffe (-2)
> [ 0.979888] 9f80: c08904e0 c05bdcec 00000000 c0889fa0 c007a190
> c000ee48 20000113 ffffffff
> [ 0.979919] [<c05b4a44>] (__irq_svc) from [<c000ee48>] (arch_cpu_idle+0x24/0x30)
> [ 0.979919] [<c000ee48>] (arch_cpu_idle) from [<c0071950>]
> (cpu_startup_entry+0x138/0x204)
> [ 0.979949] [<c0071950>] (cpu_startup_entry) from [<c0822b10>]
> (start_kernel+0x370/0x37c)
> [ 0.979980] [<c0822b10>] (start_kernel) from [<80008074>] (0x80008074)
> [ 0.979980] omap-pwm omap-pwm.14: omap_dm_timer_set_pwm
> [ 0.980010] omap-pwm omap-pwm.14: omap_pwm_enable
> [ 0.980010] omap-pwm omap-pwm.14: omap_dm_timer_start
> [ 0.980010] omap-pwm omap-pwm.14: omap_dm_timer_write_counter
> [ 0.980041] ---[ end trace 5d002a14ec98c2ad ]---
> 
> This seems to be caused by the call into omap_dm_timer_set_load.
> 

Are you talking about this?
https://lkml.org/lkml/2012/12/12/51

It doesn't seem to be in mainline though.

I'll add a check for the enable/disable, thanks.

regards,
  -Joel

> dmtimer.c has a couple of calls to pm_runtime_get_sync where the
> return value is not checked. I assume it's same problem as with
> omap-des.c which Nishanth fixed some days ago.
> http://marc.info/?l=linux-omap&m=139758112228474&w=2
> 
> regards
> Joachim Eastwood
> 


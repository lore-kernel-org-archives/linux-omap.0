From: Joachim Eastwood <manabian@gmail.com>
Subject: L3 custom error on OMAP4460
Date: Sat, 12 Apr 2014 23:06:47 +0200
Message-ID: <CAGhQ9Vy-hKBiW0_g3Ht4gqmg0w5WX8H+aqWAkeEhPnHh5AN68A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:52162 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715AbaDLVGt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Apr 2014 17:06:49 -0400
Received: by mail-lb0-f180.google.com with SMTP id 10so4481630lbg.39
        for <linux-omap@vger.kernel.org>; Sat, 12 Apr 2014 14:06:48 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I getting the following error on Linus master right now.

[ 2.166320] WARNING: CPU: 0 PID: 0 at drivers/bus/omap_l3_noc.c:113
l3_interrupt_handler+0xf4/0x154()
[ 2.166320] L3 custom error: MASTER:MPU TARGET:L4 PER2
[ 2.166320] Modules linked in:
[ 2.166351] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
3.14.0-12542-gfb5ce8367c24 #11
[ 2.166381] [<c0014ea8>] (unwind_backtrace) from [<c0011b8c>]
(show_stack+0x10/0x14)
[ 2.166381] [<c0011b8c>] (show_stack) from [<c05a9580>] (dump_stack+0x84/0x94)
[ 2.166412] [<c05a9580>] (dump_stack) from [<c0036b08>]
(warn_slowpath_common+0x70/0x8c)
[ 2.166412] [<c0036b08>] (warn_slowpath_common) from [<c0036b54>]
(warn_slowpath_fmt+0x30/0x40)
[ 2.166412] [<c0036b54>] (warn_slowpath_fmt) from [<c02876f0>]
(l3_interrupt_handler+0xf4/0x154)
[ 2.166442] [<c02876f0>] (l3_interrupt_handler) from [<c0085c7c>]
(handle_irq_event_percpu+0x54/0x1cc)
[ 2.166473] [<c0085c7c>] (handle_irq_event_percpu) from [<c0085e30>]
(handle_irq_event+0x3c/0x5c)
[ 2.166473] [<c0085e30>] (handle_irq_event) from [<c0088e30>]
(handle_fasteoi_irq+0xac/0x1a0)
[ 2.166473] [<c0088e30>] (handle_fasteoi_irq) from [<c008535c>]
(generic_handle_irq+0x2c/0x3c)
[ 2.166503] [<c008535c>] (generic_handle_irq) from [<c000ea80>]
(handle_IRQ+0x40/0x90)
[ 2.166503] [<c000ea80>] (handle_IRQ) from [<c0008594>]
(gic_handle_irq+0x2c/0x5c)
[ 2.166534] [<c0008594>] (gic_handle_irq) from [<c05b0bc4>]
(__irq_svc+0x44/0x58)
[ 2.166534] Exception stack(0xc087bf58 to 0xc087bfa0)
[ 2.166534] bf40: 00000001 00000001
[ 2.166534] bf60: 00000000 c08856f8 c087a000 c087a000 c08d9544
c0882548 c087a000 ee7ffc40
[ 2.166564] bf80: c08824e0 c05b9cec 00000000 c087bfa0 c007a0f0
c000eda8 20000113 ffffffff
[ 2.166564] [<c05b0bc4>] (__irq_svc) from [<c000eda8>] (arch_cpu_idle+0x24/0x30)
[ 2.166595] [<c000eda8>] (arch_cpu_idle) from [<c00718b0>]
(cpu_startup_entry+0x138/0x204)
[ 2.166595] [<c00718b0>] (cpu_startup_entry) from [<c0814b10>]
(start_kernel+0x370/0x37c)
[ 2.166625] [<c0814b10>] (start_kernel) from [<80008074>] (0x80008074)

Not sure what to make of it. Anyone got any idea?

Right before the L3 custom WARN I also get these messages from the
des/aes crypot drivers. Might be unrelated, though.
[ 2.134643] omap-aes 4b501000.aes: _od_fail_runtime_resume: FIXME:
missing hwmod/omap_dev info
[ 2.143737] omap-aes 4b501000.aes: omap_aes_probe: failed to get_sync(-19)
[ 2.151000] omap-aes 4b501000.aes: initialization failed.
[ 2.157196] omap-des 480a5000.des: _od_fail_runtime_resume: FIXME:
missing hwmod/omap_dev info
[ 2.166290] omap-des 480a5000.des: OMAP DES hw accel rev: 0.0

The hardware is a VAR-STK-OM44 dev kit. I got one patch on top of
Linus master which is the DT support patch which I posted a couple of
hours ago.

best regards,
Joachim Eastwood

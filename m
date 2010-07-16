From: Arno Steffen <arno.steffen@googlemail.com>
Subject: Omap3 omap3_clk_lock_dpll5() problem
Date: Fri, 16 Jul 2010 11:35:53 +0200
Message-ID: <AANLkTinHudaXyhk3qc1sFydzZaGs3PZKW6DObw_acxOc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38731 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936143Ab0GPJfy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jul 2010 05:35:54 -0400
Received: by bwz1 with SMTP id 1so1099642bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 16 Jul 2010 02:35:53 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I do have some messages while booting a 2.6.33 kernel:

What does this mean? How can I get rid of it?
What is omap3_clk_lock_dpll5()  doing and what if I comment it out? I
guess it make some sense ;)

Clocking rate (Crystal/Core/MPU): 12.0/332/550 MHz
------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/dpll.c:392
omap3_noncore_dpll_set_rate+0x214/0x258()
Modules linked in:
Backtrace:
[<8002c558>] (dump_backtrace+0x0/0x10c) from [<8025cf84>] (dump_stack+0x18/0x1c)
 r6:802cef65 r5:00000188 r4:00000000 r3:00000000
[<8025cf6c>] (dump_stack+0x0/0x1c) from [<80049bac>]
(warn_slowpath_common+0x50/0x68)
[<80049b5c>] (warn_slowpath_common+0x0/0x68) from [<80049bdc>]
(warn_slowpath_null+0x18/0x1c)
 r7:00000000 r6:07270e00 r5:80318110 r4:8031c380
[<80049bc4>] (warn_slowpath_null+0x0/0x1c) from [<80037844>]
(omap3_noncore_dpll_set_rate+0x214/0x258)
[<80037630>] (omap3_noncore_dpll_set_rate+0x0/0x258) from [<80035e60>]
(omap2_clk_set_rate+0x28/0x34)
 r7:0000000c r6:00000000 r5:800001d3 r4:80318110
[<80035e38>] (omap2_clk_set_rate+0x0/0x34) from [<800396e8>]
(clk_set_rate+0x58/0xc0)
[<80039690>] (clk_set_rate+0x0/0xc0) from [<80038e10>]
(omap3_clk_lock_dpll5+0x24/0x74)
 r6:00000000 r5:80317ba0 r4:80318110 r3:34301033
[<80038dec>] (omap3_clk_lock_dpll5+0x0/0x74) from [<8000f6f4>]
(omap2_clk_init+0x11c/0x188)
 r5:80317ba0 r4:0000014c
[<8000f5d8>] (omap2_clk_init+0x0/0x188) from [<8000db20>]
(omap2_init_common_hw+0x54/0xe4)
 r7:80313b50 r6:80023014 r5:8031c3d0 r4:00000000
[<8000dacc>] (omap2_init_common_hw+0x0/0xe4) from [<8000f808>]
(omap3_evm_init_irq+0x18/0x28)
 r5:80023018 r4:8033d040
[<8000f7f0>] (omap3_evm_init_irq+0x0/0x28) from [<8000b238>]
(init_IRQ+0x38/0x44)
[<8000b200>] (init_IRQ+0x0/0x44) from [<800088b4>] (start_kernel+0x16c/0x2cc)
[<80008748>] (start_kernel+0x0/0x2cc) from [<80008034>] (__enable_mmu+0x0/0x2c)
 r5:8033d390 r4:10c53c7d
---[ end trace 1b75b31a2719ed1c ]---
Reprogramming SDRC clock to 332000000 Hz

When I try to change to a slower core frequency (settings have been
changed in XLoader) I get nearly the same messages, but with


Clocking rate (Crystal/Core/MPU): 12.0/266/550 MHz
------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/dpll.c:392
omap3_noncore_dpll_set_rate+0x214/0x258()
Modules linked in:
.....
---[ end trace 1b75b31a2719ed1c ]---
Reprogramming SDRC clock to 266000000 Hz
dpll3_m2_clk rate change failed: -22

Why I cant't let it run only on 322 MHz?

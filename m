From: Arno Steffen <arno.steffen@googlemail.com>
Subject: OMAP3 migrating: partition / clock
Date: Thu, 4 Feb 2010 08:06:15 +0100
Message-ID: <804f0d21002032306h6a61070bof03bec78a6e4364a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:33071 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755398Ab0BDHGQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 02:06:16 -0500
Received: by ewy19 with SMTP id 19so2310873ewy.1
        for <linux-omap@vger.kernel.org>; Wed, 03 Feb 2010 23:06:15 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I am trying to migrate from kernel 28 to 32 on  TI OMA3. Our board is
derived from EVM board.
In new kernel I can't see the partitions in flash, and found no file
to set them.

Also I do get this warning now while boot:

Hierarchical RCU implementation.
NR_IRQS:368
Clocking rate (Crystal/Core/MPU): 12.0/332/500 MHz
------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/clock34xx.c:773
omap3_noncore_dpll_set_rate+0x280/0x2c4()
Modules linked in:
[<c002a924>] (unwind_backtrace+0x0/0xdc) from [<c0049e74>]
(warn_slowpath_common+0x48/0x60)
[<c0049e74>] (warn_slowpath_common+0x48/0x60) from [<c0033d30>]
(omap3_noncore_dpll_set_rate+0x280/0x2c4)
[<c0033d30>] (omap3_noncore_dpll_set_rate+0x280/0x2c4) from
[<c0031674>] (omap2_clk_set_rate+0x20/0x2c)
[<c0031674>] (omap2_clk_set_rate+0x20/0x2c) from [<c003494c>]
(clk_set_rate+0x4c/0xb0)
[<c003494c>] (clk_set_rate+0x4c/0xb0) from [<c000e980>]
(omap2_clk_init+0x124/0x1a0)
[<c000e980>] (omap2_clk_init+0x124/0x1a0) from [<c000d6ec>]
(omap2_init_common_hw+0x4c/0xe0)
[<c000d6ec>] (omap2_init_common_hw+0x4c/0xe0) from [<c000ead8>]
(omap3_evm_init_irq+0x28/0x94)
[<c000ead8>] (omap3_evm_init_irq+0x28/0x94) from [<c000b1b0>]
(init_IRQ+0x30/0x40)
[<c000b1b0>] (init_IRQ+0x30/0x40) from [<c0008978>] (start_kernel+0x140/0x29c)
[<c0008978>] (start_kernel+0x140/0x29c) from [<80008034>] (0x80008034)
---[ end trace 1b75b31a2719ed1c ]---
Reprogramming SDRC clock to 332000000 Hz
GPMC revision 5.0

Do you know the reason and how to solve it?
Thanks & regards
Arno

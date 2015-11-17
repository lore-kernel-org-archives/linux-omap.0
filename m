From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [BISECTED] v4.4-rc1 GPIO regression on OMAP1
Date: Tue, 17 Nov 2015 23:42:13 +0200
Message-ID: <20151117214212.GB18138@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Amstrad E3 computer (OMAP1) boot crashes early with v4.4-rc1. Bisected to:

	450fa54cfd66e3dda6eda26256637ee8928af12a is the first bad commit
	commit 450fa54cfd66e3dda6eda26256637ee8928af12a
	Author: Grygorii Strashko <grygorii.strashko@ti.com>
	Date:   Fri Sep 25 12:28:03 2015 -0700
	
	    gpio: omap: convert to use generic irq handler

Reverting the commit works (as a quick workaround at least).

The crash log:

[    0.253612] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    0.262613] pgd = c0004000
[    0.265754] [00000000] *pgd=00000000
[    0.269862] Internal error: Oops: 75 [#1] ARM
[    0.274734] Modules linked in:
[    0.278313] CPU: 0 PID: 1 Comm: swapper Not tainted 4.4.0-rc1-e3-los_afe0c+-00002-g25379c0-dirty #1
[    0.288246] Hardware name: Amstrad E3 (Delta)
[    0.293146] task: c1836000 ti: c1838000 task.ti: c1838000
[    0.299155] PC is at irq_gc_mask_set_bit+0x1c/0x60
[    0.304525] LR is at __irq_do_set_handler+0x118/0x15c
[    0.310165] pc : [<c004848c>]    lr : [<c0047d4c>]    psr: 600000d3
[    0.310165] sp : c1839c90  ip : c1862c64  fp : c1839c9c
[    0.322740] r10: 00000000  r9 : c0411950  r8 : c0411bbc
[    0.328533] r7 : 00000000  r6 : c185c310  r5 : c00444e8  r4 : c185c300
[    0.335687] r3 : c1854b50  r2 : 00000000  r1 : 00000000  r0 : c185c310
[    0.342858] Flags: nZCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[    0.351153] Control: 0000317f  Table: 10004000  DAC: 00000057
[    0.357494] Process swapper (pid: 1, stack limit = 0xc1838190)
[    0.363917] Stack: (0xc1839c90 to 0xc183a000)
[    0.368837] 9c80:                                     c1839cc4 c1839ca0 c0047d4c c0048480
[    0.377916] 9ca0: 00000000 00000000 00000050 c185c300 c00444e8 00000000 c1839cec c1839cc8
[    0.386989] 9cc0: c0047dd4 c0047c44 c0046f40 a0000053 00000050 c00444e8 00000000 00000050
[    0.396064] 9ce0: c1839d0c c1839cf0 c0047e1c c0047da0 c1862c64 00000050 00000000 00000050
[    0.405139] 9d00: c1839d24 c1839d10 c01b345c c0047dfc c185cb00 c185c310 c1839d54 c1839d28
[    0.414214] 9d20: c0049670 c01b3430 c0075888 c0043440 c1854b50 00000001 00000010 00000050
[    0.423293] 9d40: c185cb00 c0411bbc c1839d7c c1839d58 c0049894 c0049604 00000000 c1862c64
[    0.432375] 9d60: c1854b50 c1862c64 c0419280 c1862c64 c1839d9c c1839d80 c01b3328 c004980c
[    0.441456] 9d80: c1862c64 c1862c64 c1862c10 c1854b50 c1839ddc c1839da0 c01b79f4 c01b32d4
[    0.450530] 9da0: 00000000 00000000 c0411958 c0419294 00000000 c0411950 c0419294 c0411984
[    0.459605] 9dc0: c0419294 00000000 c03e45e8 00000000 c1839df4 c1839de0 c01fcf58 c01b7708
[    0.468684] 9de0: c0411950 c045ce30 c1839e1c c1839df8 c01fb668 c01fcf3c c0411950 c0419294
[    0.477759] 9e00: c0411984 00000000 00000000 c03e45e8 c1839e3c c1839e20 c01fb844 c01fb518
[    0.486836] 9e20: 00000000 c0419294 c01fb7a4 00000000 c1839e64 c1839e40 c01f9a90 c01fb7b4
[    0.495913] 9e40: c185434c c185b450 c185b514 c0419294 c185b4e0 c041d9c8 c1839e74 c1839e68
[    0.504991] 9e60: c01fb078 c01f9a28 c1839e9c c1839e78 c01facf8 c01fb068 c03931d0 c1839e88
[    0.514069] 9e80: c0419294 c040bb80 c1804960 c03f5a08 c1839eb4 c1839ea0 c01fbdb0 c01fab7c
[    0.523150] 9ea0: c040bb80 c040bb80 c1839ec4 c1839eb8 c01fcf18 c01fbd40 c1839ed4 c1839ec8
[    0.532227] 9ec0: c03f5a20 c01fcef0 c1839f4c c1839ed8 c000966c c03f5a18 c1839efc c1839ee8
[    0.541304] 9ee0: c03e4604 c019b3b4 c03e2700 c1ffcd34 c1839f4c c1839f00 c00314ec c03e45f8
[    0.550384] 9f00: 00000000 00000000 00000002 00000002 00000000 c03e2024 c038f2fc 00000000
[    0.559465] 9f20: c1839f4c 00000002 c03ff81c 00000002 c03ff820 0000005e c042ba80 c042ba80
[    0.568543] 9f40: c1839f94 c1839f50 c03e4e14 c00095f0 00000002 00000002 00000000 c03e45e8
[    0.577625] 9f60: 9b7bd08b c0406660 ad19cf47 00000000 c0305764 00000000 00000000 00000000
[    0.586701] 9f80: 00000000 00000000 c1839fac c1839f98 c0305774 c03e4d18 00000000 c0305764
[    0.595775] 9fa0: 00000000 c1839fb0 c000a440 c0305774 00000000 00000000 00000000 00000000
[    0.604845] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.613916] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 faef8a80 f438707c
[    0.622908] Backtrace: 
[    0.625894] [<c0048470>] (irq_gc_mask_set_bit) from [<c0047d4c>] (__irq_do_set_handler+0x118/0x15c)
[    0.635897] [<c0047c34>] (__irq_do_set_handler) from [<c0047dd4>] (__irq_set_handler+0x44/0x5c)
[    0.645458]  r6:00000000 r5:c00444e8 r4:c185c300
[    0.650746] [<c0047d90>] (__irq_set_handler) from [<c0047e1c>] (irq_set_chip_and_handler_name+0x30/0x34)
[    0.661128]  r7:00000050 r6:00000000 r5:c00444e8 r4:00000050
[    0.667559] [<c0047dec>] (irq_set_chip_and_handler_name) from [<c01b345c>] (gpiochip_irq_map+0x3c/0x8c)
[    0.677869]  r7:00000050 r6:00000000 r5:00000050 r4:c1862c64
[    0.684300] [<c01b3420>] (gpiochip_irq_map) from [<c0049670>] (irq_domain_associate+0x7c/0x1c4)
[    0.693885]  r5:c185c310 r4:c185cb00
[    0.698072] [<c00495f4>] (irq_domain_associate) from [<c0049894>] (irq_domain_add_simple+0x98/0xc0)
[    0.708008]  r8:c0411bbc r7:c185cb00 r6:00000050 r5:00000010 r4:00000001
[    0.715561] [<c00497fc>] (irq_domain_add_simple) from [<c01b3328>] (_gpiochip_irqchip_add+0x64/0x10c)
[    0.725693]  r7:c1862c64 r6:c0419280 r5:c1862c64 r4:c1854b50
[    0.732152] [<c01b32c4>] (_gpiochip_irqchip_add) from [<c01b79f4>] (omap_gpio_probe+0x2fc/0x63c)
[    0.741848]  r5:c1854b50 r4:c1862c10
[    0.746069] [<c01b76f8>] (omap_gpio_probe) from [<c01fcf58>] (platform_drv_probe+0x2c/0x64)
[    0.755309]  r10:00000000 r9:c03e45e8 r8:00000000 r7:c0419294 r6:c0411984 r5:c0419294
[    0.764089]  r4:c0411950
[    0.767193] [<c01fcf2c>] (platform_drv_probe) from [<c01fb668>] (really_probe+0x160/0x29c)
[    0.776327]  r5:c045ce30 r4:c0411950
[    0.780546] [<c01fb508>] (really_probe) from [<c01fb844>] (__driver_attach+0xa0/0xa4)
[    0.789224]  r9:c03e45e8 r8:00000000 r7:00000000 r6:c0411984 r5:c0419294 r4:c0411950
[    0.798032] [<c01fb7a4>] (__driver_attach) from [<c01f9a90>] (bus_for_each_dev+0x78/0xa8)
[    0.807072]  r7:00000000 r6:c01fb7a4 r5:c0419294 r4:00000000
[    0.813515] [<c01f9a18>] (bus_for_each_dev) from [<c01fb078>] (driver_attach+0x20/0x28)
[    0.822371]  r6:c041d9c8 r5:c185b4e0 r4:c0419294
[    0.827710] [<c01fb058>] (driver_attach) from [<c01facf8>] (bus_add_driver+0x18c/0x214)
[    0.836699] [<c01fab6c>] (bus_add_driver) from [<c01fbdb0>] (driver_register+0x80/0x100)
[    0.845649]  r7:c03f5a08 r6:c1804960 r5:c040bb80 r4:c0419294
[    0.852098] [<c01fbd30>] (driver_register) from [<c01fcf18>] (__platform_driver_register+0x38/0x4c)
[    0.862048]  r5:c040bb80 r4:c040bb80
[    0.866290] [<c01fcee0>] (__platform_driver_register) from [<c03f5a20>] (omap_gpio_drv_reg+0x18/0x20)
[    0.876568] [<c03f5a08>] (omap_gpio_drv_reg) from [<c000966c>] (do_one_initcall+0x8c/0x1fc)
[    0.885889] [<c00095e0>] (do_one_initcall) from [<c03e4e14>] (kernel_init_freeable+0x10c/0x1d0)
[    0.895458]  r8:c042ba80 r7:c042ba80 r6:0000005e r5:c03ff820 r4:00000002
[    0.903019] [<c03e4d08>] (kernel_init_freeable) from [<c0305774>] (kernel_init+0x10/0xf4)
[    0.912062]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0305764
[    0.920838]  r4:00000000
[    0.923926] [<c0305764>] (kernel_init) from [<c000a440>] (ret_from_fork+0x14/0x34)
[    0.932325]  r5:c0305764 r4:00000000
[    0.936464] Code: e5903010 e590c018 e59310a4 e5902000 (e5910000) 
[    0.943361] ---[ end trace 6ff0b7ecbf0a5042 ]---
[    0.948957] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    0.948957] 
[    0.959323] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

A.

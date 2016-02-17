From: Tony Lindgren <tony@atomide.com>
Subject: Bunch of machines are not booting in next again, GPIO regression?
Date: Wed, 17 Feb 2016 11:27:55 -0800
Message-ID: <20160217192755.GC21202@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, Michael Welling <mwelling@ieee.org>, Markus Pargmann <mpa@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Linus,

Looks like ff2b13592299 ("gpio: make the gpiochip a real device")
broke booting on all omaps, and probably other machines too according
to this:

https://kernelci.org/boot/all/job/next/kernel/next-20160217/

So far we've gone from 1 failed machine with next-20160216 to
18 failed machines with next-20160217.

The error I'm getting on omaps is below with debug_ll enable,
any ideas?

Regards,

Tony

8< -----------------------
Unable to handle kernel paging request at virtual address d1ba37bc
pgd = c0004000
[d1ba37bc] *pgd=00000000
Internal error: Oops: 5 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.5.0-rc4-next-20160217 #1024
Hardware name: Nokia RX-51 board
task: ce0a8d40 ti: ce0aa000 task.ti: ce0aa000
PC is at kfree+0x50/0x144
LR is at kfree+0x34/0x144
pc : [<c026d690>]    lr : [<c026d674>]    psr: 20000093
sp : ce0abc88  ip : ce0abbf7  fp : 00000000
r10: c0837794  r9 : ce1c0c00  r8 : ce1b30a4
r7 : c0cbf824  r6 : a0000013  r5 : ab51ab30  r4 : ce1c0c10
r3 : d1ba37a8  r2 : cfa8c000  r1 : 00000000  r0 : ab51ab30
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 80004019  DAC: 00000051
Process swapper/0 (pid: 1, stack limit = 0xce0aa218)
Stack: (0xce0abc88 to 0xce0ac000)
bc80:                   ce1c0c10 ce1bfe00 ce1bfe00 ce1b30a4 ce1b30a4 ce1c0c00
bca0: c0837794 c04632e4 ce1b3010 00000000 ce1c0c08 c04f873c 00000000 ce0abcc8
bcc0: c0498560 c09c9f94 00000000 ce1c0c08 c0770730 ce0a8d40 00000001 60000013
bce0: ce1bd010 c018a838 ce1c0c08 ce1bd0a0 00000004 c0770730 00000000 ce1b3010
bd00: ce1916d0 00000000 ce1b30a4 ce1bd010 cfdb137c c0837794 00000000 c049db40
bd20: c149646c c14964b8 ce0a8d40 ce1bd010 ce1bd010 ce1bd010 c0c80c9c fffffdfb
bd40: 00000000 00000000 00000000 c04fe394 ce1bd010 c14964b0 c14964b8 c0c80c9c
bd60: 00000000 c04fca7c 00000000 ce0abda0 c04fcbcc 00000001 00000000 c149646c
bd80: 00000000 c04fae50 ce0b38d4 ce19fed4 ce1bd010 ce1bd044 c0c898e0 c04fc790
bda0: ce1bd010 00000001 c0c8a308 ce1bd018 ce1bd010 c0c898e0 00000000 c04fbc6c
bdc0: ce1bd018 ce1bd010 ce1b5010 c04f9f78 00000000 00000000 00000000 00000001
bde0: ce1bd000 ce1bd010 ce1b5010 cfdb13cc 00000000 ce1b5010 00000000 c05f6f28
be00: 00000000 cfdb137c c0b58048 00000001 c0b61f30 c05f7048 00000000 ce0a92e0
be20: c05f3ec0 60000013 c0c9ec18 c0b58048 00000001 c0b61f30 60000013 c0c9ec18
be40: c0b58048 cfdb137c cfd8275c c0b58048 00000001 c0b61f30 ce1b5010 00000000
be60: 00000000 c05f70a4 00000001 ce0a92e0 c05f3ec0 60000013 c0c9ec18 c0b61f30
be80: c0b58048 00000000 60000013 c0c9ec18 c0b61f30 cfd8275c cfd8176c c0b61f30
bea0: c0b58048 00000000 00000001 c0b4f858 c0b00594 c05f7228 00000001 c05f4928
bec0: c0b581b0 c0b61f30 c0c06950 ce1b13c0 c0b037f8 00000000 00000000 c0b138fc
bee0: c0c06950 c0b134fc c0c06950 c0b03814 c0c06950 c01018b0 c0c3f04c 60000013
bf00: ce0a92e8 00000000 00000000 00000006 ce0a8d40 00000000 cfdff1a7 0000009f
bf20: c082b75c c0155590 ce0a8d40 c0980c40 c0a3d9ac 00000000 00000003 00000003
bf40: c0b684a0 00000003 00000003 c0b4f844 0000009f c0cc4000 c0cc4000 c0b4f858
bf60: c0b00594 c0b00ef0 00000003 00000003 00000000 c0b00594 c5804050 c0b685b4
bf80: c076a14c 00000000 c076a14c 00000000 00000000 00000000 00000000 00000000
bfa0: 00000000 c076a154 00000000 c0107970 00000000 00000000 00000000 00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000 1ea05404 55c61c1d
[<c026d690>] (kfree) from [<c04632e4>] (kobject_set_name_vargs+0x7c/0xa4)
[<c04632e4>] (kobject_set_name_vargs) from [<c04f873c>] (dev_set_name+0x24/0x34)
[<c04f873c>] (dev_set_name) from [<c0498560>] (gpiochip_add_data+0x9c/0x76c)
[<c0498560>] (gpiochip_add_data) from [<c049db40>] (omap_gpio_probe+0x2d4/0x690)
[<c049db40>] (omap_gpio_probe) from [<c04fe394>] (platform_drv_probe+0x4c/0xb0)
[<c04fe394>] (platform_drv_probe) from [<c04fca7c>] (driver_probe_device+0x208/0x2c0)
[<c04fca7c>] (driver_probe_device) from [<c04fae50>] (bus_for_each_drv+0x64/0x98)
[<c04fae50>] (bus_for_each_drv) from [<c04fc790>] (__device_attach+0xb0/0x118)
[<c04fc790>] (__device_attach) from [<c04fbc6c>] (bus_probe_device+0x88/0x90)
[<c04fbc6c>] (bus_probe_device) from [<c04f9f78>] (device_add+0x348/0x568)
[<c04f9f78>] (device_add) from [<c05f6f28>] (of_platform_device_create_pdata+0x80/0xb8)
[<c05f6f28>] (of_platform_device_create_pdata) from [<c05f7048>] (of_platform_bus_create+0xdc/0x18c)
[<c05f7048>] (of_platform_bus_create) from [<c05f70a4>] (of_platform_bus_create+0x138/0x18c)
[<c05f70a4>] (of_platform_bus_create) from [<c05f7228>] (of_platform_populate+0x5c/0xac)
[<c05f7228>] (of_platform_populate) from [<c0b138fc>] (pdata_quirks_init+0x54/0x74)
[<c0b138fc>] (pdata_quirks_init) from [<c0b134fc>] (omap_generic_init+0x10/0x1c)
[<c0b134fc>] (omap_generic_init) from [<c0b03814>] (customize_machine+0x1c/0x40)
[<c0b03814>] (customize_machine) from [<c01018b0>] (do_one_initcall+0x80/0x1dc)
[<c01018b0>] (do_one_initcall) from [<c0b00ef0>] (kernel_init_freeable+0x218/0x2ec)
[<c0b00ef0>] (kernel_init_freeable) from [<c076a154>] (kernel_init+0x8/0xf4)
[<c076a154>] (kernel_init) from [<c0107970>] (ret_from_fork+0x14/0x24)
Code: e1a00005 e5922000 e0833183 e0823103 (e5932014) 
---[ end trace ebca4d029d5eaa4e ]---


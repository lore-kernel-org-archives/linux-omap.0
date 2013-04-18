From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: ARM: dts: omap3: NAND support - how?
Date: Thu, 18 Apr 2013 14:39:49 -0500
Message-ID: <51704C05.4030200@ti.com>
References: <1366311829.4085.90.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55768 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860Ab3DRTjy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Apr 2013 15:39:54 -0400
In-Reply-To: <1366311829.4085.90.camel@mars>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Daniel Mack <daniel@zonque.org>, linux-omap@vger.kernel.org


On 04/18/2013 02:03 PM, Christoph Fritz wrote:
> Hi
> 
>  I'm trying to setup nand support for an omap3 board for linux-next
> (next-20130417). This is my approach so far:
> 
> 
> +&gpmc {
> +       ranges = <0 0 0x30000000 0x1000000>;
> +       nand@0,0 {
> +               reg = <0 0 0xff>;       /* <- ? not sure about that */

I had put the complete size in here so ...

+               reg = <0 0 0x1000000>;

> +               nand-bus-width = <16>;
> +               ti,nand-ecc-opt = "bch8";
> +               /* no elm on omap3 */
> +
> +               gpmc,time-para-granularity = <0>;

This is a boolean parameter so you don't need the "= <0>".

> +               gpmc,mux-add-data = <0>;

This should be either 1 or 2.

> +               gpmc,device-nand = <1>;

This is a boolean parameter so you don't need the "= <0>".

> +               gpmc,device-width = <2>;
> +               gpmc,wait-pin = <0>;
> +               gpmc,wait-on-write = <0>;

This is a boolean parameter so you don't need the "= <0>".

> +               gpmc,wait-on-read = <0>;

This is a boolean parameter so you don't need the "= <0>".

> +               gpmc,burst-length= <4>;
> +               gpmc,sync-write = <0>;

This is a boolean parameter so you don't need the "= <0>".

> +               gpmc,burst-write = <0>;

This is a boolean parameter so you don't need the "= <0>".

> +               gpmc,sync-read = <0>;

This is a boolean parameter so you don't need the "= <0>".

> +               gpmc,burst-read = <0>;

This is a boolean parameter so you don't need the "= <0>".

> +               gpmc,burst-wrap = <0>;

This is a boolean parameter so you don't need the "= <0>".

> +               gpmc,cs-on-ns = <0>;
> +               gpmc,cs-extra-delay = <0>;
> +               gpmc,cs-rd-off-ns = <0x14>;
> +               gpmc,cs-wr-off-ns = <0x14>;
> +               gpmc,adv-on-ns = <0>;
> +               gpmc,adv-extra-delay = <0>;
> +               gpmc,adv-rd-off-ns = <0x14>;
> +               gpmc,adv-wr-off-ns = <0x14>;
> +               gpmc,oe-on-ns = <0x1>;
> +               gpmc,oe-extra-delay = <0>;
> +               gpmc,oe-off-ns = <0xF>;
> +               gpmc,we-on-ns = <0x1>;
> +               gpmc,we-extra-delay = <0>;
> +               gpmc,we-off-ns = <0xF>;
> +               gpmc,rd-cycle-ns = <0x14>;
> +               gpmc,wr-cycle-ns = <0x14>;
> +               gpmc,access-ns = <0xC>;
> +               gpmc,page-burst-access-ns = <0x1>;
> +               gpmc,bus-turnaround-ns = <0x0>;
> +               gpmc,cycle2cycle-diffcsen = <0x0>;
> +               gpmc,cycle2cycle-samecsen = <0x1>;
> +               gpmc,cycle2cycle-delay-ns = <0xA>;
> +               gpmc,wr-data-mux-bus-ns = <0xF>;
> +               gpmc,wr-access-ns = <0x1F>;
> +
> +               #address-cells = <1>;   /* <- ? not sure about that */
> +               #size-cells = <1>;      /* <- ? not sure about that */

This is just needed in case you wish to list partition info. Seeing as
you don't you can omit.

> +       };
> +};
> +
> 
> I took the GPMC NAND config from u-boot where it's working correct.
> Without the additional nand approach from above, the board is working
> more or less fine. But with this patch I do get the following crash:
> 
> [    1.372467] mtdoops: mtd device (mtddev=name/number) must be supplied
> [    1.380615] Missing elm_id property, fall back to Software BCH
> [    1.389373] enabling NAND BCH ecc with 8-bit correction
> [    1.394927] nand_read_byte16, 166, 0xc8852000
> [    1.403625] Unhandled fault: external abort on non-linefetch (0x1008) at 0xc8852000
> [    1.411651] Internal error: : 1008 [#1] PREEMPT ARM
> [    1.416778] Modules linked in:
> [    1.419982] CPU: 0    Not tainted  (3.9.0-rc7-next-20130417-00036-ga693803-dirty #373)
> [    1.428283] PC is at nand_read_byte16+0x30/0x64
> [    1.433044] LR is at nand_read_byte16+0x2c/0x64
> [    1.437774] pc : [<c032f358>]    lr : [<c032f354>]    psr: 20000113
> [    1.437774] sp : c7057dd8  ip : c7055440  fp : 00000000
> [    1.449798] r10: c7057e4c  r9 : c7057e48  r8 : ffffffff
> [    1.455291] r7 : c72ce370  r6 : c72ce370  r5 : c05f9bb8  r4 : c051c270
> [    1.462158] r3 : c7055440  r2 : c8852000  r1 : 00000001  r0 : 00000021
> [    1.468994] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> [    1.476623] Control: 10c5387d  Table: 80004019  DAC: 00000015
> [    1.482635] Process swapper (pid: 1, stack limit = 0xc7056238)
> [    1.488739] Stack: (0xc7057dd8 to 0xc7058000)
> [    1.493316] 7dc0:                                                       c72ce050 000000ff
> [    1.501861] 7de0: ffffffff c033194c 00000000 c72ce370 c72ce050 00000000 c7057e18 c03320bc
> [    1.510437] 7e00: 00000001 00000000 c72c7b80 c72ce000 c72ce050 00000002 00000000 c0c74054
> [    1.519042] 7e20: c72ce370 c72ce050 00000000 00000001 00000002 0000008e c0702a20 c0332674
> [    1.527648] 7e40: c7057e48 00000000 c0637790 00000008 00000000 c72ce000 c72ce050 c700a690
> [    1.536285] 7e60: 00000000 c0c74054 0000008e c0336300 00000000 c72c7f50 c7120ef0 00000000
> [    1.544921] 7e80: 00000000 c0702a20 c0702a28 c0c73628 c072a57c c0702a20 00000000 c072a57c
> [    1.553527] 7ea0: c06d12fc c02ef658 c0c73628 c02ee32c c0702a20 c072a57c c0702a54 00000000
> [    1.562133] 7ec0: c06c709c c02ee4e4 c0702a20 c072a57c c0702a54 c02ee590 c072a57c c02ee4fc
> [    1.570709] 7ee0: c7057ee8 c02ecc5c c704b2a8 c7115690 c704b2d8 c072a57c c0723888 c72ba640
> [    1.579284] 7f00: 00000000 c02ed504 c05fed1c c072a57c c073bd40 c06d12f4 c072a57c c073bd40
> [    1.587890] 7f20: 00000000 c02eeb80 c06d12f4 c06db898 c073bd40 00000000 c06c709c c000874c
> [    1.596496] 7f40: 00000000 c06d12f4 00000006 c073bd40 c06d12f4 c06db898 c073bd40 00000007
> [    1.605072] 7f60: c06aa3e8 c06aa2b0 00000006 00000006 c06aa3e8 00000000 c06db460 c06db460
> [    1.613616] 7f80: 00000000 00000000 00000000 00000000 00000000 c06aa350 00000000 c04eb510
> [    1.622192] 7fa0: 00000000 c04eb518 00000000 c0009ec8 00000000 00000000 00000000 00000000
> [    1.630767] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.639312] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 10d18100 04440800
> [    1.647888] [<c032f358>] (nand_read_byte16+0x30/0x64) from [<c033194c>] (nand_command+0x174/0x1ec)
> [    1.657287] [<c033194c>] (nand_command+0x174/0x1ec) from [<c03320bc>] (nand_get_flash_type+0x4c/0x5b8)
> [    1.667053] [<c03320bc>] (nand_get_flash_type+0x4c/0x5b8) from [<c0332674>] (nand_scan_ident+0x4c/0x1a8)
> [    1.676971] [<c0332674>] (nand_scan_ident+0x4c/0x1a8) from [<c0336300>] (omap_nand_probe+0x2dc/0x6dc)
> [    1.686614] [<c0336300>] (omap_nand_probe+0x2dc/0x6dc) from [<c02ef658>] (platform_drv_probe+0x18/0x1c)
> [    1.696502] [<c02ef658>] (platform_drv_probe+0x18/0x1c) from [<c02ee32c>] (really_probe+0x70/0x1f8)
> [    1.705963] [<c02ee32c>] (really_probe+0x70/0x1f8) from [<c02ee4e4>] (driver_probe_device+0x30/0x48)
> [    1.715545] [<c02ee4e4>] (driver_probe_device+0x30/0x48) from [<c02ee590>] (__driver_attach+0x94/0x98)
> [    1.725341] [<c02ee590>] (__driver_attach+0x94/0x98) from [<c02ecc5c>] (bus_for_each_dev+0x74/0x98)
> [    1.734832] [<c02ecc5c>] (bus_for_each_dev+0x74/0x98) from [<c02ed504>] (bus_add_driver+0x1c8/0x234)
> [    1.744445] [<c02ed504>] (bus_add_driver+0x1c8/0x234) from [<c02eeb80>] (driver_register+0x78/0x140)
> [    1.754058] [<c02eeb80>] (driver_register+0x78/0x140) from [<c000874c>] (do_one_initcall+0xc0/0x134)
> [    1.763702] [<c000874c>] (do_one_initcall+0xc0/0x134) from [<c06aa2b0>] (do_basic_setup+0x84/0xc4)
> [    1.773132] [<c06aa2b0>] (do_basic_setup+0x84/0xc4) from [<c06aa350>] (kernel_init_freeable+0x60/0xf8)
> [    1.782958] [<c06aa350>] (kernel_init_freeable+0x60/0xf8) from [<c04eb518>] (kernel_init+0x8/0xe4)
> [    1.792419] [<c04eb518>] (kernel_init+0x8/0xe4) from [<c0009ec8>] (ret_from_fork+0x14/0x2c)
> [    1.801239] Code: e3a020a6 e5963000 eb06f2ce e5962000 (e1d230b0)
> [    1.807708] ---[ end trace 8c2fb2c3b59ab3aa ]---
> [    1.812591] ------------[ cut here ]------------
> [    1.817443] Kernel BUG at c0287f84 [verbose debug info unavailable]
> [    1.824035] Internal error: Oops - BUG: 0 [#2] PREEMPT ARM
> [    1.829772] Modules linked in:
> [    1.833007] CPU: 0    Tainted: G      D       (3.9.0-rc7-next-20130417-00036-ga693803-dirty #373)
> [    1.842285] PC is at omap3_l3_app_irq+0xa4/0x128
> [    1.847137] LR is at handle_irq_event_percpu+0x50/0x1b4
> [    1.852630] pc : [<c0287f84>]    lr : [<c0082600>]    psr: 20000193
> [    1.852630] sp : c7057bc8  ip : c7057bf8  fp : c073bc1e
> [    1.864624] r10: c70055b8  r9 : 3ccf0000  r8 : 0b6db6c3
> [    1.870117] r7 : 00000000  r6 : 00000000  r5 : 00020000  r4 : 00000000
> [    1.876953] r3 : 00020000  r2 : 00000004  r1 : f8000000  r0 : 00020000
> [    1.883789] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
> [    1.891387] Control: 10c5387d  Table: 80004019  DAC: 00000015
> [    1.897399] Process swapper (pid: 1, stack limit = 0xc7056238)
> [    1.903503] Stack: (0xc7057bc8 to 0xc7058000)
> [    1.908081] 7bc0:                   00000000 60000193 00000001 c7097a00 c7005590 00000000
> [    1.916656] 7be0: 00000000 0000001a c7005540 c70055b8 c073bc1e c0082600 c7056000 00000000
> [    1.925231] 7c00: 60000193 c7005540 c7005590 c7097a00 c073c814 ffffffff c7057e48 c7057e4c
> [    1.933807] 7c20: 00000000 c00827a0 c7005540 c7005590 00000000 c0084cec 0000001a 0000001a
> [    1.942382] 7c40: 00000000 c00825a0 c071c5c4 c000a69c fa200000 0000001a c7057c78 c0008538
> [    1.950958] 7c60: c04efa78 60000113 ffffffff c7057cac ffffffff c00099c4 00000001 00000001
> [    1.959533] 7c80: c7055440 00000000 c06e803c c7056000 0000000b 00000001 ffffffff c7057e48
> [    1.968078] 7ca0: c7057e4c 00000000 c7057c98 c7057cc0 c04efa70 c04efa78 60000113 ffffffff
> [    1.976684] 7cc0: c7055440 c0034090 60000193 c06e8540 0000000b c7057d90 ffffffff c000d3b0
> [    1.985260] 7ce0: 00001008 c06e8fc4 c8852000 c00084c4 00000000 00000000 00000007 00000000
> [    1.993835] 7d00: 00000000 c8852000 ffffffff c00099e8 00000001 00000001 00000000 c7055440
> [    2.002410] 7d20: 00000000 00000000 00000021 c073d288 00000000 60000113 00000000 00000000
> [    2.010986] 7d40: c7055440 c7057d58 c006af80 c0030cfc 20000113 ffffffff 00000000 00000000
> [    2.019561] 7d60: 00000000 00000000 c073dbba 00000021 20000193 c0708248 00000000 c032f358
> [    2.028137] 7d80: 20000113 ffffffff c7057dc4 c000995c 00000021 00000001 c8852000 c7055440
> [    2.036743] 7da0: c051c270 c05f9bb8 c72ce370 c72ce370 ffffffff c7057e48 c7057e4c 00000000
> [    2.045318] 7dc0: c7055440 c7057dd8 c032f354 c032f358 20000113 ffffffff c72ce050 000000ff
> [    2.053894] 7de0: ffffffff c033194c 00000000 c72ce370 c72ce050 00000000 c7057e18 c03320bc
> [    2.062469] 7e00: 00000001 00000000 c72c7b80 c72ce000 c72ce050 00000002 00000000 c0c74054
> [    2.071044] 7e20: c72ce370 c72ce050 00000000 00000001 00000002 0000008e c0702a20 c0332674
> [    2.079620] 7e40: c7057e48 00000000 c0637790 00000008 00000000 c72ce000 c72ce050 c700a690
> [    2.088195] 7e60: 00000000 c0c74054 0000008e c0336300 00000000 c72c7f50 c7120ef0 00000000
> [    2.096771] 7e80: 00000000 c0702a20 c0702a28 c0c73628 c072a57c c0702a20 00000000 c072a57c
> [    2.105346] 7ea0: c06d12fc c02ef658 c0c73628 c02ee32c c0702a20 c072a57c c0702a54 00000000
> [    2.113952] 7ec0: c06c709c c02ee4e4 c0702a20 c072a57c c0702a54 c02ee590 c072a57c c02ee4fc
> [    2.122528] 7ee0: c7057ee8 c02ecc5c c704b2a8 c7115690 c704b2d8 c072a57c c0723888 c72ba640
> [    2.131103] 7f00: 00000000 c02ed504 c05fed1c c072a57c c073bd40 c06d12f4 c072a57c c073bd40
> [    2.139709] 7f20: 00000000 c02eeb80 c06d12f4 c06db898 c073bd40 00000000 c06c709c c000874c
> [    2.148254] 7f40: 00000000 c06d12f4 00000006 c073bd40 c06d12f4 c06db898 c073bd40 00000007
> [    2.156829] 7f60: c06aa3e8 c06aa2b0 00000006 00000006 c06aa3e8 00000000 c06db460 c06db460
> [    2.165405] 7f80: 00000000 00000000 00000000 00000000 00000000 c06aa350 00000000 c04eb510
> [    2.173980] 7fa0: 00000000 c04eb518 00000000 c0009ec8 00000000 00000000 00000000 00000000
> [    2.182525] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    2.191101] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 10d18100 04440800
> [    2.199676] [<c0287f84>] (omap3_l3_app_irq+0xa4/0x128) from [<c0082600>] (handle_irq_event_percpu+0x50/0x1b4)
> [    2.210083] [<c0082600>] (handle_irq_event_percpu+0x50/0x1b4) from [<c00827a0>] (handle_irq_event+0x3c/0x5c)
> [    2.220428] [<c00827a0>] (handle_irq_event+0x3c/0x5c) from [<c0084cec>] (handle_level_irq+0x8c/0x118)
> [    2.230102] [<c0084cec>] (handle_level_irq+0x8c/0x118) from [<c00825a0>] (generic_handle_irq+0x28/0x30)
> [    2.239959] [<c00825a0>] (generic_handle_irq+0x28/0x30) from [<c000a69c>] (handle_IRQ+0x30/0x84)
> [    2.249176] [<c000a69c>] (handle_IRQ+0x30/0x84) from [<c0008538>] (omap3_intc_handle_irq+0x64/0x74)
> [    2.258636] [<c0008538>] (omap3_intc_handle_irq+0x64/0x74) from [<c00099c4>] (__irq_svc+0x44/0x78)
> [    2.268005] Exception stack(0xc7057c78 to 0xc7057cc0)
> [    2.273315] 7c60:                                                       00000001 00000001
> [    2.281890] 7c80: c7055440 00000000 c06e803c c7056000 0000000b 00000001 ffffffff c7057e48
> [    2.290466] 7ca0: c7057e4c 00000000 c7057c98 c7057cc0 c04efa70 c04efa78 60000113 ffffffff
> [    2.299041] [<c00099c4>] (__irq_svc+0x44/0x78) from [<c04efa78>] (_raw_spin_unlock_irq+0x2c/0x50)
> [    2.308349] [<c04efa78>] (_raw_spin_unlock_irq+0x2c/0x50) from [<c0034090>] (do_exit+0x268/0x358)
> [    2.317687] [<c0034090>] (do_exit+0x268/0x358) from [<c000d3b0>] (oops_end+0xb8/0xe8)
> [    2.325897] [<c000d3b0>] (oops_end+0xb8/0xe8) from [<c00084c4>] (do_DataAbort+0x88/0x98)
> [    2.334381] [<c00084c4>] (do_DataAbort+0x88/0x98) from [<c000995c>] (__dabt_svc+0x3c/0x60)
> [    2.343048] Exception stack(0xc7057d90 to 0xc7057dd8)
> [    2.348358] 7d80:                                     00000021 00000001 c8852000 c7055440
> [    2.356964] 7da0: c051c270 c05f9bb8 c72ce370 c72ce370 ffffffff c7057e48 c7057e4c 00000000
> [    2.365539] 7dc0: c7055440 c7057dd8 c032f354 c032f358 20000113 ffffffff
> [    2.372497] [<c000995c>] (__dabt_svc+0x3c/0x60) from [<c032f358>] (nand_read_byte16+0x30/0x64)
> [    2.381530] [<c032f358>] (nand_read_byte16+0x30/0x64) from [<c033194c>] (nand_command+0x174/0x1ec)
> [    2.390960] [<c033194c>] (nand_command+0x174/0x1ec) from [<c03320bc>] (nand_get_flash_type+0x4c/0x5b8)
> [    2.400756] [<c03320bc>] (nand_get_flash_type+0x4c/0x5b8) from [<c0332674>] (nand_scan_ident+0x4c/0x1a8)
> [    2.410736] [<c0332674>] (nand_scan_ident+0x4c/0x1a8) from [<c0336300>] (omap_nand_probe+0x2dc/0x6dc)
> [    2.420440] [<c0336300>] (omap_nand_probe+0x2dc/0x6dc) from [<c02ef658>] (platform_drv_probe+0x18/0x1c)
> [    2.430297] [<c02ef658>] (platform_drv_probe+0x18/0x1c) from [<c02ee32c>] (really_probe+0x70/0x1f8)
> [    2.439819] [<c02ee32c>] (really_probe+0x70/0x1f8) from [<c02ee4e4>] (driver_probe_device+0x30/0x48)
> [    2.449401] [<c02ee4e4>] (driver_probe_device+0x30/0x48) from [<c02ee590>] (__driver_attach+0x94/0x98)
> [    2.459167] [<c02ee590>] (__driver_attach+0x94/0x98) from [<c02ecc5c>] (bus_for_each_dev+0x74/0x98)
> [    2.468658] [<c02ecc5c>] (bus_for_each_dev+0x74/0x98) from [<c02ed504>] (bus_add_driver+0x1c8/0x234)
> [    2.478271] [<c02ed504>] (bus_add_driver+0x1c8/0x234) from [<c02eeb80>] (driver_register+0x78/0x140)
> [    2.487854] [<c02eeb80>] (driver_register+0x78/0x140) from [<c000874c>] (do_one_initcall+0xc0/0x134)
> [    2.497436] [<c000874c>] (do_one_initcall+0xc0/0x134) from [<c06aa2b0>] (do_basic_setup+0x84/0xc4)
> [    2.506835] [<c06aa2b0>] (do_basic_setup+0x84/0xc4) from [<c06aa350>] (kernel_init_freeable+0x60/0xf8)
> [    2.516601] [<c06aa350>] (kernel_init_freeable+0x60/0xf8) from [<c04eb518>] (kernel_init+0x8/0xe4)
> [    2.526031] [<c04eb518>] (kernel_init+0x8/0xe4) from [<c0009ec8>] (ret_from_fork+0x14/0x2c)
> [    2.534759] Code: e5911008 e2813e53 e1c320d0 eaffffe8 (e7f001f2)
> [    2.541168] ---[ end trace 8c2fb2c3b59ab3ab ]---
> [    2.545989] Kernel panic - not syncing: Fatal exception in interrupt
> 
>  Any hints?

Can you include the complete boot log? I am wondering if there were any
errors seen during the gpmc probe.

You can view my nand binding for the omap3430 sdp here [1].

Cheers
Jon

[1]
https://github.com/jonhunter/linux/blob/platform-3.8-jhunter-dt/arch/arm/boot/dts/omap3430-sdp.dts

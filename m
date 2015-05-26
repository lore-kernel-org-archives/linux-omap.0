From: Tony Lindgren <tony@atomide.com>
Subject: Re: simple-framebuffer: ioremap_wc() fails
Date: Tue, 26 May 2015 07:58:54 -0700
Message-ID: <20150526144845.GB16525@atomide.com>
References: <trinity-412e3c6c-33f0-4735-aac6-a8a38ff7e66c-1432378150845@3capp-gmx-bs10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:53939 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606AbbEZO7B (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 May 2015 10:59:01 -0400
Content-Disposition: inline
In-Reply-To: <trinity-412e3c6c-33f0-4735-aac6-a8a38ff7e66c-1432378150845@3capp-gmx-bs10>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Kuemmel <syntheticpp@gmx.net>
Cc: linux-omap@vger.kernel.org

* Peter Kuemmel <syntheticpp@gmx.net> [150523 03:51]:
> Hello,
> 
> I have a problems when using simple-framebuffer: re-using the memory provided 
> by u-boot fails when calling ioremap_wc() in simplefb.c:
> 
> [    0.370025] ------------[ cut here ]------------
> [    0.370086] WARNING: CPU: 0 PID: 1 at arch/arm/mm/ioremap.c:301 __arm_ioremap_pfn_caller+0x220/0x234()
> [    0.370086] Modules linked in:
> [    0.370117] CPU: 0 PID: 1 Comm: swapper Not tainted 4.1.0-rc4 #1
> [    0.370117] Hardware name: Generic OMAP36xx (Flattened Device Tree)
> [    0.370117] Backtrace:
> [    0.370178] [<c00198a0>] (show_stack) from [<c04ded24>] (dump_stack+0x24/0x28)
> [    0.370178]  r5:0000012d r4:c066b608
> [    0.370208] [<c04ded00>] (dump_stack) from [<c003ca7c>] (warn_slowpath_null+0x78/0xe0)
> [    0.370208] [<c003ca04>] (warn_slowpath_null) from [<c001e07c>] (__arm_ioremap_pfn_caller+0x220/0x234)
> [    0.370239]  r6:83800000 r5:00000000 r4:00083800
> [    0.370239] [<c001de5c>] (__arm_ioremap_pfn_caller) from [<c001e0e4>] (__arm_ioremap_caller+0x54/0x5c)
> [    0.370269]  r10:c0653900 r9:c065390c r8:c3b11210 r7:c3aaa264 r6:00000000 r5:c3b11200
> [    0.370269]  r4:00000003 r3:00000003
> [    0.370300] [<c001e090>] (__arm_ioremap_caller) from [<c001db80>] (__arm_ioremap+0x20/0x24)
> [    0.370300]  r4:c3aaa000
> [    0.370330] [<c001db60>] (__arm_ioremap) from [<c02f2c44>] (simplefb_probe+0x1d8/0x82c)
> [    0.370361] [<c02f2a6c>] (simplefb_probe) from [<c033e8a8>] (platform_drv_probe+0x4c/0xac)
> [    0.370361]  r10:00000000 r9:00000000 r8:c0653740 r7:fffffdfb r6:c0653740 r5:c3b11210
> [    0.370391]  r4:c067dcf0
> [    0.370391] [<c033e85c>] (platform_drv_probe) from [<c033d068>] (driver_probe_device+0x2fc/0x388)
> [    0.370422]  r7:c3b11218 r6:00000000 r5:c3b11210 r4:c067dcf0
> [    0.370452] [<c033cd6c>] (driver_probe_device) from [<c033d13c>] (__device_attach+0x48/0x4c)
> [    0.370452]  r9:c067dccc r8:c3b11210 r7:c0657a54 r6:c033d0f4 r5:c3b11210 r4:c0653740
> [    0.370483] [<c033d0f4>] (__device_attach) from [<c033a958>] (bus_for_each_drv+0x6c/0xa0)
> [    0.370483]  r5:c3b11210 r4:00000000
> [    0.370513] [<c033a8ec>] (bus_for_each_drv) from [<c033cacc>] (device_attach+0xb0/0x108)
> [    0.370513]  r6:c0657d08 r5:c3b11244 r4:c3b11210
> [    0.370544] [<c033ca1c>] (device_attach) from [<c033c16c>] (bus_probe_device+0x8c/0xb0)
> [    0.370544]  r6:c0657d08 r5:c3b11210 r4:c3b11218 r3:c3830f00
> [    0.370574] [<c033c0e0>] (bus_probe_device) from [<c03395c4>] (device_add+0x574/0x85c)
> [    0.370574]  r6:00000000 r5:c0657bc8 r4:c3b11218 r3:00000001
> [    0.370605] [<c0339050>] (device_add) from [<c03dd680>] (of_device_add+0x3c/0x44)
> [    0.370635]  r10:00000000 r9:c06065f0 r8:0000005f r7:c3b11210 r6:c3e3aad8 r5:00000000
> [    0.370635]  r4:c3b11200
> [    0.370666] [<c03dd644>] (of_device_add) from [<c03de140>] (of_platform_device_create+0x84/0xc4)
> [    0.370697] [<c03de0bc>] (of_platform_device_create) from [<c06205b8>] (simplefb_init+0x5c/0x88)
> [    0.370697]  r7:c062055c r6:c3b25400 r5:c067e260 r4:c3e3aad8
> [    0.370727] [<c062055c>] (simplefb_init) from [<c0009644>] (do_one_initcall+0x94/0x1dc)
> [    0.370727]  r5:c063fa98 r4:c063fa98
> [    0.370758] [<c00095b0>] (do_one_initcall) from [<c0606dbc>] (kernel_init_freeable+0x12c/0x1d0)
> [    0.370758]  r10:c06306ac r9:c06065f0 r8:0000005f r7:c066a640 r6:c066a640 r5:00000005
> [    0.370788]  r4:c063aca8
> [    0.370788] [<c0606c90>] (kernel_init_freeable) from [<c04dbee8>] (kernel_init+0x10/0x218)
> [    0.370819]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c04dbed8
> [    0.370819]  r4:00000000
> [    0.370849] [<c04dbed8>] (kernel_init) from [<c0016920>] (ret_from_fork+0x14/0x34)
> [    0.370849]  r5:c04dbed8 r4:00000000
> [    0.370910] ---[ end trace 58eeb60b5f9cadf1 ]---
> [    0.370941] simple-framebuffer: probe of 83800000.framebuffer failed with error -12
> 
> I tried with 4.0 and 4.1, also tried with disabled omapfb/dss, but always the same.
> 
> dts looks like this:
> 
>      chosen {
>          #address-cells = <1>;
>          #size-cells = <1>;
>          ranges;
> 
>          framebuffer@0 {
>              compatible = "simple-framebuffer";
>              reg = <0x83800000 (320 * 240 * 3)>;
>              width = <320>;
>              height = <240>;
>              stride = <(320 * 3)>;
>              format = "r8g8b8";
>              display = <&lcd0>;
>          };
>      };
> 
> Is there any special to do in u-boot to make it work?
> u-boot shows a splash screen correctly.
> 
> I saw in sunxi code is a workaround if ioremap_wc() fails,
> https://groups.google.com/forum/#!topic/linux-sunxi/C6pKdmKeZKY
> 
> Is something similar also needed for the omap?

You need to reserve the memory section early with
memblock_reserve(). Then it's available to the driver to
map with pgprot_noncached or pgprot_writecombine and
vmap.

For an example how it can be done in a Linux generic way,
see fs/pstore/ram_core.c, it handles both the vmap and
ioremap case.

Regards,

Tony

From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Bug in linux omap clock framework?
Date: Fri, 05 Dec 2008 10:23:27 -0800
Message-ID: <877i6ejxb4.fsf@deeprootsystems.com>
References: <21FAA8D4A5AB5E4096AC4BE4BF42EB140157D444@vaebe104.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:3674 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222AbYLESXg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 13:23:36 -0500
Received: by ug-out-1314.google.com with SMTP id 39so73121ugf.37
        for <linux-omap@vger.kernel.org>; Fri, 05 Dec 2008 10:23:34 -0800 (PST)
In-Reply-To: <21FAA8D4A5AB5E4096AC4BE4BF42EB140157D444@vaebe104.NOE.Nokia.com> (Tomi Valkeinen's message of "Fri\, 5 Dec 2008 16\:49\:56 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org

<Tomi.Valkeinen@nokia.com> writes:

> Hi,
>
> I have had strange clk_enable() crashes with DSS2, and now I managed to
> isolate it. With the included patch, on OMAP3 SDP board, with default
> kernel config, I always get the crash below. In this example case it
> happens at specific time on boot, but with DSS2 it happens randomly at
> runtime, when I enable the DSS clocks.
>
> diff --git a/drivers/video/omap/omapfb_main.c
> b/drivers/video/omap/omapfb_main.c
> index 3bb4247..2d5ef0d 100644
> --- a/drivers/video/omap/omapfb_main.c
> +++ b/drivers/video/omap/omapfb_main.c
> @@ -27,6 +27,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/mm.h>
>  #include <linux/uaccess.h>
> +#include <linux/clk.h>
>  
>  #include <mach/dma.h>
>  #include <mach/omapfb.h>
> @@ -1806,6 +1807,18 @@ static int omapfb_probe(struct platform_device
> *pdev)
>  {
>         BUG_ON(fbdev_pdev != NULL);
>  
> +       {
> +               struct clk *c1, *c2;
> +               c1 = clk_get(&pdev->dev, "dss_ick");
> +               c2 = clk_get(&pdev->dev, "dss1_fck");
> +               while(1) {
> +                       clk_enable(c1);
> +                       clk_enable(c2);
> +                       clk_disable(c1);
> +                       clk_disable(c2);
> +               }
> +       }
> +
>         /* Delay actual initialization until the LCD is registered */
>         fbdev_pdev = pdev;
>         if (fbdev_panel != NULL)
> @@ -1958,7 +1971,7 @@ module_param_named(rotate, def_rotate, uint,
> 0664);
>  module_param_named(mirror, def_mirror, uint, 0664);
>  module_param_named(manual_update, manual_update, bool, 0664);
>  
> -module_init(omapfb_init);
> +late_initcall(omapfb_init);
>  module_exit(omapfb_cleanup);
>  
>  MODULE_DESCRIPTION("TI OMAP framebuffer driver");
>
>
> And the crash:
>
>
>
> <1>Unhandled fault: external abort on non-linefetch (0x1028) at
> 0xd8200098
> Unhandled fault: external abort on non-linefetch (0x1028) at 0xd8200098
> Internal error: : 1028 [#1]
> Internal error: : 1028 [#1]
> Modules linked in:Modules linked in:
>
> CPU: 0    Not tainted  (2.6.28-rc6-omap1-05264-g1705711-dirty #6)
> CPU: 0    Not tainted  (2.6.28-rc6-omap1-05264-g1705711-dirty #6)
> PC is at __irq_svc+0x34/0x80
> PC is at __irq_svc+0x34/0x80
> LR is at _omap2_clk_enable+0xa0/0xe0
> LR is at _omap2_clk_enable+0xa0/0xe0

What looks to be happening is an interrupt is firing in the middle of
your clk_enable() call, and accesses to the Interrupt controller
registers are triggering a fault.

As a temporary workaround, could you try wrapping your clk_enable() 
with an IRQ save/restore?  Something like:

  local_irq_save(flags);
  clk_enable(c);
  local_irq_restore(flags);

If this works, then we need to investigate in more detail which
interrupt is firing, and why the INTC registers are not accessible.

Kevin

> pc : [<c002c9d4>]    lr : [<c0036314>]    psr: 60000193
> sp : c7817d30  ip : c7817d40  fp : c7817d8c
> pc : [<c002c9d4>]    lr : [<c0036314>]    psr: 60000193
> sp : c7817d30  ip : c7817d40  fp : c7817d8c
> r10: c001a210  r9 : 00000000  r8 : c0395048
> r10: c001a210  r9 : 00000000  r8 : c0395048
> r7 : c03910c0  r6 : c03910c0  r5 : d8200000  r4 : ffffffff
> r7 : c03910c0  r6 : c03910c0  r5 : d8200000  r4 : ffffffff
> r3 : 60000013  r2 : c003ae80  r1 : c0036314  r0 : c7817d78
> r3 : 60000013  r2 : c003ae80  r1 : c0036314  r0 : c7817d78
> Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 10c5387f  Table: 80004018  DAC: 00000017
> Control: 10c5387f  Table: 80004018  DAC: 00000017
> Process swapper (pid: 1, stack limit = 0xc78162e0)
> Process swapper (pid: 1, stack limit = 0xc78162e0)
> Stack: (0xc7817d30 to 0xc7818000)
> Stack: (0xc7817d30 to 0xc7818000)
> 7d20: 7d20:
> 00000000 00000000 00000000 00000000 00000010 00000010 00000001 00000001 
>
> 7d40: 7d40: 80000013 80000013 c037ac4c c037ac4c c03910c0 c03910c0
> c03910c0 c03910c0 c0395048 c0395048 00000000 00000000 c001a210 c001a210
> c7817d8c c7817d8c 
>
> 7d60: 7d60: c7817d40 c7817d40 c7817d78 c7817d78 c0036314 c0036314
> c003ae80 c003ae80 60000013 60000013 ffffffff ffffffff fffffffe fffffffe
> c037ac4c c037ac4c 
>
> 7d80: 7d80: c7817da4 c7817da4 c7817d90 c7817d90 c018bef4 c018bef4
> c003ae48 c003ae48 c037de28 c037de28 c037ded4 c037ded4 c7817db4 c7817db4
> c7817da8 c7817da8 
>
> 7da0: 7da0: c01afd70 c01afd70 c018beac c018beac c7817dd4 c7817dd4
> c7817db8 c7817db8 c01aef90 c01aef90 c01afd5c c01afd5c c037de28 c037de28
> c037ded4 c037ded4 
>
> 7dc0: 7dc0: c03910c0 c03910c0 c03910c0 c03910c0 c7817df4 c7817df4
> c7817dd8 c7817dd8 c01af0a4 c01af0a4 c01aeecc c01aeecc 00000000 00000000
> c7817df8 c7817df8 
>
> 7de0: 7de0: c01af03c c01af03c c03910c0 c03910c0 c7817e1c c7817e1c
> c7817df8 c7817df8 c01ae510 c01ae510 c01af048 c01af048 c78034d8 c78034d8
> c037de70 c037de70 
>
> 7e00: 7e00: 00000000 00000000 c03910c0 c03910c0 00000000 00000000
> c7941b60 c7941b60 c7817e2c c7817e2c c7817e20 c7817e20 c01aedd8 c01aedd8
> c01ae4d0 c01ae4d0 
>
> 7e20: 7e20: c7817e5c c7817e5c c7817e30 c7817e30 c01ae994 c01ae994
> c01aedc4 c01aedc4 c0325184 c0325184 c03910c0 c03910c0 00000000 00000000
> c03a0480 c03a0480 
>
> 7e40: 7e40: c03910c0 c03910c0 00000000 00000000 00000000 00000000
> 00000000 00000000 c7817e84 c7817e84 c7817e60 c7817e60 c01af298 c01af298
> c01ae8f8 c01ae8f8 
>
> 7e60: 7e60: c03a0480 c03a0480 c0024b00 c0024b00 00000000 00000000
> 00000000 00000000 00000000 00000000 c001a210 c001a210 c7817e94 c7817e94
> c7817e88 c7817e88 
>
> 7e80: 7e80: c01b0108 c01b0108 c01af20c c01af20c c7817ebc c7817ebc
> c7817e98 c7817e98 c001a41c c001a41c c01b009c c01b009c c0019c1c c0019c1c
> c01754b0 c01754b0 
>
> 7ea0: 7ea0: 00000000 00000000 00000000 00000000 12bdf916 12bdf916
> c03a0480 c03a0480 c7817fdc c7817fdc c7817ec0 c7817ec0 c002c2d0 c002c2d0
> c001a21c c001a21c 
>
> 7ec0: 7ec0: c78035a0 c78035a0 c78035a4 c78035a4 00000000 00000000
> 0000024e 0000024e c7817f34 c7817f34 c7817ee0 c7817ee0 c016ec10 c016ec10
> c0099994 c0099994 
>
> 7ee0: 7ee0: 00000000 00000000 c7817f54 c7817f54 000000d0 000000d0
> c7811f28 c7811f28 00000000 00000000 c03aa84c c03aa84c 000000d0 000000d0
> c03a93a4 c03a93a4 
>
> 7f00: 7f00: c7817f2c c7817f2c c7817f10 c7817f10 c016ee24 c016ee24
> c783c0a0 c783c0a0 c03859bc c03859bc c783d6e0 c783d6e0 c03a93a4 c03a93a4
> 00000000 00000000 
>
> 7f20: 7f20: 00000000 00000000 00000000 00000000 c7817f44 c7817f44
> c7817f38 c7817f38 c016ec44 c016ec44 c016ea7c c016ea7c c7817f74 c7817f74
> c7817f48 c7817f48 
>
> 7f40: 7f40: c00da818 c00da818 c016ec38 c016ec38 c783d6e0 c783d6e0
> c0328032 c0328032 c7817f9e c7817f9e 0000024e 0000024e c783c0a0 c783c0a0
> c03859bc c03859bc 
>
> 7f60: 7f60: 0000015f 0000015f c03a93a4 c03a93a4 c7817f94 c7817f94
> c7817f78 c7817f78 c00daa00 c00daa00 c00da7ec c00da7ec c7817f94 c7817f94
> c783d6e0 c783d6e0 
>
> 7f80: 7f80: c00dab7c c00dab7c c7817f9e c7817f9e c7817fc4 c7817fc4
> c7817f98 c7817f98 c0077f98 c0077f98 c00daa0c c00daa0c c7817fb4 c7817fb4
> 35337588 35337588 
>
> 7fa0: 7fa0: 00000031 00000031 00000000 00000000 00000192 00000192
> c03865b0 c03865b0 00000000 00000000 c0024e74 c0024e74 c0024b00 c0024b00
> 00000000 00000000 
>
> 7fc0: 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 c7817ff4 c7817ff4 c7817fe0 c7817fe0 c00088b8 c00088b8
> c002c27c c002c27c 
>
> 7fe0: 7fe0: 00000000 00000000 00000000 00000000 00000000 00000000
> c7817ff8 c7817ff8 c00538a8 c00538a8 c0008854 c0008854 ffff0000 ffff0000
> ffff0000 ffff0000 
>
> Backtrace: Backtrace: 
>
> [<c003ae3c>] [<c003ae3c>] (clk_enable+0x0/0x54) (clk_enable+0x0/0x54)
> from [<c018bef4>] from [<c018bef4>] (omapfb_probe+0x54/0x7c)
> (omapfb_probe+0x54/0x7c)
>  r5:c037ac4c r5:c037ac4c r4:fffffffe r4:fffffffe
>
> [<c018bea0>] [<c018bea0>] (omapfb_probe+0x0/0x7c)
> (omapfb_probe+0x0/0x7c) from [<c01afd70>] from [<c01afd70>]
> (platform_drv_probe+0x20/0x24)
> (platform_drv_probe+0x20/0x24)
>  r5:c037ded4 r5:c037ded4 r4:c037de28 r4:c037de28
>
> [<c01afd50>] [<c01afd50>] (platform_drv_probe+0x0/0x24)
> (platform_drv_probe+0x0/0x24) from [<c01aef90>] from [<c01aef90>]
> (driver_probe_device+0xd0/0x17c)
> (driver_probe_device+0xd0/0x17c)
> [<c01aeec0>] [<c01aeec0>] (driver_probe_device+0x0/0x17c)
> (driver_probe_device+0x0/0x17c) from [<c01af0a4>] from [<c01af0a4>]
> (__driver_attach+0x68/0x8c)
> (__driver_attach+0x68/0x8c)
>  r7:c03910c0 r7:c03910c0 r6:c03910c0 r6:c03910c0 r5:c037ded4 r5:c037ded4
> r4:c037de28 r4:c037de28
>
> [<c01af03c>] [<c01af03c>] (__driver_attach+0x0/0x8c)
> (__driver_attach+0x0/0x8c) from [<c01ae510>] from [<c01ae510>]
> (bus_for_each_dev+0x4c/0x84)
> (bus_for_each_dev+0x4c/0x84)
>  r7:c03910c0 r7:c03910c0 r6:c01af03c r6:c01af03c r5:c7817df8 r5:c7817df8
> r4:00000000 r4:00000000
>
> [<c01ae4c4>] [<c01ae4c4>] (bus_for_each_dev+0x0/0x84)
> (bus_for_each_dev+0x0/0x84) from [<c01aedd8>] from [<c01aedd8>]
> (driver_attach+0x20/0x28)
> (driver_attach+0x20/0x28)
>  r7:c7941b60 r7:c7941b60 r6:00000000 r6:00000000 r5:c03910c0 r5:c03910c0
> r4:00000000 r4:00000000
>
> [<c01aedb8>] [<c01aedb8>] (driver_attach+0x0/0x28)
> (driver_attach+0x0/0x28) from [<c01ae994>] from [<c01ae994>]
> (bus_add_driver+0xa8/0x214)
> (bus_add_driver+0xa8/0x214)
> [<c01ae8ec>] [<c01ae8ec>] (bus_add_driver+0x0/0x214)
> (bus_add_driver+0x0/0x214) from [<c01af298>] from [<c01af298>]
> (driver_register+0x98/0x120)
> (driver_register+0x98/0x120)
>  r8:00000000 r8:00000000 r7:00000000 r7:00000000 r6:00000000 r6:00000000
> r5:c03910c0 r5:c03910c0 r4:c03a0480 r4:c03a0480
>
> [<c01af200>] [<c01af200>] (driver_register+0x0/0x120)
> (driver_register+0x0/0x120) from [<c01b0108>] from [<c01b0108>]
> (platform_driver_register+0x78/0x94)
> (platform_driver_register+0x78/0x94)
> [<c01b0090>] [<c01b0090>] (platform_driver_register+0x0/0x94)
> (platform_driver_register+0x0/0x94) from [<c001a41c>] from [<c001a41c>]
> (omapfb_init+0x20c/0x24c)
> (omapfb_init+0x20c/0x24c)
> [<c001a210>] [<c001a210>] (omapfb_init+0x0/0x24c)
> (omapfb_init+0x0/0x24c) from [<c002c2d0>] from [<c002c2d0>]
> (do_one_initcall+0x60/0x18c)
> (do_one_initcall+0x60/0x18c)
>  r4:c03a0480 r4:c03a0480
>
> [<c002c270>] [<c002c270>] (do_one_initcall+0x0/0x18c)
> (do_one_initcall+0x0/0x18c) from [<c00088b8>] from [<c00088b8>]
> (kernel_init+0x70/0xdc)
> (kernel_init+0x70/0xdc)
> [<c0008848>] [<c0008848>] (kernel_init+0x0/0xdc) (kernel_init+0x0/0xdc)
> from [<c00538a8>] from [<c00538a8>] (do_exit+0x0/0x6ac)
> (do_exit+0x0/0x6ac)
>  r5:00000000 r5:00000000 r4:00000000 r4:00000000
>
> Code: Code: e58d1000 e58d1000 e1a0100e e1a0100e e885001f e885001f
> e59f503c e59f503c (e5950098) (e5950098) 
>
> <4>---[ end trace 7567be4737bae816 ]---
> ---[ end trace 7567be4737bae816 ]---
> <0>Kernel panic - not syncing: Attempted to kill init!
> Kernel panic - not syncing: Attempted to kill init!
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

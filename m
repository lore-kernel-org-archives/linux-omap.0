From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: SPI regression in today's Linux next
Date: Tue, 17 Oct 2017 07:34:54 -0700
Message-ID: <20171017143454.GA4394@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Lucas and Mark,

Looks like commit 9ce70d49fa80 ("spi: fix IDR collision on systems with
both fixed and dynamic SPI bus numbers") causes the following regression
at least for omaps. Reverting commit 9ce70d49fa80 fixes it.

Any ideas?

Seems it was also reported by the 0day kernel test robot on Saturday:

https://www.spinics.net/lists/kernel/msg2624673.html

Regards,

Tony

8< ------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at ./include/linux/idr.h:113 spi_register_controller+0x81c/0x93c
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.0-rc4-next-20171016 #1377
Hardware name: Generic OMAP4 (Flattened Device Tree)
[<c01112a0>] (unwind_backtrace) from [<c010d164>] (show_stack+0x10/0x14)
[<c010d164>] (show_stack) from [<c086fd40>] (dump_stack+0xac/0xe0)
[<c086fd40>] (dump_stack) from [<c0137ed0>] (__warn+0xd8/0x104)
[<c0137ed0>] (__warn) from [<c0137ff0>] (warn_slowpath_null+0x20/0x28)
[<c0137ff0>] (warn_slowpath_null) from [<c065ec74>] (spi_register_controller+0x81c/0x93c)
[<c065ec74>] (spi_register_controller) from [<c065edc4>] (devm_spi_register_controller+0x30/0x70)
[<c065edc4>] (devm_spi_register_controller) from [<c0662930>] (omap2_mcspi_probe+0x274/0x358)
[<c0662930>] (omap2_mcspi_probe) from [<c05b7b10>] (platform_drv_probe+0x50/0xb0)
[<c05b7b10>] (platform_drv_probe) from [<c05b5bf8>] (driver_probe_device+0x264/0x2ec)
[<c05b5bf8>] (driver_probe_device) from [<c05b5d40>] (__driver_attach+0xc0/0xc4)
[<c05b5d40>] (__driver_attach) from [<c05b3fe0>] (bus_for_each_dev+0x78/0xc0)
[<c05b3fe0>] (bus_for_each_dev) from [<c05b5018>] (bus_add_driver+0xf8/0x208)
[<c05b5018>] (bus_add_driver) from [<c05b6bd8>] (driver_register+0x78/0xf4)
[<c05b6bd8>] (driver_register) from [<c0101e24>] (do_one_initcall+0x48/0x194)
[<c0101e24>] (do_one_initcall) from [<c0c00f28>] (kernel_init_freeable+0x1fc/0x2c4)
[<c0c00f28>] (kernel_init_freeable) from [<c0884830>] (kernel_init+0x8/0x110)
[<c0884830>] (kernel_init) from [<c0108188>] (ret_from_fork+0x14/0x2c)
---[ end trace 9fd4ad3daaa4f7a3 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at drivers/spi/spi.c:2123 spi_register_controller+0x5c4/0x93c
couldn't get idr
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W        4.14.0-rc4-next-20171016 #1377
Hardware name: Generic OMAP4 (Flattened Device Tree)
[<c01112a0>] (unwind_backtrace) from [<c010d164>] (show_stack+0x10/0x14)
[<c010d164>] (show_stack) from [<c086fd40>] (dump_stack+0xac/0xe0)
[<c086fd40>] (dump_stack) from [<c0137ed0>] (__warn+0xd8/0x104)
[<c0137ed0>] (__warn) from [<c0137f3c>] (warn_slowpath_fmt+0x40/0x68)
[<c0137f3c>] (warn_slowpath_fmt) from [<c065ea1c>] (spi_register_controller+0x5c4/0x93c)
[<c065ea1c>] (spi_register_controller) from [<c065edc4>] (devm_spi_register_controller+0x30/0x70)
[<c065edc4>] (devm_spi_register_controller) from [<c0662930>] (omap2_mcspi_probe+0x274/0x358)
[<c0662930>] (omap2_mcspi_probe) from [<c05b7b10>] (platform_drv_probe+0x50/0xb0)
[<c05b7b10>] (platform_drv_probe) from [<c05b5bf8>] (driver_probe_device+0x264/0x2ec)
[<c05b5bf8>] (driver_probe_device) from [<c05b5d40>] (__driver_attach+0xc0/0xc4)
[<c05b5d40>] (__driver_attach) from [<c05b3fe0>] (bus_for_each_dev+0x78/0xc0)
[<c05b3fe0>] (bus_for_each_dev) from [<c05b5018>] (bus_add_driver+0xf8/0x208)
[<c05b5018>] (bus_add_driver) from [<c05b6bd8>] (driver_register+0x78/0xf4)
[<c05b6bd8>] (driver_register) from [<c0101e24>] (do_one_initcall+0x48/0x194)
[<c0101e24>] (do_one_initcall) from [<c0c00f28>] (kernel_init_freeable+0x1fc/0x2c4)
[<c0c00f28>] (kernel_init_freeable) from [<c0884830>] (kernel_init+0x8/0x110)
[<c0884830>] (kernel_init) from [<c0108188>] (ret_from_fork+0x14/0x2c)
---[ end trace 9fd4ad3daaa4f7a4 ]---
omap2_mcspi: probe of 48098000.spi failed with error -22

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

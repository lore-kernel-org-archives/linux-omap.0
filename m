From: Mike Turquette <mturquette@linaro.org>
Subject: Re: OMAP EHCI having clock problems?
Date: Thu, 14 Feb 2013 21:12:46 -0800
Message-ID: <20130215051246.11471.99180@quantum>
References: <87halea4s3.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:59394 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab3BOFMw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Feb 2013 00:12:52 -0500
Received: by mail-pa0-f48.google.com with SMTP id hz10so1625878pad.21
        for <linux-omap@vger.kernel.org>; Thu, 14 Feb 2013 21:12:52 -0800 (PST)
In-Reply-To: <87halea4s3.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, Felipe Balbi <balbi@ti.com>, Roger Quadros <rogerq@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Quoting Kevin Hilman (2013-02-14 14:50:52)
> Any idea what's going on?

Looks like a couple of different things.

> [    0.515747] usbhs_omap usbhs_omap: ehci_logic_fck failed:-2

Seems like the clk_get lookup failed here in usbhs_omap_probe.  So from
this point on omap->ehci_logic_fck == -ENOENT.  This bogus value gets
passed into all of the clk apis, which leads us to the below error.

> [    0.516021] ------------[ cut here ]------------
> [    0.516082] WARNING: at /work/kernel/omap/dev/drivers/clk/clk.c:522 __clk_enable+0x8c/0x9c()
> [    0.516082] Modules linked in:
> [    0.516143] [<c00145a8>] (unwind_backtrace+0x0/0xf0) from [<c003bd6c>] (warn_slowpath_common+0x4c/0x64)
> [    0.516143] [<c003bd6c>] (warn_slowpath_common+0x4c/0x64) from [<c003bda0>] (warn_slowpath_null+0x1c/0x24)
> [    0.516174] [<c003bda0>] (warn_slowpath_null+0x1c/0x24) from [<c0412758>] (__clk_enable+0x8c/0x9c)
> [    0.516174] [<c0412758>] (__clk_enable+0x8c/0x9c) from [<c0412788>] (clk_enable+0x20/0x3c)
> [    0.516204] [<c0412788>] (clk_enable+0x20/0x3c) from [<c03317fc>] (usbhs_runtime_resume+0x60/0xa4)
> [    0.516235] [<c03317fc>] (usbhs_runtime_resume+0x60/0xa4) from [<c031b408>] (pm_generic_runtime_resume+0x2c/0x40)
> [    0.516265] [<c031b408>] (pm_generic_runtime_resume+0x2c/0x40) from [<c031f07c>] (__rpm_callback+0x34/0x70)
> [    0.516296] [<c031f07c>] (__rpm_callback+0x34/0x70) from [<c0320040>] (rpm_resume+0x3bc/0x648)
> [    0.516326] [<c0320040>] (rpm_resume+0x3bc/0x648) from [<c0320548>] (__pm_runtime_resume+0x48/0x60)
> [    0.516326] [<c0320548>] (__pm_runtime_resume+0x48/0x60) from [<c0331bf0>] (usbhs_omap_probe+0x200/0x840)
> [    0.516357] [<c0331bf0>] (usbhs_omap_probe+0x200/0x840) from [<c0317d24>] (platform_drv_probe+0x18/0x1c)
> [    0.516387] [<c0317d24>] (platform_drv_probe+0x18/0x1c) from [<c0316ae4>] (driver_probe_device+0x78/0x210)
> [    0.516387] [<c0316ae4>] (driver_probe_device+0x78/0x210) from [<c0316d10>] (__driver_attach+0x94/0x98)
> [    0.516418] [<c0316d10>] (__driver_attach+0x94/0x98) from [<c03153e4>] (bus_for_each_dev+0x50/0x7c)
> [    0.516448] [<c03153e4>] (bus_for_each_dev+0x50/0x7c) from [<c0316310>] (bus_add_driver+0x178/0x240)
> [    0.516448] [<c0316310>] (bus_add_driver+0x178/0x240) from [<c03171dc>] (driver_register+0x78/0x144)
> [    0.516479] [<c03171dc>] (driver_register+0x78/0x144) from [<c0317f14>] (platform_driver_probe+0x18/0x9c)
> [    0.516479] [<c0317f14>] (platform_driver_probe+0x18/0x9c) from [<c00086e4>] (do_one_initcall+0x34/0x178)
> [    0.516510] [<c00086e4>] (do_one_initcall+0x34/0x178) from [<c06ea8f8>] (kernel_init_freeable+0xfc/0x1cc)
> [    0.516571] [<c06ea8f8>] (kernel_init_freeable+0xfc/0x1cc) from [<c04d7a78>] (kernel_init+0x8/0xe4)
> [    0.516571] [<c04d7a78>] (kernel_init+0x8/0xe4) from [<c000dd10>] (ret_from_fork+0x14/0x24)
> [    0.516693] ---[ end trace e713e7725948e018 ]---

This WARN gets tripped when a clock is enabled but not prepared.  From
__clk_enable in drivers/clk/clk.c:

        if (WARN_ON(clk->prepare_count == 0))
                return -ESHUTDOWN;

So we're basically dereferencing a bogus struct clk pointer in
__clk_enable and the memory address of clk->prepare_count just happens
to be zero filled.

On a related note, even if the clk_get lookup did not fail this WARN
would still be hit since this driver never once calls clk_prepare.

Regards,
Mike


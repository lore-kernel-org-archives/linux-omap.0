From: Nishanth Menon <nm@ti.com>
Subject: AM3517: Address Hole seen by USB_OTG  at address dc0f9c0c
Date: Tue, 1 Apr 2014 08:43:07 -0500
Message-ID: <533AC26B.7040608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56349 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbaDANnI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Apr 2014 09:43:08 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id s31Dh82L004484
	for <linux-omap@vger.kernel.org>; Tue, 1 Apr 2014 08:43:08 -0500
Received: from DLEE70.ent.ti.com (dlemailx.itg.ti.com [157.170.170.113])
	by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id s31Dh8hH018901
	for <linux-omap@vger.kernel.org>; Tue, 1 Apr 2014 08:43:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, Roger Quadros <rogerq@ti.com>

am3517-evm: http://slexy.org/raw/s2136sr6sb

Just noticed this, but present in
v3.14-rc1(http://slexy.org/view/s21053Cq8K) as well (dont have older
logs remaining in my machine at least)..

[    0.392086] Address Hole seen by USB_OTG  at address dc0f9c0c
[    0.392115] ------------[ cut here ]------------
[    0.392169] WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_smx.c:162
omap3_l3_app_irq+0x100/0x128()
[    0.392186] Modules linked in:
[    0.392221] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
3.14.0-next-20140401-00006-g6e78bd6 #1
[    0.392279] [<c0014cd8>] (unwind_backtrace) from [<c0011968>]
(show_stack+0x10/0x14)
[    0.392312] [<c0011968>] (show_stack) from [<c053fe1c>]
(dump_stack+0x78/0x94)
[    0.392341] [<c053fe1c>] (dump_stack) from [<c003fc4c>]
(warn_slowpath_common+0x6c/0x8c)
[    0.392368] [<c003fc4c>] (warn_slowpath_common) from [<c003fc88>]
(warn_slowpath_null+0x1c/0x24)
[    0.392394] [<c003fc88>] (warn_slowpath_null) from [<c02f1c58>]
(omap3_l3_app_irq+0x100/0x128)
[    0.392434] [<c02f1c58>] (omap3_l3_app_irq) from [<c008e098>]
(handle_irq_event_percpu+0x58/0x20c)
[    0.392463] [<c008e098>] (handle_irq_event_percpu) from
[<c008e288>] (handle_irq_event+0x3c/0x5c)
[    0.392495] [<c008e288>] (handle_irq_event) from [<c0090b78>]
(handle_level_irq+0xac/0x148)
[    0.392523] [<c0090b78>] (handle_level_irq) from [<c008d9a0>]
(generic_handle_irq+0x20/0x30)
[    0.392551] [<c008d9a0>] (generic_handle_irq) from [<c000ef48>]
(handle_IRQ+0x4c/0xac)
[    0.392577] [<c000ef48>] (handle_IRQ) from [<c0008800>]
(omap3_intc_handle_irq+0x80/0x9c)
[    0.392610] [<c0008800>] (omap3_intc_handle_irq) from [<c0546024>]
(__irq_svc+0x44/0x5c)
[    0.392627] Exception stack(0xce055d90 to 0xce055dd8)
[    0.392650] 5d80:                                     00000001
ce053068 00000000 ce052b00
[    0.392674] 5da0: 60000153 ce005594 ce005594 00000000 0000001a
ce005574 60000153 00000000
[    0.392696] 5dc0: ce005540 ce055dd8 c008515c c0545a18 20000153 ffffffff
[    0.392726] [<c0546024>] (__irq_svc) from [<c0545a18>]
(_raw_spin_unlock_irqrestore+0x34/0x44)
[    0.392753] [<c0545a18>] (_raw_spin_unlock_irqrestore) from
[<c008f910>] (__setup_irq+0x2d8/0x4c0)
[    0.392782] [<c008f910>] (__setup_irq) from [<c008fbb0>]
(request_threaded_irq+0xb8/0x13c)
[    0.392822] [<c008fbb0>] (request_threaded_irq) from [<c07cd288>]
(omap3_l3_probe+0x10c/0x16c)
[    0.392858] [<c07cd288>] (omap3_l3_probe) from [<c035310c>]
(platform_drv_probe+0x18/0x48)
[    0.392887] [<c035310c>] (platform_drv_probe) from [<c03517f8>]
(driver_probe_device+0x110/0x224)
[    0.392913] [<c03517f8>] (driver_probe_device) from [<c03519a0>]
(__driver_attach+0x94/0x98)
[    0.392937] [<c03519a0>] (__driver_attach) from [<c035010c>]
(bus_for_each_dev+0x54/0x88)
[    0.392961] [<c035010c>] (bus_for_each_dev) from [<c0350f8c>]
(bus_add_driver+0xdc/0x1d4)
[    0.392985] [<c0350f8c>] (bus_add_driver) from [<c0351fd0>]
(driver_register+0x78/0xf4)
[    0.393010] [<c0351fd0>] (driver_register) from [<c0352af8>]
(platform_driver_probe+0x20/0xa4)
[    0.393036] [<c0352af8>] (platform_driver_probe) from [<c0008ab8>]
(do_one_initcall+0x34/0x15c)
[    0.393065] [<c0008ab8>] (do_one_initcall) from [<c079ac04>]
(kernel_init_freeable+0xfc/0x1cc)
[    0.393098] [<c079ac04>] (kernel_init_freeable) from [<c053a78c>]
(kernel_init+0x8/0xe4)
[    0.393124] [<c053a78c>] (kernel_init) from [<c000e6e8>]
(ret_from_fork+0x14/0x2c)
[    0.393372] ---[ end trace 530cbcb2923bd006 ]---

-- 
Regards,
Nishanth Menon

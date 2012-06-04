From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: latest kernel for am35xx
Date: Mon, 4 Jun 2012 09:28:23 +0200
Message-ID: <20120604072823.GA7053@localhost.localdomain>
References: <CAP3+TEr8vsnZPhAhgH-w7jAjWZTNQgWvsQ3cn_uz4TaX8c-Zgg@mail.gmail.com>
 <CAPjKCR_CiKA_vXNyfYHdJeqPMsv0SA_oRYg1-XzbO2C1vSbLug@mail.gmail.com>
 <CAP3+TErug0DmndHWCVsguw2+e_vPCB2McF5j0+AyrMj8eGa=MQ@mail.gmail.com>
 <4FC7338E.4080502@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([78.24.191.182]:40882 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523Ab2FDH2m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Jun 2012 03:28:42 -0400
Received: (from localhost user: 'ladis' uid#521 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S1903626Ab2FDH2j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 4 Jun 2012 09:28:39 +0200
Content-Disposition: inline
In-Reply-To: <4FC7338E.4080502@visionsystems.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, May 31, 2012 at 11:02:06AM +0200, Yegor Yefremov wrote:
> my best choice was 3.3-rc7 so far. With final 3.3 frame buffer made problems. wl1271 was working like a charm. I have another PMIC, so I don't know if it works well with tps65910.
> 
> I just took the master branch of linux-omap.git

Yegor,

does USB work for you? I forward ported support for TechNexion's TAM-3517 on
Twister board to current master, but so far no luck with mass storage
support (patch for reference http://ladislav.michl.sweb.cz/tam3517.patch).
It does not detect any plugged in devices.

USB related errors:
GPMC revision 5.0
gpmc: irq-20 could not claim: err -22
------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/pm.c:48 _init_omap_device+0x74/0x94()
_init_omap_device: could not find omap_hwmod for iva
Modules linked in:
[<c0012838>] (unwind_backtrace+0x0/0xec) from [<c0028e9c>] (warn_slowpath_common+0x4c/0x64)
[<c0028e9c>] (warn_slowpath_common+0x4c/0x64) from [<c0028f48>] (warn_slowpath_fmt+0x30/0x40)
[<c0028f48>] (warn_slowpath_fmt+0x30/0x40) from [<c03fcca8>] (_init_omap_device+0x74/0x94)
[<c03fcca8>] (_init_omap_device+0x74/0x94) from [<c03fcd00>] (omap2_common_pm_init+0x38/0x64)
[<c03fcd00>] (omap2_common_pm_init+0x38/0x64) from [<c0008660>] (do_one_initcall+0x94/0x15c)
[<c0008660>] (do_one_initcall+0x94/0x15c) from [<c03f62fc>] (kernel_init+0xd4/0x1ac)
[<c03f62fc>] (kernel_init+0xd4/0x1ac) from [<c000e654>] (kernel_thread_exit+0x0/0x8)
---[ end trace 1b75b31a2719ed1c ]---
[...]
------------[ cut here ]------------
WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:161 omap3_l3_app_irq+0x210/0x2a0()
In-band Error seen by USB_OTG  at address 0
Modules linked in:
[<c0012838>] (unwind_backtrace+0x0/0xec) from [<c0028e9c>] (warn_slowpath_common+0x4c/0x64)
[<c0028e9c>] (warn_slowpath_common+0x4c/0x64) from [<c0028f48>] (warn_slowpath_fmt+0x30/0x40)
[<c0028f48>] (warn_slowpath_fmt+0x30/0x40) from [<c0021118>] (omap3_l3_app_irq+0x210/0x2a0)
[<c0021118>] (omap3_l3_app_irq+0x210/0x2a0) from [<c005f06c>] (handle_irq_event_percpu+0x34/0x194)
[<c005f06c>] (handle_irq_event_percpu+0x34/0x194) from [<c005f1f4>] (handle_irq_event+0x28/0x38)
[<c005f1f4>] (handle_irq_event+0x28/0x38) from [<c00615e4>] (handle_level_irq+0xb8/0xe8)
[<c00615e4>] (handle_level_irq+0xb8/0xe8) from [<c005ecac>] (generic_handle_irq+0x2c/0x44)
[<c005ecac>] (generic_handle_irq+0x2c/0x44) from [<c000e5b4>] (handle_IRQ+0x64/0x8c)
[<c000e5b4>] (handle_IRQ+0x64/0x8c) from [<c00084cc>] (omap3_intc_handle_irq+0x58/0x70)
[<c00084cc>] (omap3_intc_handle_irq+0x58/0x70) from [<c000d940>] (__irq_svc+0x40/0x60)
Exception stack(0xcf02be40 to 0xcf02be88)
be40: 00000000 0000000a 00000000 00000021 c043d044 0000000a 00000000 cf04b740
be60: 60000013 c043d074 00000000 c045fd80 cf006080 cf02be88 c0061834 c005fff8
be80: 60000013 ffffffff
[<c000d940>] (__irq_svc+0x40/0x60) from [<c005fff8>] (__setup_irq+0x2a4/0x358)
[<c005fff8>] (__setup_irq+0x2a4/0x358) from [<c00602b8>] (request_threaded_irq+0xc0/0x114)
[<c00602b8>] (request_threaded_irq+0xc0/0x114) from [<c03ffe28>] (omap3_l3_probe+0x108/0x164)
[<c03ffe28>] (omap3_l3_probe+0x108/0x164) from [<c01964e8>] (platform_drv_probe+0x1c/0x24)
[<c01964e8>] (platform_drv_probe+0x1c/0x24) from [<c0195410>] (driver_probe_device+0xcc/0x21c)
[<c0195410>] (driver_probe_device+0xcc/0x21c) from [<c01955c0>] (__driver_attach+0x60/0x84)
[<c01955c0>] (__driver_attach+0x60/0x84) from [<c0193ea4>] (bus_for_each_dev+0x4c/0x8c)
[<c0193ea4>] (bus_for_each_dev+0x4c/0x8c) from [<c0194524>] (bus_add_driver+0xa0/0x21c)
[<c0194524>] (bus_add_driver+0xa0/0x21c) from [<c01959e0>] (driver_register+0xa0/0x12c)
[<c01959e0>] (driver_register+0xa0/0x12c) from [<c01967b8>] (platform_driver_probe+0x1c/0x70)
[<c01967b8>] (platform_driver_probe+0x1c/0x70) from [<c0008660>] (do_one_initcall+0x94/0x15c)
[<c0008660>] (do_one_initcall+0x94/0x15c) from [<c03f62fc>] (kernel_init+0xd4/0x1ac)
[<c03f62fc>] (kernel_init+0xd4/0x1ac) from [<c000e654>] (kernel_thread_exit+0x0/0x8)
---[ end trace 1b75b31a2719ed1d ]---
omap_mux_init: Add partition: #1: core, flags: 0
 usbhs_omap: alias fck already exists
[...]
hci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-omap.0 supply hsusb0 not found, using dummy regulator
ehci-omap ehci-omap.0: OMAP-EHCI Host Controller
ehci-omap ehci-omap.0: new USB bus registered, assigned bus number 1
ehci-omap ehci-omap.0: irq 77, io mem 0x48064800
ehci-omap ehci-omap.0: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OMAP-EHCI Host Controller
usb usb1: Manufacturer: Linux 3.4.0-rc6+ ehci_hcd
usb usb1: SerialNumber: ehci-omap.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
usbcore: registered new interface driver cdc_wdm
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
[...]
musb-hdrc: version 6.0, ?dma?, otg (peripheral+host)
musb-am35x musb-am35x: failed to get clock
musb-am35x: probe of musb-am35x failed with error -2

Any ideas? Not following OMAP development for a long time was
probably a bad idea.

Thanks,
	ladis

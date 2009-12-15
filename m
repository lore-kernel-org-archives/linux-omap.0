From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: dadd2bb931a08a4b6b17f9e82d9bbe7bedebbc98 breaks omapfb (old
 non-dss2)
Date: Tue, 15 Dec 2009 17:22:58 +0200
Message-ID: <1260890578.6017.11.camel@tubuntu.research.nokia.com>
References: <48239d390912150158xdf2999dr6b43f21c64456002@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:64911 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbZLOPXK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 10:23:10 -0500
In-Reply-To: <48239d390912150158xdf2999dr6b43f21c64456002@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sergey Lapin <slapinid@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, 2009-12-15 at 10:58 +0100, ext Sergey Lapin wrote:
> dadd2bb931a08a4b6b17f9e82d9bbe7bedebbc98
> OMAP: OMAPFB: add omapdss device
> 
>     The upcoming new display subsystem driver is divided to two devices,
>     omapdss and omapfb, of which omapdss handles the actual hardware.
> 
>     This patch adds a dummy omapdss platform device for the current omapfb
>     driver, which is then used to get the clocks. This will make it possible
>     for the current and the new display drivers to co-exist.
> 
>     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
>     Acked-by: Tony Lindgren <tony@atomide.com>
> 
> breaks old omapfb.

I didn't look at this further, but I quickly tested with OMAP3 SDP
board, reverting the patch that makes SDP use DSS2, and it seems to work
fine with the old omapfb.

Perhaps you have more kernel debug options enabled, and then it
complains about missing release function. I'll look at it tomorrow.

> 
> [   17.234466] Registering platform device 'omapdss'. Parent at platform
> [   17.237548] device: 'omapdss': device_add
> [   17.241180] bus: 'platform': add device omapdss
> [   17.244964] PM: Adding info for platform:omapdss
> [   17.250244] omapfb: DISPC version 3.0 initialized
> [   17.253326] omapfb omapfb: can't get ick
> [   17.257324] PM: Removing info for platform:omapdss
> [   17.261291] bus: 'platform': remove device omapdss
> [   17.265411] ------------[ cut here ]------------
> [   17.271545] WARNING: at drivers/base/core.c:131 device_release+0x68/0x7c()
> [   17.279510] Device 'omapdss' does not have a release() function, it
> is broken and must be fixed.
> [   17.281433] Modules linked in:
> [   17.290008] [<c003a9dc>] (unwind_backtrace+0x0/0xdc) from
> [<c0062330>] (warn_slowpath_common+0x48/0x60)
> [   17.298583] [<c0062330>] (warn_slowpath_common+0x48/0x60) from
> [<c0062380>] (warn_slowpath_fmt+0x24/0x30)
> [   17.306610] [<c0062380>] (warn_slowpath_fmt+0x24/0x30) from
> [<c01fcd2c>] (device_release+0x68/0x7c)
> [   17.314453] [<c01fcd2c>] (device_release+0x68/0x7c) from
> [<c01b23cc>] (kobject_release+0x5c/0x70)
> [   17.321746] [<c01b23cc>] (kobject_release+0x5c/0x70) from
> [<c01b3208>] (kref_put+0x5c/0x6c)
> [   17.328887] [<c01b3208>] (kref_put+0x5c/0x6c) from [<c01d9a78>]
> (hx8340_init+0x89c/0x8d8)
> [   17.336822] [<c01d9a78>] (hx8340_init+0x89c/0x8d8) from
> [<c01d5018>] (omapfb_do_probe+0x38c/0x970)
> [   17.345123] [<c01d5018>] (omapfb_do_probe+0x38c/0x970) from
> [<c01d9af8>] (gnome5_panel_probe+0xc/0x18)
> [   17.353515] [<c01d9af8>] (gnome5_panel_probe+0xc/0x18) from
> [<c0201014>] (platform_drv_probe+0x18/0x1c)
> [   17.362243] [<c0201014>] (platform_drv_probe+0x18/0x1c) from
> [<c01fff60>] (driver_probe_device+0x100/0x1e8)
> [   17.370727] [<c01fff60>] (driver_probe_device+0x100/0x1e8) from
> [<c02000a8>] (__driver_attach+0x60/0x84)
> [   17.378753] [<c02000a8>] (__driver_attach+0x60/0x84) from
> [<c01ff658>] (bus_for_each_dev+0x44/0x74)
> [   17.386871] [<c01ff658>] (bus_for_each_dev+0x44/0x74) from
> [<c01fef80>] (bus_add_driver+0x140/0x2d0)
> [   17.394989] [<c01fef80>] (bus_add_driver+0x140/0x2d0) from
> [<c020039c>] (driver_register+0xa8/0x130)
> [   17.403106] [<c020039c>] (driver_register+0xa8/0x130) from
> [<c0034364>] (do_one_initcall+0x5c/0x1b4)
> [   17.410858] [<c0034364>] (do_one_initcall+0x5c/0x1b4) from
> [<c0008588>] (kernel_init+0xa0/0x124)
> [   17.418640] [<c0008588>] (kernel_init+0xa0/0x124) from [<c0035f80>]
> (kernel_thread_exit+0x0/0x8)
> [   17.422363] ---[ end trace da227214a82491b7 ]---
> [   17.427520] omapfb omapfb: controller initialization failed (-2)
> [   17.433715] driver: 'gnome5_lcd': driver_bound: bound to device 'gnome5_lcd'
> [   17.440948] bus: 'platform': really_probe: bound device gnome5_lcd
> to driver gnome5_lcd
> 
> Any ideas?
> 
> Also - is there some guidelines on porting old RFBI-based driver to DSS2?

No, and currently the DSS2 RFBI support may not work. I don't have
hardware to test it, and the DSS driver has changed around it. Can
anyone confirm that the RFBI support works, and does anyone have public
RFBI drivers?

But basically RFBI drivers and DSI command mode panels (panel-taal.c for
example) should be somewhat similar. One thing to note is that the
current model doesn't support separate controller (or "buffer") chips
and panels very neatly, although it should work.

 Tomi



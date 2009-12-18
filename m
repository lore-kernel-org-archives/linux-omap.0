From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 5/5] OMAP3: PM: Disable OTG autoidle when waking up
 from off-mode
Date: Fri, 18 Dec 2009 10:08:32 +0200
Message-ID: <20091218080832.GA2858@esdhcp037198.research.nokia.com>
References: <1258020444-3809-1-git-send-email-tero.kristo@nokia.com>
 <1258020444-3809-2-git-send-email-tero.kristo@nokia.com>
 <1258020444-3809-3-git-send-email-tero.kristo@nokia.com>
 <1258020444-3809-4-git-send-email-tero.kristo@nokia.com>
 <1258020444-3809-5-git-send-email-tero.kristo@nokia.com>
 <1258020444-3809-6-git-send-email-tero.kristo@nokia.com>
 <87zl6ru53p.fsf@deeprootsystems.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A8C8537@dbde02.ent.ti.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17048 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbZLRIJF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 03:09:05 -0500
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A8C8537@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gadiyar, Anand" <gadiyar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com

Hello All,

On Thu, Nov 12, 2009 at 04:40:56PM +0100, ext Gadiyar, Anand wrote:
> > Tero Kristo <tero.kristo@nokia.com> writes:
> > 
> > > From: Tero Kristo <tero.kristo@nokia.com>
> > >
> > > OMAP3 sleep can be prevented in some cases where OTG autoidle is enabled.
> > > This patch force disables autoidle during wakeup from off-mode. See omap
> > > errata 1.164.
> > >
> > > This fix can't be done in driver level, as off-mode entry resets and enables
> > > the autoidle bit, and driver does not access the register after each off-mode
> > > entry even if it is loaded.
> > >
> > > Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> > 
> > Thanks Tero for the updated changelog.
> > 
> > Applying to PM branch reluctantly and with grumbles.  I sure hope
> > someone in TI is reporting all these ROM code issues to the ROM code
> > team so they get appropriate fixes.
> > 
> > Kevin
> 
> Yes, rest assured we're following these up with the HW teams.
> 
> This particular one should not matter on 3630, we can keep autoidle
> enabled all the time, I think.


I've made a few tests with pm branch + rx51. Currently at:
commit 1f1d16a8164d63459c1a5e155bcb9fc8a15b859e
Merge: 46e0bec 5660cac
Author: Kevin Hilman <khilman@deeprootsystems.com>
Date:   Wed Dec 16 16:09:47 2009 -0800

    manual merge for branch pm-debug

And this patch
"OMAP3: PM: Disable OTG autoidle when waking up from off-mode"

Seams to be not complete at least. It causes:

# modprobe g_zero
[   28.073944] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[   28.080932] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   28.088317] usb usb1: Product: MUSB HDRC host driver
[   28.093414] usb usb1: Manufacturer: Linux 2.6.32-14504-g1f1d16a musb-hcd
[   28.100250] usb usb1: SerialNumber: musb_hdrc
[   28.110565] hub 1-0:1.0: USB hub found
[   28.114715] hub 1-0:1.0: 1 port detected
[   28.119506] Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa0ab060
[   28.127288] Internal error: : 1028 [#1]
[   28.131164] last sysfs file: /sys/devices/platform/serial8250.2/sleep_timeout
[   28.138366] Modules linked in: g_zero(+)
[   28.142364] CPU: 0    Not tainted  (2.6.32-14504-g1f1d16a #10)
[   28.148284] PC is at musb_start+0x18/0xdc
[   28.152343] LR is at musb_hub_control+0x33c/0x454
[   28.157104] pc : [<c01b85a8>]    lr : [<c01bc3ec>]    psr: 800000d3
[   28.157135] sp : cf3fbac8  ip : 001c20a8  fp : cf3fbb80
[   28.168731] r10: cf824000  r9 : 80000053  r8 : 00000001
[   28.174011] r7 : 00000008  r6 : cf3fbb80  r5 : fa0ab000  r4 : cf824168
[   28.180603] r3 : 00000000  r2 : cf3923c0  r1 : 00000001  r0 : cf824168
[   28.187194] Flags: Nzcv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment user
[   28.194580] Control: 10c5387d  Table: 8fea4019  DAC: 00000015
[   28.200408] Process modprobe (pid: 405, stack limit = 0xcf3fa2e8)
[   28.206573] Stack: (0xcf3fbac8 to 0xcf3fc000)
[   28.210968] bac0:                   00002303 cf824168 cf3fbb80 c01bc3ec 00002303 00000000
[   28.219238] bae0: 00000008 ce8544c0 00000001 00000000 cf824000 c01a8280 cf3fbb80 00000000
[   28.227539] bb00: cf3923c0 c026ef98 842b0152 00000000 00000001 00000000 c04f1f34 00000004
[   28.235809] bb20: 00000000 c026ef98 00000001 cf3923c0 00000006 00000007 cf3fbbf4 00000000
[   28.244079] bb40: 00000024 c0071598 cf3923c0 c0071a20 cf3fbbd0 20000053 cf3fbbf4 c00718d0
[   28.252349] bb60: cf3923c0 cf3923f0 c051e63c c00701b8 cf3fbbe0 cf3fbbd0 c0a6b1b0 c00701b8
[   28.260620] bb80: cf3fbbe0 cf3fbbd0 c0a6b1b0 000003e8 ce8544c0 cf3fbbcc 00000000 000003e8
[   28.268890] bba0: ce8544c0 00000001 00000000 cf3fbc2c cf3a0c00 c01a9d30 00000001 cf3923c0
[   28.277160] bbc0: 00000006 00000007 00000001 00000000 00000001 dead4ead ffffffff ffffffff
[   28.285430] bbe0: c0a6b1b0 00000000 c030a3fb 00000000 ce8544c0 cf3fbbf4 cf3fbbf4 c00a7f60
[   28.293731] bc00: 00000000 00000000 cfeb6340 00000008 00000023 00000001 00000003 c01a9fcc
[   28.302001] bc20: c036e25c 80000100 c036e25c c004f0a8 00000000 00000002 cfeaf400 00000005
[   28.310272] bc40: 00000000 00000000 00000010 cfeaf200 ce852f80 c01a1104 00000008 00000001
[   28.318542] bc60: 00000000 00000000 000003e8 cfeaf400 00000005 c01a1668 40408180 cfeaf400
[   28.326812] bc80: cfeaf400 cfeaf220 00000000 c01a21cc cf800140 000000d0 cf3a0c00 cf3a0c00
[   28.335083] bca0: ce854540 60000053 cf800140 40408180 00000004 cfeaf400 cfeaf220 cf3a0c00
[   28.343353] bcc0: 00000010 cfeaf200 ce852f80 c01a4de0 c0312a3e 00000000 cfeb63c0 0000000f
[   28.351623] bce0: 00001388 c0071598 cf3923c0 c026cd88 60000053 cf3a0f3c c04f1da0 c00718d0
[   28.359924] bd00: cf3a0f64 cf3a0f3c 60000053 00000000 cf3a0c00 cfeaf220 cfeaf200 00000000
[   28.368194] bd20: cf3a0c00 c04f1da0 c04f1e84 c04f1d4c cfeaf228 c01ac620 00000000 cfeaf220
[   28.376464] bd40: c04f1da0 00000000 cfeaf000 00000000 c04f2004 c0178838 00000000 c0178968
[   28.384735] bd60: cfeaf220 00000000 cfeaf000 c0177e30 cf8b5690 cf8b8c18 cfeaf220 cfeaf254
[   28.393005] bd80: 00000000 c0178a1c cfeaf200 cfeaf220 00000000 c0177c80 cfeaf200 c01768c4
[   28.401275] bda0: cfeaf220 cf3a0c68 cf3a0c00 cfeaf000 ce852f48 00000001 ce852f40 cfeaf200
[   28.409545] bdc0: cfeaf220 00000000 cf3a0c00 cfeaf000 ce852f48 00000001 ce852f40 c01aaf14
[   28.417816] bde0: 00000001 00000000 00000000 00000000 00001388 c04f1c64 00000001 cf3a0c04
[   28.426116] be00: 00000000 cfeb6640 00000001 cf3a0c68 cfeaf000 cfeaf004 cfeb6980 cf3a0c00
[   28.434387] be20: 00000001 c04f278c 00000000 cf824000 00000000 c04f1c64 cf3a0c70 c01b27b8
[   28.442657] be40: cf3a0c00 c031ec77 c04f2778 cf3a0c00 c04f278c c01ab7a8 00000000 cf3a0c68
[   28.450927] be60: c04f278c c0178838 00000000 c0178968 cf3a0c68 00000000 cf824000 c0177e30
[   28.459197] be80: cf8b5690 cf8b8b98 cf3a0c68 cf3a0c9c cf801cc0 c0178a1c cf3fbeb9 cf3a0c68
[   28.467468] bea0: cf801cc0 c0177c80 cf3fbeb9 c01768c4 000d1158 c036c290 39383117 cf00303a
[   28.475738] bec0: cfeb6980 c01a1090 c031e917 00000001 00000001 cf3a0c00 cf3a0c68 cf824000
[   28.484039] bee0: ffffffff cf3a0c00 000d1158 c01a4064 00000002 00000001 00000012 cf3a0c00
[   28.492309] bf00: c036c290 00000012 00000000 c01a7818 cf824000 ffffffff 00000000 00000000
[   28.500579] bf20: 60000053 cf824168 00000000 cf824e38 c002aae4 cf3fa000 00000000 c01ba920
[   28.508880] bf40: bf00291c bf0024c4 bf002730 00000000 bf0029e4 bf006f9c 00000000 c002a344
[   28.517150] bf60: 00000000 bf0029e4 000d11a8 000d18e0 c002aae4 00000000 bf0029e4 000d11a8
[   28.525421] bf80: 000d18e0 c007cff0 000d18e0 0000803c 000d11a8 0000803c 000d1018 000d11a8
[   28.533691] bfa0: 00000080 c002a940 0000803c 000d1018 000d18e0 0000803c 000d11a8 000d1158
[   28.541961] bfc0: 0000803c 000d1018 000d11a8 00000080 000d13e0 000d1048 00000000 000d1158
[   28.550231] bfe0: bebbeb38 bebbeb28 0001f2a8 4014b620 60000050 000d18e0 00000000 00000000
[   28.558532] [<c01b85a8>] (musb_start+0x18/0xdc) from [<c01bc3ec>] (musb_hub_control+0x33c/0x45)
[   28.567413] [<c01bc3ec>] (musb_hub_control+0x33c/0x454) from [<c01a8280>] (usb_hcd_submit_urb+)
[   28.577178] [<c01a8280>] (usb_hcd_submit_urb+0x7b4/0x9e0) from [<c01a9d30>] (usb_start_wait_ur)
[   28.587036] [<c01a9d30>] (usb_start_wait_urb+0x40/0x120) from [<c01a9fcc>] (usb_control_msg+0x)
[   28.596466] [<c01a9fcc>] (usb_control_msg+0xbc/0xe0) from [<c01a1104>] (set_port_feature+0x40/)
[   28.605621] [<c01a1104>] (set_port_feature+0x40/0x48) from [<c01a1668>] (hub_power_on+0x68/0xb)
[   28.614501] [<c01a1668>] (hub_power_on+0x68/0xb0) from [<c01a21cc>] (hub_activate+0x3c/0x32c)
[   28.623138] [<c01a21cc>] (hub_activate+0x3c/0x32c) from [<c01a4de0>] (hub_probe+0x954/0xa74)
[   28.631683] [<c01a4de0>] (hub_probe+0x954/0xa74) from [<c01ac620>] (usb_probe_interface+0x138/)
[   28.640930] [<c01ac620>] (usb_probe_interface+0x138/0x194) from [<c0178838>] (driver_probe_dev)
[   28.650970] [<c0178838>] (driver_probe_device+0xa0/0x14c) from [<c0177e30>] (bus_for_each_drv+)
[   28.660583] [<c0177e30>] (bus_for_each_drv+0x44/0x80) from [<c0178a1c>] (device_attach+0x50/0x)
[   28.669555] [<c0178a1c>] (device_attach+0x50/0x68) from [<c0177c80>] (bus_probe_device+0x24/0x)
[   28.678527] [<c0177c80>] (bus_probe_device+0x24/0x40) from [<c01768c4>] (device_add+0x3dc/0x53)
[   28.687438] [<c01768c4>] (device_add+0x3dc/0x538) from [<c01aaf14>] (usb_set_configuration+0x5)
[   28.696929] [<c01aaf14>] (usb_set_configuration+0x56c/0x614) from [<c01b27b8>] (generic_probe+)
[   28.706542] [<c01b27b8>] (generic_probe+0x58/0x98) from [<c01ab7a8>] (usb_probe_device+0x48/0x)
[   28.715515] [<c01ab7a8>] (usb_probe_device+0x48/0x54) from [<c0178838>] (driver_probe_device+0)
[   28.725128] [<c0178838>] (driver_probe_device+0xa0/0x14c) from [<c0177e30>] (bus_for_each_drv+)
[   28.734710] [<c0177e30>] (bus_for_each_drv+0x44/0x80) from [<c0178a1c>] (device_attach+0x50/0x)
[   28.743682] [<c0178a1c>] (device_attach+0x50/0x68) from [<c0177c80>] (bus_probe_device+0x24/0x)
[   28.752655] [<c0177c80>] (bus_probe_device+0x24/0x40) from [<c01768c4>] (device_add+0x3dc/0x53)
[   28.761566] [<c01768c4>] (device_add+0x3dc/0x538) from [<c01a4064>] (usb_new_device+0x11c/0x19)
[   28.770446] [<c01a4064>] (usb_new_device+0x11c/0x190) from [<c01a7818>] (usb_add_hcd+0x45c/0x5)
[   28.779449] [<c01a7818>] (usb_add_hcd+0x45c/0x5dc) from [<c01ba920>] (usb_gadget_register_driv)
[   28.789489] [<c01ba920>] (usb_gadget_register_driver+0x1fc/0x298) from [<c002a344>] (do_one_in)
[   28.799774] [<c002a344>] (do_one_initcall+0x5c/0x1b8) from [<c007cff0>] (sys_init_module+0xb0/)
[   28.809020] [<c007cff0>] (sys_init_module+0xb0/0x1e4) from [<c002a940>] (ret_fast_syscall+0x0/)
[   28.818176] Code: e59050d0 e5933000 e1a04000 e3530001 (e5d52060) 
[   28.824432] ---[ end trace 4adc03808bb20271 ]---
Segmentation fault[   28.831024] mtdoops: Ready 49, 114 (no erase)


Are you guys also able to reproduce this? After reverting this patch I can
properly load the module, and pm features keep in one piece as well.

I will investigate to see what is missing.

BR,

> 
> - Anand
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Eduardo Valentin

From: Luciano Coelho <coelho@ti.com>
Subject: Re: Oops on ehci_hcd when booting 3.0.0-rc2 on panda
Date: Tue, 09 Aug 2011 14:26:08 +0300
Message-ID: <1312889168.2407.148.camel@cumari>
References: <1307356643.23002.413.camel@cumari>
	 <20110606104417.GP18731@legolas.emea.dhcp.ti.com>
	 <20110606110218.GS18731@legolas.emea.dhcp.ti.com>
	 <1307358348.23002.419.camel@cumari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:59972 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752873Ab1HIL0O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Aug 2011 07:26:14 -0400
In-Reply-To: <1307358348.23002.419.camel@cumari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, sameo@linux.intel.com
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>

Hi,

On Mon, 2011-06-06 at 14:05 +0300, Luciano Coelho wrote: 
> On Mon, 2011-06-06 at 14:02 +0300, Felipe Balbi wrote: 
> > On Mon, Jun 06, 2011 at 01:44:18PM +0300, Felipe Balbi wrote:
> > > looks like this is resulting from the missing hwmod conversion in
> > > mainlnie. Check if reverting 7e6502d577106fb5b202bbaac64c5f1b065e6daa
> > > helps.
> > 
> > I verified off-list with Luca that reverting that commit does make it
> > work. Keshava, care to send a revert patch to Sam until we get all the
> > hwmod stuff in.
> 
> Yes, I confirm that I'm not getting the oops anymore, after reverting
> this patch.
> 
> Thanks a lot for the quick answer, dude! :)

I'm again getting a very similar oops with 3.1-rc1 on my pandaboard:

[    2.054351] usbcore: registered new interface driver cdc_ncm
[    2.061431] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.068664] Unhandled fault: imprecise external abort (0x1406) at 0x00000000
[    2.076110] Internal error: : 1406 [#1] SMP
[    2.080505] Modules linked in:
[    2.083709] CPU: 0    Not tainted  (3.1.0-rc1-wl+ #283)
[    2.089233] PC is at omap_usbhs_enable+0x148/0x590
[    2.094299] LR is at trace_hardirqs_off+0x14/0x18
[    2.099243] pc : [<c02a8640>]    lr : [<c007fea0>]    psr: 60000093
[    2.099243] sp : df871dc8  ip : df871d80  fp : df871dec
[    2.111328] r10: 80000013  r9 : df9ef9e0  r8 : df9ef9ec
[    2.116821] r7 : dfa32800  r6 : dfa316f8  r5 : c06f5da8  r4 : dfa316a0
[    2.123687] r3 : 00000000  r2 : 00000000  r1 : 00000001  r0 : 00000000
[    2.130584] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    2.138366] Control: 10c53c7d  Table: 8000404a  DAC: 00000015
[    2.144409] Process swapper (pid: 1, stack limit = 0xdf8702f8)
[    2.150543] Stack: (0xdf871dc8 to 0xdf872000)
[    2.155120] 1dc0:                   df105400 dfa32808 df105400 dfa32800 df9ef9ec 00000003
[    2.163726] 1de0: df871e8c df871df0 c0321d60 c02a8504 df871e2c df10a588 df1075a0 df10a588
[    2.172363] 1e00: df871e2c df871e10 df10a588 00000000 df10a608 dfa28e88 0000006d fc064c00
[    2.180969] 1e20: df871e6c df871e30 c015654c c0155c08 c0082098 c0071f74 00000001 dfa32898
[    2.189575] 1e40: dfa28e88 00000000 dfa32808 dfa32810 00000000 00000000 73757368 00003062
[    2.198181] 1e60: df871e7c dfa32808 c0716da8 c0716da8 00000000 00000000 00000000 00000000
[    2.206787] 1e80: df871e9c df871e90 c0298cfc c0321bb8 df871ec4 df871ea0 c0297650 c0298ce4
[    2.215423] 1ea0: df871ec4 dfa32808 dfa3283c dfa32808 dfa3283c c0716da8 df871ee4 df871ec8
[    2.224029] 1ec0: c02977ec c0297504 00000000 c0716da8 c0297774 00000000 df871f0c df871ee8
[    2.232635] 1ee0: c0296c00 c0297780 df891658 dfa31670 c023ac60 c0716da8 df1075a0 c070d6f8
[    2.241241] 1f00: df871f1c df871f10 c0297334 c0296bb0 df871f4c df871f20 c02963ec c0297318
[    2.249847] 1f20: c05b84a8 df871f30 c0716da8 c0c7e4c0 c0014ba0 00000000 00000000 00000000
[    2.258483] 1f40: df871f74 df871f50 c0297f00 c0296320 c0298d44 c0c7df14 c0c7e4c0 c0014ba0
[    2.267089] 1f60: 00000000 00000000 df871f84 df871f78 c02991e0 c0297e54 df871fa4 df871f88
[    2.275695] 1f80: c069904c c0299198 000000a0 00000060 c06c4e40 c0698fa4 df871fdc df871fa8
[    2.284301] 1fa0: c0008854 c0698fb0 c0014ba0 c009960c df871fdc df871fc0 c06c4e40 c06c49dc
[    2.292907] 1fc0: c0014ba0 00000013 00000000 00000000 df871ff4 df871fe0 c06792d4 c00087b8
[    2.301513] 1fe0: 00000000 c067924c 00000000 df871ff8 c0014ba0 c0679258 882bf20f 3184000e
[    2.310150] [<c02a8640>] (omap_usbhs_enable+0x148/0x590) from [<c0321d60>] (ehci_hcd_omap_probe+0x1b4/0x568)
[    2.320526] [<c0321d60>] (ehci_hcd_omap_probe+0x1b4/0x568) from [<c0298cfc>] (platform_drv_probe+0x24/0x28)
[    2.330780] [<c0298cfc>] (platform_drv_probe+0x24/0x28) from [<c0297650>] (driver_probe_device+0x158/0x27c)
[    2.341033] [<c0297650>] (driver_probe_device+0x158/0x27c) from [<c02977ec>] (__driver_attach+0x78/0x9c)
[    2.351043] [<c02977ec>] (__driver_attach+0x78/0x9c) from [<c0296c00>] (bus_for_each_dev+0x5c/0x8c)
[    2.360565] [<c0296c00>] (bus_for_each_dev+0x5c/0x8c) from [<c0297334>] (driver_attach+0x28/0x30)
[    2.369903] [<c0297334>] (driver_attach+0x28/0x30) from [<c02963ec>] (bus_add_driver+0xd8/0x260)
[    2.379180] [<c02963ec>] (bus_add_driver+0xd8/0x260) from [<c0297f00>] (driver_register+0xb8/0x144)
[    2.388702] [<c0297f00>] (driver_register+0xb8/0x144) from [<c02991e0>] (platform_driver_register+0x54/0x68)
[    2.399047] [<c02991e0>] (platform_driver_register+0x54/0x68) from [<c069904c>] (ehci_hcd_init+0xa8/0xfc)
[    2.409149] [<c069904c>] (ehci_hcd_init+0xa8/0xfc) from [<c0008854>] (do_one_initcall+0xa8/0x17c)
[    2.418487] [<c0008854>] (do_one_initcall+0xa8/0x17c) from [<c06792d4>] (kernel_init+0x88/0x134)
[    2.427764] [<c06792d4>] (kernel_init+0x88/0x134) from [<c0014ba0>] (kernel_thread_exit+0x0/0x8)
[    2.437011] Code: e59f0414 e1a01005 e59f2424 ebffac8d (e594303c) 

This seems to be very similar (if not identical) to the oops I was
getting before (with 3.0-rc2).  I checked the git log and the revert
that fixed my problem with 3.0-rc2 is now included in 3.1-rc1, so it
seems that something else is broken now.

I tried to revert the revert, with the idea that maybe the hwmod changes
were also included in 3.1-rc1, but it didn't help and I'm still getting
a similar oops.

Any clues?

-- 
Cheers,
Luca.


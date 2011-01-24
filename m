From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] OMAP3EVM:FIX: Reset the SMSC911x Ethernet controller in
 board_init
Date: Tue, 25 Jan 2011 01:28:14 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404BD7BE119@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
	<1295880108-15584-1-git-send-email-hvaibhav@ti.com> <87oc769je4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59772 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205Ab1AXT6a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 14:58:30 -0500
In-Reply-To: <87oc769je4.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "tony@atomide.com" <tony@atomide.com>


> -----Original Message-----
> From: Hilman, Kevin
> Sent: Tuesday, January 25, 2011 1:14 AM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; Varadarajan, Charulatha; tony@atomide.com
> Subject: Re: [PATCH] OMAP3EVM:FIX: Reset the SMSC911x Ethernet controller
> in board_init
> 
> Hi Vaibhav,
> 
> hvaibhav@ti.com writes:
> 
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > With addition of HWMOD support to GPIO, the Ethernet controller
> > goes undetected for OMAP35xEVM. So explicitely assert the reset signal
> to
> > Ethernet controller smsc911x -
> >
> > 	- GPIO7 (>=RevG version of EVM's)
> > 	- GPIO64 (<=RevD version of EVM's)
> >
> > I have tested this patch on RevG version of EVM with ES3.1 Si.
> > This patch is based on intial version from Charulatha V.
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> This didn't apply cleanly to l-o master, with or without your previous
> patches which touch the EVM board file.
> 
[Hiremath, Vaibhav] may be order in which you apply the patches is different, but should have been trivial to fix, right? 
I would suggest you to use newer version.

> > ---
> > NOTE: I have not been able to test it on older version of EVM's.
> 
> After manually applying,
> 
> Tested-by: Kevin Hilman <khilman@ti.com>
> 
> I tested on my rev D board with DHCP + nfs rootfs and it's working well.
> 
[Hiremath, Vaibhav] Thanks a lot for validating it.

> While testing though, I also noticed that the smsc driver is dumping
> some warnings (below) while trying to get the MAC address, resulting in
> not using the actual MAC but generating a random one.
> 
> This isn't related to your patch, since it also happens with l-o master,
> but was wondering if you saw the same thing?
> 
[Hiremath, Vaibhav] Yes I did see this message, and this is coming from 

#ifdef CONFIG_DEBUG_SPINLOCK
#define SMSC_ASSERT_MAC_LOCK(pdata) \
                WARN_ON(!spin_is_locked(&pdata->mac_lock))

And the root-cause is, in __init function we are calling smsc911x_read_mac_address->smsc911x_mac_read without holding mac_lock.

I will submit the patch to net mailing list for this.

Thanks,
Vaibhav

> A first glance looks like there are problems with the locking in the
> driver, but I didn't look very deep.
> 
> Kevin
> 
> 
> [    2.221832] smsc911x: Driver version 2008-10-21.
> [    2.227447] ------------[ cut here ]------------
> [    2.232574] WARNING: at
> /work/kernel/omap/dev/drivers/net/smsc911x.c:261
> smsc911x_mac_read+0x24/0x220()
> [    2.242645] Modules linked in:
> [    2.246124] [<c0060d40>] (unwind_backtrace+0x0/0xe0) from [<c0091dcc>]
> (warn_slowpath_common+0x4c/0x64)
> [    2.256256] [<c0091dcc>] (warn_slowpath_common+0x4c/0x64) from
> [<c0091dfc>] (warn_slowpath_null+0x18/0x1c)
> [    2.266632] [<c0091dfc>] (warn_slowpath_null+0x18/0x1c) from
> [<c02daeec>] (smsc911x_mac_read+0x24/0x220)
> [    2.276855] [<c02daeec>] (smsc911x_mac_read+0x24/0x220) from
> [<c03e6e38>] (smsc911x_read_mac_address+0x18/0x6c)
> [    2.287750] [<c03e6e38>] (smsc911x_read_mac_address+0x18/0x6c) from
> [<c03e7324>] (smsc911x_drv_probe+0x498/0x1788)
> [    2.298858] [<c03e7324>] (smsc911x_drv_probe+0x498/0x1788) from
> [<c028b53c>] (platform_drv_probe+0x14/0x18)
> [    2.309356] [<c028b53c>] (platform_drv_probe+0x14/0x18) from
> [<c028a764>] (driver_probe_device+0xc8/0x184)
> [    2.319793] [<c028a764>] (driver_probe_device+0xc8/0x184) from
> [<c028a888>] (__driver_attach+0x68/0x8c)
> [    2.329895] [<c028a888>] (__driver_attach+0x68/0x8c) from [<c02899cc>]
> (bus_for_each_dev+0x48/0x74)
> [    2.339660] [<c02899cc>] (bus_for_each_dev+0x48/0x74) from [<c028a064>]
> (bus_add_driver+0x9c/0x228)
> [    2.349426] [<c028a064>] (bus_add_driver+0x9c/0x228) from [<c028ac80>]
> (driver_register+0xa0/0x124)
> [    2.359191] [<c028ac80>] (driver_register+0xa0/0x124) from [<c0050618>]
> (do_one_initcall+0xb4/0x18c)
> [    2.369018] [<c0050618>] (do_one_initcall+0xb4/0x18c) from [<c0008abc>]
> (kernel_init+0x150/0x218)
> [    2.378631] [<c0008abc>] (kernel_init+0x150/0x218) from [<c005b14c>]
> (kernel_thread_exit+0x0/0x8)
> [    2.388427] ---[ end trace 5ae2d34b582d5786 ]---
> [    2.393493] ------------[ cut here ]------------
> [    2.398406] WARNING: at
> /work/kernel/omap/dev/drivers/net/smsc911x.c:244
> smsc911x_mac_complete+0x20/0xac()
> [    2.408813] Modules linked in:
> [    2.412139] [<c0060d40>] (unwind_backtrace+0x0/0xe0) from [<c0091dcc>]
> (warn_slowpath_common+0x4c/0x64)
> [    2.422241] [<c0091dcc>] (warn_slowpath_common+0x4c/0x64) from
> [<c0091dfc>] (warn_slowpath_null+0x18/0x1c)
> [    2.432647] [<c0091dfc>] (warn_slowpath_null+0x18/0x1c) from
> [<c02dae3c>] (smsc911x_mac_complete+0x20/0xac)
> [    2.443176] [<c02dae3c>] (smsc911x_mac_complete+0x20/0xac) from
> [<c02db068>] (smsc911x_mac_read+0x1a0/0x220)
> [    2.453735] [<c02db068>] (smsc911x_mac_read+0x1a0/0x220) from
> [<c03e6e38>] (smsc911x_read_mac_address+0x18/0x6c)
> [    2.464691] [<c03e6e38>] (smsc911x_read_mac_address+0x18/0x6c) from
> [<c03e7324>] (smsc911x_drv_probe+0x498/0x1788)
> [    2.475860] [<c03e7324>] (smsc911x_drv_probe+0x498/0x1788) from
> [<c028b53c>] (platform_drv_probe+0x14/0x18)
> [    2.486328] [<c028b53c>] (platform_drv_probe+0x14/0x18) from
> [<c028a764>] (driver_probe_device+0xc8/0x184)
> [    2.496734] [<c028a764>] (driver_probe_device+0xc8/0x184) from
> [<c028a888>] (__driver_attach+0x68/0x8c)
> [    2.506866] [<c028a888>] (__driver_attach+0x68/0x8c) from [<c02899cc>]
> (bus_for_each_dev+0x48/0x74)
> [    2.516601] [<c02899cc>] (bus_for_each_dev+0x48/0x74) from [<c028a064>]
> (bus_add_driver+0x9c/0x228)
> [    2.526367] [<c028a064>] (bus_add_driver+0x9c/0x228) from [<c028ac80>]
> (driver_register+0xa0/0x124)
> [    2.536132] [<c028ac80>] (driver_register+0xa0/0x124) from [<c0050618>]
> (do_one_initcall+0xb4/0x18c)
> [    2.545989] [<c0050618>] (do_one_initcall+0xb4/0x18c) from [<c0008abc>]
> (kernel_init+0x150/0x218)
> [    2.555572] [<c0008abc>] (kernel_init+0x150/0x218) from [<c005b14c>]
> (kernel_thread_exit+0x0/0x8)
> [    2.565124] ---[ end trace 5ae2d34b582d5787 ]---
> [    2.570037] ------------[ cut here ]------------
> [    2.575103] WARNING: at
> /work/kernel/omap/dev/drivers/net/smsc911x.c:261
> smsc911x_mac_read+0x24/0x220()
> [    2.585144] Modules linked in:
> [    2.588470] [<c0060d40>] (unwind_backtrace+0x0/0xe0) from [<c0091dcc>]
> (warn_slowpath_common+0x4c/0x64)
> [    2.598602] [<c0091dcc>] (warn_slowpath_common+0x4c/0x64) from
> [<c0091dfc>] (warn_slowpath_null+0x18/0x1c)
> [    2.609008] [<c0091dfc>] (warn_slowpath_null+0x18/0x1c) from
> [<c02daeec>] (smsc911x_mac_read+0x24/0x220)
> [    2.619201] [<c02daeec>] (smsc911x_mac_read+0x24/0x220) from
> [<c03e6e48>] (smsc911x_read_mac_address+0x28/0x6c)
> [    2.630065] [<c03e6e48>] (smsc911x_read_mac_address+0x28/0x6c) from
> [<c03e7324>] (smsc911x_drv_probe+0x498/0x1788)
> [    2.641204] [<c03e7324>] (smsc911x_drv_probe+0x498/0x1788) from
> [<c028b53c>] (platform_drv_probe+0x14/0x18)
> [    2.651702] [<c028b53c>] (platform_drv_probe+0x14/0x18) from
> [<c028a764>] (driver_probe_device+0xc8/0x184)
> [    2.662109] [<c028a764>] (driver_probe_device+0xc8/0x184) from
> [<c028a888>] (__driver_attach+0x68/0x8c)
> [    2.672210] [<c028a888>] (__driver_attach+0x68/0x8c) from [<c02899cc>]
> (bus_for_each_dev+0x48/0x74)
> [    2.681976] [<c02899cc>] (bus_for_each_dev+0x48/0x74) from [<c028a064>]
> (bus_add_driver+0x9c/0x228)
> [    2.691741] [<c028a064>] (bus_add_driver+0x9c/0x228) from [<c028ac80>]
> (driver_register+0xa0/0x124)
> [    2.701507] [<c028ac80>] (driver_register+0xa0/0x124) from [<c0050618>]
> (do_one_initcall+0xb4/0x18c)
> [    2.711334] [<c0050618>] (do_one_initcall+0xb4/0x18c) from [<c0008abc>]
> (kernel_init+0x150/0x218)
> [    2.720916] [<c0008abc>] (kernel_init+0x150/0x218) from [<c005b14c>]
> (kernel_thread_exit+0x0/0x8)
> [    2.730499] ---[ end trace 5ae2d34b582d5788 ]---
> [    2.735382] ------------[ cut here ]------------
> [    2.740447] WARNING: at
> /work/kernel/omap/dev/drivers/net/smsc911x.c:244
> smsc911x_mac_complete+0x20/0xac()
> [    2.750793] Modules linked in:
> [    2.754272] [<c0060d40>] (unwind_backtrace+0x0/0xe0) from [<c0091dcc>]
> (warn_slowpath_common+0x4c/0x64)
> [    2.764404] [<c0091dcc>] (warn_slowpath_common+0x4c/0x64) from
> [<c0091dfc>] (warn_slowpath_null+0x18/0x1c)
> [    2.774810] [<c0091dfc>] (warn_slowpath_null+0x18/0x1c) from
> [<c02dae3c>] (smsc911x_mac_complete+0x20/0xac)
> [    2.785308] [<c02dae3c>] (smsc911x_mac_complete+0x20/0xac) from
> [<c02db068>] (smsc911x_mac_read+0x1a0/0x220)
> [    2.795898] [<c02db068>] (smsc911x_mac_read+0x1a0/0x220) from
> [<c03e6e48>] (smsc911x_read_mac_address+0x28/0x6c)
> [    2.806823] [<c03e6e48>] (smsc911x_read_mac_address+0x28/0x6c) from
> [<c03e7324>] (smsc911x_drv_probe+0x498/0x1788)
> [    2.817962] [<c03e7324>] (smsc911x_drv_probe+0x498/0x1788) from
> [<c028b53c>] (platform_drv_probe+0x14/0x18)
> [    2.828460] [<c028b53c>] (platform_drv_probe+0x14/0x18) from
> [<c028a764>] (driver_probe_device+0xc8/0x184)
> [    2.838867] [<c028a764>] (driver_probe_device+0xc8/0x184) from
> [<c028a888>] (__driver_attach+0x68/0x8c)
> [    2.848968] [<c028a888>] (__driver_attach+0x68/0x8c) from [<c02899cc>]
> (bus_for_each_dev+0x48/0x74)
> [    2.858734] [<c02899cc>] (bus_for_each_dev+0x48/0x74) from [<c028a064>]
> (bus_add_driver+0x9c/0x228)
> [    2.868499] [<c028a064>] (bus_add_driver+0x9c/0x228) from [<c028ac80>]
> (driver_register+0xa0/0x124)
> [    2.878265] [<c028ac80>] (driver_register+0xa0/0x124) from [<c0050618>]
> (do_one_initcall+0xb4/0x18c)
> [    2.888122] [<c0050618>] (do_one_initcall+0xb4/0x18c) from [<c0008abc>]
> (kernel_init+0x150/0x218)
> [    2.897705] [<c0008abc>] (kernel_init+0x150/0x218) from [<c005b14c>]
> (kernel_thread_exit+0x0/0x8)
> [    2.907257] ---[ end trace 5ae2d34b582d5789 ]---
> [    2.929656] smsc911x-mdio: probed
> [    2.934234] eth0: attached PHY driver [SMSC LAN911x Internal PHY]
> (mii_bus:phy_addr=ffffffff:01, irq=-1)
> [    2.945068] net eth0: MAC Address: ea:a9:2b:c2:01:14

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: arm-soc + rmk's tree boot failure on OMAP4430SDP
Date: Sat, 17 Mar 2012 21:15:05 +0000
Message-ID: <20120317211505.GA4720@n2100.arm.linux.org.uk>
References: <20120316231158.GA9970@n2100.arm.linux.org.uk> <20120317004706.GF7276@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49626 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756988Ab2CQVPS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Mar 2012 17:15:18 -0400
Content-Disposition: inline
In-Reply-To: <20120317004706.GF7276@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Fri, Mar 16, 2012 at 05:47:06PM -0700, Tony Lindgren wrote:
> Hi,
> 
> Adding Tomi to this thread.
> 
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120316 16:14]:
> > Sometime during the last week, the OMAP4430SDP stopped booting - it now
> > stops with no kernel messages output:
> > 
> > http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=69
> > 
> > The previously booted version:
> > 
> > http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=57
> > 
> > worked fine - though this log will only be available for about 3 hours.
> > 
> > I've re-checked my tree, and the OMAP4430SDP boots fine, so it's either
> > breakage coming from arm-soc or a result of merging the two trees
> > together.
> 
> Based on initcall_debug with current linux-next, it seems to hang at
> omap_dss_init2. And leaving out CONFIG_OMAP2_DSS makes devices boot
> again.

Well, if I put my printk hack in, then I get:

Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
<6>msgmni has been set to 995
<6>io scheduler noop registered
<6>io scheduler deadline registered
<6>io scheduler cfq registered (default)
<3>INFO: task swapper/0:1 blocked for more than 120 seconds.
<3>"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
<6>swapper/0       D<c> c03237b0 <c>    0     1      0 0x00000000
Backtrace: 
[<c03233b4>] (__schedule+0x0/0x4d0) from [<c03239c4>] (schedule+0x74/0x78)
[<c0323950>] (schedule+0x0/0x78) from [<c0322404>] (__mutex_lock_slowpath+0x140/
0x19c)
[<c03222c4>] (__mutex_lock_slowpath+0x0/0x19c) from [<c032248c>] (mutex_lock+0x2
c/0x40)
[<c0322460>] (mutex_lock+0x0/0x40) from [<c01f8f68>] (__driver_attach+0x48/0x90)
 r4:df4f2808
[<c01f8f20>] (__driver_attach+0x0/0x90) from [<c01f77b0>] (bus_for_each_dev+0x58
/0x98)
 r6:c0475634 r5:c01f8f20 r4:00000000
[<c01f7758>] (bus_for_each_dev+0x0/0x98) from [<c01f8c58>] (driver_attach+0x20/0
x28)
 r7:df472780 r6:c0475634 r5:c0475634 r4:c045ea28
[<c01f8c38>] (driver_attach+0x0/0x28) from [<c01f8034>] (bus_add_driver+0xb4/0x2
30)
[<c01f7f80>] (bus_add_driver+0x0/0x230) from [<c01f9614>] (driver_register+0xac/
0x138)
[<c01f9568>] (driver_register+0x0/0x138) from [<c01fa678>] (platform_driver_regi
ster+0x4c/0x60)
 r8:c046c0d8 r7:c04755a4 r6:c04755a4 r5:c045ea30 r4:c045ea28
[<c01fa62c>] (platform_driver_register+0x0/0x60) from [<c01a7ae4>] (dss_init_pla
tform_driver+0x14/0x1c)
[<c01a7ad0>] (dss_init_platform_driver+0x0/0x1c) from [<c01a742c>] (omap_dss_pro
be+0x3c/0x200)
[<c01a73f0>] (omap_dss_probe+0x0/0x200) from [<c01fa2e8>] (platform_drv_probe+0x
20/0x24)
[<c01fa2c8>] (platform_drv_probe+0x0/0x24) from [<c01f8e3c>] (driver_probe_devic
e+0xd0/0x1b4)
[<c01f8d6c>] (driver_probe_device+0x0/0x1b4) from [<c01f8f8c>] (__driver_attach+
0x6c/0x90)
 r7:df443ef0 r6:c04755a4 r5:c045ea64 r4:c045ea30
[<c01f8f20>] (__driver_attach+0x0/0x90) from [<c01f77b0>] (bus_for_each_dev+0x58
/0x98)
 r6:c04755a4 r5:c01f8f20 r4:00000000
[<c01f7758>] (bus_for_each_dev+0x0/0x98) from [<c01f8c58>] (driver_attach+0x20/0
x28)
 r7:df472800 r6:c04755a4 r5:c04755a4 r4:c043e388
[<c01f8c38>] (driver_attach+0x0/0x28) from [<c01f8034>] (bus_add_driver+0xb4/0x2
30)
[<c01f7f80>] (bus_add_driver+0x0/0x230) from [<c01f9614>] (driver_register+0xac/
0x138)
[<c01f9568>] (driver_register+0x0/0x138) from [<c01fa678>] (platform_driver_regi
ster+0x4c/0x60)
 r8:00000000 r7:00000013 r6:c00373ec r5:c043e464 r4:c043e388
[<c01fa62c>] (platform_driver_register+0x0/0x60) from [<c042a0fc>] (omap_dss_ini
t2+0x14/0x1c)
[<c042a0e8>] (omap_dss_init2+0x0/0x1c) from [<c0008770>] (do_one_initcall+0x9c/0
x164)
[<c00086d4>] (do_one_initcall+0x0/0x164) from [<c04122f4>] (kernel_init+0x90/0x1
38)
[<c0412264>] (kernel_init+0x0/0x138) from [<c00373ec>] (do_exit+0x0/0x6c4)
 r5:c0412264 r4:00000000

And the reason is that a platform _driver_ (omapdss_dss) is being
registered while a platform device (omapdss) is being probed.

This is a very bad idea.  There is absolutely no reason to register
drivers from within a probe function - to put it another way, this
code is absolutely insane.

Why?  Because you're destroying the whole idea that drivers only ever
get registered once.  If you happen to have two omapdss devices (okay
that probably won't happen yet) then you'll register those device
structures twice which will cause all hell to break lose.

Moreover - and this is why it's failing - when devices are probed, their
mutex is held.  But not just _their_ mutex, but also their direct parent's
mutex as well.

So, when the omapdss_dss driver is registered while the omapdss device is
being probed, and there's already an omapdss_dss platform device present,
the driver model tries to bind the omapdss_dss platform device with the
newly registered omapdss_dss platform driver.

That binding wants to take the mutex on the omapdss device, but wait,
that's already held by the thread registering the omapdss_dss platform
driver.  Hence, deadlock.

This mess has been created by all those
	"DSS2: xxx: create platform_driver, move init, exit to driver"

commits, and they're all _wrong_ for the above reason.

However, I doubt simply moving the driver registration calls out of the
probe function will be enough - "OMAP: DSS2: Fix init and unit sequence"
hints that there's a dependence in the driver initialization order.
That's another finger pointing at the approach being wrong, because
there is _no_ guarantee as to the order in which drivers or devices are
probed by the driver model.

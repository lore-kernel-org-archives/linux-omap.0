From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: OMAP4430 produces boot warnings
Date: Wed, 21 Nov 2012 23:03:37 +0000
Message-ID: <20121121230337.GR3332@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

This one is nice and long, from last nights boot test.  Looks like it was
introduced sometime in the last couple of weeks.  Full log at:

http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=518

and config:
http://www.arm.linux.org.uk/developer/build/file.php?type=config&idx=2786

taal display1: taal panel revision e3.83.7d
------------[ cut here ]------------
WARNING: at drivers/bus/omap_l3_noc.c:97 l3_interrupt_handler+0x100/0x150()
L3 standard error: TARGET:DMM2 at address 0x0
Modules linked in:
Backtrace: 
[<c0016e90>] (dump_backtrace+0x0/0x110) from [<c035d964>] (dump_stack+0x18/0x1c)
 r6:c0395088 r5:00000061 r4:df03fb30 r3:c04d0d54
[<c035d94c>] (dump_stack+0x0/0x1c) from [<c003519c>] (warn_slowpath_common+0x54/0x6c)
[<c0035148>] (warn_slowpath_common+0x0/0x6c) from [<c0035258>] (warn_slowpath_fmt+0x38/0x40)
 r8:00000000 r7:00000000 r6:c0394f74 r5:00080001 r4:f8000200
r3:00000009
[<c0035220>] (warn_slowpath_fmt+0x0/0x40) from [<c01ac168>] (l3_interrupt_handler+0x100/0x150)
 r3:c0395121 r2:c03950bc
[<c01ac068>] (l3_interrupt_handler+0x0/0x150) from [<c007a210>] (handle_irq_event_percpu+0x38/0x17c)
 r6:0000002a r5:df006500 r4:df14a6c0
[<c007a1d8>] (handle_irq_event_percpu+0x0/0x17c) from [<c007a3ac>] (handle_irq_event+0x58/0x78)
[<c007a354>] (handle_irq_event+0x0/0x78) from [<c007d23c>] (handle_fasteoi_irq+0xcc/0x138)
 r6:c04b4558 r5:00000000 r4:df006500 r3:00000000
[<c007d170>] (handle_fasteoi_irq+0x0/0x138) from [<c0079bb8>] (generic_handle_irq+0x28/0x38)
 r4:0000002a r3:c007d170
[<c0079b90>] (generic_handle_irq+0x0/0x38) from [<c0014358>] (handle_IRQ+0x80/0xc0)
 r4:0000002a r3:000001bc
[<c00142d8>] (handle_IRQ+0x0/0xc0) from [<c0008684>] (gic_handle_irq+0x3c/0x60)
 r5:df03fc38 r4:fa240100
[<c0008648>] (gic_handle_irq+0x0/0x60) from [<c0012fc0>] (__irq_svc+0x40/0x50)
Exception stack(0xdf03fc38 to 0xdf03fc80)
fc20:                                                       c0509360 60000113
fc40: 00000000 00200020 df29e600 60000113 c0508f0c df195400 fa044104 4012fde0
fc60: 000a2139 df03fc8c df03fc90 df03fc80 c01c9708 c03604a8 60000113 ffffffff
 r6:ffffffff r5:60000113 r4:c03604a8 r3:c01c9708
[<c0360474>] (_raw_spin_unlock_irqrestore+0x0/0x38) from [<c01c9708>] (dss_mgr_start_update+0xc4/0xd8)
[<c01c9644>] (dss_mgr_start_update+0x0/0xd8) from [<c01d0ecc>] (dsi_update_screen_dispc.clone.9+0x1c4/0x22c)
 r6:00000000 r5:df195410 r4:df340410 r3:001f001f
[<c01d0d08>] (dsi_update_screen_dispc.clone.9+0x0/0x22c) from [<c01d0f74>] (omap_dsi_update+0x40/0x48)
[<c01d0f34>] (omap_dsi_update+0x0/0x48) from [<c01dd0ec>] (taal_update+0xb8/0xe4)
 r7:c04d9798 r6:00000000 r5:df340800 r4:df29ea10
[<c01dd034>] (taal_update+0x0/0xe4) from [<c01d8cc0>] (omapfb_init_display+0x110/0x14c)
 r6:00000000 r5:df340800 r4:df042000
[<c01d8bb0>] (omapfb_init_display+0x0/0x14c) from [<c0493918>] (omapfb_probe+0x378/0x408)
 r8:df042708 r7:c04d0a80 r6:00000003 r5:df340800 r4:df042000
[<c04935a0>] (omapfb_probe+0x0/0x408) from [<c0210a7c>] (platform_drv_probe+0x1c/0x20)
[<c0210a60>] (platform_drv_probe+0x0/0x20) from [<c020f654>] (really_probe+0xa4/0x1c4)
[<c020f5b0>] (really_probe+0x0/0x1c4) from [<c020f894>] (driver_probe_device+0x38/0x50)
 r7:00000000 r6:c04d907c r5:c04d907c r4:c04d0a90
[<c020f85c>] (driver_probe_device+0x0/0x50) from [<c020f914>] (__driver_attach+0x68/0x8c)
 r5:c04d0ac4 r4:c04d0a90
[<c020f8ac>] (__driver_attach+0x0/0x8c) from [<c020df48>] (bus_for_each_dev+0x58/0x88)
 r6:c020f8ac r5:df03fe50 r4:c04d907c r3:c020f8ac
[<c020def0>] (bus_for_each_dev+0x0/0x88) from [<c020f3a8>] (driver_attach+0x20/0x28)
 r7:00000000 r6:c04ddeb0 r5:df167180 r4:c04d907c
[<c020f388>] (driver_attach+0x0/0x28) from [<c020ee34>] (bus_add_driver+0xb4/0x228)
[<c020ed80>] (bus_add_driver+0x0/0x228) from [<c020fec8>] (driver_register+0xa4/0x134)
 r8:00000000 r7:c0493564 r6:c04a238c r5:c04a23ac r4:c04d907c
[<c020fe24>] (driver_register+0x0/0x134) from [<c0210d74>] (platform_driver_register+0x4c/0x60)
[<c0210d28>] (platform_driver_register+0x0/0x60) from [<c0210da8>] (platform_driver_probe+0x20/0xb4)
[<c0210d88>] (platform_driver_probe+0x0/0xb4) from [<c049357c>] (omapfb_init+0x18/0x3c)
 r6:c04a238c r5:c04a23ac r4:00000007 r3:df03e000
[<c0493564>] (omapfb_init+0x0/0x3c) from [<c00088d4>] (do_one_initcall+0xa4/0x174)
[<c0008830>] (do_one_initcall+0x0/0x174) from [<c0479960>] (kernel_init_freeable+0x104/0x1c8)
[<c047985c>] (kernel_init_freeable+0x0/0x1c8) from [<c03535b4>] (kernel_init+0x10/0x10c)
[<c03535a4>] (kernel_init+0x0/0x10c) from [<c0013458>] (ret_from_fork+0x14/0x3c)
 r4:00000000 r3:00000000
---[ end trace e317d608bf587b3d ]---
omapdss DISPC error: OCP_ERR

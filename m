From: lamikr <lamikr@cc.jyu.fi>
Subject: rmmod omap-keymap crash for others?
Date: Tue, 18 Apr 2006 22:50:03 +0300
Message-ID: <444542EB.8030301@cc.jyu.fi>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi

Are others still seeing same crash than what I get with 2.6.16 kernel
when I rmmod omap-kaymap?
For me this happens omap1510 based iPAQ h6300.
I have checked that the irq tryed to free has earlier received ok by
using platform_get_irq() method and before calling the rmmod, the driver
seems to work just fine.

rmmod omap-keymap
omap-keypad: key 0-1 released
Trying to free IRQ33
[<c002bb60>] (dump_stack+0x0/0x14) from [<c002829c>] (free_irq+0xa8/0xc0)
[<c00281f4>] (free_irq+0x0/0xc0) from [<bf0423ac>]
(omap_kp_remove+0x48/0x70 [omap_keypad])
 r4 = C1D4E420
[<bf042364>] (omap_kp_remove+0x0/0x70 [omap_keypad]) from [<c018265c>]
(platform_drv_remove+0x20/0x24)
 r4 = C02F38E0
[<c018263c>] (platform_drv_remove+0x0/0x24) from [<c0180b28>]
(__device_release_driver+0x70/0x88)
[<c0180ab8>] (__device_release_driver+0x0/0x88) from [<c0180c3c>]
(driver_detach+0x9c/0x100)
 r6 = BF042EAC  r5 = C02F38E0  r4 = C02F39A4
[<c0180ba0>] (driver_detach+0x0/0x100) from [<c0180474>]
(bus_remove_driver+0x8c/0xb0)
 r6 = C1EFC000  r5 = C0305BE4  r4 = BF042EAC
[<c01803e8>] (bus_remove_driver+0x0/0xb0) from [<c0180f78>]
(driver_unregister+0x14/0x20)
 r7 = 00000000  r6 = C1EFC000  r5 = BF042F80  r4 = BF042EAC
[<c0180f64>] (driver_unregister+0x0/0x20) from [<c0182768>]
(platform_driver_unregister+0x14/0x18)
 r4 = C02F64CC
[<c0182754>] (platform_driver_unregister+0x0/0x18) from [<bf042410>]
(omap_kp_exit+0x14/0x1c [omap_keypad])
[<bf0423fc>] (omap_kp_exit+0x0/0x1c [omap_keypad]) from [<c006c574>]
(sys_delete_module+0x244/0x2a8)
[<c006c330>] (sys_delete_module+0x0/0x2a8) from [<c0026

Mika

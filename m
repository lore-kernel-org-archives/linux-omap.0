From: "Mouhammad Tayseer Alquoatli" <idoit.ief@gmail.com>
Subject: spinlock recursion bug on booting 2.6.15
Date: Mon, 12 Jun 2006 19:02:29 +0300
Message-ID: <d8c9df6c0606120902j40869ad9n1213d91e87b2a23d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi All:
i'm working on OSK5912 i've just updated the boot loader to u-boot-1.1.2 and
i'm running kernel 2.6.15 with omap patches
kernel hangs just after decompression phase .. setting CONFIG_DEBUG_LL to
"y" helps showing the following bug:

BUG: spinlock recursion on CPU#0, swapper/1
[   52.887786] BUG: spinlock recursion on CPU#0, swapper/1
 lock: c01fde50, .magic: dead4ead, .owner: swapper/1, .owner_cpu: 0
[   52.899566]  lock: c01fde50, .magic: dead4ead, .owner: swapper/1,
.owner_cpu: 0
[<c002706c>] [   52.908477] [<c002706c>] (dump_stack+0x0/0x14)
(dump_stack+0x0/0x14) from [<c01075dc>] from [<c01075dc>]
(spin_bug+0x94/0xac)
(spin_bug+0x94/0xac)
[<c0107548>] [   52.923706] [<c0107548>] (spin_bug+0x0/0xac)
(spin_bug+0x0/0xac) from [<c01078c8>] from [<c01078c8>]
(_raw_spin_lock+0x50/0x134)
(_raw_spin_lock+0x50/0x134)
 r6 = C02BC000 [   52.939941]  r6 = C02BC000  r5 = C01FDE50  r5 = C01FDE50
r4 = C01FDE50  r4 = C01FDE50

[<c0107878>] [   52.949768] [<c0107878>] (_raw_spin_lock+0x0/0x134)
(_raw_spin_lock+0x0/0x134) from [<c01c6168>] from [<c01c6168>]
(_spin_lock+0x20/0x24)
(_spin_lock+0x20/0x24)
 r6 = 00000005 [   52.966369]  r6 = 00000005  r5 = C01FDE50  r5 = C01FDE50
r4 = C01FDE50  r4 = C01FDE50

[<c01c6148>] [   52.976226] [<c01c6148>] (_spin_lock+0x0/0x24)
(_spin_lock+0x0/0x24) from [<c0037258>] from [<c0037258>]
(gpio_wake_enable+0x74/0xc4)
(gpio_wake_enable+0x74/0xc4)
 r4 = C01FDE38 [   52.993011]  r4 = C01FDE38

[<c00371e4>] [   52.997344] [<c00371e4>] (gpio_wake_enable+0x0/0xc4)
(gpio_wake_enable+0x0/0xc4) from [<c002259c>] from [<c002259c>]
(enable_irq_wake+0x44/0x5c)
(enable_irq_wake+0x44/0x5c)
 r7 = 00000000 [   52.015045]  r7 = 00000000  r6 = 00000001  r6 = 00000001
r5 = 80000013  r5 = 80000013  r4 = 000000C5
 r4 = 000000C5
[<c0022558>] [   52.027404] [<c0022558>] (enable_irq_wake+0x0/0x5c)
(enable_irq_wake+0x0/0x5c) from [<c0011370>] from [<c0011370>]
(omap_serial_set_port_wakeup+0xa8/0xbc)
(omap_serial_set_port_wakeup+0xa8/0xbc)
 r5 = C02BC000 [   52.047119]  r5 = C02BC000  r4 = 00000025  r4 = 00000025

[<c00112c8>] [   52.054229] [<c00112c8>]
(omap_serial_set_port_wakeup+0x0/0xbc)
(omap_serial_set_port_wakeup+0x0/0xbc) from [<c00113a8>] from [<c00113a8>]
(omap_serial_wakeup_init+0x24/0x68)
(omap_serial_wakeup_init+0x24/0x68)
 r4 = C001E6EC [   52.075378]  r4 = C001E6EC

[<c0011384>] [   52.079711] [<c0011384>] (omap_serial_wakeup_init+0x0/0x68)
(omap_serial_wakeup_init+0x0/0x68) from [<c00210f8>] from [<c00210f8>]
(init+0x8c/0x220)
(init+0x8c/0x220)
[<c002106c>] [   52.096679] [<c002106c>] (init+0x0/0x220) (init+0x0/0x220)
from [<c003ffa8>] from [<c003ffa8>] (do_exit+0x0/0xbb8)
(do_exit+0x0/0xbb8)
 r6 = 00000000 [   52.110931]  r6 = 00000000  r5 = 00000000  r5 = 00000000
r4 = 00000000  r4 = 00000000

BUG: spinlock lockup on CPU#0, swapper/1, c01fde50
[   52.606048] BUG: spinlock lockup on CPU#0, swapper/1, c01fde50
[<c002706c>] [   52.613433] [<c002706c>] (dump_stack+0x0/0x14)
(dump_stack+0x0/0x14) from [<c0107970>] from [<c0107970>]
(_raw_spin_lock+0xf8/0x134)
(_raw_spin_lock+0xf8/0x134)
[<c0107878>] [   52.629882] [<c0107878>] (_raw_spin_lock+0x0/0x134)
(_raw_spin_lock+0x0/0x134) from [<c01c6168>] from [<c01c6168>]
(_spin_lock+0x20/0x24)
(_spin_lock+0x20/0x24)
 r6 = 00000005 [   52.646484]  r6 = 00000005  r5 = C01FDE50  r5 = C01FDE50
r4 = C01FDE50  r4 = C01FDE50

[<c01c6148>] [   52.656311] [<c01c6148>] (_spin_lock+0x0/0x24)
(_spin_lock+0x0/0x24) from [<c0037258>] from [<c0037258>]
(gpio_wake_enable+0x74/0xc4)
(gpio_wake_enable+0x74/0xc4)
 r4 = C01FDE38 [   52.673095]  r4 = C01FDE38

[<c00371e4>] [   52.677429] [<c00371e4>] (gpio_wake_enable+0x0/0xc4)
(gpio_wake_enable+0x0/0xc4) from [<c002259c>] from [<c002259c>]
(enable_irq_wake+0x44/0x5c)
(enable_irq_wake+0x44/0x5c)
 r7 = 00000000 [   52.695129]  r7 = 00000000  r6 = 00000001  r6 = 00000001
r5 = 80000013  r5 = 80000013  r4 = 000000C5
 r4 = 000000C5
[<c0022558>] [   52.707489] [<c0022558>] (enable_irq_wake+0x0/0x5c)
(enable_irq_wake+0x0/0x5c) from [<c0011370>] from [<c0011370>]
(omap_serial_set_port_wakeup+0xa8/0xbc)
(omap_serial_set_port_wakeup+0xa8/0xbc)
 r5 = C02BC000 [   52.727203]  r5 = C02BC000  r4 = 00000025  r4 = 00000025

[<c00112c8>] [   52.734283] [<c00112c8>]
(omap_serial_set_port_wakeup+0x0/0xbc)
(omap_serial_set_port_wakeup+0x0/0xbc) from [<c00113a8>] from [<c00113a8>]
(omap_serial_wakeup_init+0x24/0x68)
(omap_serial_wakeup_init+0x24/0x68)
 r4 = C001E6EC [   52.755462]  r4 = C001E6EC

[<c0011384>] [   52.759796] [<c0011384>] (omap_serial_wakeup_init+0x0/0x68)
(omap_serial_wakeup_init+0x0/0x68) from [<c00210f8>] from [<c00210f8>]
(init+0x8c/0x220)
(init+0x8c/0x220)
[<c002106c>] [   52.776763] [<c002106c>] (init+0x0/0x220) (init+0x0/0x220)
from [<c003ffa8>] from [<c003ffa8>] (do_exit+0x0/0xbb8)
(do_exit+0x0/0xbb8)
 r6 = 00000000 [   52.791015]  r6 = 00000000  r5 = 00000000  r5 = 00000000
r4 = 00000000  r4 = 00000000

the same error happened when compiling the kernel with both ELDK4 and gcc
3.4.4
what am i missing ? how can i get rid of this error ?


-- 
Mouhammad Tayseer Alquoatli

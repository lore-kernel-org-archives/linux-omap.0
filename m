From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Mon, 13 Jul 2015 18:05:47 +0200
Message-ID: <20150713160547.GA3270@pali>
References: <201507111405.06048@pali>
 <20150713155139.GA17362@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150713155139.GA17362@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

On Monday 13 July 2015 17:51:39 Sebastian Reichel wrote:
> Hi,
>=20
> On Sat, Jul 11, 2015 at 02:05:05PM +0200, Pali Roh=C3=A1r wrote:
> > now I tested 4.2-rc1 release on Nokia N900 and couple of drivers ar=
e
> > broken and cause kernel oops...
> >=20
> > Basically wifi, touchscreen and rtc drivers not working...
>=20
> I just tried 4.2-rc2 and I can't see any of the problems you have:
>=20
> [    2.473968] twl_rtc 48070000.i2c:twl@48:rtc: Power up reset detect=
ed.
> [    2.481170] twl_rtc 48070000.i2c:twl@48:rtc: Enabling TWL-RTC
> [    2.492095] twl_rtc 48070000.i2c:twl@48:rtc: rtc core: registered =
48070000.i2c:twl@48 as rtc0
> ...
> [    3.017028] wl1251: loaded
> [    3.022430] wl1251: initialized
> ...
> [    3.065490] input: TSC2005 touchscreen as /devices/platform/680000=
00.ocp/48098000.spi/spi_master/spi1/spi1.0/input/input5
> ...
>=20
> The only thing I noticed is, that the display is not working.
> For some reason it is not enabled:
>=20
> root@n900:/sys/class/drm/card0-Unknown-2# cat status
> connected
> root@n900:/sys/class/drm/card0-Unknown-2# cat modes
> 800x480
> root@n900:/sys/class/drm/card0-Unknown-2# cat enabled
> disabled
>=20
> -- Sebastian

Hi!

now I'm testing 4.2-rc2 release and rtc is working:

[   27.426055] omap_i2c 48072000.i2c: controller timed out
[   28.723358] twl_rtc 48070000.i2c:twl@48:rtc: Power up reset detected=
=2E
[   30.127014] twl_rtc 48070000.i2c:twl@48:rtc: Enabling TWL-RTC
[   31.373626] twl_rtc 48070000.i2c:twl@48:rtc: rtc core: registered 48=
070000.i2c:twl@48 as rtc0

There is still some i2c time out line and some reset detected, but
driver loads fine.

But problem with touchscreen tsc2005 and wifi wl1251 is still there :-(
Drivers are compiled as external .ko modules.

Plus I see new problem with bq2415_charger :-(

[   54.214965] isp1704_charger isp1704: registered with product id isp1=
707
[   54.828674] bq2415x-charger 2-006b: automode enabled
[   55.192596] ------------[ cut here ]------------
[   55.200561] WARNING: CPU: 0 PID: 528 at kernel/workqueue.c:1443 __qu=
eue_delayed_work+0x50/0x144()
[   55.208648] Modules linked in: isp1704_charger rx51_battery nokia_h4=
p lis3lv02d_i2c lis3lv02d input_polldev bluetooth ad5820 bq2415x_charge=
r omap_ssi bq27x00_battery hsi si4713 v4l2_common rtc_twl tsl2563 leds_=
lp5523 leds_lp55xx_common video_bus_switch videodev media twl4030_vibra=
 ff_memless tsc2005(+) omap_sham twl4030_wdt omap_wdt
[   55.242828] CPU: 0 PID: 528 Comm: kworker/0:3 Tainted: G      D W   =
    4.2.0-rc2+ #364
[   55.251556] Hardware name: Nokia RX-51 board
[   55.260070] Workqueue: events power_supply_changed_work
[   55.268524] [<c0013650>] (unwind_backtrace) from [<c0011bf4>] (show_=
stack+0x10/0x14)
[   55.277099] [<c0011bf4>] (show_stack) from [<c003346c>] (warn_slowpa=
th_common+0x84/0xac)
[   55.285675] [<c003346c>] (warn_slowpath_common) from [<c00334ac>] (w=
arn_slowpath_null+0x18/0x1c)
[   55.294281] [<c00334ac>] (warn_slowpath_null) from [<c0047bb0>] (__q=
ueue_delayed_work+0x50/0x144)
[   55.302795] [<c0047bb0>] (__queue_delayed_work) from [<c0047cdc>] (q=
ueue_delayed_work_on+0x38/0x44)
[   55.319488] [<c0047cdc>] (queue_delayed_work_on) from [<bf0a59e4>] (=
bq2415x_notifier_call+0x90/0x9c [bq2415x_charger])
[   55.337249] [<bf0a59e4>] (bq2415x_notifier_call [bq2415x_charger]) f=
rom [<c004de34>] (notifier_call_chain+0x38/0x68)
[   55.355621] [<c004de34>] (notifier_call_chain) from [<c004dff4>] (__=
atomic_notifier_call_chain+0x34/0x44)
[   55.374664] [<c004dff4>] (__atomic_notifier_call_chain) from [<c004e=
018>] (atomic_notifier_call_chain+0x14/0x18)
[   55.394042] [<c004e018>] (atomic_notifier_call_chain) from [<c0305a9=
c>] (power_supply_changed_work+0xac/0x130)
[   55.414245] [<c0305a9c>] (power_supply_changed_work) from [<c00484d8=
>] (process_one_work+0x278/0x45c)
[   55.435302] [<c00484d8>] (process_one_work) from [<c0048918>] (worke=
r_thread+0x230/0x354)
[   55.446228] [<c0048918>] (worker_thread) from [<c004d0e0>] (kthread+=
0xcc/0xe0)
[   55.457183] [<c004d0e0>] (kthread) from [<c000eb08>] (ret_from_fork+=
0x14/0x2c)
[   55.468170] ---[ end trace 53c71cbce36f62a7 ]---
[   55.478912] ------------[ cut here ]------------
[   55.489501] WARNING: CPU: 0 PID: 528 at kernel/workqueue.c:1445 __qu=
eue_delayed_work+0xb4/0x144()
[   55.500213] Modules linked in: isp1704_charger rx51_battery nokia_h4=
p lis3lv02d_i2c lis3lv02d input_polldev bluetooth ad5820 bq2415x_charge=
r omap_ssi bq27x00_battery hsi si4713 v4l2_common rtc_twl tsl2563 leds_=
lp5523 leds_lp55xx_common video_bus_switch videodev media twl4030_vibra=
 ff_memless tsc2005(+) omap_sham twl4030_wdt omap_wdt
[   55.543579] CPU: 0 PID: 528 Comm: kworker/0:3 Tainted: G      D W   =
    4.2.0-rc2+ #364
[   55.554565] Hardware name: Nokia RX-51 board
[   55.565307] Workqueue: events power_supply_changed_work
[   55.576049] [<c0013650>] (unwind_backtrace) from [<c0011bf4>] (show_=
stack+0x10/0x14)
[   55.586853] [<c0011bf4>] (show_stack) from [<c003346c>] (warn_slowpa=
th_common+0x84/0xac)
[   55.597778] [<c003346c>] (warn_slowpath_common) from [<c00334ac>] (w=
arn_slowpath_null+0x18/0x1c)
[   55.608764] [<c00334ac>] (warn_slowpath_null) from [<c0047c14>] (__q=
ueue_delayed_work+0xb4/0x144)
[   55.619628] [<c0047c14>] (__queue_delayed_work) from [<c0047cdc>] (q=
ueue_delayed_work_on+0x38/0x44)
[   55.640594] [<c0047cdc>] (queue_delayed_work_on) from [<bf0a59e4>] (=
bq2415x_notifier_call+0x90/0x9c [bq2415x_charger])
[   55.661651] [<bf0a59e4>] (bq2415x_notifier_call [bq2415x_charger]) f=
rom [<c004de34>] (notifier_call_chain+0x38/0x68)
[   55.682647] [<c004de34>] (notifier_call_chain) from [<c004dff4>] (__=
atomic_notifier_call_chain+0x34/0x44)
[   55.703613] [<c004dff4>] (__atomic_notifier_call_chain) from [<c004e=
018>] (atomic_notifier_call_chain+0x14/0x18)
[   55.724639] [<c004e018>] (atomic_notifier_call_chain) from [<c0305a9=
c>] (power_supply_changed_work+0xac/0x130)
[   55.745605] [<c0305a9c>] (power_supply_changed_work) from [<c00484d8=
>] (process_one_work+0x278/0x45c)
[   55.766784] [<c00484d8>] (process_one_work) from [<c0048918>] (worke=
r_thread+0x230/0x354)
[   55.777740] [<c0048918>] (worker_thread) from [<c004d0e0>] (kthread+=
0xcc/0xe0)
[   55.788635] [<c004d0e0>] (kthread) from [<c000eb08>] (ret_from_fork+=
0x14/0x2c)
[   55.799591] ---[ end trace 53c71cbce36f62a8 ]---
[   55.810363] ------------[ cut here ]------------
[   55.820953] WARNING: CPU: 0 PID: 528 at kernel/workqueue.c:1376 __qu=
eue_work+0x2c0/0x404()
[   55.831604] Modules linked in: isp1704_charger rx51_battery nokia_h4=
p lis3lv02d_i2c lis3lv02d input_polldev bluetooth ad5820 bq2415x_charge=
r omap_ssi bq27x00_battery hsi si4713 v4l2_common rtc_twl tsl2563 leds_=
lp5523 leds_lp55xx_common video_bus_switch videodev media twl4030_vibra=
 ff_memless tsc2005(+) omap_sham twl4030_wdt omap_wdt
[   55.874847] CPU: 0 PID: 528 Comm: kworker/0:3 Tainted: G      D W   =
    4.2.0-rc2+ #364
[   55.885803] Hardware name: Nokia RX-51 board
[   55.896545] Workqueue: events power_supply_changed_work
[   55.907226] [<c0013650>] (unwind_backtrace) from [<c0011bf4>] (show_=
stack+0x10/0x14)
[   55.918029] [<c0011bf4>] (show_stack) from [<c003346c>] (warn_slowpa=
th_common+0x84/0xac)
[   55.928924] [<c003346c>] (warn_slowpath_common) from [<c00334ac>] (w=
arn_slowpath_null+0x18/0x1c)
[   55.939910] [<c00334ac>] (warn_slowpath_null) from [<c004722c>] (__q=
ueue_work+0x2c0/0x404)
[   55.950744] [<c004722c>] (__queue_work) from [<c0047cdc>] (queue_del=
ayed_work_on+0x38/0x44)
[   55.961456] [<c0047cdc>] (queue_delayed_work_on) from [<bf0a59e4>] (=
bq2415x_notifier_call+0x90/0x9c [bq2415x_charger])
[   55.982391] [<bf0a59e4>] (bq2415x_notifier_call [bq2415x_charger]) f=
rom [<c004de34>] (notifier_call_chain+0x38/0x68)
[   56.003295] [<c004de34>] (notifier_call_chain) from [<c004dff4>] (__=
atomic_notifier_call_chain+0x34/0x44)
[   56.024139] [<c004dff4>] (__atomic_notifier_call_chain) from [<c004e=
018>] (atomic_notifier_call_chain+0x14/0x18)
[   56.045013] [<c004e018>] (atomic_notifier_call_chain) from [<c0305a9=
c>] (power_supply_changed_work+0xac/0x130)
[   56.065887] [<c0305a9c>] (power_supply_changed_work) from [<c00484d8=
>] (process_one_work+0x278/0x45c)
[   56.086761] [<c00484d8>] (process_one_work) from [<c0048918>] (worke=
r_thread+0x230/0x354)
[   56.097503] [<c0048918>] (worker_thread) from [<c004d0e0>] (kthread+=
0xcc/0xe0)
[   56.108245] [<c004d0e0>] (kthread) from [<c000eb08>] (ret_from_fork+=
0x14/0x2c)
[   56.118896] ---[ end trace 53c71cbce36f62a9 ]---
[   56.145874] g_nokia gadget: high-speed config #1: Bus Powered
[   56.243347] bq2415x-charger 2-006b: driver registered
[   77.142181] INFO: rcu_preempt detected stalls on CPUs/tasks: { P528}=
 (detected by 0, t=3D2102 jiffies, g=3D1101, c=3D1100, q=3D3834)
[   77.163391] kworker/0:3     R running      0   528      2 0x00000000
[   77.173706] Workqueue: events power_supply_changed_work
[   77.183898] [<c042883c>] (__schedule) from [<c0428c94>] (preempt_sch=
edule_irq+0x54/0x84)
[   77.194274] [<c0428c94>] (preempt_schedule_irq) from [<c042c23c>] (s=
vc_preempt+0x8/0x18)
[   77.204711] [<c042c23c>] (svc_preempt) from [<c0047ce4>] (queue_dela=
yed_work_on+0x40/0x44)
[   77.215179] [<c0047ce4>] (queue_delayed_work_on) from [<bf0a59e4>] (=
bq2415x_notifier_call+0x90/0x9c [bq2415x_charger])
[   77.235870] [<bf0a59e4>] (bq2415x_notifier_call [bq2415x_charger]) f=
rom [<c004de34>] (notifier_call_chain+0x38/0x68)
[   77.257019] [<c004de34>] (notifier_call_chain) from [<c004dff4>] (__=
atomic_notifier_call_chain+0x34/0x44)
[   77.278411] [<c004dff4>] (__atomic_notifier_call_chain) from [<c004e=
018>] (atomic_notifier_call_chain+0x14/0x18)
[   77.299804] [<c004e018>] (atomic_notifier_call_chain) from [<c0305a9=
c>] (power_supply_changed_work+0xac/0x130)
[   77.321197] [<c0305a9c>] (power_supply_changed_work) from [<c00484d8=
>] (process_one_work+0x278/0x45c)
[   77.342529] [<c00484d8>] (process_one_work) from [<c0048918>] (worke=
r_thread+0x230/0x354)
[   77.353393] [<c0048918>] (worker_thread) from [<c004d0e0>] (kthread+=
0xcc/0xe0)
[   77.364074] [<c004d0e0>] (kthread) from [<c000eb08>] (ret_from_fork+=
0x14/0x2c)
[   77.374572] kworker/0:3     R running      0   528      2 0x00000000
[   77.384948] Workqueue: events power_supply_changed_work
[   77.395111] [<c042883c>] (__schedule) from [<c0428c94>] (preempt_sch=
edule_irq+0x54/0x84)
[   77.405456] [<c0428c94>] (preempt_schedule_irq) from [<c042c23c>] (s=
vc_preempt+0x8/0x18)
[   77.415863] [<c042c23c>] (svc_preempt) from [<c0047ce4>] (queue_dela=
yed_work_on+0x40/0x44)
[   77.426269] [<c0047ce4>] (queue_delayed_work_on) from [<bf0a59e4>] (=
bq2415x_notifier_call+0x90/0x9c [bq2415x_charger])
[   77.447174] [<bf0a59e4>] (bq2415x_notifier_call [bq2415x_charger]) f=
rom [<c004de34>] (notifier_call_chain+0x38/0x68)
[   77.468322] [<c004de34>] (notifier_call_chain) from [<c004dff4>] (__=
atomic_notifier_call_chain+0x34/0x44)
[   77.489990] [<c004dff4>] (__atomic_notifier_call_chain) from [<c004e=
018>] (atomic_notifier_call_chain+0x14/0x18)
[   77.512115] [<c004e018>] (atomic_notifier_call_chain) from [<c0305a9=
c>] (power_supply_changed_work+0xac/0x130)
[   77.534637] [<c0305a9c>] (power_supply_changed_work) from [<c00484d8=
>] (process_one_work+0x278/0x45c)
[   77.557189] [<c00484d8>] (process_one_work) from [<c0048918>] (worke=
r_thread+0x230/0x354)
[   77.568634] [<c0048918>] (worker_thread) from [<c004d0e0>] (kthread+=
0xcc/0xe0)
[   77.579925] [<c004d0e0>] (kthread) from [<c000eb08>] (ret_from_fork+=
0x14/0x2c)

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

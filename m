From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Tue, 14 Jul 2015 09:18:52 +0900
Message-ID: <55A4556C.6030007@samsung.com>
References: <201507111405.06048@pali> <20150713155139.GA17362@earth>
 <20150713160547.GA3270@pali> <20150713193232.GA15675@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150713193232.GA15675@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, =?windows-1252?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 14.07.2015 04:32, Sebastian Reichel wrote:
> Hi,
>=20
> On Mon, Jul 13, 2015 at 06:05:47PM +0200, Pali Roh=E1r wrote:
>> now I'm testing 4.2-rc2 release and rtc is working:
>>
>> [   27.426055] omap_i2c 48072000.i2c: controller timed out
>> [   28.723358] twl_rtc 48070000.i2c:twl@48:rtc: Power up reset detec=
ted.
>> [   30.127014] twl_rtc 48070000.i2c:twl@48:rtc: Enabling TWL-RTC
>> [   31.373626] twl_rtc 48070000.i2c:twl@48:rtc: rtc core: registered=
 48070000.i2c:twl@48 as rtc0
>>
>> There is still some i2c time out line and some reset detected, but
>> driver loads fine.
>>
>> But problem with touchscreen tsc2005 and wifi wl1251 is still there =
:-(
>> Drivers are compiled as external .ko modules.
>=20
> Right, my kernel was with everything built-in.
>=20
>> Plus I see new problem with bq2415_charger :-(
>=20
> Mh did you see them in 4.1?
>=20
>> [   54.214965] isp1704_charger isp1704: registered with product id i=
sp1707
>> [   54.828674] bq2415x-charger 2-006b: automode enabled
>> [   55.192596] ------------[ cut here ]------------
>> [   55.200561] WARNING: CPU: 0 PID: 528 at kernel/workqueue.c:1443 _=
_queue_delayed_work+0x50/0x144()
>> ...
>> [   55.489501] WARNING: CPU: 0 PID: 528 at kernel/workqueue.c:1445 _=
_queue_delayed_work+0xb4/0x144()
>> ...
>> [   55.820953] WARNING: CPU: 0 PID: 528 at kernel/workqueue.c:1376 _=
_queue_work+0x2c0/0x404()
>> ...
>> [   56.243347] bq2415x-charger 2-006b: driver registered
>=20
> So the driver tries to send a notification before it's fully
> registered. The warnings are probably a side-effect of the
> power-supply API changes in 4.1.
>=20
>> [   77.142181] INFO: rcu_preempt detected stalls on CPUs/tasks: { P5=
28} (detected by 0, t=3D2102 jiffies, g=3D1101, c=3D1100, q=3D3834)
>> [   77.163391] kworker/0:3     R running      0   528      2 0x00000=
000
>> [   77.173706] Workqueue: events power_supply_changed_work
>> [   77.183898] [<c042883c>] (__schedule) from [<c0428c94>] (preempt_=
schedule_irq+0x54/0x84)
>> [   77.194274] [<c0428c94>] (preempt_schedule_irq) from [<c042c23c>]=
 (svc_preempt+0x8/0x18)
>> [   77.204711] [<c042c23c>] (svc_preempt) from [<c0047ce4>] (queue_d=
elayed_work_on+0x40/0x44)
>> [   77.215179] [<c0047ce4>] (queue_delayed_work_on) from [<bf0a59e4>=
] (bq2415x_notifier_call+0x90/0x9c [bq2415x_charger])
>> [   77.235870] [<bf0a59e4>] (bq2415x_notifier_call [bq2415x_charger]=
) from [<c004de34>] (notifier_call_chain+0x38/0x68)
>> [   77.257019] [<c004de34>] (notifier_call_chain) from [<c004dff4>] =
(__atomic_notifier_call_chain+0x34/0x44)
>> [   77.278411] [<c004dff4>] (__atomic_notifier_call_chain) from [<c0=
04e018>] (atomic_notifier_call_chain+0x14/0x18)
>> [   77.299804] [<c004e018>] (atomic_notifier_call_chain) from [<c030=
5a9c>] (power_supply_changed_work+0xac/0x130)
>> [   77.321197] [<c0305a9c>] (power_supply_changed_work) from [<c0048=
4d8>] (process_one_work+0x278/0x45c)
>> [   77.342529] [<c00484d8>] (process_one_work) from [<c0048918>] (wo=
rker_thread+0x230/0x354)
>> [   77.353393] [<c0048918>] (worker_thread) from [<c004d0e0>] (kthre=
ad+0xcc/0xe0)
>> [   77.364074] [<c004d0e0>] (kthread) from [<c000eb08>] (ret_from_fo=
rk+0x14/0x2c)
>> [   77.374572] kworker/0:3     R running      0   528      2 0x00000=
000
>> [   77.384948] Workqueue: events power_supply_changed_work
>> [   77.395111] [<c042883c>] (__schedule) from [<c0428c94>] (preempt_=
schedule_irq+0x54/0x84)
>> [   77.405456] [<c0428c94>] (preempt_schedule_irq) from [<c042c23c>]=
 (svc_preempt+0x8/0x18)
>> [   77.415863] [<c042c23c>] (svc_preempt) from [<c0047ce4>] (queue_d=
elayed_work_on+0x40/0x44)
>> [   77.426269] [<c0047ce4>] (queue_delayed_work_on) from [<bf0a59e4>=
] (bq2415x_notifier_call+0x90/0x9c [bq2415x_charger])
>> [   77.447174] [<bf0a59e4>] (bq2415x_notifier_call [bq2415x_charger]=
) from [<c004de34>] (notifier_call_chain+0x38/0x68)
>> [   77.468322] [<c004de34>] (notifier_call_chain) from [<c004dff4>] =
(__atomic_notifier_call_chain+0x34/0x44)
>> [   77.489990] [<c004dff4>] (__atomic_notifier_call_chain) from [<c0=
04e018>] (atomic_notifier_call_chain+0x14/0x18)
>> [   77.512115] [<c004e018>] (atomic_notifier_call_chain) from [<c030=
5a9c>] (power_supply_changed_work+0xac/0x130)
>> [   77.534637] [<c0305a9c>] (power_supply_changed_work) from [<c0048=
4d8>] (process_one_work+0x278/0x45c)
>> [   77.557189] [<c00484d8>] (process_one_work) from [<c0048918>] (wo=
rker_thread+0x230/0x354)
>> [   77.568634] [<c0048918>] (worker_thread) from [<c004d0e0>] (kthre=
ad+0xcc/0xe0)
>> [   77.579925] [<c004d0e0>] (kthread) from [<c000eb08>] (ret_from_fo=
rk+0x14/0x2c)
>=20
> Not sure about these.

I've got an idea however I cannot test it (I don't have the hardware).
I'll sent it with RFT.

Best regards,
Krzysztof

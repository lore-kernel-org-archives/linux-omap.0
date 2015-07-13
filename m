From: Sebastian Reichel <sre@kernel.org>
Subject: Re: linux 4.2-rc1 broken Nokia N900
Date: Mon, 13 Jul 2015 21:32:32 +0200
Message-ID: <20150713193232.GA15675@earth>
References: <201507111405.06048@pali>
 <20150713155139.GA17362@earth>
 <20150713160547.GA3270@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150713160547.GA3270@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-omap@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 13, 2015 at 06:05:47PM +0200, Pali Roh=E1r wrote:
> now I'm testing 4.2-rc2 release and rtc is working:
>=20
> [   27.426055] omap_i2c 48072000.i2c: controller timed out
> [   28.723358] twl_rtc 48070000.i2c:twl@48:rtc: Power up reset detected.
> [   30.127014] twl_rtc 48070000.i2c:twl@48:rtc: Enabling TWL-RTC
> [   31.373626] twl_rtc 48070000.i2c:twl@48:rtc: rtc core: registered 4807=
0000.i2c:twl@48 as rtc0
>=20
> There is still some i2c time out line and some reset detected, but
> driver loads fine.
>=20
> But problem with touchscreen tsc2005 and wifi wl1251 is still there :-(
> Drivers are compiled as external .ko modules.

Right, my kernel was with everything built-in.

> Plus I see new problem with bq2415_charger :-(

Mh did you see them in 4.1?

> [   54.214965] isp1704_charger isp1704: registered with product id isp1707
> [   54.828674] bq2415x-charger 2-006b: automode enabled
> [   55.192596] ------------[ cut here ]------------
> [   55.200561] WARNING: CPU: 0 PID: 528 at kernel/workqueue.c:1443 __queu=
e_delayed_work+0x50/0x144()
> ...
> [   55.489501] WARNING: CPU: 0 PID: 528 at kernel/workqueue.c:1445 __queu=
e_delayed_work+0xb4/0x144()
> ...
> [   55.820953] WARNING: CPU: 0 PID: 528 at kernel/workqueue.c:1376 __queu=
e_work+0x2c0/0x404()
> ...
> [   56.243347] bq2415x-charger 2-006b: driver registered

So the driver tries to send a notification before it's fully
registered. The warnings are probably a side-effect of the
power-supply API changes in 4.1.

> [   77.142181] INFO: rcu_preempt detected stalls on CPUs/tasks: { P528} (=
detected by 0, t=3D2102 jiffies, g=3D1101, c=3D1100, q=3D3834)
> [   77.163391] kworker/0:3     R running      0   528      2 0x00000000
> [   77.173706] Workqueue: events power_supply_changed_work
> [   77.183898] [<c042883c>] (__schedule) from [<c0428c94>] (preempt_sched=
ule_irq+0x54/0x84)
> [   77.194274] [<c0428c94>] (preempt_schedule_irq) from [<c042c23c>] (svc=
_preempt+0x8/0x18)
> [   77.204711] [<c042c23c>] (svc_preempt) from [<c0047ce4>] (queue_delaye=
d_work_on+0x40/0x44)
> [   77.215179] [<c0047ce4>] (queue_delayed_work_on) from [<bf0a59e4>] (bq=
2415x_notifier_call+0x90/0x9c [bq2415x_charger])
> [   77.235870] [<bf0a59e4>] (bq2415x_notifier_call [bq2415x_charger]) fro=
m [<c004de34>] (notifier_call_chain+0x38/0x68)
> [   77.257019] [<c004de34>] (notifier_call_chain) from [<c004dff4>] (__at=
omic_notifier_call_chain+0x34/0x44)
> [   77.278411] [<c004dff4>] (__atomic_notifier_call_chain) from [<c004e01=
8>] (atomic_notifier_call_chain+0x14/0x18)
> [   77.299804] [<c004e018>] (atomic_notifier_call_chain) from [<c0305a9c>=
] (power_supply_changed_work+0xac/0x130)
> [   77.321197] [<c0305a9c>] (power_supply_changed_work) from [<c00484d8>]=
 (process_one_work+0x278/0x45c)
> [   77.342529] [<c00484d8>] (process_one_work) from [<c0048918>] (worker_=
thread+0x230/0x354)
> [   77.353393] [<c0048918>] (worker_thread) from [<c004d0e0>] (kthread+0x=
cc/0xe0)
> [   77.364074] [<c004d0e0>] (kthread) from [<c000eb08>] (ret_from_fork+0x=
14/0x2c)
> [   77.374572] kworker/0:3     R running      0   528      2 0x00000000
> [   77.384948] Workqueue: events power_supply_changed_work
> [   77.395111] [<c042883c>] (__schedule) from [<c0428c94>] (preempt_sched=
ule_irq+0x54/0x84)
> [   77.405456] [<c0428c94>] (preempt_schedule_irq) from [<c042c23c>] (svc=
_preempt+0x8/0x18)
> [   77.415863] [<c042c23c>] (svc_preempt) from [<c0047ce4>] (queue_delaye=
d_work_on+0x40/0x44)
> [   77.426269] [<c0047ce4>] (queue_delayed_work_on) from [<bf0a59e4>] (bq=
2415x_notifier_call+0x90/0x9c [bq2415x_charger])
> [   77.447174] [<bf0a59e4>] (bq2415x_notifier_call [bq2415x_charger]) fro=
m [<c004de34>] (notifier_call_chain+0x38/0x68)
> [   77.468322] [<c004de34>] (notifier_call_chain) from [<c004dff4>] (__at=
omic_notifier_call_chain+0x34/0x44)
> [   77.489990] [<c004dff4>] (__atomic_notifier_call_chain) from [<c004e01=
8>] (atomic_notifier_call_chain+0x14/0x18)
> [   77.512115] [<c004e018>] (atomic_notifier_call_chain) from [<c0305a9c>=
] (power_supply_changed_work+0xac/0x130)
> [   77.534637] [<c0305a9c>] (power_supply_changed_work) from [<c00484d8>]=
 (process_one_work+0x278/0x45c)
> [   77.557189] [<c00484d8>] (process_one_work) from [<c0048918>] (worker_=
thread+0x230/0x354)
> [   77.568634] [<c0048918>] (worker_thread) from [<c004d0e0>] (kthread+0x=
cc/0xe0)
> [   77.579925] [<c004d0e0>] (kthread) from [<c000eb08>] (ret_from_fork+0x=
14/0x2c)

Not sure about these.

-- Sebastian

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVpBJNAAoJENju1/PIO/qaAdAP/24qv1UYevpJwH+phCdgzoFB
oHoanRwRVJrBpLsH6GShQ8lgxYmjGWs5qXbYvgn0nRKnl7K1LpimVtgnfQzy2PmF
vQnZ8h80XPwSvxft/AktPVr+UEZIVSaWL57ydRDxCd6f+zl9wq55rJrC2S/xCbx+
Apdc3bASyXX36hJNMmL5RVPOxm8WM2xHjivzIh71tz2mUh2QXchrd0Gzc6GzawBN
g7n+sTxm3pUzz7woLk81M3UTFEsR8wI79jzDb/ce1PPGed362P59uPqqgUk+QBr2
GQYb+E/Oq4dOGPDdbRDXyfPNqkkbSA5ff/vonrtyTGtkdk5VXMouD9F/+poZ3CKT
jx7wKctDzfPaP0s5m7yARheKBPJqj4p3eofw+GAW/BE56yHLmVgeE5tSFhLeTAgk
SKnj/wUt1C1Zy3oT0qD847hVo6Z2/Krl953fqzHVNZ3Byr8n8taAqhftswMefa7f
HK/pSfRsQ8frZwL9McS2rzd8HbdW3XkjxLkvNGiY1QSrV/3RfS2yxMCknc8eZnur
5K+LCQaZAEbSIuG93JMlfFYRcKpilrq5r7/OoU4Ryf4NjQFj1/h+I/6IN+KpdVeu
BNtUfhp4xo/j3ggkomkQVMVlm0ZtUnz7033pQPaHD1bLuWpJ7un5KnMx/IJKrPCu
tObKPc/o8kqHJrvoMtOt
=Uq0+
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--

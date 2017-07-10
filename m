From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: 4.13-rc0: stopped booting on Nokia N900
Date: Mon, 10 Jul 2017 12:16:08 +0200
Message-ID: <20170710101608.qdamqomegbjwuweh@earth>
References: <20170710074610.GA22846@amd>
 <20170710081334.GA29726@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dsd3phybjjrurzql"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170710081334.GA29726@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--dsd3phybjjrurzql
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 10, 2017 at 10:13:35AM +0200, Pavel Machek wrote:
> On Mon 2017-07-10 09:46:10, Pavel Machek wrote:
> > Hi!
> >=20
> > First, I got segfault from make:
> >=20
> > : 0: Can't open
> > scripts/Makefile.build:561: recipe for target
> > 'drivers/iio/imu/st_lsm6dsx' failed
> > make[3]: *** [drivers/iio/imu/st_lsm6dsx] Segmentation fault (core
> > dumped)
> > scripts/Makefile.build:561: recipe for target 'drivers/iio/imu' failed
> > make[2]: *** [drivers/iio/imu] Error 2
> > scripts/Makefile.build:561: recipe for target 'drivers/iio' failed
> > make[1]: *** [drivers/iio] Error 2
> > make[1]: *** Waiting for unfinished jobs....
> > Makefile:1008: recipe for target 'drivers' failed
> > make: *** [drivers] Error 2
> > make: *** Waiting for unfinished jobs....
> > pavel@duo:/data/l/linux-n900$ ./mkit
> >=20
> > Then compile worked, but it failed to boot. I've now cleaned caches
> > and am rebuilding to make sure it is not build machine that has
> > glitches.
> >=20
> > No such luck :-(.
> >=20
> > I tested linux-next relatively recently, and it worked ok.
>=20
> > af3c8d98508d37541d4bf57f13a984a7f73a328c is broken.
> > 650fc87 worked ok.
>=20
> 2b97620 is broken.
>=20
> commit a51166ce71844ffbb8f78d63647b44dd69e46cf1
>     Add linux-next specific files for 20170628

I just rebased my droid4 development branch. I do not have any
problems with segfaulting toolchain, but boot also fails on OMAP4
based Droid 4. The problem seems to be SPI being accessed without
runtime PM (clocks) being enabled:

[    1.346984] cpcap-core spi1.0: CPCAP vendor: ST rev: 2.10 (1a)
[    1.354766] Unhandled fault: imprecise external abort (0x1406) at 0xfeff=
ffff
[    1.354797] ------------[ cut here ]------------
[    1.354827] WARNING: CPU: 0 PID: 0 at drivers/bus/omap_l3_noc.c:147 l3_i=
nterrupt_handler+0x21c/0x348
[    1.354827] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4CFG (Read)=
: Data Access in User mode during Functional access
[    1.354827] Modules linked in:
[    1.354858] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.12.0-10335-gb8c0=
c26d6667 #516
[    1.354858] Hardware name: Generic OMAP4 (Flattened Device Tree)
[    1.354888] [<c0110460>] (unwind_backtrace) from [<c010c4ac>] (show_stac=
k+0x10/0x14)
[    1.354888] [<c010c4ac>] (show_stack) from [<c0adca28>] (dump_stack+0xac=
/0xe0)
[    1.354919] [<c0adca28>] (dump_stack) from [<c013a940>] (__warn+0xd8/0x1=
04)
[    1.354919] [<c013a940>] (__warn) from [<c013a9a0>] (warn_slowpath_fmt+0=
x34/0x44)
[    1.354919] [<c013a9a0>] (warn_slowpath_fmt) from [<c0508324>] (l3_inter=
rupt_handler+0x21c/0x348)
[    1.354949] [<c0508324>] (l3_interrupt_handler) from [<c01aa1b4>] (__han=
dle_irq_event_percpu+0x48/0x3b4)
[    1.354949] [<c01aa1b4>] (__handle_irq_event_percpu) from [<c01aa53c>] (=
handle_irq_event_percpu+0x1c/0x58)
[    1.354949] [<c01aa53c>] (handle_irq_event_percpu) from [<c01aa5b0>] (ha=
ndle_irq_event+0x38/0x5c)
[    1.354980] [<c01aa5b0>] (handle_irq_event) from [<c01adb30>] (handle_fa=
steoi_irq+0xb4/0x178)
[    1.354980] [<c01adb30>] (handle_fasteoi_irq) from [<c01a94a8>] (generic=
_handle_irq+0x20/0x34)
[    1.354980] [<c01a94a8>] (generic_handle_irq) from [<c01a9a18>] (__handl=
e_domain_irq+0x64/0xe0)
[    1.354980] [<c01a9a18>] (__handle_domain_irq) from [<c010155c>] (gic_ha=
ndle_irq+0x54/0xb8)
[    1.355010] [<c010155c>] (gic_handle_irq) from [<c0af7e30>] (__irq_svc+0=
x70/0x98)
[    1.355010] Exception stack(0xc1001f38 to 0xc1001f80)
[    1.355010] 1f20:                                                       =
00000001 00000001
[    1.355041] 1f40: 00000000 c100abc0 c1000000 c1007bcc c1007b68 c0f8a938 =
c1007f68 c1046133
[    1.355041] 1f60: 00000000 00000000 00000000 c1001f88 c019a828 c010822c =
20000013 ffffffff
[    1.355041] [<c0af7e30>] (__irq_svc) from [<c010822c>] (arch_cpu_idle+0x=
20/0x3c)
[    1.355072] [<c010822c>] (arch_cpu_idle) from [<c018b6b4>] (do_idle+0x16=
8/0x21c)
[    1.355072] [<c018b6b4>] (do_idle) from [<c018bad4>] (cpu_startup_entry+=
0x18/0x1c)
[    1.355072] [<c018bad4>] (cpu_startup_entry) from [<c0f00c2c>] (start_ke=
rnel+0x348/0x3c0)
[    1.355102] [<c0f00c2c>] (start_kernel) from [<8000807c>] (0x8000807c)
[    1.355133] ---[ end trace 03269d8f047e066b ]---
[    1.584167] pgd =3D c0004000
[    1.586914] [feffffff] *pgd=3D00000000
[    1.590515] Internal error: : 1406 [#1] SMP ARM
[    1.595062] Modules linked in:
[    1.598144] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W       4.12=
=2E0-10335-gb8c0c26d6667 #516
[    1.607238] Hardware name: Generic OMAP4 (Flattened Device Tree)
[    1.613281] task: ee8aae00 task.stack: ee8ac000
[    1.617858] PC is at debug_lockdep_rcu_enabled+0x38/0x48
[    1.623199] LR is at lock_release+0x25c/0x360
[    1.627593] pc : [<c01b3788>]    lr : [<c019cc58>]    psr: 20000093
[    1.633880] sp : ee8adb80  ip : c10fe40c  fp : eea0fc10
[    1.639160] r10: 00000001  r9 : c10f4230  r8 : 60000093
[    1.644409] r7 : c1007b68  r6 : c051b3f8  r5 : eea0ce74  r4 : a0000013
[    1.650970] r3 : ee8aae00  r2 : 00000001  r1 : 00000003  r0 : 0000001f
[    1.657531] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segmen=
t none
[    1.664825] Control: 10c5387d  Table: 8000404a  DAC: 00000051
[    1.670593] Process swapper/0 (pid: 1, stack limit =3D 0xee8ac218)
[    1.676635] Stack: (0xee8adb80 to 0xee8ae000)
[    1.681030] db80: a0000013 c051b3e8 00000007 a0000013 eea0ce64 eea0ce64 =
00000007 eea0fd04
[    1.689270] dba0: c06208d8 eea0fc00 eea0fc10 c0af76ec 00000000 fc310134 =
eea0ce64 c051b3f8
[    1.697479] dbc0: 00000020 eea0cea4 eea0cc70 00000000 eea0fd04 c0514430 =
eea0cea4 eea0fc10
[    1.705718] dbe0: eef44cc0 c0514960 eea0fc00 00000021 eef44cc0 c01ac370 =
ee8000c0 60000013
[    1.713958] dc00: eed2d57c eef44cc0 00000000 c01aa628 eef42000 00000021 =
c06208d8 eea0fc00
[    1.722198] dc20: eea0fc10 c01ac73c 00002084 eef42000 00000204 c10a88cc =
00000001 eee8a200
[    1.730407] dc40: 00000000 00000000 00000010 c0621460 c0da9f6c eef42000 =
00000000 00000111
[    1.738647] dc60: 00000021 00000084 00000084 eee8a200 eef22610 00000021 =
00000084 eef23800
[    1.746887] dc80: 00000010 eef2513c c0b69968 c0621618 c10a88cc ee8adc9c =
00000004 eef23800
[    1.755126] dca0: eef23800 eee8a200 00000021 eef22710 eef25010 c062d618 =
ffffffff c10a88cc
[    1.763366] dcc0: eef22718 ee8aae00 00000001 00000000 c10a88cc 00000010 =
00000000 00000000
[    1.771575] dce0: eef23800 0000001a eef22710 00000000 00000010 00000013 =
00000000 00000000
[    1.779815] dd00: c0dba8a8 c062d7a0 0000000a 0000001a 00000000 00000013 =
eef23800 c10a887c
[    1.788055] dd20: 00000000 c10a888c 00000000 c06a2784 eef23800 c18c195c =
00000000 c05fdd00
[    1.796295] dd40: 00000000 ee8add78 c05fde4c 00000001 00000000 c18c1918 =
00000000 c05fc374
[    1.804534] dd60: ee9f2ad4 eee7e154 eef23800 eef23834 c10b0dbc c05fd9bc =
eef23800 00000001
[    1.812744] dd80: c18c1918 eef23808 eef23800 c10b0dbc 00000000 c05fd044 =
eef23808 eef25800
[    1.820983] dda0: eef23800 c05fb4d0 00000000 eef23800 eef23a64 00000000 =
eef23800 eef25800
[    1.829223] ddc0: 00000000 eea6cc10 00000000 c0dba89c 00000000 c06a3958 =
eef25800 ef6e7b80
[    1.837463] dde0: eef23800 ef6e7bd0 00000000 c06a41a4 00000000 00000000 =
c06a3dc4 002dc6c0
[    1.845672] de00: eea6cc10 eef22990 eef25800 eef25800 eea6cc10 eea6cc10 =
c0dbaf80 c0dbaf78
[    1.853912] de20: 000001f0 c06a4670 00000000 eef25ce8 eef25800 eef25800 =
eea6cc10 c06a8090
[    1.862152] de40: 00000000 60000013 c1899108 00000004 21547a13 eea6cc10 =
ffffffed c10b1acc
[    1.870391] de60: fffffdfb 00000000 00000000 c0f67858 c0f005a8 c05ffb34 =
eea6cc10 c18c195c
[    1.878631] de80: 00000000 c10b1acc 00000000 c05fdd00 eea6cc10 c10b1acc =
eea6cc44 00000000
[    1.886840] dea0: c10fa000 00000007 c0f67858 c05fde48 00000000 c10b1acc =
c05fdd88 c05fc2c8
[    1.895080] dec0: ee8a46a4 eea67dd0 c10b1acc eee8ea00 c10a6210 c05fd248 =
c0dbaf88 c0f40af8
[    1.903320] dee0: 00000000 c10b1acc c0f40af8 00000000 c0e68a14 c05fec8c =
ffffe000 c0f40af8
[    1.911560] df00: 00000000 c0101874 00000138 00000000 efffec00 efffecdd =
c0e6a274 00000138
[    1.919769] df20: 00000138 c015f0b8 c0e68a14 00000000 00000006 00000006 =
efffecdd 00000000
[    1.928009] df40: c0f806b0 00000006 c10fa000 c0f6784c c0f80d58 c10fa000 =
c0f67850 c10fa000
[    1.936248] df60: 00000007 c0f00ea0 00000006 00000006 00000000 c0f005a8 =
c0af025c 00000138
[    1.944488] df80: 00000000 00000000 c0af025c 00000000 00000000 00000000 =
00000000 00000000
[    1.952728] dfa0: 00000000 c0af0264 00000000 c01077b0 00000000 00000000 =
00000000 00000000
[    1.960937] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    1.969177] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 =
c0c0c0c0 c0c0c0c0
[    1.977416] [<c01b3788>] (debug_lockdep_rcu_enabled) from [<c019cc58>] (=
lock_release+0x25c/0x360)
[    1.986358] [<c019cc58>] (lock_release) from [<c0af76ec>] (_raw_spin_unl=
ock_irqrestore+0x1c/0x44)
[    1.995300] [<c0af76ec>] (_raw_spin_unlock_irqrestore) from [<c051b3f8>]=
 (omap_gpio_get_direction+0x38/0x44)
[    2.005187] [<c051b3f8>] (omap_gpio_get_direction) from [<c0514430>] (gp=
iochip_lock_as_irq+0x98/0xe4)
[    2.014495] [<c0514430>] (gpiochip_lock_as_irq) from [<c0514960>] (gpioc=
hip_irq_reqres+0x2c/0x6c)
[    2.023406] [<c0514960>] (gpiochip_irq_reqres) from [<c01ac370>] (__setu=
p_irq+0x478/0x6ec)
[    2.031738] [<c01ac370>] (__setup_irq) from [<c01ac73c>] (request_thread=
ed_irq+0xcc/0x14c)
[    2.040069] [<c01ac73c>] (request_threaded_irq) from [<c0621460>] (regma=
p_add_irq_chip+0x740/0x8a0)
[    2.049194] [<c0621460>] (regmap_add_irq_chip) from [<c0621618>] (devm_r=
egmap_add_irq_chip+0x58/0xb4)
[    2.058471] [<c0621618>] (devm_regmap_add_irq_chip) from [<c062d618>] (c=
pcap_init_irq_chip+0x138/0x16c)
[    2.067932] [<c062d618>] (cpcap_init_irq_chip) from [<c062d7a0>] (cpcap_=
probe+0x154/0x258)
[    2.076263] [<c062d7a0>] (cpcap_probe) from [<c06a2784>] (spi_drv_probe+=
0x7c/0xac)
[    2.083892] [<c06a2784>] (spi_drv_probe) from [<c05fdd00>] (driver_probe=
_device+0x260/0x2e8)
[    2.092407] [<c05fdd00>] (driver_probe_device) from [<c05fc374>] (bus_fo=
r_each_drv+0x64/0x98)
[    2.100982] [<c05fc374>] (bus_for_each_drv) from [<c05fd9bc>] (__device_=
attach+0xb0/0x118)
[    2.109313] [<c05fd9bc>] (__device_attach) from [<c05fd044>] (bus_probe_=
device+0x88/0x90)
[    2.117523] [<c05fd044>] (bus_probe_device) from [<c05fb4d0>] (device_ad=
d+0x3c8/0x57c)
[    2.125518] [<c05fb4d0>] (device_add) from [<c06a3958>] (spi_add_device+=
0x90/0x134)
[    2.133209] [<c06a3958>] (spi_add_device) from [<c06a41a4>] (spi_registe=
r_controller+0x350/0x7ec)
[    2.142150] [<c06a41a4>] (spi_register_controller) from [<c06a4670>] (de=
vm_spi_register_controller+0x30/0x70)
[    2.152130] [<c06a4670>] (devm_spi_register_controller) from [<c06a8090>=
] (omap2_mcspi_probe+0x27c/0x358)
[    2.161773] [<c06a8090>] (omap2_mcspi_probe) from [<c05ffb34>] (platform=
_drv_probe+0x50/0xb0)
[    2.170349] [<c05ffb34>] (platform_drv_probe) from [<c05fdd00>] (driver_=
probe_device+0x260/0x2e8)
[    2.179290] [<c05fdd00>] (driver_probe_device) from [<c05fde48>] (__driv=
er_attach+0xc0/0xc4)
[    2.187805] [<c05fde48>] (__driver_attach) from [<c05fc2c8>] (bus_for_ea=
ch_dev+0x6c/0xa0)
[    2.196014] [<c05fc2c8>] (bus_for_each_dev) from [<c05fd248>] (bus_add_d=
river+0x100/0x210)
[    2.204345] [<c05fd248>] (bus_add_driver) from [<c05fec8c>] (driver_regi=
ster+0x78/0xf4)
[    2.212402] [<c05fec8c>] (driver_register) from [<c0101874>] (do_one_ini=
tcall+0x3c/0x16c)
[    2.220642] [<c0101874>] (do_one_initcall) from [<c0f00ea0>] (kernel_ini=
t_freeable+0x1fc/0x2c4)
[    2.229400] [<c0f00ea0>] (kernel_init_freeable) from [<c0af0264>] (kerne=
l_init+0x8/0x114)
[    2.237640] [<c0af0264>] (kernel_init) from [<c01077b0>] (ret_from_fork+=
0x14/0x24)
[    2.245269] Code: e3c3303f e593300c e59305ec e16f0f10 (e1a002a0)=20
[    2.251403] ---[ end trace 03269d8f047e066c ]---
[    2.256134] Kernel panic - not syncing: Attempted to kill init! exitcode=
=3D0x0000000b
[    2.256134]=20
[    2.265350] CPU0: stopping
[    2.268096] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D W       4.12=
=2E0-10335-gb8c0c26d6667 #516
[    2.277221] Hardware name: Generic OMAP4 (Flattened Device Tree)
[    2.283294] [<c0110460>] (unwind_backtrace) from [<c010c4ac>] (show_stac=
k+0x10/0x14)
[    2.291107] [<c010c4ac>] (show_stack) from [<c0adca28>] (dump_stack+0xac=
/0xe0)
[    2.298400] [<c0adca28>] (dump_stack) from [<c010e920>] (handle_IPI+0x30=
0/0x408)
[    2.305847] [<c010e920>] (handle_IPI) from [<c01015a4>] (gic_handle_irq+=
0x9c/0xb8)
[    2.313476] [<c01015a4>] (gic_handle_irq) from [<c0af7e30>] (__irq_svc+0=
x70/0x98)
[    2.321044] Exception stack(0xc1001f38 to 0xc1001f80)
[    2.326141] 1f20:                                                       =
c0108228 00000000
[    2.334381] 1f40: 00000000 00000000 c1000000 c1007bcc c1007b68 c0f8a938 =
c1007f68 c1046133
[    2.342620] 1f60: 00000000 00000000 000006c8 c1001f88 c0108228 c010822c =
60000013 ffffffff
[    2.350860] [<c0af7e30>] (__irq_svc) from [<c010822c>] (arch_cpu_idle+0x=
20/0x3c)
[    2.358337] [<c010822c>] (arch_cpu_idle) from [<c018b6b4>] (do_idle+0x16=
8/0x21c)
[    2.365814] [<c018b6b4>] (do_idle) from [<c018bad4>] (cpu_startup_entry+=
0x18/0x1c)
[    2.373443] [<c018bad4>] (cpu_startup_entry) from [<c0f00c2c>] (start_ke=
rnel+0x348/0x3c0)
[    2.381683] [<c0f00c2c>] (start_kernel) from [<8000807c>] (0x8000807c)
[    2.388275] ---[ end Kernel panic - not syncing: Attempted to kill init!=
 exitcode=3D0x0000000b

-- Sebastian

--dsd3phybjjrurzql
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlljU+UACgkQ2O7X88g7
+prN+A/4zh4OmS0e2F0J8Ye3TN9AJZ1TVVb++Tmhil/VtbYgaY+pJ/zqEgSU6AyH
7Cml7lyO4Q41cL7I6pWHWeEZL1+pjR0pT8GbIzVzgiVk4xAYQCghhrmb5eBLkJHq
vblwuLnhWxh2FwLAf59oqwKwludW3/XdykquCGw6T0wXjkCUtaJqq1hQSToXV1aP
HE7AG8neiYiebconzxd2q3iMj05SojzuogHJvue31nzizQLOsBl/6+3wi/TK4KYi
nfuAwVpoTw97hpGAzPVOOsKw1wVkFp4/vt63ga1kHAxiLlZivL01IeUgwTZhBUZG
PCoCwG6kyNvNziA5YJX+xbEk6q6NDIOGleue/wVWpdPROMH9QLpQTfaVhNmQDmYX
R9kkBX9IisqLFrxIGcz6IwPniiTxZVWszSH9xplbXeb1WYe/zMJcA+mVSSUDxIak
+Qmao9dRbFvWkPGYvRlwBNGTZCXxfDlXBgaa32LslXvBNiHJQI3RQOcbrVR61Aqn
Fskk4g552Jr/93q3vSmzcpJrE7E3AkEOh9qpv0TRM4Fvor2KSAJHEKGcrATsK5i5
Em0WQaC2C5Dxd1Bt+RJhy2MM+sKHutA1hgVu5BFUcLmksUyqmCB1I/IeJ5V0ViNP
xeixMTnnp/NNpLyEIw0gQQxFPeDmPOT85vJJIJWQo8VM16u19Q==
=jo9J
-----END PGP SIGNATURE-----

--dsd3phybjjrurzql--

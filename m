From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Thu, 17 Mar 2016 01:49:18 +0100
Message-ID: <20160317004917.GA6750@earth>
References: <201507251228.27128@pali>
 <201601050034.12810@pali>
 <20160306152339.GA428@earth>
 <201603121342.33099@pali>
 <56E68B71.2030202@ti.com>
 <20160316133319.GR8413@pali>
 <20160316144709.GA3389@earth>
 <56E9A42B.3010209@gmail.com>
 <56E9A6D9.7000003@ti.com>
 <56E9B910.7000904@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56E9B910.7000904@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 16, 2016 at 09:50:40PM +0200, Ivaylo Dimitrov wrote:
> Jan  1 06:01:43 Nokia-N900 kernel: [    6.947998] omap_i2c 48070000.i2c: =
bus 1 rev3.3 at 2200 kHz
> Jan  1 06:01:43 Nokia-N900 kernel: [    6.960632] tpa6130a2 2-0060: Write=
 failed
> Jan  1 06:01:43 Nokia-N900 kernel: [    6.965026] CPU: 0 PID: 6 Comm: kwo=
rker/u2:0 Not tainted 4.5.0-rc5+ #26
> Jan  1 06:01:43 Nokia-N900 kernel: [    6.972106] Hardware name: Nokia RX=
-51 board
> Jan  1 06:01:43 Nokia-N900 kernel: [    6.976684] Workqueue: deferwq defe=
rred_probe_work_func
> Jan  1 06:01:43 Nokia-N900 kernel: [    6.982299] [<c0013c18>] (unwind_ba=
cktrace) from [<c0011f38>] (show_stack+0x10/0x14)
> Jan  1 06:01:43 Nokia-N900 kernel: [    6.990570] [<c0011f38>] (show_stac=
k) from [<c0390884>] (tpa6130a2_i2c_write+0x58/0x90)
> Jan  1 06:01:43 Nokia-N900 kernel: [    6.999114] [<c0390884>] (tpa6130a2=
_i2c_write) from [<c0390968>] (tpa6130a2_power+0xac/0x1c4)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.008239] [<c0390968>] (tpa6130a2=
_power) from [<c0390d80>] (tpa6130a2_probe+0x144/0x234)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.017059] [<c0390d80>] (tpa6130a2=
_probe) from [<c032b650>] (i2c_device_probe+0x170/0x1b8)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.025939] [<c032b650>] (i2c_devic=
e_probe) from [<c02a7bd4>] (driver_probe_device+0x120/0x2b0)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.035247] [<c02a7bd4>] (driver_pr=
obe_device) from [<c02a62c8>] (bus_for_each_drv+0x48/0x8c)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.044311] [<c02a62c8>] (bus_for_e=
ach_drv) from [<c02a7a20>] (__device_attach+0x88/0xf8)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.053009] [<c02a7a20>] (__device_=
attach) from [<c02a70b0>] (bus_probe_device+0x28/0x80)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.061737] [<c02a70b0>] (bus_probe=
_device) from [<c02a5680>] (device_add+0x3c0/0x55c)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.070159] [<c02a5680>] (device_ad=
d) from [<c032cf28>] (i2c_new_device+0xf8/0x198)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.078308] [<c032cf28>] (i2c_new_d=
evice) from [<c032d4e8>] (i2c_register_adapter+0x2d0/0x47c)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.087432] [<c032d4e8>] (i2c_regis=
ter_adapter) from [<c032f084>] (omap_i2c_probe+0x54c/0x64c)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.096618] [<c032f084>] (omap_i2c_=
probe) from [<c02a93bc>] (platform_drv_probe+0x58/0xa0)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.105438] [<c02a93bc>] (platform_=
drv_probe) from [<c02a7bd4>] (driver_probe_device+0x120/0x2b0)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.114929] [<c02a7bd4>] (driver_pr=
obe_device) from [<c02a62c8>] (bus_for_each_drv+0x48/0x8c)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.123962] [<c02a62c8>] (bus_for_e=
ach_drv) from [<c02a7a20>] (__device_attach+0x88/0xf8)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.132659] [<c02a7a20>] (__device_=
attach) from [<c02a70b0>] (bus_probe_device+0x28/0x80)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.141357] [<c02a70b0>] (bus_probe=
_device) from [<c02a7508>] (deferred_probe_work_func+0x58/0x84)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.150939] [<c02a7508>] (deferred_=
probe_work_func) from [<c0042a50>] (process_one_work+0x1c4/0x324)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.160705] [<c0042a50>] (process_o=
ne_work) from [<c0042ef4>] (worker_thread+0x314/0x4a8)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.169433] [<c0042ef4>] (worker_th=
read) from [<c00474e4>] (kthread+0xcc/0xe0)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.177154] [<c00474e4>] (kthread) =
=66rom [<c000f218>] (ret_from_fork+0x14/0x3c)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.184783] tpa6130a2 2-0060: Faile=
d to initialize chip
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.190551] tpa6130a2: probe of 2-0=
060 failed with error -121
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.197174] omap_i2c 48072000.i2c: =
bus 2 rev3.3 at 100 kHz
>=20
> now, the only thing I can think of remaining to test is the reset gpio se=
t-up -
> I wonder if it is possible to be set in safe mode(or input, or... ?), so =
the
> reset is never deasserted.

mh both, the power gpio is turned off in tpa6130a2_power(0). I guess
if you don't see the problem during probe() everything works?

I have another idea though: In opposit to the gpio, the regulator
may also be referenced by something else/already enabled. I guess
adding a sleep after the regulator_enable() is worth a try.

Also I wonder if the same happens, if you avoid having the module
available during boot and instead load it once everything has
settled. That would rule out any side-effects of other modules
being probed on the same i2c bus.

-- Sebastian

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW6f8LAAoJENju1/PIO/qan6UQAJh0qQ1+vzM+dwcpSese90lD
lTsUeue+wpWKkoGaJVZ7oSRGf3COP7m9/YwUQn7809wBJCpoHvtFkiZVo5Cw6f/6
pN2REv5qMurxhOJPv5stDJd1H8p5DcUkpINxoo4qAxrdx2unTZZ+eQToCjKJ3gWA
K+mqmQImjzGYimE62hyUBK3w1COGIMUf7arZJVO7pG5BwbHCLt028bVtXu1RiPf3
3GgJGdUKgWRlVjlL+H/i05KN8nedHhoensaCuE892Afc/l7n8FiOH6JRzArnbuhp
fQbJDkjim0xeTotVSBVjUMQ3GA100K4KYSU/ueNIkfoOwgHn7CO56Yp9wuUvSemC
/SlHQq+md+NmVg00sEL2OynuqrQbV5QwVgVIIjAqhEy76JI/OdcbuW4i0Audf+rZ
4wKAiCHK8GchOoaY1UjOFkF0tpIxjvgN+IYVeBC8O8Jv9FcqDMU77n+7Bwb9sncC
MkwNeFiJELZFP2nXr8y5GosHlAD/ek05+DZkkbf+5omQojmulT5qkj6wRY4Rylq4
EC/T00KeChwnNvIoMTJv5lgmmT0RC9wHcQshE6G/C0mjhpWKecjmGLZxMiCm35g9
51CrdgpFfzXOlj4NBEj/XhFShgMg7ACv8mVYLF10U8OOy06RKriV3r3TkAXbBB7a
/DiB1hMh+2DXIJfzupJp
=Qd7Y
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--

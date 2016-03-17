From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Thu, 17 Mar 2016 09:53:38 +0200
Message-ID: <56EA6282.5050501@ti.com>
References: <201507251228.27128@pali> <201601050034.12810@pali>
 <20160306152339.GA428@earth> <201603121342.33099@pali>
 <56E68B71.2030202@ti.com> <20160316133319.GR8413@pali>
 <20160316144709.GA3389@earth> <56E9A42B.3010209@gmail.com>
 <56E9A6D9.7000003@ti.com> <56E9B910.7000904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56E9B910.7000904@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Sebastian Reichel <sre@kernel.org>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

On 03/16/16 21:50, Ivaylo Dimitrov wrote:
> Hi,
>=20
> On 16.03.2016 20:32, Grygorii Strashko wrote:
>>
>> No-no :) take a look on i2c-omap.c
>>
>>     r =3D i2c_add_numbered_adapter(adap);
>>
>> ^^^^ here you see messages from tpa6130a2 (create i2c devices & prob=
e if
>> drivers are ready)
>>
>>     if (r) {
>>         dev_err(omap->dev, "failure adding adapter\n");
>>         goto err_unuse_clocks;
>>     }
>>
>>     dev_info(omap->dev, "bus %d rev%d.%d at %d kHz\n", adap->nr,
>>          major, minor, omap->speed);
>>
>> ^^^^ and here "omap_i2c 48072000.i2c:  bus 2 rev3.3 at 100 kHz"
>>
>> so everything is ok with probe order
>>
>=20
> Sorry for the noise then :)
>=20
> here is the log with dump_stack() in tpa6130a2_i2c_write:
>=20
> Jan  1 06:01:43 Nokia-N900 kernel: [    6.947998] omap_i2c 48070000.i=
2c: bus 1
> rev3.3 at 2200 kHz
> Jan  1 06:01:43 Nokia-N900 kernel: [    6.960632] tpa6130a2 2-0060: W=
rite failed
> Jan  1 06:01:43 Nokia-N900 kernel: [    6.965026] CPU: 0 PID: 6 Comm:
> kworker/u2:0 Not tainted 4.5.0-rc5+ #26
> Jan  1 06:01:43 Nokia-N900 kernel: [    6.972106] Hardware name: Noki=
a RX-51
> board
> Jan  1 06:01:43 Nokia-N900 kernel: [    6.976684] Workqueue: deferwq
> deferred_probe_work_func
> Jan  1 06:01:43 Nokia-N900 kernel: [    6.982299] [<c0013c18>]
> (unwind_backtrace) from [<c0011f38>] (show_stack+0x10/0x14)
> Jan  1 06:01:43 Nokia-N900 kernel: [    6.990570] [<c0011f38>] (show_=
stack)
> from [<c0390884>] (tpa6130a2_i2c_write+0x58/0x90)
> Jan  1 06:01:43 Nokia-N900 kernel: [    6.999114] [<c0390884>]
> (tpa6130a2_i2c_write) from [<c0390968>] (tpa6130a2_power+0xac/0x1c4)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.008239] [<c0390968>]
> (tpa6130a2_power) from [<c0390d80>] (tpa6130a2_probe+0x144/0x234)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.017059] [<c0390d80>]
> (tpa6130a2_probe) from [<c032b650>] (i2c_device_probe+0x170/0x1b8)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.025939] [<c032b650>]
> (i2c_device_probe) from [<c02a7bd4>] (driver_probe_device+0x120/0x2b0=
)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.035247] [<c02a7bd4>]
> (driver_probe_device) from [<c02a62c8>] (bus_for_each_drv+0x48/0x8c)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.044311] [<c02a62c8>]
> (bus_for_each_drv) from [<c02a7a20>] (__device_attach+0x88/0xf8)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.053009] [<c02a7a20>]
> (__device_attach) from [<c02a70b0>] (bus_probe_device+0x28/0x80)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.061737] [<c02a70b0>]
> (bus_probe_device) from [<c02a5680>] (device_add+0x3c0/0x55c)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.070159] [<c02a5680>] (devic=
e_add)
> from [<c032cf28>] (i2c_new_device+0xf8/0x198)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.078308] [<c032cf28>]
> (i2c_new_device) from [<c032d4e8>] (i2c_register_adapter+0x2d0/0x47c)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.087432] [<c032d4e8>]
> (i2c_register_adapter) from [<c032f084>] (omap_i2c_probe+0x54c/0x64c)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.096618] [<c032f084>]
> (omap_i2c_probe) from [<c02a93bc>] (platform_drv_probe+0x58/0xa0)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.105438] [<c02a93bc>]
> (platform_drv_probe) from [<c02a7bd4>] (driver_probe_device+0x120/0x2=
b0)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.114929] [<c02a7bd4>]
> (driver_probe_device) from [<c02a62c8>] (bus_for_each_drv+0x48/0x8c)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.123962] [<c02a62c8>]
> (bus_for_each_drv) from [<c02a7a20>] (__device_attach+0x88/0xf8)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.132659] [<c02a7a20>]
> (__device_attach) from [<c02a70b0>] (bus_probe_device+0x28/0x80)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.141357] [<c02a70b0>]
> (bus_probe_device) from [<c02a7508>] (deferred_probe_work_func+0x58/0=
x84)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.150939] [<c02a7508>]
> (deferred_probe_work_func) from [<c0042a50>] (process_one_work+0x1c4/=
0x324)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.160705] [<c0042a50>]
> (process_one_work) from [<c0042ef4>] (worker_thread+0x314/0x4a8)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.169433] [<c0042ef4>] (worke=
r_thread)
> from [<c00474e4>] (kthread+0xcc/0xe0)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.177154] [<c00474e4>] (kthre=
ad) from
> [<c000f218>] (ret_from_fork+0x14/0x3c)
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.184783] tpa6130a2 2-0060: F=
ailed to
> initialize chip
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.190551] tpa6130a2: probe of=
 2-0060
> failed with error -121
> Jan  1 06:01:43 Nokia-N900 kernel: [    7.197174] omap_i2c 48072000.i=
2c: bus 2
> rev3.3 at 100 kHz
>=20
> now, the only thing I can think of remaining to test is the reset gpi=
o set-up -
> I wonder if it is possible to be set in safe mode(or input, or... ?),=
 so the
> reset is never deasserted.

can you try this:
diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.=
c
index 11d85c5c787a..7f5881bff5d9 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -386,6 +386,8 @@ static int tpa6130a2_probe(struct i2c_client *clien=
t,
                data->power_gpio =3D pdata->power_gpio;
        } else if (np) {
                data->power_gpio =3D of_get_named_gpio(np, "power-gpio"=
, 0);
+               if (data->power_gpio =3D=3D -EPROBE_DEFER)
+                       return data->power_gpio;
        } else {
                dev_err(dev, "Platform data not set\n");
                dump_stack();

--=20
P=E9ter

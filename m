From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Wed, 16 Mar 2016 20:32:57 +0200
Message-ID: <56E9A6D9.7000003@ti.com>
References: <201507251228.27128@pali> <201601050034.12810@pali>
 <20160306152339.GA428@earth> <201603121342.33099@pali>
 <56E68B71.2030202@ti.com> <20160316133319.GR8413@pali>
 <20160316144709.GA3389@earth> <56E9A42B.3010209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56E9A42B.3010209@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

On 03/16/2016 08:21 PM, Ivaylo Dimitrov wrote:
> Hi,
>=20
> On 16.03.2016 16:47, Sebastian Reichel wrote:
>> Hi,
>>
>> On Wed, Mar 16, 2016 at 02:33:19PM +0100, Pali Roh=E1r wrote:
>>> Hi! We found out that tpa6130a2 device is being initialized before
>>> i2c_2 bus is initialized. So that is reason why tpa6130a2 fails...
>>
>> What do you mean by initialize? A call to tpa6130a2_probe()? In that
>> case I wonder about client->adapter. Is it NULL?
>>
>=20
> This is (a part of) the log when tpa6130a2 fails to initialize:
>=20
> Jan  1 08:03:07 Nokia-N900 kernel: [    1.928344] twl 1-0048: PIH (ir=
q=20
> 23) chaining IRQs 340..348
> Jan  1 08:03:07 Nokia-N900 kernel: [    1.934326] twl 1-0048: power (=
irq=20
> 345) chaining IRQs 348..355
> Jan  1 08:03:07 Nokia-N900 kernel: [    2.498504] twl4030_gpio=20
> twl4030-gpio: gpio (irq 340) chaining IRQs 356..373
> Jan  1 08:03:07 Nokia-N900 kernel: [    2.858215] twl4030_usb=20
> 48070000.i2c:twl@48:twl4030-usb: Initialized TWL4030 USB module
> Jan  1 08:03:07 Nokia-N900 kernel: [    2.888702] input:=20
> twl4030_pwrbutton as=20
> /devices/platform/68000000.ocp/48070000.i2c/i2c-1/1-0048/48070000.i2c=
:twl@48:pwrbutton/input/input0=20
>=20
> Jan  1 08:03:07 Nokia-N900 kernel: [    2.903594] input: TWL4030 Keyp=
ad=20
> as=20
> /devices/platform/68000000.ocp/48070000.i2c/i2c-1/1-0048/48070000.i2c=
:twl@48:keypad/input/input1=20
>=20
> Jan  1 08:03:07 Nokia-N900 kernel: [    3.148040]=20
> 48070000.i2c:twl@48:madc supply vusb3v1 not found, using dummy regula=
tor
> Jan  1 08:03:07 Nokia-N900 kernel: [    6.997985] omap_i2c 48070000.i=
2c:=20
> bus 1 rev3.3 at 2200 kHz
> Jan  1 08:03:07 Nokia-N900 kernel: [    7.010528] tpa6130a2 2-0060:=20
> Write failed
> Jan  1 08:03:07 Nokia-N900 kernel: [    7.015563] omap_i2c 48072000.i=
2c:=20
> bus 2 rev3.3 at 100 kHz
> Jan  1 08:03:07 Nokia-N900 kernel: [    7.023742] omap_i2c 48060000.i=
2c:=20
> bus 3 rev3.3 at 400 kHz
>=20
> Now, it is either tpa6130a2 probe() is called before i2c-2 is
> initialized or i2c driver first probes devices on the bus and only th=
en
> logs successful probe ("omap_i2c 48072000.i2c: bus 2 rev3.3 at 100 kH=
z")
> in our case.

No-no :) take a look on i2c-omap.c

	r =3D i2c_add_numbered_adapter(adap);=20

^^^^ here you see messages from tpa6130a2 (create i2c devices & probe i=
f drivers are ready)

	if (r) {
		dev_err(omap->dev, "failure adding adapter\n");
		goto err_unuse_clocks;
	}

	dev_info(omap->dev, "bus %d rev%d.%d at %d kHz\n", adap->nr,
		 major, minor, omap->speed);

^^^^ and here "omap_i2c 48072000.i2c:  bus 2 rev3.3 at 100 kHz"

so everything is ok with probe order

>=20
>> ---------------
>>
>> I just had another look at the driver and I think there is a race
>> condition for tpa6130a2_add_controls() and tpa6130a2_stereo_enable()=
=2E
>>
>> As far as I can see both functions check for "tpa6130a2_client !=3D
>> NULL". tpa6130a2_client is set before the probe function has finishe=
d,
>> though. Simplified probe:
>>
>> ...
>> tpa6130a2_client =3D client;
>> set_default_regs();
>> acquire_power_gpio();
>> acquire_regulator();
>> tpa6130a2_power(1); // needs tpa6130a2_client
>> check_device();
>> tpa6130a2_power(0); // needs tpa6130a2_client
>> ...
>>
>> If tpa6130a2_add_controls() or tpa6130a2_stereo_enable() is called
>> after tpa6130a2 probe has started, but before probe has completed,
>> tpa6130a2_client is set, but not yet initialized. The race condition
>> can be fixed easily by moving the tpa6130a2_client assignment direct=
ly
>> after the regulator acquisition.
>>



--=20
regards,
-grygorii

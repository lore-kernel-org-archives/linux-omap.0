From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Mon, 03 Aug 2015 21:03:16 +0300
Message-ID: <55BFACE4.1010100@bitmer.com>
References: <201507251228.27128@pali> <55B38C59.8060001@metafoo.de> <201508011218.45076@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201508011218.45076@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi

On 08/01/2015 01:18 PM, Pali Roh=C3=A1r wrote:
> On Saturday 25 July 2015 15:17:13 Lars-Peter Clausen wrote:
>> On 07/25/2015 12:28 PM, Pali Roh=C3=A1r wrote:
>>> Hello,
>>>
>>> sometimes after rebooting Nokia N900 initializing alsa audio fails.
>>> Here output from dmesg log when it happen:
>>>
>>> [    6.925140] tpa6130a2 2-0060: Write failed
>>> [    6.929534] tpa6130a2 2-0060: Failed to initialize chip
>>> [    6.935272] tpa6130a2: probe of 2-0060 failed with error -121
>>> [    7.624237] rx51-audio n900-audio: Failed to add TPA6130A2
>>> controls [    7.635101] rx51-audio n900-audio: ASoC: failed to
>>> init TLV320AIC34: -19 [    7.645874] rx51-audio n900-audio: ASoC:
>>> failed to instantiate card -19 [    7.665740] rx51-audio
>>> n900-audio: snd_soc_register_card failed (-19) [    8.063049] ALSA
>>> device list:
>>> [    8.070343]   No soundcards found.
>>>
>>> Any idea what to do?
>>
>> Looks like the chip is not responding. Try to add a small delay afte=
r
>> powerup to give the device to be fully ready, something like the
>> following:
>>
>> --- a/sound/soc/codecs/tpa6130a2.c
>> +++ b/sound/soc/codecs/tpa6130a2.c
>> @@ -152,6 +152,8 @@ static int tpa6130a2_power(u8 power)
>>   		if (data->power_gpio >=3D 0)
>>   			gpio_set_value(data->power_gpio, 1);
>>
>> +		msleep(5);
>> +
>>   		data->power_state =3D 1;
>>   		ret =3D tpa6130a2_initialize();
>>   		if (ret < 0) {
>=20
>=20
> Hello, your patch did not helped. Problem is still there...
>=20
=46or me v4.2-rc5 works, i.e. TPA6130A2 can still play loudly to
headphones. Don't know were there any i2c etc regression before it or
how easy it would be to reproduce.

Logs below made me thinking can it be a HW issue? Although if it is an
HW issue it shouldn't work sometimes I guess. Do you have any earlier
well known configuration you could try is it an SW regression or
something else?

> [    5.962585] tpa6130a2 2-0060: Write failed
> [    5.962707] tpa6130a2 2-0060: Failed to initialize chip
> [    5.962860] tpa6130a2: probe of 2-0060 failed with error -121

-121 =3D=3D EREMOTEIO which is returned from i2c-omap.c when there is n=
o ACK
from the chip.

> [   28.102233] omap_i2c 48072000.i2c: controller timed out
> [   29.463653] lp5523x 2-0032: lp5523 Programmable led chip found
> [   30.734191] omap_i2c 48072000.i2c: controller timed out waiting fo=
r start condition to finish
> [   32.142333] i2c i2c-2: SCL is stuck low, exit recovery

If SCL is really stuck it also explains why chip doesn't acknowledge.

--=20
Jarkko

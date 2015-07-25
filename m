From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Sat, 25 Jul 2015 15:17:13 +0200
Message-ID: <55B38C59.8060001@metafoo.de>
References: <201507251228.27128@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201507251228.27128@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On 07/25/2015 12:28 PM, Pali Roh=C3=A1r wrote:
> Hello,
>
> sometimes after rebooting Nokia N900 initializing alsa audio fails.
> Here output from dmesg log when it happen:
>
> [    6.925140] tpa6130a2 2-0060: Write failed
> [    6.929534] tpa6130a2 2-0060: Failed to initialize chip
> [    6.935272] tpa6130a2: probe of 2-0060 failed with error -121
> [    7.624237] rx51-audio n900-audio: Failed to add TPA6130A2 control=
s
> [    7.635101] rx51-audio n900-audio: ASoC: failed to init TLV320AIC3=
4: -19
> [    7.645874] rx51-audio n900-audio: ASoC: failed to instantiate car=
d -19
> [    7.665740] rx51-audio n900-audio: snd_soc_register_card failed (-=
19)
> [    8.063049] ALSA device list:
> [    8.070343]   No soundcards found.
>
> Any idea what to do?

Looks like the chip is not responding. Try to add a small delay after=20
powerup to give the device to be fully ready, something like the follow=
ing:

--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -152,6 +152,8 @@ static int tpa6130a2_power(u8 power)
  		if (data->power_gpio >=3D 0)
  			gpio_set_value(data->power_gpio, 1);

+		msleep(5);
+
  		data->power_state =3D 1;
  		ret =3D tpa6130a2_initialize();
  		if (ret < 0) {

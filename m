From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: v3.19: Nokia N900 - auto not working
Date: Sat, 31 Jan 2015 12:40:12 +0200
Message-ID: <54CCB10C.6030609@bitmer.com>
References: <201501311035.45875@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:51941 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbbAaKkv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 31 Jan 2015 05:40:51 -0500
In-Reply-To: <201501311035.45875@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>

Hi

On 01/31/2015 11:35 AM, Pali Roh=C3=A1r wrote:
> Hello,
>=20
> audio on (real) n900 device does not working with 3.19 kernel. Here i=
s relevant dmesg output:
>=20
> [    5.687438] omap_i2c 48070000.i2c: bus 1 rev3.3 at 2200 kHz
> [    5.696166] tpa6130a2 2-0060: Write failed
> [    5.696228] tpa6130a2 2-0060: Failed to initialize chip
> [    5.696380] tpa6130a2: probe of 2-0060 failed with error -121
> [    5.697937] omap_i2c 48072000.i2c: bus 2 rev3.3 at 100 kHz
> [    5.700256] omap_i2c 48060000.i2c: bus 3 rev3.3 at 400 kHz
> [    6.289154] rx51-audio n900-audio: Failed to add TPA6130A2 control=
s
> [    6.295715] rx51-audio n900-audio: ASoC: failed to init TLV320AIC3=
4: -19
> [    6.302459] rx51-audio n900-audio: ASoC: failed to instantiate car=
d -19
> [    6.309173] gpiod_unexport: invalid GPIO
> [    6.315612] rx51-audio n900-audio: snd_soc_register_card failed (-=
19)
> [    6.397949] ALSA device list:
> [    6.404876]   No soundcards found.
>=20
> Any idea why tpa6130a2 fails to initialize?
>=20
> I applied also these patches:
> https://lkml.org/lkml/2015/1/29/465
> http://mailman.alsa-project.org/pipermail/alsa-devel/2015-January/087=
228.html
>=20
Here probes and plays from headset fine on top of
1c999c47a9f1 Merge tag 'dm-3.19-fixes-3' of
git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm

I have above patches and these two:
http://marc.info/?l=3Ddevicetree&m=3D142264840506833&w=3D2
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3D8294/1

Your error code -121, -EREMOTEIO suggests that chip doesn't acknowledge
its address on i2c bus when trying to communicate with it. I don't know
what can cause it. Could it be some timing or probe ordering issue? I
have CONFIG_I2C_OMAP=3Dy and sound drivers including
CONFIG_SND_SOC_TPA6130A2 as modules.

--=20
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

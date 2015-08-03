From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Mon, 3 Aug 2015 20:17:45 +0200
Message-ID: <201508032017.45654@pali>
References: <201507251228.27128@pali> <201508011218.45076@pali> <55BFACE4.1010100@bitmer.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart13451724.AVhIQa7zlz";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55BFACE4.1010100@bitmer.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

--nextPart13451724.AVhIQa7zlz
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 03 August 2015 20:03:16 Jarkko Nikula wrote:
> Hi
>=20
> On 08/01/2015 01:18 PM, Pali Roh=C3=A1r wrote:
> > On Saturday 25 July 2015 15:17:13 Lars-Peter Clausen wrote:
> >> On 07/25/2015 12:28 PM, Pali Roh=C3=A1r wrote:
> >>> Hello,
> >>>=20
> >>> sometimes after rebooting Nokia N900 initializing alsa audio
> >>> fails. Here output from dmesg log when it happen:
> >>>=20
> >>> [    6.925140] tpa6130a2 2-0060: Write failed
> >>> [    6.929534] tpa6130a2 2-0060: Failed to initialize chip
> >>> [    6.935272] tpa6130a2: probe of 2-0060 failed with error -121
> >>> [    7.624237] rx51-audio n900-audio: Failed to add TPA6130A2
> >>> controls [    7.635101] rx51-audio n900-audio: ASoC: failed to
> >>> init TLV320AIC34: -19 [    7.645874] rx51-audio n900-audio: ASoC:
> >>> failed to instantiate card -19 [    7.665740] rx51-audio
> >>> n900-audio: snd_soc_register_card failed (-19) [    8.063049]
> >>> ALSA device list:
> >>> [    8.070343]   No soundcards found.
> >>>=20
> >>> Any idea what to do?
> >>=20
> >> Looks like the chip is not responding. Try to add a small delay
> >> after powerup to give the device to be fully ready, something
> >> like the following:
> >>=20
> >> --- a/sound/soc/codecs/tpa6130a2.c
> >> +++ b/sound/soc/codecs/tpa6130a2.c
> >> @@ -152,6 +152,8 @@ static int tpa6130a2_power(u8 power)
> >>=20
> >>   		if (data->power_gpio >=3D 0)
> >>   	=09
> >>   			gpio_set_value(data->power_gpio, 1);
> >>=20
> >> +		msleep(5);
> >> +
> >>=20
> >>   		data->power_state =3D 1;
> >>   		ret =3D tpa6130a2_initialize();
> >>   		if (ret < 0) {
> >=20
> > Hello, your patch did not helped. Problem is still there...
>=20
> For me v4.2-rc5 works, i.e. TPA6130A2 can still play loudly to
> headphones. Don't know were there any i2c etc regression before it or
> how easy it would be to reproduce.
>=20

Did you tested it on Nokia N900? Or other device?

> Logs below made me thinking can it be a HW issue? Although if it is
> an HW issue it shouldn't work sometimes I guess. Do you have any
> earlier well known configuration you could try is it an SW
> regression or something else?
>=20

Stock Nokia's 2.6.28 kernel works always. With that kernel I have never=20
seen this problem. So I do not think this is HW problem.

This problem is there in more kernel versions, maybe in some older (like=20
v3.5) is was there not so often. But do not remember correctly...

> > [    5.962585] tpa6130a2 2-0060: Write failed
> > [    5.962707] tpa6130a2 2-0060: Failed to initialize chip
> > [    5.962860] tpa6130a2: probe of 2-0060 failed with error -121
>=20
> -121 =3D=3D EREMOTEIO which is returned from i2c-omap.c when there is no
> ACK from the chip.
>=20

Maybe some power management problem? Something is not always initialized=20
correctly?

I remember that there is some problem (maybe in NoLo - Nokia bootloader)=20
that sometimes chainloaded U-Boot (booted via NoLo) is not able to=20
initialize mmc chip (all read operation fails). In U-Boot I added some=20
code to enable some parts in twl4030 regulator and after that mmc is=20
working always...

So maybe something similar? Kernel expects that some PM or regulator=20
parts are initialized, but they are only sometimes? Just speculation...

> > [   28.102233] omap_i2c 48072000.i2c: controller timed out
> > [   29.463653] lp5523x 2-0032: lp5523 Programmable led chip found
> > [   30.734191] omap_i2c 48072000.i2c: controller timed out waiting
> > for start condition to finish [   32.142333] i2c i2c-2: SCL is
> > stuck low, exit recovery
>=20
> If SCL is really stuck it also explains why chip doesn't acknowledge.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart13451724.AVhIQa7zlz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlW/sEkACgkQi/DJPQPkQ1LzwACglgDwJ371iDeGNrxGCjLCvS76
0voAoKn7Tx+mSYkYaDOPXSzlfL+BhZjW
=yVKw
-----END PGP SIGNATURE-----

--nextPart13451724.AVhIQa7zlz--

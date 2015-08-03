From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Mon, 3 Aug 2015 20:55:34 +0200
Message-ID: <201508032055.35091@pali>
References: <201507251228.27128@pali> <201508032017.45654@pali> <55BFB77C.6000208@bitmer.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart20268991.rAIczhEcuU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55BFB77C.6000208@bitmer.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

--nextPart20268991.rAIczhEcuU
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 03 August 2015 20:48:28 Jarkko Nikula wrote:
> On 08/03/2015 09:17 PM, Pali Roh=C3=A1r wrote:
> > On Monday 03 August 2015 20:03:16 Jarkko Nikula wrote:
> >> Hi
> >>=20
> >> On 08/01/2015 01:18 PM, Pali Roh=C3=A1r wrote:
> >>> On Saturday 25 July 2015 15:17:13 Lars-Peter Clausen wrote:
> >>> Hello, your patch did not helped. Problem is still there...
> >>=20
> >> For me v4.2-rc5 works, i.e. TPA6130A2 can still play loudly to
> >> headphones. Don't know were there any i2c etc regression before it
> >> or how easy it would be to reproduce.
> >=20
> > Did you tested it on Nokia N900? Or other device?
>=20
> N900. Seems to be only user of TPA6130A2 in mainline :-)
>=20

Great, can you do more tests? I get this error often after I reboot N900=20
(without power off) more times. But no idea if this is just "sometimes".

> >> Logs below made me thinking can it be a HW issue? Although if it
> >> is an HW issue it shouldn't work sometimes I guess. Do you have
> >> any earlier well known configuration you could try is it an SW
> >> regression or something else?
> >=20
> > Stock Nokia's 2.6.28 kernel works always. With that kernel I have
> > never seen this problem. So I do not think this is HW problem.
> >=20
> > This problem is there in more kernel versions, maybe in some older
> > (like v3.5) is was there not so often. But do not remember
> > correctly...
>=20
> It is well possible that some regression got introduced to TPA6130A2
> I2C communication over the years without nobody than you now
> notices. We used to do QA back in Meego N900 days but that was pre
> 3.x kernels.
>=20

Do you still have these pre 3.x kernels? This could be good starting=20
point as 2.6.28 kernel is tooo old and heavily patches...

> > Maybe some power management problem? Something is not always
> > initialized correctly?
> >=20
> > I remember that there is some problem (maybe in NoLo - Nokia
> > bootloader) that sometimes chainloaded U-Boot (booted via NoLo) is
> > not able to initialize mmc chip (all read operation fails). In
> > U-Boot I added some code to enable some parts in twl4030 regulator
> > and after that mmc is working always...
> >=20
> > So maybe something similar? Kernel expects that some PM or
> > regulator parts are initialized, but they are only sometimes? Just
> > speculation...
>=20
> I'm thinking the same. I could figure SCL could be stuck low if TPA
> or some other chip connected to the same I2C bus is without power
> and is pulling I2C signals down.

We should know which devices are connected to which i2c bus. So maybe=20
detecting which i2c device is incorrectly initialized?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart20268991.rAIczhEcuU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlW/uScACgkQi/DJPQPkQ1LVSgCfX1xpB8cHETkmfE4zb6BzRWad
7aIAnRIfiI02lPslmRRqIxqC+6mcgR/F
=84Be
-----END PGP SIGNATURE-----

--nextPart20268991.rAIczhEcuU--

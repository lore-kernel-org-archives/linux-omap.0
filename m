From: Felipe Balbi <balbi@kernel.org>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Mon, 22 Feb 2016 09:31:50 +0200
Message-ID: <87ziutnqu1.fsf@ti.com>
References: <201601091616.04193@pali> <20160126143450.GG25796@pali> <20160126172631.GZ19432@atomide.com> <201602211212.49460@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201602211212.49460@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>, b-liu@ti.com
Cc: joerg Reisenweber <joerg@openmoko.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pali Roh=C3=A1r <pali.rohar@gmail.com> writes:

> On Tuesday 26 January 2016 18:26:32 Tony Lindgren wrote:
>> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [160126 06:35]:
>> > On Thursday 21 January 2016 12:30:13 Tony Lindgren wrote:
>> > > * joerg Reisenweber <joerg@openmoko.org> [160121 11:35]:
>> > > > On Thu 21 January 2016 11:21:13 Tony Lindgren wrote:
>> > > > > Do you have some pointer
>> > > > > to the "certain resistor value on ID to GND" spec? Is it
>> > > > > maybe part of the carkit related parts of the USB spec?
>> > > >=20
>> > > > ""Three additional ID pin states are defined[4] at the nominal
>> > > > resistance values of 124 k=CE=A9, 68 k=CE=A9, and 36.5 k=CE=A9, wi=
th respect
>> > > > to the ground pin. These permit the device to work with USB
>> > > > Accessory Charger Adapters that allows the OTG device to be
>> > > > attached to both a charger and another device simultaneously.
>> > > > [6]""
>> > > > https://en.wikipedia.org/wiki/USB_On-The-Go#OTG_micro_plugs
>> > >=20
>> > > OK thanks. So it's the "accessory charger" part of the
>> > > battery charging specification 1.1.
>> >=20
>> > So, Tony, do you have some idea what needs to be changed and how to
>> > fix peripheral mode after boot on Nokia N900?
>>=20
>> No, I'm waiting to hear an educated guess from Felipe on this one.

about why peripheral mode doesn't work on n900 ? No idea. that's always
the default role of MUSB and last I checked, before stopping working on
this, BBB was working just fine.

N900 is odd in that it has two PHYs (1701 handles data lines while
twl4030 handles power lines, IIRC), but peripheral should be working.

The only reason for MUSB to not start would be that it's not detecting
VBUS being above session valid threshold, however twl4030 should have an
IRQ for that.

What happens when cable is attached ? Any IRQs anywhere firing ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWyrlmAAoJEIaOsuA1yqREnzoQAKve7fazuqTYf94MJP0+M3SK
MB2au0QbPxYlKJz5OIlZ9je1IeEPHX+jb6JWRlqe02NXXgSLIM0zGplUFn1c1ED7
8wljdf/ZvJo6fghWYyKyY0Y/sJ1lPfdYo+iHnOnIowcR8aKHgw5wHWGx05IasPEX
xfBJI+mScHfzCYnPOCxxmA+3pgqInTJs/r6hHxNRcv62CtkyXFPm/0O93LE6Sfl6
uXSVZL5oTSBPp4VZuojLaxUHAmXgGkrNvi6SLTCZpyHP4+MDncxjfSJRq51mDayY
HwtHEI0m+zcKjfbpB37KzGRPu8zJbq/a/UpLv9ghHxDnY8raR7OtUSM7XsjWuLih
L2ptOotqqf5imZiXkBcEkpQYpBOg4bi2tnwzddjxRr8dOKP5/QjJmmnn0vwgAcYJ
JjhMYdAxIzR+d5ceN8AZ2j/gh+BqqEZ4b2/g7dcXQdQxbgHTG4M7II7fdF+mVl21
jKcb+rI2JL9DPUdMStLAI3FlflqCsK2MuGWGLpzFzxdAYh0HpTNquKlfS8rLrk6q
vcqQpdSNsKA5grnmzFWsnyWkvYBt3I7+6/n/9PturHD2Zg3CfFaJ5HfKcvgOFnLN
jJnO0gPGnmf5uVWDYm6+UQIgJImUsrER+ZxLYk2KsNSninDTeq0oSQOJyEypk3di
t67IX3fYCyOwO6fJlI/V
=FiIK
-----END PGP SIGNATURE-----
--=-=-=--

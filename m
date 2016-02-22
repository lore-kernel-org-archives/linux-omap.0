From: Felipe Balbi <balbi@kernel.org>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Mon, 22 Feb 2016 10:54:21 +0200
Message-ID: <87oab9nn0i.fsf@ti.com>
References: <201601091616.04193@pali> <20160126143450.GG25796@pali> <20160126172631.GZ19432@atomide.com> <201602211212.49460@pali> <87ziutnqu1.fsf@ti.com> <20160222083431.GA4606@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160222083431.GA4606@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>, b-liu@ti.com
Cc: Tony Lindgren <tony@atomide.com>, joerg Reisenweber <joerg@openmoko.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

Pali Roh=C3=A1r <pali.rohar@gmail.com> writes:
> On Monday 22 February 2016 09:31:50 Felipe Balbi wrote:
>> Pali Roh=C3=A1r <pali.rohar@gmail.com> writes:
>>=20
>> > On Tuesday 26 January 2016 18:26:32 Tony Lindgren wrote:
>> >> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [160126 06:35]:
>> >> > On Thursday 21 January 2016 12:30:13 Tony Lindgren wrote:
>> >> > > * joerg Reisenweber <joerg@openmoko.org> [160121 11:35]:
>> >> > > > On Thu 21 January 2016 11:21:13 Tony Lindgren wrote:
>> >> > > > > Do you have some pointer
>> >> > > > > to the "certain resistor value on ID to GND" spec? Is it
>> >> > > > > maybe part of the carkit related parts of the USB spec?
>> >> > > >=20
>> >> > > > ""Three additional ID pin states are defined[4] at the nominal
>> >> > > > resistance values of 124 k=CE=A9, 68 k=CE=A9, and 36.5 k=CE=A9,=
 with respect
>> >> > > > to the ground pin. These permit the device to work with USB
>> >> > > > Accessory Charger Adapters that allows the OTG device to be
>> >> > > > attached to both a charger and another device simultaneously.
>> >> > > > [6]""
>> >> > > > https://en.wikipedia.org/wiki/USB_On-The-Go#OTG_micro_plugs
>> >> > >=20
>> >> > > OK thanks. So it's the "accessory charger" part of the
>> >> > > battery charging specification 1.1.
>> >> >=20
>> >> > So, Tony, do you have some idea what needs to be changed and how to
>> >> > fix peripheral mode after boot on Nokia N900?
>> >>=20
>> >> No, I'm waiting to hear an educated guess from Felipe on this one.
>>=20
>> about why peripheral mode doesn't work on n900 ? No idea. that's always
>> the default role of MUSB and last I checked, before stopping working on
>> this, BBB was working just fine.
>>=20
>> N900 is odd in that it has two PHYs (1701 handles data lines while
>> twl4030 handles power lines, IIRC), but peripheral should be working.
>>=20
>> The only reason for MUSB to not start would be that it's not detecting
>> VBUS being above session valid threshold, however twl4030 should have an
>> IRQ for that.
>>=20
>> What happens when cable is attached ? Any IRQs anywhere firing ?
>>=20
>
> Just to note, when I call echo peripheral > mode then detecting usb
> cable starts working and usb peripheral mode also works fine (also
> after disconnecting and connecting usb cable again). Read my first
> post in this thread, there are also some logs:
> https://lkml.org/lkml/2016/1/9/69

interesting... that softconnect interface looks odd. We _know_ the value
of softconnect from musb->softconnect. /me reads commit which added
it... Oh okay, that's only valid for host mode. Argh!

Okay, the session bit is _NOT_ set when it should be. Note that DevCtl
reads as 0x98. Bit 0 is Session bit and that's not set. MUSB _is_ in the
device mode (bit 7 set).

For some reason DevCtl didn't get set. Care to add a print to
musb_gadget_pullup() to see when/if it's called ?

BTW, Bin will be maintaining MUSB going forward.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWysy9AAoJEIaOsuA1yqRE84UP/1P0Ey9an5VZoSQiK3gCOqWZ
+Sg1JJMup15Em/xuAbNgUIPKlttt1P7PYd6O3x7dOkY1nFGPKlKyS86ZpwzPosU9
EJPWos7Plsm+X9pc5ZA5MCHnFn4XEysiAn7fcwLvs3QnwxQBwiJLQo73WzRCapcr
Vovd18Ij8eUkfBRcoaoPYPn6ab9uBepYmPgqhxRjRI3ymQ19zHDRPUKqCcJG3n1Q
L9OHcZMg03iXw9OQg3HjPsULyfgrxWws+3abaWBRo4JWonVpqxtY+XLlqdD0qEvG
963dX+MF6A+eKoVsUAmOvJaVAANCvvQtewAzfuFLVXYbdLidTgxboITlzCbAcuJ8
yjf/L+i2jNZ02OACGd+IjozQg3sM0GKVEbn19CaEYvuzaDDX5IzlonFPl6AGbGnR
qqz0NR936gSZikTtKsGWqoae8TEK1rwFrNThqNLGfZSigCmgZCe/SGAnPJ8yR1U9
1W0fooOKpTSAWPTUX6eivmKomY2LvCDhiciSEzhVPYrDQ9F82QS9icXvBfUrusDb
Cr9ZzL9ZBtRKu+SuCLY7zkzidNDO5Uvwfyech7w6RCfFFu+nEtkWKMrmL4sKGNDc
IOMiQNWkByqC6/gSSfy3rf2RVsDg4opAwHzyaHzUzTpazpelE5HXAjQ3YqZ6bjiO
Xu1XxxFGuDEzQZI2AD5f
=oZZS
-----END PGP SIGNATURE-----
--=-=-=--

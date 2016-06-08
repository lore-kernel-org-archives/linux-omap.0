From: Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Wed, 08 Jun 2016 13:02:00 +0300
Message-ID: <87h9d49exz.fsf@linux.intel.com>
References: <201601091616.04193@pali> <3690314.8jDXSUDcRZ@saturn> <20160121192113.GM19432@atomide.com> <201601231357.32629@pali> <20160529103824.GM29844@pali> <20160607125044.GI29844@pali> <20160608095321.GH22406@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160608095321.GH22406@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: joerg Reisenweber <joerg@openmoko.org>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

Tony Lindgren <tony@atomide.com> writes:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [160607 05:53]:
>> > Tony, what do you think about that patch?
>> >=20
>>=20
>> Tony, PING
>
> Yeah I don't know, AFAIK we don't have a generic way to
> force MUSB to change mode without ID pin. If you have figured
> something generic for that which does not actually tinker with
> the PHY registers directly, that should be the generic
> musb_set_mode() that we've been wondering about for years.

#define MUSB_TEST_FORCE_HOST	0x80

Can someone confirm on MUSB's docs (and actual running system) that this
does what's supposed to do?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXV+0YAAoJEIaOsuA1yqREhwIP/0S8l2dT6pq85lWYM9jvqKx2
MzZSL1e/MJZZDQZ54iPLdIijRnogkv97TL7CIY/wkS2gcetpPdjvAVXYoV0IPay2
XYpLzyjRqs+LrIfIXefFjhCa++QLMHQjUj0I6n38VNwpbScqcKOzrJapM+Ep4s7S
rqd4wvRxUkVKy8ZFPS5D0Qd8cb0aFf9o9108Zy/KKIyp2gC7lJHuxd36Q6qRJPEt
jXjIgbVWNGYI6dhRVK/jqI7uUp5RqfkZycIfxpmhWb8t0LskPMt4v6oTGlTcFgai
TSJayDjCOMbpr6Y7x4dNyBgKMiqZaWpXbBPiMk0f/Gb4Gym910wIedCur97qEXaF
UzyHDXVYT6FWb/24AJoQcVilZHRLUyxUgZ2mehQXkWzPhdciZze2sqJwyKpfCfAd
sEMD2AkHTOUwW8RMrxo2iXdrEhCJTq/XFq9CnCOnlijn2EZed5G/xT+q7QfhnKlh
QO17A9p9afNMHPsWaljks1MLAQBA81u5UXyuSPWMQsO1yuShIkPx/O7D4d4KO4cA
T69xLCVi0LviaurQ7Z5VX1rfBCcxKSFZFcSArjVk2ynOkHu9yGHFZIB0grYn5G9u
SO8nGYJ/ryKSYNY8+GRmmP9c5A9MdgoKZZOjqbJLVPC1NZQMvdrD6jDMKuOr3KXV
1uPaAudjFq+VHlqpZsqm
=wqm2
-----END PGP SIGNATURE-----
--=-=-=--

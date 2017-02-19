From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [Letux-kernel] [PATCH v9 1/8] drivers:input:tsc2007: add new
 common binding names, pre-calibration, flipping and rotation
Date: Sun, 19 Feb 2017 23:29:18 +0100
Message-ID: <20170219232918.53801560@aktux>
References: <20170218180811.GB9377@amd>
        <27287BC5-E4E2-4F50-B140-C74D3CADED5B@goldelico.com>
        <20170218225435.GA4693@amd>
        <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com>
        <20170219141715.GA7159@amd>
        <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com>
        <20170219171518.GA12833@amd>
        <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com>
        <20170219190547.GA17292@amd>
        <EB41EEED-0D94-473F-944F-757B25350A4C@goldelico.com>
        <20170219205708.GA9641@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/C6+C.W4k3c5jM8YobTOnFfb"; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20170219205708.GA9641@amd>
Sender: linux-input-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Mark Rutland <mark.rutland@arm.com>, Andrey Gelman <andrey.gelman@compulab.co.il>, Michel Verlaan <michel.verl@gmail.com>, Nick Dyer <nick@shmanahar.org>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Aaro Koskinen <aaro.koskinen@nokia.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, Hans Verkuil <hans.verkuil@cisco.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-omap@vger.kernel.org

--Sig_/C6+C.W4k3c5jM8YobTOnFfb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 19 Feb 2017 21:57:08 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
>=20
>=20
> > But as said I don't think we need float or fixed point for
> > practical systems at all.
>=20
> So you are going to loose precision. And if userspace decides to
> calibrate it slightly differently from kernel, lost precision will
> matter.
>=20
> > >>> and floating point in kernel is hard. Also
> > >>> you'd either have to invent new interface, or you'd break
> > >>> touchscreen for people that already have their touchscreens
> > >>> calibrated.
> > >>=20
> > >> No, I don't break calibration for people using a different chip.
> > >=20
> > > So you propose your touchscreen to behave differently from all
> > > other touchscreens in tree?
> >=20
> > No. I only propose that my touch screen behaves properly and in the
> > best way it can. If others are worse, they should also be improved
> > at some time.
>=20
> Different from all other drivers. Read: broken.
>=20
> No. You have to design interface such that they _can_ be improved, and
> what you propose does not work that way.=20
>=20
Then the consequent way would be to use i2c directly from userspace.
Because maybe for some really, really unusual you can do
something better there. Maybe adjust on-chip filtering (here the
MAV-filter) to interact better with your userspace filtering or
something like that if you want to exactly detect where maybe a
mosquito tries to drill into your touch screen (if the pressure would
be enough...)=20

> > And note that I am not making things different from others in tree,
> > I am making the tsc2007 right (incl. following the touchscreen
> > bindings which define the touchscreen size in "Pixels").
>=20
> Your touch screen is not in any way special, so it has to behave in
> the same way others do.
>=20

I agree, the tsc2007 (=3Dwhat the interface provides to userspace) should
not behave special, for example it should behave like the virtual
touchscreen (=3Dwhat the interface provides to userspace) virtualbox
gives. No need to be calibrated. Well, the internals are different. But
that is what the kernel is good for, abstract such things.
Conclusion: It cannot be totally wrong behavior to have pixel values
there.

And the generic touchscreen bindings describe the size in "Pixels" as
said by Nikolaus,

And here it is up to the dt to decide whether the touch screen is good
enough in position so it does not need to be manually calibrated or
there are chances to improve something. If there is no calibration in
the dt, then nothing changes.

Regards,
Andreas



--Sig_/C6+C.W4k3c5jM8YobTOnFfb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYqhxCAAoJEInxNTv1CwY0r3YP/2vYaVbdMDxMYSF4ynybSXpA
kJoaxlwZ069q7OTMFAeqPrXaClcJGvRIZOD4vBskGSn1XE3a0reOS0DwfxFB3aiP
blFmBIc9Noq/XeCZ9MAT7hSQN5sSn6oEu3EJnud3TXbY/Dg81FaNVUhvTXHkXG0q
uF9S6ZD4rw1mTvmcV3B0uYAM1f7rDlx84nits95Hu7T/IJGbQNNh6iD+CsEywM7a
IySiWoHgGdRLt/RciksvJs4rwd7FuPcxiH3i71rW+3K05qsW6F4VBh1Pb0h2D80G
5WaA5PGDCbf7dtkEGksSscOwl7RRoki/S49m6nnGekeNk3NV1Nd5fVqBf+e9V6Ht
4EuvhM4IKLnQ8V3bhrSvVaBYvQk6tekaNvuTOTjbHTUlcvlap4gc45aeYAY9EkVr
ZQGP80SV5t6GaWlRiZFFAw5upr0ElhW1zV8IZppVYGWxqZ3dkvdggMFsuIsA8a4J
cDiSnXaS9dR0SPhuqPpmJJwMZzI9oT7XSdNNSnLAbBfVfnZX/ADbL8YmkCw5I44f
bJsXpSbSVz+ZcPwsWqs548tY8UpI1bY8NX+dOAXElfc8ubB6OK8r96m8m8PrphtX
/pt1GrKHgrbHCPFtJInZqQYB8bI60qG40w+NCEpJanhyNMclKyNiNmKM1DTlruNw
TN/g7U1vBf0so6kd9Pa/
=Dpus
-----END PGP SIGNATURE-----

--Sig_/C6+C.W4k3c5jM8YobTOnFfb--

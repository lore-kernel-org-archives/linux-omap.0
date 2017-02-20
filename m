From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [Letux-kernel] [PATCH v9 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Mon, 20 Feb 2017 21:22:22 +0100
Message-ID: <776DC6E2-5D58-40F4-8866-39D9002EF772@goldelico.com>
References: <20170219141715.GA7159@amd> <05F3816F-46E6-4BC2-9E2E-F20E645F7197@goldelico.com> <20170219171518.GA12833@amd> <B41253A6-95D5-4E0F-ABD6-6909362843C4@goldelico.com> <20170219190547.GA17292@amd> <EB41EEED-0D94-473F-944F-757B25350A4C@goldelico.com> <20170219205708.GA9641@amd> <20170219232918.53801560@aktux> <20170219223949.GA2470@amd> <EE81034E-C10E-4E8B-B026-B3E92C0DAA19@goldelico.com> <20170220193228.GB23745@amd>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: multipart/signed; boundary="Apple-Mail=_4A4D9AB0-0AB0-4625-B4E5-FEE40EF83A02"; protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20170220193228.GB23745@amd>
Sender: linux-input-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andreas Kemnade <andreas@kemnade.info>, Mark Rutland <mark.rutland@arm.com>, Andrey Gelman <andrey.gelman@compulab.co.il>, Michel Verlaan <michel.verl@gmail.com>, Nick Dyer <nick@shmanahar.org>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Aaro Koskinen <aaro.koskinen@nokia.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, Hans Verkuil <hans.verkuil@cisco.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-omap@vger.kernel.org


--Apple-Mail=_4A4D9AB0-0AB0-4625-B4E5-FEE40EF83A02
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

Hi,

> Am 20.02.2017 um 20:32 schrieb Pavel Machek <pavel@ucw.cz>:
> 
> Hi!
> 
>>> But if you have userspace that depends on touchscreen to be
>>> calibrated... that _is_ wrong.
>> 
>> User-space people and real users have the opposite opinion. They
>> prefer if a touch is plug&play. I.e. without need for calibration.
> 
> Some people prefer to calibrate their touchscreens; because of
> per-device variations, that gives better precision.
> 
> You can pass default calibration data from device tree to kernel to
> userland. But you can not force people to use that calibration.

Yes, you can do that if you want. I hope it became clear by the formula
in my last mail.

I just want to be able to do it the other way for those users who don't
care about this per-device variation.

BR,
Nikolaus


--Apple-Mail=_4A4D9AB0-0AB0-4625-B4E5-FEE40EF83A02
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYq0/+AAoJEIl79TGLgAm6AxIP+wcd66vWnQnL5WPDOdyOt2cl
Go4t5ZU+kEI+bP8ucpge4REuAC0yK5AH4HqHLiOUnRpj/l1vKxWAgfX5Om8pdL9u
fbghblmb6LLPeO0MBh03LWxyFSfoGA12hLYVs3jhh/YY8c2z3tcTGy1zezGfG2CI
KYDy3UIlcucNILgNzJglNIXSfNrCLETmYgxRTJaDVryhGpjN5RWV9ELaK7V3Bk2i
UaIFfE5mTMYKW4zW1MkFmc+PWbR6a+5Au6qUdLmEnL/jVSRb7UUQUwMsdwipo/qd
hu06yIYpGYxIURihL5DrlGhuZEGBdTGFXWBwLVXOJ1G6/HECvPXIDk8MHvZC+qKU
1n/1sBxKrDs6PA5uC4nTAgrcWe4UQIj7QTjOb27oOgJdKrYK18NBb39GULxPjNwb
WQ08gvt0l66dxULxkv5JQhNfL/dGLt1VpqYRemo6iea/L7abylmYSTYqj2r2EG+V
uvU1FHbN5cE/gKVOZuE1mDbH8pW8/N84XHxFgy1i6p+nZLZugNlcaK0KW9H0hwIb
bUv3jHqbtT0E3eLgR3/0YGCXSMvh5s3d/P20bMetU1zfBYDeBWFnD+EMMum5HDpf
xYifNVV5ccQONrn58kvimPREJInxhfEn/m3/X9Lw3fzTsIu5tyO5G9Fyu+u5M1Mr
toR1+BPPP5u3sHY1AhzU
=+Qxw
-----END PGP SIGNATURE-----

--Apple-Mail=_4A4D9AB0-0AB0-4625-B4E5-FEE40EF83A02--

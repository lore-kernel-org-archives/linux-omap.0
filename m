From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900 sound driver and ECI GPIOs
Date: Mon, 2 Jan 2017 18:02:52 +0100
Message-ID: <201701021802.53045@pali>
References: <201701012054.54505@pali> <20170102125840.GD6728@pali> <a132c193-5c00-14cb-91bf-abb86eac01d6@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4274171.QCtXKVD3Iv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a132c193-5c00-14cb-91bf-abb86eac01d6@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Pavel Machek <pavel@ucw.cz>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, joerg Reisenweber <joerg@openmoko.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart4274171.QCtXKVD3Iv
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 02 January 2017 15:36:38 Peter Ujfalusi wrote:
> On 01/02/2017 02:58 PM, Pali Roh=C3=A1r wrote:
> > On Monday 02 January 2017 14:53:44 Peter Ujfalusi wrote:
> >> On 01/02/2017 10:51 AM, Pali Roh=C3=A1r wrote:
> >>> On Monday 02 January 2017 10:34:34 Peter Ujfalusi wrote:
> >>>> On 01/02/2017 12:36 AM, Pavel Machek wrote:
> >>>>> Are there multi-button headsets compatible with N900?
> >>>>=20
> >>>> Not sure if n900 is capable of handling ECI communication, n9
> >>>> was. In n9 the PMIC/Audio chip had an ECI core integrated afaik
> >>>=20
> >>> In N9 it is handled by twl5030 chip? Is there documentation for
> >>> that ECI/ACI part? N900 has twl4030 so we need some chip
> >>> documentation for adding support for N900...
> >>=20
> >> n9 has twl5031 and the documentation is not public. But the kernel
> >> source from Nokia have the driver under drivers/mfd/twl5031-aci.c
> >> It is using the ECI stack to report the changes.
> >> twl4030 and twl5030 does not have support for ECI, only twl5031.
> >=20
> > Ok, so Nokia N900's audio chip (twl4030) does not have support for
> > ECI.
>=20
> TLV320AIC34 (two of them) on n900 to be precise, n9 uses twl5031 and
> tlv320dac33.
>=20
> > But still as Jarkko wrote there could be an option to supports ECI
> > via GPIO and ADC.
>=20
> Yes, there is the option, but w/o documentation on the ECI protocol
> it is not going to be easy.

Is there documentation?

> And I'm sure there were a (good) reason the n900 does not support ECI.

What was that (good) reason? I would like to know it.

> If it could be done in a stable way the product would have support for it.

Hm... I would rather not to speak about decisions of product managers :-)
=20
> > And there is still mysterious gpio 178 (RX51_ECI_SWITCH_1_GPIO)
> > which could help us?
>=20
> Yeah, that is something I have no idea what it is for. It could be
> that the schema is using different pin mode for it? It might worth
> looking at the TRM on which pin the gpio_178 can go out and look for
> the possible modes? Most likely waste of time...

According to omap trm GPIO_178 is connected to mcspi2_clk. But
mcspi2_clk is missing in RX51 schematic too.

To verify that omap trm is correct: GPIO_177 (in omap trm) is connected
to mcspi1_cs3. And in RX51 schematic HEADPH_IND (gpio 177) is connected
to mcspi1_cs3. So looks like omap trm is correct there.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4274171.QCtXKVD3Iv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlhqh70ACgkQi/DJPQPkQ1JpGACff1KbogGopFAa5P9owBXZMzQz
XpsAn1s5VUcm+XGf0uYewMMllFGljSBy
=acFF
-----END PGP SIGNATURE-----

--nextPart4274171.QCtXKVD3Iv--

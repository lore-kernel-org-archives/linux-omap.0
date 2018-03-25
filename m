From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Date: Sun, 25 Mar 2018 20:58:58 +0200
Message-ID: <20180325185857.GA7582@amd>
References: <20180322164633.GF5799@atomide.com>
 <20180322192843.GA17189@amd>
 <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
 <20180323105455.GB21644@amd>
 <20180323113521.45va72bhzis6ym6m@earth.universe>
 <20180323201343.GC23658@amd>
 <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
 <20180324142517.GA94954@atomide.com>
 <20180324200224.GA17857@amd>
 <20180325154512.GC5700@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180325154512.GC5700@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dan Williams <dcbw@redhat.com>, Sebastian Reichel <sre@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Hmm. Interesting. Anyway, for me ttyUSB4 is interesting, as it seems
> > to react to AT commands, and in particular reacts to ADT123; (; is
> > important).
>=20
> Is that to dial a voice call?

Yes. And it is ATD123; not ATD.

> > AT+CMGF=3D1
> > AT+CMGS=3D"123"
> > foo^Z
> >=20
> > Works for SMS sending. Good.
>=20
> So what do you use for reading notifying and reading sms?

Well, did not try that, but they should just be displayed in the
serial terminal.

Anyway, "good" solution is to get ofonod running, then use ofone from
here: https://github.com/pavelmachek/unicsy_demo

But parsing AT commands is easy enough that I can probably hack it
together in few days if neccessary.

> > Now, if someone knows what needs to be done to get GSM audio working,
> > let me know. That's something I'd really like.
>=20
> I think it's the cpcap based config to route voice call audio
> to SoC, Sebastian knows the details :)
>=20
> The way to figure that one out is to dump the cpcap registers
> before and during voice call on android with cpcaprw, then
> diff the output for the audio registers. Probably some SoC
> registers need to be diffed too with rwmem or similar tool
> for the mcbsp instance(s) used.

That sounds like hard way to do it. There's source available, I'm now
trying to understand it / fit it into Sebastian's driver.

https://raw.githubusercontent.com/NotKit/android_kernel_motorola_omap4-comm=
on/hybris-11.0/sound/soc/codecs/cpcap.c

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq38XEACgkQMOfwapXb+vLQaACfRbi3fedoNP8KvAVCxGprzpWZ
uZgAoLr5p+ovefk4xKPfs/jf4AtFHpMc
=wPdt
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

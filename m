From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: 3.19 on Nokia n900: audio quality awful
Date: Fri, 30 Jan 2015 09:16:22 +0100
Message-ID: <201501300916.22364@pali>
References: <20150106170433.GA5408@amd> <54CA173F.1070301@ti.com> <20150129204218.GC3962@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1957060.QjZQkCj7Gr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150129204218.GC3962@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com
List-Id: linux-omap@vger.kernel.org

--nextPart1957060.QjZQkCj7Gr
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 29 January 2015 21:42:18 Pavel Machek wrote:
> Hi!
>=20
> > >> I did this:
> > >>=20
> > >> I'm not sure which one is "main" microphone and which is
> > >> headset, but I guess 2V should be "close enough" to 2.5V
> > >> to produce something different from zeros..?
> > >=20
> > > Main or integrated is digital microphone which does AD
> > > conversion itself and headset is analogue. If DMIC is
> > > without bias codec will sample plain zeros from DMIC
> > > input but analogue input should always produce some
> > > random LSB bits from codec's AD converter.
> > >=20
> > > If codec produces zeros also from analogue input then I
> > > suppose codec ADC is not powered up or similar. One way
> > > to hunt regression if bisecting is not possible due
> > > reason or another is to dump and diff codec registers
> > > from /sys/kernel/debug/regmap/ using both working commit
> > >
> > >and head.
>=20
> I tried 2.6.28... where recording was, but it does not support
> regmap. Then I tried 3.14, but could not get recording to work
> there.
>=20
> > >>  	tlv320aic3x_aux: tlv320aic3x@19 {
> > >>=20
> > >> @@ -502,6 +504,8 @@
> > >>=20
> > >>  		DRVDD-supply =3D <&vmmc2>;
> > >>  		IOVDD-supply =3D <&vio>;
> > >>  		DVDD-supply =3D <&vio>;
> > >>=20
> > >> +
> > >> +		ai3x-micbias-vg =3D <1>;
> > >>=20
> > >>  	};
> > >=20
> > > This should be 2, i.e. 2.5 V according to
> > > Documentation/devicetree/bindings/sound/tlv320aic3x.txt. I
> > > think 2 V is too low for some headset mics and that was
> > > the reason for 2.5 V.
>=20
> Ok, tried that, but no change.
>=20
> > Can you also try this patch to correct the DAPM route for the=20
rx51:
> Yes, with the patch below (and dts updates I did) recording
> works.
>=20
> Another interesting note is that audio quality is not that
> horrible when playing 8 kHz, mono signal... it is mostly what
> I'd expect. Playing 44.1kHz, stereo mp3 .. is not good.
>=20
> Tested-by: Pavel Machek <pavel@ucw.cz>
>=20
> Thanks,
> 									Pavel
>=20
> > diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
> > index 04896d6252a2..7f299357c2d2 100644
> > --- a/sound/soc/omap/rx51.c
> > +++ b/sound/soc/omap/rx51.c
> > @@ -250,14 +250,14 @@ static const struct snd_soc_dapm_route
> > audio_map[] =3D {
> >=20
> >  	{"FM Transmitter", NULL, "LLOUT"},
> >  	{"FM Transmitter", NULL, "RLOUT"},
> >=20
> > -	{"DMic Rate 64", NULL, "Mic Bias"},
> > -	{"Mic Bias", NULL, "DMic"},
> > +	{"DMic Rate 64", NULL, "DMic"},
> > +	{"DMic", NULL, "Mic Bias"},
> >=20
> >  	{"b LINE2R", NULL, "MONO_LOUT"},
> >  	{"Earphone", NULL, "b HPLOUT"},
> >=20
> > -	{"LINE1L", NULL, "b Mic Bias"},
> > -	{"b Mic Bias", NULL, "HS Mic"}
> > +	{"LINE1L", NULL, "HS Mic"},
> > +	{"HS Mic", NULL, "b Mic Bias"},
> >=20
> >  };
> > =20
> >  static const char * const spk_function[] =3D {"Off", "On"};

Can you try DT and non-DT boot of 3.19? If there is difference?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1957060.QjZQkCj7Gr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTLPdYACgkQi/DJPQPkQ1IRzACeOlMSJeSQaQcCNpN0Cgii9se0
7hQAn2UVKrGCDmFNKFe8mBaDS39ZtQbr
=bCgS
-----END PGP SIGNATURE-----

--nextPart1957060.QjZQkCj7Gr--

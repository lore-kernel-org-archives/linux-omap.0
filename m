From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv4 1/4] dt-bindings: sound: add motorola,cpcap-audio-codec
Date: Fri, 16 Feb 2018 16:58:37 +0100
Message-ID: <20180216155837.e57lt4dhc7wlryq6@earth.universe>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
 <20180214220741.28306-2-sebastian.reichel@collabora.co.uk>
 <20180216113008.GB5886@sirena.org.uk>
 <20180216132537.lkd4wzfg7uuoyx7k@earth.universe>
 <20180216134448.GI5886@sirena.org.uk>
 <20180216141237.rd75sbix7bopi7zu@earth.universe>
 <20180216151609.GK5886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dtydjqporgovqia7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180216151609.GK5886@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--dtydjqporgovqia7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 16, 2018 at 03:16:09PM +0000, Mark Brown wrote:
> On Fri, Feb 16, 2018 at 03:12:37PM +0100, Sebastian Reichel wrote:
> > On Fri, Feb 16, 2018 at 01:44:48PM +0000, Mark Brown wrote:
> > > On Fri, Feb 16, 2018 at 02:25:38PM +0100, Sebastian Reichel wrote:
>=20
> > > > While it looks empty in the DT binding file, it's actually not empty
> > > > once some standard properties are added to support audio-graph-card.
>=20
> > > This tells me you're missing something in the binding defining the
> > > DAIs and...
>=20
> > Well it is described by the following document:
>=20
> > Documentation/devicetree/bindings/sound/audio-graph-card.txt
>=20
> You still need to say which DAIs exist on the device and how they are
> identified - if there's only one DAI it's obviously easy but if a device
> has multiple DAIs then there's some naming to do.

Ok, I will add some more description of the codec's capabilities.

> > > ...that still doesn't require a compatible here.
>=20
> > I agree, that it's not required. Also the node is not required.
> > Everything could be dumped into the main node. Many things are
> > not required, but they make implementations easier and help in
> > regards to DT readability and consistency. Having the compatible
> > means, that all sub-functions _can_ be handled equally by the
> > operating system. Not having the compatible means you _always_
> > need special handling for the audio codec. This basically makes
> > the codec node different for the simple purpose of "because it is
> > not strictly required". If we have a compatible node, other
> > operating systems can still decide to ignore it, right?
>=20
> It's not just other operating systems, it's also other versions of
> Linux we have to think about here. The most obvious issue with audio is
> the clocking where the division between ASoC and clock APIs is not super
> obvious and could easily change in the future.

Which does not change my argument. Other handling in Linux is
basically equal to other operating system. We don't loose anything
by having a compatible available.

-- Sebastian

--dtydjqporgovqia7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqG/6gACgkQ2O7X88g7
+ppy9w/+KxWpLExUDVnnFYwRUUsI6Owg6sDV567BqUMqbigA7Zbl3CfS346iOlnh
cSGfLQQgTQIoR0oEeyb9eQPqQu9QBPW8KY2jdxc+4zfNInpZ0YmRKeAbDQaZGF2r
Zqk/y7ZRgpIRw7IXmS7BxiS2WTLS8dmGOGxzA+StJZb8MmqNteAuZ5c/7S/IPD5H
Ro315xkQct9oirM7ljRjRrumaEgagVmSJpmznQ4Ta0KGJ3ftm/eUrSjLYpYsQMAq
ODqDTCfVqJlPlEZP024HUORXSQtkUyA060RNrX/NAk1YkaEm/gKuKdoyAQDIBaqo
mEAhN6cqwC5DbFtVxk5sr7Y9nEAUYzb2ZzV4s1Bo2fITJdiPiaI3AqfP7R825F2r
U0JFAd7PUhu3j7mm/RYXstFROrtwAhiwUjsKJOnC29tpJdtU5/jFQ3eCLDlBhRBp
cVoArGV7nnDBECk6iKu4NwZYAHOpeGclY38cqy2gyTvLl3WnUjZd5cF0PSOUjaZT
fmJmfzgKb6bxL9BNc5O5kfbepApMwvDDS/61YYVrrUGA+OYv96e3BLflQ0AY5ASJ
l6Ovra3QJJRNE/aviYOmgURzW7p5D/7auY0c7I73Qto2/SQRsLtv+S7Y6eI7/0cp
Kd99yMNCa4obhsAYmLgiIIlJIuCrPS8g5Mc2tS/uU5kl5IcOJxk=
=ulJl
-----END PGP SIGNATURE-----

--dtydjqporgovqia7--

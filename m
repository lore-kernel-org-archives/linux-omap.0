From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv2 3/6] ASoC: codec: cpcap: new codec
Date: Mon, 17 Jul 2017 16:18:08 +0200
Message-ID: <20170717141808.qsh2di4dzgirqiij@earth>
References: <20170712151846.24621-1-sebastian.reichel@collabora.co.uk>
 <20170712151846.24621-4-sebastian.reichel@collabora.co.uk>
 <20170717092928.GH10026@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7056960683391862332=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20170717092928.GH10026@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-omap@vger.kernel.org


--===============7056960683391862332==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v3ftj4tvlsyedq4e"
Content-Disposition: inline


--v3ftj4tvlsyedq4e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 17, 2017 at 02:29:29AM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sebastian.reichel@collabora.co.uk> [170712 08:19]:
> > diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> > index 6c78b0b49b81..1615e5acc8fd 100644
> > --- a/sound/soc/codecs/Kconfig
> > +++ b/sound/soc/codecs/Kconfig
> > @@ -401,6 +401,11 @@ config SND_SOC_ALC5632
> >  config SND_SOC_BT_SCO
> >  	tristate "Dummy BT SCO codec driver"
> > =20
> > +config SND_SOC_CPCAP
> > +	tristate "Motorola CPCAP codec"
> > +	depends on MFD_CPCAP
> > +	default MFD_CPCAP
> > +
>=20
> Should it also have depends on SND_AUDIO_GRAPH_CARD?

The codec does not depend on audio graph card. You can
also use it with (deprecated) simple card or a custom
written one. In case of a custom written one it would
make sense to add a dependency from the custom written
one to SND_SOC_CPCAP. So I think we should not add such
a dependency.

-- Sebastian

--v3ftj4tvlsyedq4e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllsxx8ACgkQ2O7X88g7
+ppXzA/9GLXtsaVoQM7T5fc1gi9mBofbNdT9/bZwvJeCbrz6AttERqVmBRiUikMc
LJ/3BNNWYTAcmaGYM8QIaimztVuOQ4TyIHW9hh2tf/lsYYjAPCJifaSyEC9S149V
5uBBbXhVnbUcqDGuSE+EejsfNc0eotrTkK/9B2R3jaO5pJSH0yBhBiayg5i8djSp
aBVOYyLwiorvZzDT/0IW+rjfg91edE5gysKs5DlUvAYKikpI7yA3isxslgHvCSrG
DbdDPopJiBpspxuZc8Is37+iU3Z2XfG8uH3BVcbb5gbpk48vr4mFkTE7eODwUFUC
VIMMCbpyeavIR/A6uPLpKgbEwaZbZZ+o/Cb/tu8etiFJdOoRGFxJnToHACQUtZSd
VbSmLxxwcl8epJoVac3kGDmGLw2emvvxjmlgDuh2sU8kDzdIWatD4DdrV5IHa8dK
VKmaZfsscpezQ7Ug8Skls2QZIJbAVa6e+xBQcjfjn0fg49OGsvAI3Bw9V11LTzsn
DEL1sdWxMKlHpB9XvzAb+qGQl98Uu314AMEUIwf+qhzLl20ppyMKhe1Js/URKjAL
sODoBki6D7gusbEBY/MTzS76eeN5WIj2yW3SdbhHyREr+UU8nMrYgOv4iGfnFLKw
TWvOTDJjCOrhmO71W2e64Gm5+e1N+NWS+y9iauQVP9QQod5VKcc=
=8iNG
-----END PGP SIGNATURE-----

--v3ftj4tvlsyedq4e--

--===============7056960683391862332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7056960683391862332==--

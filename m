From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,
 5/5] ARM: dts: omap4-droid4: add soundcard
Date: Fri, 30 Mar 2018 12:57:42 +0200
Message-ID: <20180330105742.4laay5qtu37zxpbw@earth.universe>
References: <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com>
 <20180329133613.khldv72w3zj63vsk@earth.universe>
 <20180329135904.GN5700@atomide.com>
 <20180329154600.qhels5fqzzg364gj@earth.universe>
 <20180329160611.GP5700@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2937575814766221968=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180329160611.GP5700@atomide.com>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org


--===============2937575814766221968==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dtoyyvsv6euhb6du"
Content-Disposition: inline


--dtoyyvsv6euhb6du
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 29, 2018 at 09:06:11AM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sebastian.reichel@collabora.co.uk> [180329 15:47]:
> > Hi,
> >=20
> > On Thu, Mar 29, 2018 at 06:59:04AM -0700, Tony Lindgren wrote:
> > > > I think cpcap is always the clock and frame master, but I think
> > > > mdm6600 is the remote side and OMAP is not involved at all.
> > >=20
> > > OK. So could it be just an alsamixer on/off toggle then for
> > > "Modem" or something similar?
> >=20
> > I think so. We might want to have an "Mode" enum instead, though.
> > That can be extended, once we unlock the other modes (bluetooth,
> > bluetooth call).
>=20
> OK. Seems in addition to the "Mode" enum, we also need
> some other switch for modem on and off toggle?

I don't think so. DAPM should automatically power on/off the
modem if there is a valid path from some CPCAP output/input.
Since the mode enum will "disconnect" the modem in the DAPM
graph, it should be enabled/disabled automatically.

> I guess most people want to save the preferred "Mode" enum,
> then for the duration of the call enable the selected mode.
>=20
> And I guess the mute is already there for the mic with 'm'
> in alsamixer for conf calls :)

Yes.

-- Sebastian

--dtoyyvsv6euhb6du
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlq+GCMACgkQ2O7X88g7
+pqT5A//bgZCPfqwkJPw0+YJNKRQWZFpFNiAn2OPuASup1KHHCL3td8MKJbas4fP
3N/A/z5b6a1f2x7ti30pW7bKYIdiALVVZIZpImKtSwzikDldJFgZLxDiYx+19ERl
9kEKyOsbq8OuPp8dzHitmcwZmOjQ0zp+dcOXhcOJFD54/urq9p8bbeUOjjDqSXN7
G+R7UAZ5DoF5D10Teg39Bq29tv2Q71LR6Kmw/f3QRtPHaDTlLgSLrNube3wpDOP5
xMXw+k+3RPhgUij7jX1hXqRQu1qFNzs9fNsjWavqeuH5XzkP9EWJ2sBDESEy8u3l
0A4JpOr9PFH4pykFVACGTuiUPCHeymarRURmIqJQLY6iU5uCjg5jM58kbxRrdXcu
m9lsHq13bJXcrjaVSnJIUXp8losd8R/W12GvNNe66uL/Xnn/lT+fhEuXd6OrvAD3
31HdKSCzWq2ffkYmsAR76T5vXmuIBx66YYYx9QiDBWT9L+LWBGFqNFTtX7LopvIN
utpnkdo7LMkGg+ZuDiS2KjluH7Wa/M+acjdOSDq6+wRb5AL/V8JuoVA5wSwaMOHy
GNpj8/82nujbMT15AsSu88pC8Ud2OrDWYlpY0yJFL0KyygxpbyVV6Ns9H8OhU0pL
QqLcDiWS3siThLgXWwyWnLpdBAs6dJmjYKvoY8aszMHgw8CuxI8=
=0ZYh
-----END PGP SIGNATURE-----

--dtoyyvsv6euhb6du--

--===============2937575814766221968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2937575814766221968==--

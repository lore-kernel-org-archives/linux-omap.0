From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,
 5/5] ARM: dts: omap4-droid4: add soundcard
Date: Wed, 28 Mar 2018 00:22:37 +0200
Message-ID: <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1410738994701922851=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180327121441.GH29239@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org


--===============1410738994701922851==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ohop5liubgppbvc6"
Content-Disposition: inline


--ohop5liubgppbvc6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Tue, Mar 27, 2018 at 08:14:41PM +0800, Mark Brown wrote:
> On Mon, Mar 26, 2018 at 05:58:28PM +0200, Sebastian Reichel wrote:
>=20
> > My understanding is, that we only need to replace the audio-graph-card
> > driver to something more complex. The VOICE DAI needs to be configured
> > differently based on the use case:
>=20
> No, this is exactly the sort of use case with multiple DAIs that the
> graph card is intended to enable over the old simple-card.

Oh nice. So the Droid 4 hardware wiring looks like this (at least
according to my understanding):

+----------+         +-------------+
| OMAP4    |         | CPCAP       |
|          |         |             |
| [McBSP2] | <-----> | [HiFi DAI]  |
|          |         |             |
| [McBSP3] | <--+--> | [Voice DAI] |
|          |    |    |             |
+----------+    |    +-------------+
                |
+----------+    |    +-------------+
| MDM6600  |    |    | WL1285      |
|          |    |    |             |
|    [DAI] | <--+--> | [DAI]       |
|          |         |             |
+----------+         +-------------+

Legend:
    OMAP4   =3D SoC running Linux
    CPCAP   =3D Audio codec
    MDM6600 =3D Baseband
    WL1285  =3D Bluetooth

Re-reading the audio-graph-card binding document I still don't see
how the network (OMAP.McBSP3, CPCAP.Voice, MDM6600, WL1285) is
supposed to look like. It seems to expect point-to-point DAI
connections.

> > "audio-graph-card" is not capable of doing this. I was planning to
> > try "audio-graph-scu-card" in combination with adding codecs for the
> > modem and BT to DT. If that does not work we need a Droid 4 specific
> > soundcard driver.
>=20
> That's just the audio graph card with some hacks for working with a DPCM
> based SoC driver set.

Ok.

-- Sebastian

--ohop5liubgppbvc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlq6xCsACgkQ2O7X88g7
+pr4Mw/9H73f8pw44CXjo5tlVFXl5Q1SECW4Rtl7d7ji8UPUi5vVX/AKb+Aai1Ag
PW3EzEUuz8qLKgXtb21eTRazQd4ueh6XuzaTucUIhTv/jELr/jt99Sw9xby2loPU
UN0X6w/h6Qsfqi2mfaLfsNv/6fTZqKbgCIVEV6eA6rf0W0zcTm3rNMtnuzG7l6z1
iUnPxWXeSBE4gqr6xwn1JQ21QH3R7HCZpsRc1nJA46OnT5D7eg40lOnHOVOH0jD1
erb9Q4R1NdDHDn9iPWQPmmK30gFpKr/etPO+r3PhNysQpoikU3ZfrD2u4626ssiy
6tIRogsxECPWnmHCn89QnQQiI691S7zWlbJnlbPAdU7g1Re1MHZs2o+XQYDPU4bA
tf0nVubaQeSI+JyqdY5OnSEJlDp9F089HBnjWJnK9ptror/Zfl5BePG3LtfyWZOB
7QyrQkW4vA4jN6wBuOU+QW//Lt+bEvjZeH8qc2s07Ubp2+cmOdV8Ug6xowfWvH0p
rGqG5QW/PYy5UU/60+Qlj0vvyS8GDjJk5f9QgA2vxC8kql21yFzAO2e6rjc5HaCO
usnVZ84zflgzH3CIkk5Mt34d54KFvo/tRQJFGir6A/+5dNUVg29JjykDNEaPrn1r
5gtCJ7yvtbfM0yZnTy7oTtfgDRZCCwu1OCLW4sX1HUMC91wkqEI=
=mFzH
-----END PGP SIGNATURE-----

--ohop5liubgppbvc6--

--===============1410738994701922851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1410738994701922851==--

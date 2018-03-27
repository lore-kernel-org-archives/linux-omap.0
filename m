From: Mark Brown <broonie@kernel.org>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,
 5/5] ARM: dts: omap4-droid4: add soundcard
Date: Tue, 27 Mar 2018 20:14:41 +0800
Message-ID: <20180327121441.GH29239@sirena.org.uk>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5432426207577814094=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180326155828.ttnduivadob4iqmd@earth.universe>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org


--===============5432426207577814094==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nFBW6CQlri5Qm8JQ"
Content-Disposition: inline


--nFBW6CQlri5Qm8JQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 26, 2018 at 05:58:28PM +0200, Sebastian Reichel wrote:

> My understanding is, that we only need to replace the audio-graph-card
> driver to something more complex. The VOICE DAI needs to be configured
> differently based on the use case:

No, this is exactly the sort of use case with multiple DAIs that the
graph card is intended to enable over the old simple-card.

> "audio-graph-card" is not capable of doing this. I was planning to
> try "audio-graph-scu-card" in combination with adding codecs for the
> modem and BT to DT. If that does not work we need a Droid 4 specific
> soundcard driver.

That's just the audio graph card with some hacks for working with a DPCM
based SoC driver set.

--nFBW6CQlri5Qm8JQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlq6NbEACgkQJNaLcl1U
h9B3oAf8DFja7E3t6S5AyZX1NtVgh8eJn596ExCt8AVnePFYiplaATZ6Ep943zrd
UzT1lYfV6O9HJeF3rw6hTQWdH5YMIH8OIGFN7fWmXlrHrpFzKkmi9Q9cNMukPo96
DP5sWk1bsyCay5R0utl/A89SBHlImiB9IDHzS4mZnzALl3cWVP+ldjeZ56K4/haT
sRH+pH+fcFH3IVklo5HZY3xnovBr9eXwS6na24SAR7jX+WSCGGLQQoyCVpnoZfFT
7mIw59VLDaBmi+YA+rPsBJAmMlq2buiwtk9HPf2j800sAJd/hkyyID+GvmgQekBD
10Oq5Nhdcf7b7XQC+T2ISH5bxL8nYA==
=nvVV
-----END PGP SIGNATURE-----

--nFBW6CQlri5Qm8JQ--

--===============5432426207577814094==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5432426207577814094==--

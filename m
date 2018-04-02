From: Mark Brown <broonie@kernel.org>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,
 5/5] ARM: dts: omap4-droid4: add soundcard
Date: Mon, 2 Apr 2018 16:06:44 +0100
Message-ID: <20180402150644.GP29239@sirena.org.uk>
References: <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6468977839626181820=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180328140219.f6667up5evrrafkv@earth.universe>
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


--===============6468977839626181820==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PZYVFYZbFYjzBslI"
Content-Disposition: inline


--PZYVFYZbFYjzBslI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 28, 2018 at 04:02:19PM +0200, Sebastian Reichel wrote:

> In case of the last two variants, the bus clock is provided by
> CPCAP, so it needs to be enabled for any audio stream. I suppose
> the codec <-> codec as part of TDM is out of scope for the graph
> card and we need a Droid 4 specific card driver?

It's definitely pushing it towards being more useful to consider at
least in the short term, basically nobody ever did these TDM muxes since
usually you end up needing something more than just straight digital
data muxing (mixing for example) so things usually get routed through a
chip that can do more with the data.

--PZYVFYZbFYjzBslI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrCRwQACgkQJNaLcl1U
h9Cjzgf3fkRFxkzl8WMDbR2avF91e5NwyRTrilN7DXkjZvGUmVUldiJZmSbIyGiD
vi9wUfT1B6qO500+nHxKsTqQL4QOZsfZbNEoa6+o3RIL0wVuZB5JDzSBzsjQHxll
4+E4xskEjlHsbDcxEifSpNUYol20PZ9B3aejjIkFdsAMhf8wfGvJ0TA0m9dM0K5x
buhM/Gp1BnaFkviid0ygp1eT4TiCYCUCyeUi0ClNwbS3g0kYQ7Hurg/pG0oak3Uq
AUp0CiiqFoS47+broPx1p4qVpERD584vbhj3DwtQVHSANO/9J6ZZOF+/mYcoRdPq
onp5bPIHQjNDJbDSqFwVgZqd4w9J
=KSVV
-----END PGP SIGNATURE-----

--PZYVFYZbFYjzBslI--

--===============6468977839626181820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6468977839626181820==--

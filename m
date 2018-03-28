From: Mark Brown <broonie@kernel.org>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,
 5/5] ARM: dts: omap4-droid4: add soundcard
Date: Wed, 28 Mar 2018 10:29:10 +0800
Message-ID: <20180328022910.GM29239@sirena.org.uk>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
 <20180326141638.GB1450@amd>
 <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8485846830688507552=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
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


--===============8485846830688507552==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cN0A5YokcrYPGsSB"
Content-Disposition: inline


--cN0A5YokcrYPGsSB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 28, 2018 at 12:22:37AM +0200, Sebastian Reichel wrote:
> On Tue, Mar 27, 2018 at 08:14:41PM +0800, Mark Brown wrote:

> > No, this is exactly the sort of use case with multiple DAIs that the
> > graph card is intended to enable over the old simple-card.

> +----------+         +-------------+
> | OMAP4    |         | CPCAP       |
> |          |         |             |
> | [McBSP2] | <-----> | [HiFi DAI]  |
> |          |         |             |
> | [McBSP3] | <--+--> | [Voice DAI] |
> |          |    |    |             |
> +----------+    |    +-------------+
>                 |
> +----------+    |    +-------------+
> | MDM6600  |    |    | WL1285      |
> |          |    |    |             |
> |    [DAI] | <--+--> | [DAI]       |
> |          |         |             |
> +----------+         +-------------+

> Legend:
>     OMAP4   = SoC running Linux
>     CPCAP   = Audio codec
>     MDM6600 = Baseband
>     WL1285  = Bluetooth

> Re-reading the audio-graph-card binding document I still don't see
> how the network (OMAP.McBSP3, CPCAP.Voice, MDM6600, WL1285) is
> supposed to look like. It seems to expect point-to-point DAI
> connections.

Ugh, a TDM mux?  That's really unusual and not particularly supported
yet, you'd need to extend the graph card to do it.  It's where things
should end up for a generic card though.

--cN0A5YokcrYPGsSB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlq6/fUACgkQJNaLcl1U
h9C0Wgf/chTotUC9eLSM2kefgGQKyFJjAxPUYX/mQsycb5qlOcipCSSMxMLKhhNV
rOjGxqyWQVIdk9NloSxrpcmDcwiiAswI6pHyM/NCHPIUVbQTh8iAyH54BQUzxQHE
hS9odp7qwgzlnOB3cDglUI//3jBGVDqGUaR2rkmyXbY3OnpBLdBioFXItcGLFV87
Ra/Ix2Gbz5qHTUMxq8fm+yyfavLEOjQ/fTxLiRII177HtFf1SsCoQ5XzwNyxjfAP
gtVheyEHVdcWrMfuxKw3/49zM0jRrqrZwQvNoDGwCRYjX0jZs5BusGwW06h1tUij
gNx2sJSLZX9lrLs9l5P0E2DH8/R4ug==
=+2O+
-----END PGP SIGNATURE-----

--cN0A5YokcrYPGsSB--

--===============8485846830688507552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8485846830688507552==--

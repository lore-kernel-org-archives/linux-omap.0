From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v3 3/7] ASoC: hdmi-codec: Add
 hdmi-codec for external HDMI-encoders
Date: Mon, 17 Aug 2015 11:41:02 -0700
Message-ID: <20150817184102.GW10748@sirena.org.uk>
References: <cover.1439542916.git.jsarha@ti.com>
 <ed41a6c0b594866c05e695cc066371d0e3862c7e.1439542916.git.jsarha@ti.com>
 <20150814161820.GU10748@sirena.org.uk> <55D1884B.6050800@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2287357263356496001=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <55D1884B.6050800@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, moinejf@free.fr, airlied@linux.ie, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tony@atomide.com, tomi.valkeinen@ti.com, bcousson@baylibre.com, rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============2287357263356496001==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AXVeTwB1tCcD1nEH"
Content-Disposition: inline


--AXVeTwB1tCcD1nEH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 17, 2015 at 10:07:55AM +0300, Jyri Sarha wrote:
> On 08/14/15 19:18, Mark Brown wrote:
> >On Fri, Aug 14, 2015 at 12:30:41PM +0300, Jyri Sarha wrote:

> >>+	/* Called when ASoC starts an audio stream setup. The call
> >>+	 * provides an audio abort callback for stoping an ongoing
> >>+	 * stream if the HDMI audio becomes unavailable.
> >>+	 * Optional */
> >>+	int (*audio_startup)(struct device *dev,
> >>+			     void (*abort_cb)(struct device *dev));

> >I'm a bit confused about what is going to use abort_cb() and why they
> >wouldn't just call shutdown instead?

> audio_shutdown() is for ASoC side to tell video side that audio playback has
> stopped.

> The abort_cb() is for video side to inform ASoC that current audio stream
> can not continue anymore and it should be aborted. The similar mechanism is
> currently in use in sound/soc/omap/omap-hdmi-audio.c.

Someone reading the code needs to be able to understand this.

--AXVeTwB1tCcD1nEH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV0iq9AAoJECTWi3JdVIfQkP8IAIBnhDFmE7PxTUWEQ/8qpwwV
VXsEs4lNDKcPaZw09mjq1de6UkA4NL9jXZ3N52K77NadS3++OoA4xkaq27C7IogF
g6sSp32K5PStTrC/3lRRomwvfJACAq9sxSkud/NWQSEBOT7msrISehF44boLDtRX
BhsnG08im4OJYWqDjKDoQKFou7dbdSP7tMjvrTJTn7Rap3nJff2fl8JSmVBqvb16
WxxJ9nXOGoglOlcwZnoxmYUbNq4SAk2ZEllqytElbZP5R3o4uSDFby2h1uTkqpFw
OFW1iHYV3rs+6xU8LnQMMxoUU2At4knbjgP2lTRls/AUcFalBDDd/FNnsj52vIQ=
=jzCG
-----END PGP SIGNATURE-----

--AXVeTwB1tCcD1nEH--

--===============2287357263356496001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2287357263356496001==--

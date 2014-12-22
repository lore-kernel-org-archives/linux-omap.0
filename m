From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 25/28] ASoC: omap: drop owner assignment
 from platform_drivers
Date: Mon, 22 Dec 2014 12:02:01 +0000
Message-ID: <20141222120201.GE17800@sirena.org.uk>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
 <1419196495-9626-26-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2561335576189574521=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1419196495-9626-26-git-send-email-wsa@the-dreams.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org


--===============2561335576189574521==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FN+gV9K+162wdwwF"
Content-Disposition: inline


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 21, 2014 at 10:14:46PM +0100, Wolfram Sang wrote:
> This platform_driver does not need to set an owner, it will be populated by the
> driver core.

Applied, thanks.

--FN+gV9K+162wdwwF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUmAg4AAoJECTWi3JdVIfQPsYH/jGOqmG1m9OPV0AQEqMHx7+M
FPFUfYUrTmIIqXUdc3sjK/6ti1HsgFuoFM0BGOIewI0/xoPgwz0EVUg1JD0ohJnI
mqX3H37bcqGTL3B6aBkFBzGVodFb/I7p5KsxxgI7QKo3hoJqNoXauaUggnG8EnEc
0bBDxTyQa02AoSTxDrPM8AHqzCG0vC/2X206dWBM4RZGJvulezTom6LyT/S+M/gK
Wf1dMfMs+W6qbe1D5QtPzmRUD60WevduoH12pP0oxcE1cVhkoCYZfH17jcSXd7Hn
GvnbWhl8bixgUGbBZXxZjQhMhzvb7EpzIM0m9Jna2RM5J4zquagmSzGrZxC7ryY=
=m8sN
-----END PGP SIGNATURE-----

--FN+gV9K+162wdwwF--

--===============2561335576189574521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2561335576189574521==--

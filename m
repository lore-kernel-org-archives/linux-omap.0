From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 01/12] ASoC: davinci: Fix AM33xx SoC
	Audio support
Date: Tue, 22 Oct 2013 13:24:08 +0100
Message-ID: <20131022122408.GE9388@sirena.org.uk>
References: <cover.1382110089.git.jsarha@ti.com>
 <7289635e982532bb1a53865ae09cb7b17d866525.1382110089.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7430622162062053974=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <7289635e982532bb1a53865ae09cb7b17d866525.1382110089.git.jsarha@ti.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, joelf@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============7430622162062053974==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Uwl7UQhJk99r8jnw"
Content-Disposition: inline


--Uwl7UQhJk99r8jnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2013 at 06:37:40PM +0300, Jyri Sarha wrote:
> SND_DAVINCI_SOC is a platform driver for Davinci and AM33XX SoCs, not
> a machine driver. Make SND_AM33XX_SOC_EVM dependent of SND_DAVINCI_SOC
> instead of selecting it and add dependecy to SOC_AM33XX.

This doesn't apply against topic/davinci or -next - can you please
check?

--Uwl7UQhJk99r8jnw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSZm5lAAoJELSic+t+oim96WQP/3vfZdSKESSs/4nn62OoHK5j
y6zDamxMf/RArjHGh6MWHiVx2CecrG/yDDRj37G9YQZiJoPkFmpSH6Ebhhx0Adon
JPT8bOcPF+xF0E5aEtZtOMGjPJodFkHEyuUIstCaGcAzWhuvbjyeENnMfFKrWS4L
OeCbZg/AR+qHGHXWoSI2vCA4hKQ5MqIHNpwIab/jmO+3YIi5sk1hcZgdAavengFn
Fpg7vWTlKNrMw1gAYRUhxYLFjzCXgKo9dmxBwFMtXZ1odS0bAfvlMs0oX794TW3u
NcRoo8U1VUMPvVEbp+h2HDEYuBGmhEHb3v9EVeLAwepr+u5ML+myCTSqKUIgULoW
Pik3w5Pg7wOLpnqaTwxmVAcBbvDY9ZA3jos+aMT08n47nCFdfzHZ5EEILM2UYhrT
VaY93t+NrpCKGzud+Df/Z6IO8C/YPCtQwnM2wi9o5J7f6q7GsuOTwwmCQO5LpJaJ
PPR21euEMuGmiZtY8A9DMCCNNbUJ+FnFn+00v1ZO8Co/Qc2JjHrp73fM7HHraH6H
ypE92bL8f6mIPyDzooSPFtKWJUrcB7fSfcfTdIzyQ4e3ha5ZL23MoZbBG15JopR8
QUmMf2tNzNQw/Jxu5fK/ayTU0MxRfy0NHtZDIkDVITmAp+SnOCs1vGYGns56Y7I6
ziwRBGf5jceKkA9t4dIp
=AV5f
-----END PGP SIGNATURE-----

--Uwl7UQhJk99r8jnw--

--===============7430622162062053974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7430622162062053974==--

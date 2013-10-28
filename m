From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 3/4] ASoC: Allow Aux Codecs to be specified using DT
Date: Mon, 28 Oct 2013 12:49:36 -0700
Message-ID: <20131028194936.GC18208@sirena.org.uk>
References: <1382909086-10493-1-git-send-email-sre@debian.org>
 <1382909086-10493-4-git-send-email-sre@debian.org>
 <20131028163721.GJ13643@sirena.org.uk>
 <20131028175341.GA28136@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131028175341.GA28136@earth.universe>
Sender: linux-doc-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Grant Likely <grant.likely@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2013 at 06:53:42PM +0100, Sebastian Reichel wrote:
> On Mon, Oct 28, 2013 at 09:37:21AM -0700, Mark Brown wrote:

> > This doesn't apply against current git, please check and resend.

> Can you give me a git url to rebase against? I used current git
> master from torvalds.

=46rom MAINTAINERS:

SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEMENT (ASoC)
M:      Liam Girdwood <lgirdwood@gmail.com>
M:      Mark Brown <broonie@kernel.org>
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
L:      alsa-devel@alsa-project.org (moderated for non-subscribers)
W:      http://alsa-project.org/main/index.php/ASoC
S:      Supported
F:      Documentation/sound/alsa/soc/
F:      sound/soc/
F:      include/sound/soc*

> > Please also consider your CC list more carefully, there's an awful lot
> > of people on this...

> I added exactly those recipients, that were returned by
> ./scripts/get_maintainer.pl for the patchset.

> The list of involved people is quite long, because the patchset
> touches devicetree, documentation, boardcode, asoc and the specific
> driver.

You shouldn't be using the output of get_maintainers directly, you
should understand why everyone it's including is in the list and if they
really should be.  This is especially important if you are sending a
series that covers many subsystems, or nested subsystems.

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSbr/NAAoJELSic+t+oim9uwEP/ArzjQNT/narEQzmn4Sum523
FFFoQNp46ojemL5q/fM3jcXYBUqIZMlLlkCo77/oeZ+Yv5Fvay5nBtrqyss6madL
dwrxWtim3Z1/4Hu17lRbOR6/jZmq/cF1U7ni93UPpGO+QcRYvgdCI5wnstdi8YlY
kFyzlPDKW2XrjRfWQc9FdPsukSnjPN3TzGn6NBpz+WBgU4YzGGBNqea1tcDw6Tp3
+AjlxMR7FuYLcHlVFFCGsDSDqgtlpmlpcXE89/LukpceIubWmPUmv6RPqlQqSWJC
Wwkuc6ih5GJUHJybMc9IPQ1SxgYSySFUBFRvyCPPH+dHQjbyFz/4Zsx8QAVBZH7j
sErdS+z+GYuLzZUdU6fytnUtPoFwwNtCgEaByAh8z5S6X8f/nEhXMxsiROLc1NXl
f9Z1BikFWuqTzh/Pdg1CB0II25CuN3R3iG9pQ/oC0dWdinX6dQRoo1BDLd8D/856
oXPzEjx2+NtW6cEIQPzU3FDO09BLhti6AvzH6sE6hssrddglMUJ+/bYCnxwi4/5M
/kwR9MKV3nTnWhm5uE9r0Ihx7K7VoTqDYXzb+3meigYcjakfYgHJt9AjmXarwbIC
IvXsZby+AAxASMyu6EmrQtkkmRlEaUiIGohsUREZDKyRoQd76xKvgQdqFloSlX1N
hnpOlKPz548BztzXPNUl
=LsZo
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--

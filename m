From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 7/9] ASoC: omap-mcbsp: Remove
 cpu_is_omap* checks from the code
Date: Wed, 22 Aug 2012 20:15:48 +0100
Message-ID: <20120822191547.GN7995@opensource.wolfsonmicro.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-8-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2189657018078826131=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1345124468-8876-8-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org


--===============2189657018078826131==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g/o8sqaH6XVFI89B"
Content-Disposition: inline


--g/o8sqaH6XVFI89B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 16, 2012 at 04:41:06PM +0300, Peter Ujfalusi wrote:
> We can use the has_ccr flag to replace the cpu_is_omap* checks.
> This provides future proof implementation and we do not need to update the
> code if new OMAP revision starts to use the McBSP driver.

Applied, thanks.

--g/o8sqaH6XVFI89B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQNS/cAAoJEFJkBDiqVpZ4Vn0QAKRZpUZv6y2vsXwzVB0rNEc9
rjZyicIeskVKyuYywsa9gZo60n6Lho7Kyi9EssAXc+MvZ382A2Dg6G1lAS4eCaB1
eMvTuihzQP86p/Itl8TLRr4lzFkmIPW99HN/SgtvVjWji38bLAdPuDTf1cQZ9cBe
seRVf9tmwvNKF3m45ajmoQFaKABQR24TlzSH1gredsn26mfYLwvX4m43H7mbQk3N
CWTErrzqPZ8Y9UjEruNK0lUnl0qXP6973xUhTxwXLhGaQE6aA53VL3psEQt5wua+
blfGt3snMyQawZtDFr8HHhGr83wljyWkgG9dkVVRDqGMqQ6Ft+gWURTW/leBnRjQ
c5gicDFkE02cudjonWAKAh3a4FoE5G4aMRvenkT18stjvR8xrXY1UJbVgqljpFgT
oe0C2mS+Ja0VireadBcKkmPiPJjBmGa0AmTbaXND9IcROrAL8/NQiDxxKhECcLZC
9E+Q2zBYja7KIWQBn4n2v7393W/Pprb5QqrHhE/g5KrQ9ngsXbbP7Yo2Ad2wnQc6
C/pubs0/kYu/V2MkL3UXkVzr1cfL4Z6zrlrnoiKSWrwkwuRRAvUh+3DENXb1w1mS
izyirlAZkykG+o9Wd6rLE7ejQ0jd80OW6gNrYPoFXHuJPRpIBTmQ5Nr8r0713WnW
fP64x4gp/XXPxoWZEdtR
=uvaF
-----END PGP SIGNATURE-----

--g/o8sqaH6XVFI89B--

--===============2189657018078826131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2189657018078826131==--

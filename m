From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: pandora: switch clock back to
	internal on stop
Date: Sat, 18 Feb 2012 22:30:06 -0800
Message-ID: <20120219063005.GA4517@opensource.wolfsonmicro.com>
References: <1329604795-24509-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0247796993966281692=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1329604795-24509-1-git-send-email-notasas@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org


--===============0247796993966281692==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 19, 2012 at 12:39:55AM +0200, Grazvydas Ignotas wrote:
> For some reason, OMAP doesn't enter lower power states with functional
> clock (CLKS) source set to external, so switch it back to internal when
> done playing.
>=20
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>

Might be an idea to do this in the McBSP driver - have it do the switch
transparently, then flip back when the port is brought up again?

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPQJbmAAoJEBus8iNuMP3djuYP/1IfcbwuCbaEcn57/Y9GTuld
gPa4qIi2njejYaeOcDk9ywwtL4gxvtQVGMPGoT3mq8NoqjCNQTIElwjft/DlEKgX
YTt4iqO8gfYIQVW7GlGymzk/voeG1FteTrOE8FPxdvwDWEcBf+PUC+dnWx9eQz90
iHqfaGoR4UY9EFPu/0b2g+kmMKR47L5WKOel4Td8n/vCCdGtlgAkA5tO35btpm47
3lSgKPigHwmC9f2mdgqpObEvaTJd8rbMwFmv2S47xjocVYbbDYyXVnhjzbVej/DR
+SMDdWSS6md2vaPnTLo9usMZJP7yvuh4mG0nHx12PTYQS1+RJ9gRtXX+N+CVXfzG
gxfJzjl+6dBxiKVXKF4PC7wsFM66UCdXSXrUljr/KjHyddkqGcMILl1DIHtScEEJ
fiLHpw43m13/GTiovMMTYTZP9J8JU9amKkGoTJfXM2YyqRYG1byzO/q2vb78rgUI
lfKhuLE5JAZcaI6QPIlIDAhooGLeYD/ARS+uim30Ft9k9ax5KVaKQf4bc1Nh9Z4w
i4aEqritA9N/0dhqhXNu5NasKO68iAgQTp7ZyUQhy9YyzD+JQRv1OuHRC33gyalY
NeNJZc087MQe60KVlqsPFF1/cL1O4fWSOAE5hw55CZ6IvH2ZXgTjJYSaWlnJ9QwK
7raIATMBCJsnzHmQMWP4
=NZVE
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--

--===============0247796993966281692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0247796993966281692==--

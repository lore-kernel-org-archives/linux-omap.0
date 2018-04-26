From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] ASoC: omap: Remove OMAP_MUX dependency
 from Nokia N810 audio support
Date: Thu, 26 Apr 2018 13:54:37 +0100
Message-ID: <20180426125437.GG21755@sirena.org.uk>
References: <20180426115115.13744-1-peter.ujfalusi@ti.com>
 <20180426115115.13744-6-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2243278768130808383=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180426115115.13744-6-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, aaro.koskinen@iki.fi, tony@atomide.com, Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org


--===============2243278768130808383==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7uYPyRQQ5N0D02nI"
Content-Disposition: inline


--7uYPyRQQ5N0D02nI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 02:51:15PM +0300, Peter Ujfalusi wrote:
> From: Jarkko Nikula <jarkko.nikula@bitmer.com>
>=20
> Commit e9f5f1e45608 ("ARM: OMAP2+: Remove legacy mux code") removed
> CONFIG_OMAP_MUX making impossible to build Nokia N810 audio support. Remo=
ve
> this dependency so we can do at least build tests.
>=20
> Fixes: e9f5f1e45608 ("ARM: OMAP2+: Remove legacy mux code")
> Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> ---

You're missing your signoff here.

--7uYPyRQQ5N0D02nI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrhzAwACgkQJNaLcl1U
h9BSRwf+O0NZTqAcGmt7byzAx8RAguXg7Z0I15dSLWOm/dtSTJ0Ebv65d4b6Xm7A
E/fSPD6xAyW3B+bT68gAL4xE3UfEjcwjvZo8LbvlJz4ZPmfaJDu6zgu4HmNeNyk4
s9DMzMtg7vu3pFAWOFWIpqct9m+9anrU8XPJQ++mZxX0Pm+UdbH+Pz1baVUHtHKr
nyaiBqmBcZ2/pU3WQSuiEM5ypSZr4jU7iv7oUTCNxPnSjSdjKhISvsS2RNiKiY5P
5KmOyewxR7Tbe8wNmvX68WfRZTS03uweG1D4C8FU/v51nXOg+24emHosOxZCQUy/
r6KA8tQFq/wNwkp3gg0cNDRqVBObaQ==
=C8qh
-----END PGP SIGNATURE-----

--7uYPyRQQ5N0D02nI--

--===============2243278768130808383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2243278768130808383==--

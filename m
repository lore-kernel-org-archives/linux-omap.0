From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: omap: Remove OMAP_MUX dependency
 from Nokia N810 audio support
Date: Wed, 25 Apr 2018 19:03:30 +0100
Message-ID: <20180425180330.GK24769@sirena.org.uk>
References: <20180425180100.15104-1-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4820743420845019739=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180425180100.15104-1-jarkko.nikula@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, tony@atomide.com, Liam Girdwood <lgirdwood@gmail.com>, aaro.koskinen@iki.f, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============4820743420845019739==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aqWxf8ydqYKP8htK"
Content-Disposition: inline


--aqWxf8ydqYKP8htK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 09:01:00PM +0300, Jarkko Nikula wrote:

> P=E9ter, Tony: Shall we pile fixes together or just send separately whene=
ver
> fixes or cleanups are ready?

It's probably easier for me if you could send everything en masse, and
that'll avoid partial fixes going into stable if they potentially cause
issues by themselves (eg, enabling build of a driver which crashes on
boot or something if that happens).

--aqWxf8ydqYKP8htK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrgwvIACgkQJNaLcl1U
h9DbPgf/fkJ25EBo1QCLBmh72iiU08JbMkSAlaZlS7qgTw0dx3WXzeptAm/F+/Dw
xYHsMuZo3toapQntXH+3ebC94QpXkRp49mOm83E1LujeO9tqN3Ts12ffLplbeMKG
olCajThr9uUvvyYvxYM5J6Gc7uVvFrPqD30nDfQpLvCmcl0OjCDyb8emjUlH4Tmu
QBvgjnEDrZ5LDWdbKfz8iEdAwpYOPWEonHPTe/0R3QX23oRm21RNZ0xMsE+WcQNa
13672sGsMjgRkhj0LGfiWLLQOgHnRlzHPNMQUOIrhX0QbTQzNrpCuRp3PEGCBJUI
TrlcBcS9jcCNAM83t0m3Q4vMekgPAA==
=eTDp
-----END PGP SIGNATURE-----

--aqWxf8ydqYKP8htK--

--===============4820743420845019739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4820743420845019739==--

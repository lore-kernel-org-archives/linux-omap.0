From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: omap-mcbsp: Convert to use the
 sdma-pcm instead of omap-pcm" to the asoc tree
Date: Wed, 9 May 2018 18:39:17 +0900
Message-ID: <20180509093917.GA13402@sirena.org.uk>
References: <20180509085356.B8D6844007A@finisterre.ee.mobilebroadband>
 <afb5ef2d-811e-b041-edee-1ab4da911268@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7231350145389766593=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <afb5ef2d-811e-b041-edee-1ab4da911268@ti.com>
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
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, aaro.koskinen@iki.fi
List-Id: linux-omap@vger.kernel.org


--===============7231350145389766593==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TXtETX/xrt1zdi6e"
Content-Disposition: inline


--TXtETX/xrt1zdi6e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2018 at 12:18:44PM +0300, Peter Ujfalusi wrote:
> Mark,
>=20
> On 2018-05-09 11:53, Mark Brown wrote:
> > The patch
> >=20
> >    ASoC: omap-mcbsp: Convert to use the sdma-pcm instead of omap-pcm
>=20
> Can you drop this for now? w/o the patch 1 from this series it is going
> to break things.

That's applied too...  problem with sending out the mails.

--TXtETX/xrt1zdi6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrywcQACgkQJNaLcl1U
h9C82wf/VZsUiMV5eOWexjnzhMEIKNzeqxqckkMSP3D/fDpeGcSTuGvYJ2d3cmd/
WZHO8yi0zWW532QNL3+TJzJPQI4ZUOASL0RMbv07F6LaAo6LYoQxwpgqmSmiD+t6
6G6gi9KXkJ2pxzX4l6hw5HPnwn/rQw1ecOAcNrQTv9By2ngG0VwChDoxSgdgQwHR
878Ew0bEkGktHrjES10bcyPCsJUFJAVF3w277i3aFafNbSICbJ+uvQZejjyL63by
pHspSHT0qtjqpgN0TD9wOSY/sGYaI2HUBV4lsNnYHNOMEoYQoGkVoJIRBjHTE+14
XE+E+6BHOBNsaIG+qmLh6yG/2z+Trg==
=YbZY
-----END PGP SIGNATURE-----

--TXtETX/xrt1zdi6e--

--===============7231350145389766593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7231350145389766593==--

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 4/7] OMAP: 4430sdp: Correct fixed regulator
	device ID
Date: Thu, 2 Feb 2012 12:38:57 +0000
Message-ID: <20120202123857.GE7428@opensource.wolfsonmicro.com>
References: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com>
	<1328185019-29575-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3785982330462169941=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1328185019-29575-5-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dtor@mail.ru>, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============3785982330462169941==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="10jrOL3x2xqLmOsH"
Content-Disposition: inline


--10jrOL3x2xqLmOsH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 02, 2012 at 02:16:56PM +0200, Peter Ujfalusi wrote:
> The board has two fixed voltage regulator. Correct the
> device ID for the vbat, which used -1.
> Create defines for the fixed regulator IDs so when adding new
> regulators we know the next available ID to use for them.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--10jrOL3x2xqLmOsH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKoPaAAoJEBus8iNuMP3ds1IP/j2dTeJOAHYA5PueT+FiEuXB
yjoZjzoXDmLJAMoIU7wJX2E+3dsiahcDZyL3nYA6HIO+ckJFO4ccbmifTLrg7Pfo
/ct6XPdaQRXJ1r901Z1bEFzbra9YIMmCbCL3yWTFWkHXLNLS61fdNKLhSNxTjEwU
N5gvziHmGKLNJEzjkgqMgbu7NZwzpgtaZDwwy5GhnwOgZgZPeG7KLTBLkPPbjsZ7
3VmdAx+A1fSmvtd+oS4dYgWmw73Q+skhuzJcPnfI8io9RGlytaojB20T92QR2s4S
gMbMnnPYYHvqS2FN3KmMbOxK6Wfa4sLtiWaVN7vEKw/1BDmWzpwIdXy/MebryLbx
D1shxBrdXVr6dHciq8WTi27NfrupD7keGk7oo/wJUFAWMle50o0xeDNjb94pxVn5
g/k71+Yz/LsC9uUQvfWk31VrBoXN3BNpeMWd1pRlX1UTZye9XTldZmncBu893CoK
I/p74926rqXG2PRggnN6NAPxVQepTu8xww1gewwMTqTa6ArUTdhrLUYzw5xUiy1W
TR/JkdKj51VleRuQH7uy2CTN6EYI8phnKOecVknB9AngO9ZTqHHU0l1aFAESjXp/
l6ugPTLvDEneu5VIMLJFoFZzGa0qKeaAQ4lBg82sCWPk6Mqu2ZwClR2ks2IOieYU
v1v5rX59zyllqinBmwvx
=Ns5j
-----END PGP SIGNATURE-----

--10jrOL3x2xqLmOsH--

--===============3785982330462169941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3785982330462169941==--

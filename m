From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 6/7] OMAP: omap4panda: Add fixed regulator
	for twl6040 needs
Date: Thu, 2 Feb 2012 12:41:12 +0000
Message-ID: <20120202124112.GG7428@opensource.wolfsonmicro.com>
References: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com>
	<1328185019-29575-7-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5202645975399160450=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1328185019-29575-7-git-send-email-peter.ujfalusi@ti.com>
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


--===============5202645975399160450==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5UGlQXeG3ziZS81+"
Content-Disposition: inline


--5UGlQXeG3ziZS81+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 02, 2012 at 02:16:58PM +0200, Peter Ujfalusi wrote:
> The twl6040 VIO power is connected to SMPS V1V8, the
> V2V1 power is coming from SMPS V2V1 of twl6030.
> These are fixed, always on regulators.
> Create fixed voltage regulators for these supplies.

Same issue as previously, shouldn't the PMIC create the regulators?

--5UGlQXeG3ziZS81+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKoRhAAoJEBus8iNuMP3drgEP/3H7Cx6Ymsi+NQUG2Ku0d/tq
MVkeUHFvc3QInl1DQHI/qMp8dJSnQBgPr+95cmRbh9Yfv/6RD//b/i3VAZJ4sWOx
9p6UEyT784IWYk5lXiXh/wQOC/eqCLFKVhg39jmbjkGA+nhDQgoUhHRjn9GLE4iV
wb19mj/QZEN4HhCfDiJF6TJur2YnjIldKJDw66WJ06V9eLfrTs/jw0MGYFAHTomj
FerFax0nPlSj6f0P0WrSoJ1kIRxdJT6GZksqYCAyZZHTTtKmZdYkTsxrsnYsKnWN
L4Jk+JlgvuzGbB5cCJCL8s4+h5SWbJaebtXIXCLyKPjBwWU+/0t7JRLTjPLyn9+8
kJYhliTHX0r1CfTXbXHocTLp3YOQOfQGdWeXbzIif/XplgpzESuITC0EjC+K7/SG
84XtTFSS5bX4PAIxxtVESMW4+mUQmYueoRpYqorBhD2w6EbfwWUqEWe7VnnYgD+a
9lIp5FLkW7PYzyEKhNSdYUOwaOAoYM/5+fY8hE7yBwb088GrSPTCwQSyF5TAgk42
sVF6wI7LiEp4xa6jrdxTQN4qL+PYpLH87hytS+ixtna0Mae0ehYKn/ZBq8L5PzF/
u8/u7gdgQ3iSWbQgrEY+nJwnk1chQZKHBUFTNGVxKLE3D+/kF/S84x7eUvUz5JxU
/ljzWMAUHDy20A9ecaMD
=eIkI
-----END PGP SIGNATURE-----

--5UGlQXeG3ziZS81+--

--===============5202645975399160450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5202645975399160450==--

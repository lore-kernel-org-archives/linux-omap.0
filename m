From: Mark Brown <broonie@kernel.org>
Subject: Re: Regression in next with spi return from transfer_one()
Date: Thu, 15 Nov 2018 16:01:54 -0800
Message-ID: <20181116000154.GS2089@sirena.org.uk>
References: <20181115211451.GH53235@atomide.com>
 <20181115221241.GQ2089@sirena.org.uk>
 <20181115234359.GJ53235@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1208217216123030437=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181115234359.GJ53235@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============1208217216123030437==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+sObS8/rhx1YpqEF"
Content-Disposition: inline


--+sObS8/rhx1YpqEF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 03:44:00PM -0800, Tony Lindgren wrote:

> It seems to be caused because of the now missing "if (ret > 0) {"
> line somehow that was there earlier. New code sets ms to 200 it
> seems, then dmesg shows:

Doh, of course :(  Sorry I missed that.

> The old code is not updating ms and it's set to 1.

Right, and not waiting either which should be the issue.  Does the
following work:

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 498d3b9bf3ae..430ad637c643 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1114,9 +1114,11 @@ static int spi_transfer_one_message(struct spi_contr=
oller *ctlr,
 				goto out;
 			}
=20
-			ret =3D spi_transfer_wait(ctlr, msg, xfer);
-			if (ret < 0)
-				msg->status =3D ret;
+			if (ret > 0) {
+				ret =3D spi_transfer_wait(ctlr, msg, xfer);
+				if (ret < 0)
+					msg->status =3D ret;
+			}
 		} else {
 			if (xfer->len)
 				dev_err(&msg->spi->dev,

--+sObS8/rhx1YpqEF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvuCO4ACgkQJNaLcl1U
h9ANuwf+IHvPFE5q4uHvxIDsrFdb+JSKUCjFjCUr7uL3Cn9T86CHbD8b+j3xP6U6
bryD7L9gRVH6nnV5UZN7LSlnVWZjGMwRoPkbMWUAtQCunhEP+PDCoBSGPeBRqBw2
1gLGHRmr8mtJ/As4TX9MVr14ybwaIPca7uQOvvtZx7Fx6MxNT4rFE3XOIlrpxXCq
qX/3DqTKmTCpxaughsuIbdg806hBYo4Bot2wR5qITuOOV3kOaDm5mzKefKUBtpH6
7L08S6chbvqST/XAfILHwui7OCw290DTRQyN+Dp76/W2ysSUNdJ4K+FuIbxPgQyM
vTCfyGeuYVGDZ7vPJE5YIeoBS5BM1A==
=KFSj
-----END PGP SIGNATURE-----

--+sObS8/rhx1YpqEF--


--===============1208217216123030437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1208217216123030437==--

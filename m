From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 06/12] ASoC: davinci-mcasp: Improve DT
 bindings document
Date: Wed, 23 Oct 2013 12:15:20 +0100
Message-ID: <20131023111520.GL9388@sirena.org.uk>
References: <cover.1382110089.git.jsarha@ti.com>
 <668306c88da19a61b88c45111a27e3602b0def7e.1382110090.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8876360657818197955=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <668306c88da19a61b88c45111a27e3602b0def7e.1382110090.git.jsarha@ti.com>
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


--===============8876360657818197955==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aYrjF+tKt+ApYAdb"
Content-Disposition: inline


--aYrjF+tKt+ApYAdb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2013 at 06:37:45PM +0300, Jyri Sarha wrote:
> Makes interrupts property optional as the interrupts are not currently
> used by the driver and adds interrupt-names property to name listed
> interrupts. Currently know interrupt names are "tx" and "rx".

Applied, thanks.

--aYrjF+tKt+ApYAdb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSZ6/FAAoJELSic+t+oim9u1cP/Ax96V2HSKx2JDL/C0h2F2IM
WZUpV/SqwnsFn8PdUiji+a8gipt1xVzwj20aKqSZJONqz8hc9slgEQEXiD7KbNrz
MNuSz/kfxEgjH/J08aigVjuDGwyzyio1tPFVv2lUvlOv5Sk437OQoPtE1YFYjLIe
5vxC6ANebn968n3eMJAk3moHUQ2HC6jGysNL2Ul5OHwtVSYr3f7+5XejcSJwpCQG
B5OYZMctNfPiRPHgs8VMM/5aIMnn4pPSkLSwNHOKvqmUQRw3a5LS36DjxpcZHAF3
xPQ1/Lum17qnME2V2W2A+7TLoNIx5azJNk5nRsi6xKGCiZmQC4oCV1PSY7w+w1Y7
+OpnhaHa+OnQhnaj4/c+HSgjQXpHu45/eH3MvMbNSyoF5YEz1qx6kTL8MfYcGBDg
m/WO4kuUwYC5FjzGR06n4cjEbTUGGNUGM/EBUE4OLjCmYhDdPA3sNl+Jz6A6BH3x
QwS5DJyzHmb9wuSsEJ6XGZYJ+MOVF3xHZUBdK8lClAtYMF6ptX+2G5lG+OtIfcrK
GZixSJr6WWdLYgyFlKeFWi6vPQ6TCwVvruARhQyACyArLryKqxyF8iK5jotCX4Jr
TYMd1ulovMWRNLiLBNna0+0RkfS/FrDKWHFDPYUbJdhYms0pDn8Fin0ArSkJtxG7
3OEbI7oLPqgl4eaDSZ1n
=eYA9
-----END PGP SIGNATURE-----

--aYrjF+tKt+ApYAdb--

--===============8876360657818197955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8876360657818197955==--

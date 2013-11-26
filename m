From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 12/17] spi/qspi: convert driver to enable/disable memory
 mapped.
Date: Tue, 26 Nov 2013 13:11:38 +0000
Message-ID: <20131126131138.GJ14725@sirena.org.uk>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
 <1385451313-1875-13-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0794396402005553253=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1385451313-1875-13-git-send-email-sourav.poddar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: devicetree@vger.kernel.org, computersforpeace@gmail.com, balbi@ti.com, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============0794396402005553253==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZxoMK3jQATP4mxSH"
Content-Disposition: inline


--ZxoMK3jQATP4mxSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 26, 2013 at 01:05:08PM +0530, Sourav Poddar wrote:
> Idea is to enable memory mapped by default at the end of the probe,
> if the control reaches the "transfer" api, then the operation is
> not a memory mapped one. Hence, we switch to Normal mode and at the
> end of the "transfer" function. switch back to memory mapped mode.

This doesn't see safe, what happens if something tries to use the map
while a transfer is in progress?

--ZxoMK3jQATP4mxSH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlJ4GAAoJELSic+t+oim9UDAP/1HCyrOjywRL7IQ+E2U4wFwL
Id2hu80W1K73HTE89OoQiDefG1ne8uO7ITkOWJw21u2wG1WX2lk+K2MZxP16Ob3n
rFqlaxWEf2Thh5wiGt62bqDSTgI7RC5qHHBG6vLkOy4oFlytjntpAHjd83NK+k5O
35HWqoCLmNDnO1YdGVExDvuLCFLgQmdW1+SsDfpcWLIfkd+OUxRnLhYwt39qoLLu
idv10brHo+7AJ3bbdYU8vYzO668Lz+Yr6lnv3Puf5QqJM7rpoOcZGQFn8NEkAcjZ
CfPs6j7vSL9K+6PfvdkXzJfsz20uuOIPtV2MT3c76/hL1DxojLxjXl/1HCoNqHKO
mOoWwYCxSJGfpnKhyXon/qx84+tkwVKi1IZXLu6AERChNRsmmsM+RlinCgAo/C3J
sFVa43tYJb2QlS89dauCRbM7YcWRsh/Rpz1B2icaRcYOtjH47hGN29ScIymBKTHJ
9J51XB4rVWmdQdEJiYsSXBSrkU3WkZ24Q0XDI6gVzjmA1Ds6lFmgNblBYB8GiOkD
VGdme9KtSCP1hZO46D+HGHIPCCI3BykhvpTd0qWvpxgi5ByF5K7CwL9l4Wo6VdXy
rPRWVDe6hnkrGvO0jYKMtEFJ2jixwkVSex3hAo+meIy5f7RKOtt6hXVulZ0A7dL0
1qkZhI9edxEx5LcbpeF7
=qcNZ
-----END PGP SIGNATURE-----

--ZxoMK3jQATP4mxSH--


--===============0794396402005553253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============0794396402005553253==--

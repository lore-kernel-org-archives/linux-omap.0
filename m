From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2 02/10] spi/qspi: parse register by name.
Date: Thu, 19 Dec 2013 13:34:19 +0000
Message-ID: <20131219133419.GD31886@sirena.org.uk>
References: <1386339891-32717-1-git-send-email-sourav.poddar@ti.com>
 <1386339891-32717-3-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0515743846308826132=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1386339891-32717-3-git-send-email-sourav.poddar@ti.com>
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
Cc: marex@denx.de, devicetree@vger.kernel.org, computersforpeace@gmail.com, balbi@ti.com, linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, dwmw2@infradead.org
List-Id: linux-omap@vger.kernel.org


--===============0515743846308826132==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7QsOHKuLbhbLTwLB"
Content-Disposition: inline


--7QsOHKuLbhbLTwLB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 06, 2013 at 07:54:43PM +0530, Sourav Poddar wrote:
> Modify the qspi driver to parse reg information by name.
> If "reg names" is not found, then revert back to normal
> get resource.

Applied, thanks.

--7QsOHKuLbhbLTwLB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsvXYAAoJELSic+t+oim9Y0AP/A4oZIcLJk9EM3v2X4FUe8vQ
edA+C67Djn9Ie/8MnwtwAZsmYeZiVDWokFVaMjlWERNhWmCpoo1u5ZDd8XEWYT91
0mzVCRAEV6tul21bbdRN2tGEm0kTFwvZhyUoqUOhsh1VHwdfhsFLzgmQk0nMB6xk
cRAje3lcqPfM6T6At4yypJafBFhoiHnZ0ATjezdPU2gu9mKyR61DtQB/RjrD4pVt
JvoGEJUuPOnSN9FAiIaPsdMQRuAqfWzfd1lFrswNQ8oPysYISe71UCcoYsiA9y9g
IJeSI2wTHQVQ7yy/Ar6/7itM734wzHx56bPjDCdxKnMOPEmCXh80isubDOMwJgfK
ynhP5YPBI/WlqV/xeSEGgy/hINoC24JcYIun2gxfkh9weaO7g0E7/UaH31Jt+AcH
dR6MBDRx1qLmczkBkGvSuYR52Xe6xTZ4wGAnxkPcHCRcyEUXDFypT7wgcEWVK1gZ
Lmw+oWKEflcCJR0tPNgH44cdIayg/2oUVqMYo9zmfxGNtK5B/u/Cm+F33hTVlczw
urBr4x1Wvxi6bfaajx6fZuQljiS3ByYoCXjqVUp0qs/dnKE+zc9/jSXNbaDbCOoK
kRIcimNuXuyq0UVTWo/Qp+E9W4iPneVOOrIo1q4ALU3x8hzUie0Jl/kAIgIZnSlI
OgwiZoIZfFdqWAWlzku2
=y5ob
-----END PGP SIGNATURE-----

--7QsOHKuLbhbLTwLB--


--===============0515743846308826132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============0515743846308826132==--

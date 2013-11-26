From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/17] spi/qspi: parse control module register.
Date: Tue, 26 Nov 2013 10:31:04 +0000
Message-ID: <20131126103104.GZ14725@sirena.org.uk>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
 <1385451313-1875-5-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1020111012097443253=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1385451313-1875-5-git-send-email-sourav.poddar@ti.com>
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


--===============1020111012097443253==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S/OOmhz5UkAXnkSU"
Content-Disposition: inline


--S/OOmhz5UkAXnkSU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 26, 2013 at 01:05:00PM +0530, Sourav Poddar wrote:
> In qspi controller, we need to switch to memory mapped operations.
> These switching depends on

This will need to be added to the DT binding.

--S/OOmhz5UkAXnkSU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlHhlAAoJELSic+t+oim9VvQP/1z3ojMhLVfYarimp8Vsyd0Y
+NJ3TH8gU5sCB5OlLfpbg4qnOlUO4N7PzZZNRfYK9WbbxMUg2Tr0IVcUKBvxyOlD
Uz9fps08VTnvc7/dFjZczZEW+jGH/wkgn0rbH3SQu5lNo307JqcBopkf9VdwlbTA
J0foTDDxGOICUuLBArjUyJJ9F+iPDm9u9mZkvbSpCSsmQlJCQz7wfDKf3CWu+CDJ
TKaxyBd//4JT1D9q5Y4l6kTwCLiMJoQkWjoJyinWhhoELEoVAFldHhFfVQsOmkCU
iCZINfkD5JY+aJysZpyPdAZcv2XVLsrzn6bh77QC/Gr5qydE40CM6Jwoo7Ghf8Uk
1S20zjevyIBFwByHfUs7ULGmhZ8PYKaqcow7LrVeholoJBV4vVHNFILBks6GiwBD
2FnBi45aIib1+rf5VQhSQ9S41UoW9QTbkHOUE4jEJ/uoMulW+wJscC2PqDiKQDNN
SIpFRYL7gIbaHfZiUlHD9xtR99AyeTQSq2fIUCOm+hLX42Qh0wHIkkp9S94B3Mlu
cbqPaZ5gyrXHYi8YahUMDG7N+oyWlwpjWO8E4sdtevxc0sCGXheYUz+itdOrdLG9
n/eyNbhMEEPwhn4da36H3u8RkvYLmxxmyet0/H6O1Zjn4PvA/DsPz9oDJd4x1bca
LzQoSd+LUqyE2/FvM+R/
=j4PP
-----END PGP SIGNATURE-----

--S/OOmhz5UkAXnkSU--


--===============1020111012097443253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============1020111012097443253==--

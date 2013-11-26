From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 09/17] spi/spi.h: Add "mem" variable in spi master.
Date: Tue, 26 Nov 2013 13:01:19 +0000
Message-ID: <20131126130119.GH14725@sirena.org.uk>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
 <1385451313-1875-10-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8402795421520857920=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1385451313-1875-10-git-send-email-sourav.poddar@ti.com>
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


--===============8402795421520857920==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="213B/23bCmw+8GSd"
Content-Disposition: inline


--213B/23bCmw+8GSd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 26, 2013 at 01:05:05PM +0530, Sourav Poddar wrote:
> Add "mem" variable in spi_master, which can be used to hold on the
> memory mapped address.

Is this really generic enough to put here rather than in the driver
data?

--213B/23bCmw+8GSd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlJucAAoJELSic+t+oim92uUP/2HbaUOMqmEsz2WqBXrCyIfU
23RCClegy2/K9Iw2ukldQyNvhEiro0PyXqRTDW7LeKMc9Ga9l6IFqto5EL1+IFfj
hJpoURqr8lt/EmoAsMt7jV9HJ2z0eb0eswWY2lGTFoRSLG4v+K19fKOdheoy32Ve
06Sw+EGLxIjVwB/GmBsgjs4UIim53jtCD/xYF999K3WC5In8WKwWHwAZegFOiE15
0x0li2G9ZwiOkWHyMZaGomg4rmT8zXCQ+ZhnnFyVS+3zMxo+ys5DnfeET7CxM4Km
6noEjdy/UjFqtnW+oxVOiTy3uzH96AKKpKlwvSqshL8BJs8RTCa4SBE9PWpCArAv
whst+Nodeg+2F5WtgAv2bzqyiIHjXsDoTby1YYM+eQDGGCAgr+1eK+T8gRnZppst
h9Jmw71puyjk23Dd35YHytbrGHBnaJlt46ZhsccWaRVPPFe1GYP5MsW30BM86chI
1zVlDhxYfLYvPtJUuyFoEP31CAbkI2BfipQ1ZMD9t0X6B7xxLJq60SXjtPbVplOn
QuCPInq3zEL5IKFGeX93GtiFEREngHHeMbSUa2Ht30VeEhXKNs67adh0SIblSMQe
DEWBVlpTtJfFpXutsLlPERHge8XWIxQfCrPhUU/A77j0LdtDrJr0Qz898kRG8gCw
yLRQAaC0r6Ktz9BvFSab
=h++a
-----END PGP SIGNATURE-----

--213B/23bCmw+8GSd--


--===============8402795421520857920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============8402795421520857920==--

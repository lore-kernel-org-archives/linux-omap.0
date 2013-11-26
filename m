From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/17] spi/qspi: parse control module register.
Date: Tue, 26 Nov 2013 13:19:27 +0000
Message-ID: <20131126131927.GN14725@sirena.org.uk>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
 <1385451313-1875-5-git-send-email-sourav.poddar@ti.com>
 <20131126103104.GZ14725@sirena.org.uk> <529483A2.3080000@ti.com>
 <20131126122512.GD14725@sirena.org.uk> <5294964A.8020507@ti.com>
 <20131126125535.GF14725@sirena.org.uk> <52949B5F.7010304@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2619840558933550241=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <52949B5F.7010304@ti.com>
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


--===============2619840558933550241==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QIE8wBgbk5Wqyq1O"
Content-Disposition: inline


--QIE8wBgbk5Wqyq1O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 26, 2013 at 06:30:15PM +0530, Sourav Poddar wrote:

> I mean to say, do I need to document "qspi_base", "qspi_ctrlmod"
> register names
> also which I have used in omy dts files.

Yes, you need to document what the valid names are and what they mean.

--QIE8wBgbk5Wqyq1O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlJ/bAAoJELSic+t+oim9JuoP/iPliwCYKd+Xc0UcVNrJ7On2
vnvw6x4nRs2UTECz+AgO68qtoCQaZu66RYd6TKIWf4o3FAjgZ3RnazlHWexBeBg5
4RhjvCmJuk2emlE6iMYklweuvGxPTKV9p3NzSCzYzpZjZZWwXwu1Fty2XNKAJQ0C
KcrNpkMpzIK5hT7P4t3mNeoyddXf70OOpOAB1fJMllw4wLavCtc9kEIvkyh36rRd
YWEGUNo3BIFT6YfZqCV1Asf8bOpLc2HWkrz1+YAs9SqOyEmNXUmm6rAmFdtc0qOj
bb5AfIjblKe/OLg5E2XomVcbfUhiwACpKXyQ04rQ8FAZdz0WcMNXEYYWyCRMSXGF
WD9lhfO1MZbv4vW1LqeeF/VK0aiOkFiy7CfZObpzqK9xeiOaXzvzTRC/CO57KfQ6
6QBTSkKm0l0QuEBD3SOZMx5bq8wkxFNvbq8C0QzqEaR2TRx1mqZqmucv+w44WtRw
nv7vjKYCFU+7vtVqCSfU+QvVuxRQUqwFXKAUPSDlABtul3U3IrMg2hWKiOoOgBOX
eYmzJjmC2/RcZTVFTZkui+0SfqUFB9Fmb6u6VIbZgmsckNfIKeKZRCa8FVYM4eQa
KDKfJuxaycT42xeVEguefpISLkGfBbDv3limHTCO758h1QiZ2xcsccrcDh7nn+Iy
QdwkRWranYjlznareZ3B
=0USX
-----END PGP SIGNATURE-----

--QIE8wBgbk5Wqyq1O--


--===============2619840558933550241==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============2619840558933550241==--

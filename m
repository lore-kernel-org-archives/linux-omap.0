From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 12/17] spi/qspi: convert driver to enable/disable memory
 mapped.
Date: Thu, 28 Nov 2013 10:49:22 +0000
Message-ID: <20131128104922.GK14725@sirena.org.uk>
References: <1385451313-1875-1-git-send-email-sourav.poddar@ti.com>
 <1385451313-1875-13-git-send-email-sourav.poddar@ti.com>
 <20131126131138.GJ14725@sirena.org.uk>
 <5296D37C.2020003@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uU2Tt3HF5Lkp2Lhz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:54820 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab3K1Kt3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Nov 2013 05:49:29 -0500
Content-Disposition: inline
In-Reply-To: <5296D37C.2020003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: computersforpeace@gmail.com, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com


--uU2Tt3HF5Lkp2Lhz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 28, 2013 at 10:54:12AM +0530, Sourav Poddar wrote:

> At the beginning of this api, I am doing a "disable memory mapped",
> as becuase of
> the code implemntation, if the control has reaches this api, memory
> mapped is not
> the desired operation. Then, at the end of this api after
> "spi_finalize_current_message(master)", which indicated the current
> transfer complete, I
> issue a end of transfer command. Only after which, I enable memory
> mapped mode again.

> So, will the condition you mention above will hit.? Please help me
> understand if i am
> missing something?

Removing the mapping isn't going to stop another context which has
obtained a handle on the map trying to look at the mapping.

--uU2Tt3HF5Lkp2Lhz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlx+uAAoJELSic+t+oim9zZYP/jH2FbRLSu51xDnNht2012dr
QDRaGRX/N1ggDa6zkHxfaW2uwc5599/pxICsZillw5pZH9bSFh0f0bFvhPLXAkYx
MUhw8SvSthOA5ScMZ08/BuvuXSL/0KyGDVFf8d4uztMbJraRxIoWszn8xjhs70n0
fSnGykY9pKNm27EbWnuSXQgjBXBvLk3xUJcGD0H9ezA0OCORdt6eufZ2MvEAyLxx
YoEmm5HWxpNhvOYG6opDq+/uuBWbC/k5jQLVsvvAEJ4vvQfbVU+JXWON4/qi9EKx
7OeH4f8EoR8unE2ZxBIorMWNRZ5C3NzcWmmexBJkEjyAqin6JhyOzCddZ6L9KXBy
89wFq3/grXkB3RwH32G9Oa4QzLGEhnF+SVYf2P2cPQ+qRZx3rGQCm/mU9igRDoBU
SCN5ptehThp5nkRU79Ef+2O1h3uB5+iU5aGmTaciDeOd8J6OAG+ss/LMDLYoqaEl
L3MxeQX/WRTEEgHg9RTHtwHKjHFq58MmRrvMZuOHbXsfim9AKt//j8VaRA/qVhpg
S6VVbQUjf9miKXyR3mpQgdTAF3vi7mE1S7OukmXk8GPmAA/Z+YYyBlbPpVXq+Bgq
LQCWlNfn3Vbu3HWNQ5P3W/HXxBSqaqzBcveDEvYtbgJNQUmOOd37MXx8Q0DaE5Bc
WtwtMa2wqOPmZ8t2DZ51
=T6bf
-----END PGP SIGNATURE-----

--uU2Tt3HF5Lkp2Lhz--

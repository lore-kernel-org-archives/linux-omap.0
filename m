From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: omap2-mcspi: Fix transfers if DMADEVICES is not set
Date: Mon, 15 Apr 2013 17:11:38 +0100
Message-ID: <20130415161137.GG15837@opensource.wolfsonmicro.com>
References: <20130413002506.GG10155@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fCcDWlUEdh43YKr8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:50461 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751385Ab3DOQLj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Apr 2013 12:11:39 -0400
Content-Disposition: inline
In-Reply-To: <20130413002506.GG10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, Jon Hunter <jon-hunter@ti.com>


--fCcDWlUEdh43YKr8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 12, 2013 at 05:25:07PM -0700, Tony Lindgren wrote:

> Selecting CONFIG_DMADEVICES is optional, and we must
> be able to continue even without DMA. Otherwise things
> like omap4430sdp nfsroot will fail if DMA is not
> selected.

Applied, thanks.

--fCcDWlUEdh43YKr8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRbCaiAAoJELSic+t+oim9yp0QAJABW89fbQoUIT236lZD0QjC
rC3Md1Eh/LVPbtLV+XnYG9SWWSA8DHWyZiZiBNxZyUCh/1xtypCZIU/ecoD7ndVi
vyTrFafgzHR6oNv5uMpRA36OKf5WXgTnA+IuFFwPMLGLKeBBOFBQsxcDGYnRl4VX
e/c++o9fFEoyGqJFBAucDZuZnErPzl1IAYXq0BJ9BrTl+NlrA9HrYv5ATE5Qb2ZG
h3rPFM5t9sMaE3z6Vibd3zhyZoE9WboSNeDvv/IRD4a+XuNoqp0CRJYETnpVXVYc
TmK7eQACnzSwkIPyQxoP1d6ZDFaBW7akdM+5jW24DcmdOSVvR/JGdSmnyqPEKXM0
upU7t0ESMR40l2QshD23VAEB/k/1clRrYc9Cv+lpKMJP2RSNJXz1AD4+TAf3mw1E
6HjS01sZAsBWKJfKWjUCtjtGUrpU4Vs3vb+nSGc48AEncVee7Iee1xIwkGDBLOkL
jK1sdm9OVE7WFnI/mHBQKegRK5BSUuPDwjfCCe1PN6GJ7uhJig2WupTqDACl5pNA
NCXsaiB5Jr0OAQpoHwNQqbh14oX/Nuo+h1GZ5q2TZal6Ja8fIU7B8czmiRyYVP8B
slorZUZuwYMVMsWuW/ZNfmRdSvK5UpNPSa7YdAE0tVcL3nF5d64AM85X14IrAPxM
F1fIv+C/EvjcbnbP+so4
=mAvL
-----END PGP SIGNATURE-----

--fCcDWlUEdh43YKr8--

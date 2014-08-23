From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ARM: dts: Remove twl6030 clk32g "regulator"
Date: Fri, 22 Aug 2014 19:04:03 -0500
Message-ID: <20140823000403.GG24407@sirena.org.uk>
References: <1407865760-15448-1-git-send-email-broonie@kernel.org>
 <20140822231259.GC17254@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u2zjs13kMz/cGsQm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:56101 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbaHWAEM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Aug 2014 20:04:12 -0400
Content-Disposition: inline
In-Reply-To: <20140822231259.GC17254@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linaro-kernel@lists.linaro.org


--u2zjs13kMz/cGsQm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 22, 2014 at 04:13:00PM -0700, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [140812 10:52]:

> > The kernel has never supported clk32g as a regulator since it is a clock
> > and not a regulator. Fortunately nothing actually references this node so
> > we can just remove it.

> If not too late:

> Acked-by: Tony Lindgren <tony@atomide.com>

Definitely not too late - indeed I'd have expected you to apply this.

--u2zjs13kMz/cGsQm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT99prAAoJELSic+t+oim9aDgP/3FU6vCzQ0K3SsQatva5oLzO
o6rcS4jvk/ZomuVxrFJ3J9YjqqPn85eF8AQxY5UY4/RXxO9KmyomEr7jFf4mGWUt
grZEc5o3plqTM2TBDyQiSwfekNwbN69BcTl07laAlPsSglpcJ+iABw+pMcoeGn7z
gNpb7DjwHP/GpQkFst9e6BDC+MKqrK4hOEPZkpN6LuiwAvwTxCDoEcecUu7Velqn
T/i4f3q1OU0yooWK6gMR+DTiP0sCp0bgJ+jVI2lT/yI/PQ/yL+jRL9Yzbz/2+fu2
3a+JKzXXJjql7egIqzcLz5FtDqwhRrwvppnHVABxP7p2TFGl9owkbFOFsn/ZBhqn
OLkHEHAPMw9roj2rDXhKGTr6scK0uz5rfV5usCodTwcu4IW1Rfn5fEux+RQdbRiU
6GixnxP/yRKBunskz7mtQ9/MQ4TJoY6C5+VW8rzpizo03H/kWg0Kw3zSfQLl6iPq
YP1bTxjxa7vCMVGZp+SLaF/dGCiwFJLQOyQqUI0PLOxGVzEac44HUifSrh3CdbFp
esUvMYuLf1I4ofowqqvQJgWPZon+P1Z0g7DefchSyozKMqW6Xmpmbb970ZiKmcxO
8zW9h/hufWSNANUvB8iUwm15BVtFvtaxKWerBoSpLz+ymESz3UtTaRDj5phAyb1D
XM7Nav18AnTpOsmri3B4
=xffY
-----END PGP SIGNATURE-----

--u2zjs13kMz/cGsQm--

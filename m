From: Mark Brown <broonie@kernel.org>
Subject: Re: mainline boot: 37 passed 4 failed
 (mainline/v3.15-rc8-4569-g3de0ef8) (palmas regression uEVM)
Date: Wed, 4 Jun 2014 23:15:27 +0100
Message-ID: <20140604221527.GR2520@sirena.org.uk>
References: <538e6a20.0168440a.7895.422b@mx.google.com>
 <CAOesGMg4ESoPVvCc4is7wpA8PVOOSDzh5=VZZ67NnJjD3jUzmw@mail.gmail.com>
 <20140604090111.GE2520@sirena.org.uk>
 <20140604193431.GB4858@kahuna>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PPxI8paQBs33t8dK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:54260 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbaFDWQA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jun 2014 18:16:00 -0400
Content-Disposition: inline
In-Reply-To: <20140604193431.GB4858@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@linaro.org>, kernel-build-reports@lists.linaro.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, j-keerthy@ti.com


--PPxI8paQBs33t8dK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 04, 2014 at 02:34:31PM -0500, Nishanth Menon wrote:

> Seems to help my OMAP5uevm.
> If this makes sense, I will repost it as a formal patch.

Yes, this makes sense - there was a similar issue with one of the other
drivers.

--PPxI8paQBs33t8dK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTj5p2AAoJELSic+t+oim9VIoP/jLscublXh0NHtcBC9BXazQw
XS9cryFJ0ZI4MdU54Nwz3Spf9uv0wwvpxwL727Ywxb0szzwE3hXT3TMCHpS3qEal
k39bUQEQGAxzy1yWd6+BeiJA0HzAn2jIOudoHCW6m/7uCz0o/qMR69bBxXImNyoD
YtdjZOJ4YUdZXGJFZdjopmLJHGMwBnQ2YW05dqak4BePJZD+Pn/D0nqxvZJiz9K8
WZB7C8fgeZ56mIZKaeNze3VSiEQIiNuWgqH20z3wpvQjbhjcsr8zABakCw9E9Xah
AJThbABgrj3FEFPdUmc1AEaJjw9JJCBS0aT8GP4nVgzHQ1gtmLIY2IM27n9LxBNF
0xI5JD4/nJvafD5Yr0AvJjwoFjFnDBbhCvSx/ORtELTEGInzpKB+vJxVA5p4w5cr
hvyMrHmNuxDKcVGeZM1a5pxbXkjqV0DCBbbbKNxATP1qAO+gp8k+FGH6Je9NihMo
/XhQDOHt00+GrbeXcUbhPKKgN/6Ae4Ef+OWUiKk52V7BDqV0LQCq3X/zZCizIEzY
BVXNtFuQS0UoQ0HQFQU/q6WwDsElrqmbGk7fg73SbZHcyWFTlvcykpaaP6XJjllO
0lMNpXGOlFe/NGSJjySvbiV1WCO+KDfjDpYn3nPaT4F8DPQ6NhmysJNUIcJaq2hy
GFYRHRkfaEzZpJSOKwuR
=dwOl
-----END PGP SIGNATURE-----

--PPxI8paQBs33t8dK--

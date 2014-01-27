From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC v3 3/8] ASoC: davinci-mcasp: Set BCLK divider if
 McASP is BCLK master
Date: Mon, 27 Jan 2014 20:46:17 +0000
Message-ID: <20140127204617.GA11841@sirena.org.uk>
References: <cover.1390836773.git.jsarha@ti.com>
 <27d041ee149081cd9b401939d4382e73fba5e7a5.1390836773.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i3QSQnH4pbmkdUT9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60366 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219AbaA0UqV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jan 2014 15:46:21 -0500
Content-Disposition: inline
In-Reply-To: <27d041ee149081cd9b401939d4382e73fba5e7a5.1390836773.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, peter.ujfalusi@ti.com, detheridge@ti.com


--i3QSQnH4pbmkdUT9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2014 at 05:37:52PM +0200, Jyri Sarha wrote:
> Make BCLK divider setting implicite in hw_params call if McASP device
> is the bit clock master on the audio serial bus.

Applied, thanks.

--i3QSQnH4pbmkdUT9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5sWVAAoJELSic+t+oim9sV8QAIhtE41aL8iajy2+MCr7PWqh
WKLuv/b5Fw3pPehPhyKC+YtgjiXPCH+e1caXwhBmQD9sLFV4UGvgSrG9TQM2Nx8+
eYoZ3Rq9NjG/zN+Xx613PjghAQElYfJYjC+zoCHd/eYieEeE0g7vDeooLNXynONV
Bn3pmGQg//eUjEwEL8NNtXOVQtJNFvtJd+mqWwUn9bPOy3POxQEiRSqEJ91FQj1a
J+aIuVoFMpnBpvytmmOQ8V3VzDvzbdvFFFqrAR9kml0n5W2NZLUnVKQ6tCis5pq7
fJ84LPjyN3flSK77g8DF4TQqwzgyHw/QrSmwr8r5BKGnQNPTG1eLcuJ0ICgCgKjf
a3MC341PLn7afgVhFNAHsKi91JWwBVUvQ1azQmDZVCz5nTMoaKkdTJ6c6ejxCHGx
twDHssUe0fW6s+FsXkFtpGcHnks1LsGYCJjGXK6K3mfQwQ/FsGmVtO5xagoR1tin
yi/CgRcflgfksQuqwKC6fezSAZJslTOgDlej9PEDL5xWHC/NUib1RXxZXtbfJ/sa
5tIOeqQadvWlaz4jW8xpy7Ww6s0DEuOGhMKahiTYbYBPnucaM9Oqrv+Uo5WK6I4Q
CVZPMMxNkewW1cvMfXdP9b06tKXzPDkCibMDifjire+H6sqduY6RWL4i82EX6uiG
vZB8sNYe0BT2GIo6tGjI
=S79g
-----END PGP SIGNATURE-----

--i3QSQnH4pbmkdUT9--

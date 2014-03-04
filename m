From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND] sound: omap: n810: fix init with DT boot
Date: Tue, 4 Mar 2014 12:31:23 +0800
Message-ID: <20140304043123.GG2411@sirena.org.uk>
References: <1393886718-1817-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oo9lGHhGGlJeg+6I"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:55087 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755944AbaCDEbn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Mar 2014 23:31:43 -0500
Content-Disposition: inline
In-Reply-To: <1393886718-1817-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>


--oo9lGHhGGlJeg+6I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 04, 2014 at 12:45:18AM +0200, Aaro Koskinen wrote:
> Since 3.14-rc1 only DT boot has been supported on N810, so this
> file fails to init. Make a minimal fix to retain functionality.
> This file should be properly converted to DT in longer term.

Applied, please remember to use subject lines consistent with those for
the rest of the subsystem.

--oo9lGHhGGlJeg+6I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFVcTAAoJELSic+t+oim9IdgP/RC4+kzbbxB0qOspeMGhVqOA
YdVeLxwP5WloVUApZq3R6xfpibhaa1ZoJxoOzq4PyGOr5H3pYveX248gifzQfufB
FYKemEmP/p8bFD6ilDqNeY1woY+cx1TF0FGaVVdZpq/Gsq6LIUp28V4ZYyAy/yF/
Rrplh67snic6MyN/trXfeNoSlwpX/K9XAzNfRZi89hzKrncTs8eE5tGRQsUqHj8m
u9nongbhPxpfLUu8fP5tr4NOlH0yg8uQREpSmOt0YE3wHNz5r94Yn2pZcVu54t9K
wOZ56DUBxVclx8Gc2UnV0JU+wKz/rrEcN00MZEQql+IkWYUYbc9Po7agfBAt7PdF
BcgVRu8tGJBTw21hdx5Noop1aiebnDN5k0sS5P81GrY1Yxd8fiLrLA6Z7+NXg3VT
Jw0WNBESsipOCwe0H71c3jNaJ+xxrxsoSHinhZ1XMUBhOXSgrMPWQYTMx3gdqv6T
grt6owIQ8Fv1MwrAXbN86PP55NN67n74szz7XJTht4dEcMvOtXVhursbQq8fFSpv
9LxMYjt/F1h5mYyLuqh1E+ICflQUVGZLDwHzJu7IB6kf1izdw5G7fj1wrnXRKfV9
D/1mFW+jGeePBE0/79JG8pWQny08pBbhmbiTtmRRRebJR3LLKrATZKDk6VZ12xgU
yKBoJxhmxZXIWnCTMu4G
=7ZSQ
-----END PGP SIGNATURE-----

--oo9lGHhGGlJeg+6I--

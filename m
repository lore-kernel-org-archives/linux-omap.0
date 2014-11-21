From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Date: Fri, 21 Nov 2014 11:23:17 +0000
Message-ID: <20141121112317.GQ3815@sirena.org.uk>
References: <cover.1415803064.git.jsarha@ti.com>
 <20141112222344.GU3815@sirena.org.uk>
 <54646648.5030807@ti.com>
 <546DC9A0.8060700@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NLEjUu5vKZJctsGO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:33380 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101AbaKULYj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2014 06:24:39 -0500
Content-Disposition: inline
In-Reply-To: <546DC9A0.8060700@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com


--NLEjUu5vKZJctsGO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2014 at 12:59:44PM +0200, Tomi Valkeinen wrote:

> The series looks good to me, and works for me.

> Do you have any comments for the sound/ parts? If not, I can merge this
> series via fbdev tree, and for that I'd like your ack on the sound/ patch=
es.

I've not reviewed it yet and I'm still seeing some fairly basic
discussion between Jiri and Jean-Francois about approaches to
integrating HDMI which seem to have ground to a halt (I've not been
reading them in any detail).  The fact that we're getting no sharing at
all between all the different HDMI devices people are supporting and
very limited dialogue between them is really setting off alarm bells.

As far as I can tell in order to figure out what to do with all this
HDMI stuff I'm going to need to go to square one, get an overview of the
hardware that's out there for myself and try to work out what to do with=20
it.=20

With this specific series I also need to figure out what all the video
side is about (like I said earlier a lot of the patches look like
they're supposed to be simple fixes for the video code not terribly
closely tied to the rest of the series but none of them are getting
applied) and what the end goal is beyond mechanically moving code.

--NLEjUu5vKZJctsGO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUbyCkAAoJECTWi3JdVIfQxD4H/0W1DwQCu+doHME9r5gREKif
ZWGtQdztNZ7SLxbKL9hqTbQA0UX4pguMw0gkHYMF3Pp3KQVN+ZbeUbUBWcy9XthG
/kl9Cj0XbPVyaYi6yd9rRm8djwTXWtdu9Z2uf1LqQWuRdYvyTQHejXm0Dz9su9CL
fcw1QHX/MiCu0k/6WbAMEE0Fn2BLaTMMUtGAhvCiV+9b64UJOhmDhY+3LyXq1h5g
irbiDeLDaE71TR/MdbhFg2uhvAOomYgr1XMBBkje+JO8RnCkQZxTmzSyzRa5SuFC
suafPCeSrV3lZpBfI8yV5baT2dDxdmNBXYZVzKY6XZZWL+8CuM8EIyoSh9eCQhs=
=IvNm
-----END PGP SIGNATURE-----

--NLEjUu5vKZJctsGO--

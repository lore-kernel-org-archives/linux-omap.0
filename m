From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Date: Fri, 21 Nov 2014 16:14:35 +0000
Message-ID: <20141121161435.GS3815@sirena.org.uk>
References: <cover.1415803064.git.jsarha@ti.com>
 <20141112222344.GU3815@sirena.org.uk>
 <54646648.5030807@ti.com>
 <546DC9A0.8060700@ti.com>
 <20141121112317.GQ3815@sirena.org.uk>
 <546F317B.9030004@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qe1hh2wipCyCpKD2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:33857 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152AbaKUQQS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2014 11:16:18 -0500
Content-Disposition: inline
In-Reply-To: <546F317B.9030004@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com


--qe1hh2wipCyCpKD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 21, 2014 at 02:35:07PM +0200, Jyri Sarha wrote:
> On 11/21/2014 01:23 PM, Mark Brown wrote:

> >With this specific series I also need to figure out what all the video
> >side is about (like I said earlier a lot of the patches look like
> >they're supposed to be simple fixes for the video code not terribly
> >closely tied to the rest of the series but none of them are getting
> >applied) and what the end goal is beyond mechanically moving code.

> The end goal of this series is to fix OMAP HDMI audio, that got broken
> couple of releases ago. At the same time I cleaned up the old complex scheme
> to make the connection between the video and audio parts and allow multiple
> HDMI devices (DSS side is not ready for this yet, but audio side is).

But in what way is it broken and how did this happen?  Why are none of
the patches which look like they're supposed to be bug fixes early on in
the series getting applied?  I had thought this was just a lack of
interest on the video side but it seems there's some other problems
since the series has apparently been discussed off-list and still it's
just as big as it was initially.

--qe1hh2wipCyCpKD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUb2TrAAoJECTWi3JdVIfQCtkH/3kL0kh9YqsExu8q6I1d9zgx
ko+a9SfkuIkF0a66D69INQFex7ACsyJe+bOCAJ/EogbIvvDISzUyqaESsDvwPQHq
pYwSS48+Fs1+kmmHswGGi4tWRd7BVGkACa51ZIzhHoKQ+Lfwfz8OkQgQPlNqDwLQ
Rhkyqtn+BcK5u55X2qCDnTCikBrtCyKTPZhLA+rvV9xKyETNNgysh9rOSPcLlcy3
sV8548H4LyAL5iDXs7RsSinr+MN+7a8mtr7xtOvc3rfDo3OcSwfS31rGZSyO9/C6
gT0Pm95ThODCkKbyxeOxgo2Ra0vJcx+1q/3Pjbz4RqOvbtwcj00vW0cNoIOi97Q=
=CHr7
-----END PGP SIGNATURE-----

--qe1hh2wipCyCpKD2--

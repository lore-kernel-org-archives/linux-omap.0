From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 14/14] OMAPDSS: HDMI: Implement DSS driver interface
 for audio
Date: Thu, 10 May 2012 10:54:09 +0300
Message-ID: <1336636449.5182.26.camel@deskari>
References: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
	   <1336095848-6923-15-git-send-email-ricardo.neri@ti.com>
	  <1336390986.2667.8.camel@deskari> <4FA9B289.5000101@ti.com>
	 <1336552081.3962.15.camel@deskari> <4FAB403E.6010000@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-OHYrgN/EJi1l6rBRXmbK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:54881 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757103Ab2EJHyP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 03:54:15 -0400
Received: by lags15 with SMTP id s15so875985lag.6
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 00:54:12 -0700 (PDT)
In-Reply-To: <4FAB403E.6010000@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: mythripk@ti.com, s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org


--=-OHYrgN/EJi1l6rBRXmbK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-05-09 at 23:12 -0500, Ricardo Neri wrote:

> Under the new strategy, in addition to not allowing the audio functions=
=20
> to be called from multiple threads, audio functions will fail if the=20
> sequence _CONFIGURED -> _ENABLED -> PLAYING -> DISABLED is not followed.=
=20
> This is aligned with the behavior that ALSA follows for the audio=20
> codecs. Also, it checks the state of the panel to allow the audio=20
> transitions.
> >
> > But the video and audio paths are probably always separate, and for
> > those we need protection. As you said, using the mutex for the may-slee=
p
> > audio functions solves the issue for those, leaving start/stop as the
> > only problem case.
>=20
> Audio only needs to know if the display is active. Under the improved=20

Audio also needs to know if the video mode is suitable for audio, right?
So not only disabling the video has to stop audio, but also if the video
mode changes to a non-supported one.

> strategy, audio_start indirectly checks the state of the panel because=
=20
> the audio needs to be in AUDIO_ENABLED state to start and this state is=
=20
> reached only if the panel is active. The mutex is held to check the=20
> state of the panel and the audio lock is held to change the audio state.=
=20
> Also, the audio transitions to AUDIO_DISABLED if the panel is disabled.=
=20

Hmm, I can't see the code that does that. As far as I see, no video
enable/disable/reconfig affects audio in any way. Am I missing a patch?
Could you setup a public git branch so it's easier for me to get the
whole series, instead of sending individual patches.

 Tomi


--=-OHYrgN/EJi1l6rBRXmbK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPq3QhAAoJEPo9qoy8lh7149IP/1JsMskK6cHMO23WLmpd4L+X
SQZFNpSYParoFieovmghjSibRxAwuMbVVtYhCxTh2eu00wH/3JeR+0vsqcWckkg8
XQGrbtybSwPZTwfw0IBEC6r9ukj6fDn36SAipStXVv0QbrCYlvJmWLQPo7WgYQxs
EVpYKLlS+pE3SpKaAsCmUfFIrq5QHXqYqtnvv0nZ2YYP+uxQu7lyDyXkNJbr6vD8
2s0bNCM6kQgVj9Q7lQOTlYHqrEzjyYu5OG1rhOSKn8aGKVfd5Fcu9SfSUWSWJe3r
6uAqFdbFEvcggMZWZwe72x2iubQ8xVfn9kPxfrV9Lr99gE+jyzm8FNNkT3U3cS0/
2WJYxiScX0iyXO2MTkcZhIrkCHFriLFZQu4YZyUUjKnm0b50CMkvom4+rTR66gL+
JBqeq7cLRn0damUr8FvYaFLaDyHdBzIsR7v3Z/kdHZAwh+EfXtvqm8RZr7y5SvYf
iLhu+XLcDkh7GIcZNeUC55rTpwe+oPL109P5aFKtzY7jvSJKjSRVeLlZPUCV1slv
30nc7/P83Iv/nrY2JnPqDBtwKX3N0hvLYjP1CjhKdqm2GUGxOeMeoUk3KZrhiU5c
e969X/UOXr2nT8U2v39PaIz8h4iQ9LB7bZ+LhwOFlTW7ttgzh3nyOmtaqpqNfSOJ
xxGnGw27CA726FeWPEno
=Y1mo
-----END PGP SIGNATURE-----

--=-OHYrgN/EJi1l6rBRXmbK--


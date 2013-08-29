From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Thu, 29 Aug 2013 12:05:34 +0100
Message-ID: <20130829110534.GV10783@sirena.org.uk>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
 <1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
 <CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
 <87txiasqhk.fsf@linaro.org>
 <CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+61ZvX8xaeyevaKt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:37940 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab3H2LFk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 07:05:40 -0400
Content-Disposition: inline
In-Reply-To: <CA+Bv8XZagHZ9mUuZB49hrH=901fXzoAcV8C0Fm3EfLa2eiBu0w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, Jan =?iso-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>, devicetree@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>


--+61ZvX8xaeyevaKt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 27, 2013 at 06:05:34PM -0700, Russ Dill wrote:
> On Tue, Aug 27, 2013 at 3:44 PM, Kevin Hilman <khilman@linaro.org> wrote:

> > The framework already has a concept of suspend voltage, suspend mode
> > etc.  Maybe it needs some generalizing so low-level platform code could
> > query the framework for the sequence so it can be done late in platform
> > idle/suspend paths.  Especially for regmap drivers, this seems feasible.

> Yes, my main hesitation for going down this path is possible lack of
> support for such an interface upstream.

Someone is going to have to walk me through the context for me to fully
understand what this is all about - what's the problem?

Generally for suspend if the sequencing is being done by the processor
it's been handled by the drivers for the components in question.  For
sequencing beyond that you're into hardware features which aren't all
that regular sadly and often aren't controllable either.  It sounds like
this is the latter case but the thing that manages some of the late
power down stages does so using a firmware we can rewrite?

--+61ZvX8xaeyevaKt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSHyr7AAoJELSic+t+oim9UTMP/2i04TBDlsb8WPvSPlfu7FDJ
K/QiIyEf5QPkhvFw2wqFfEPQPHOfs7hmq0HJ3Y2Z1HAkZhI5IzNJfCp8/1D+QgnC
ghBqYYUUs3Y7kq2aFpHX3ruk4Mz3duK8d0Q2HSv/4vRhVzGSKAFWZhjuIZDgX78p
dQjzHDxPGpXmZcpAJ1SwQ35yDeip1nx68SNkKXVj5YzteRsMzrp7ykgSBnddeugT
qbt1ohD9QY9JVV0oONG4HnMhLi8bnmkCGXAeG+OzmjP8eLfREy42elNwbAMBogwj
QfqPacA3xNQKIQMuGVZu4RBLyWkAbAb/ZFsAvwUBCKeSDn9cQMISJp93o7KrDklB
zHgKoBfKYDVjAQmIb/HHNkfLk5Wj1wnQbwhCvrAawsti5pGKJGoGKlPho+lndaew
XohW6jtq8X10W/GeeoMQCslUZDcf9BDlX0F7CsxOyReowSdxnB1goNOZJkxaPFTb
9z1wzeK8U0844mrbhfS5szq+SxXtJJj5qyu3Dj0YN82gTwXCxJkiBofE8ABDmbXd
7EAfKbge3mp8GP5JyrqfPt1g+hBcOMgHEsZm8BDAX7iLCxqDxGUfbqNYBXBO2AjS
hADjHNRt1niyp7ggk+kVkEBOPgnBJdzTM6dRfOS5OQEE45f0gCuf6C3rF596uQb7
/7KXvKoA0idEszuM8sRW
=c6vT
-----END PGP SIGNATURE-----

--+61ZvX8xaeyevaKt--

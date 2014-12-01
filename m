From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Date: Mon, 1 Dec 2014 19:31:12 +0000
Message-ID: <20141201193112.GN7712@sirena.org.uk>
References: <cover.1415803064.git.jsarha@ti.com>
 <20141129115957.GE7712@sirena.org.uk>
 <547C2FBA.4030204@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eSIQo8/L/IVtUaNr"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:45357 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311AbaLATbS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2014 14:31:18 -0500
Content-Disposition: inline
In-Reply-To: <547C2FBA.4030204@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com


--eSIQo8/L/IVtUaNr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 01, 2014 at 11:07:06AM +0200, Tomi Valkeinen wrote:
> On 29/11/14 13:59, Mark Brown wrote:

> > Reviewed-by: Mark Brown <broonie@kernel.org>

> Thanks. And just to be sure, that's "ok, we can merge these in the next
> merge window"?

Yes.

> > but like I said in reply to the patch adding the new driver I think
> > we're going to want to generalize this a bit.

> Yep, if I'm not mistaken I did suggest that to Jyri at some point. We
> can continue working on that, but I'd rather not do anything big on that
> front before there is some other SoC that has the same setup.

I really want to see people making an effort to make code shareable here
- I think one of the reasons nobody is upstreaming any of their code is
that there's nothing generic in place to handle generic tasks so people
just look at their code, think it's too much of a device specific hack
and think they'll get back to looking at it later.  If this is a
sensible set of callbacks to have to pass configuration around let's
make that discoverable without requiring people to look through the OMAP
drivers.

--eSIQo8/L/IVtUaNr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfMH/AAoJECTWi3JdVIfQg5IH/i3sTbK4INdyckCWZ873u1cU
5nuZ99BN8e/5Dzl8Juvy0uqovDFcysVjyB4q8lBqxH/O1sEAnH6CaX+qu3rfWgTZ
4xX/7gp4qmrF6SR5LJ7DFFWUbP91V04ciabM+WKu/3z7EIJtJLZs3zaLEQ01rv8U
OlM//Zy4Zmh1DhBbAxRHCIqZ1dHET9o0SE7v+IMiuFwWR9mQXdv3mXqJFf1TJ2Bq
EPKKdKW+DO453MKwE4lkBuYYfX3ZTpwQZkzAbb6jvyaEs+DKQ9hXB3ovBbnQZ53b
vbLRmVTQgaVjp5/zsjBRtPyu9KAHc3oXxVr6OMCKf+XQSax3rls+37qHr2ehhrc=
=AAsU
-----END PGP SIGNATURE-----

--eSIQo8/L/IVtUaNr--

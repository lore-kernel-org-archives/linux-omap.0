From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Fri, 20 Jan 2012 09:16:13 +0200
Message-ID: <1327043773.1921.17.camel@deskari>
References: <WC20120109124643.880164@terrafix.co.uk>
	 <1326386551.1896.41.camel@deskari> <87obu8sfx3.fsf@ti.com>
	 <1326432554.1700.6.camel@lappyti> <87zkdrpfha.fsf@ti.com>
	 <1326712308.1875.18.camel@deskari>  <87r4yvv6k7.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-lUnpAK4ziYQTPR4NiRGq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:50903 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750983Ab2ATHQS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jan 2012 02:16:18 -0500
Received: by mail-lpp01m010-f51.google.com with SMTP id p5so132793lag.38
        for <linux-omap@vger.kernel.org>; Thu, 19 Jan 2012 23:16:17 -0800 (PST)
In-Reply-To: <87r4yvv6k7.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>


--=-lUnpAK4ziYQTPR4NiRGq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-01-19 at 11:24 -0800, Kevin Hilman wrote:
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> > Now, you already said using pm_runtime_put_sync version is the correct
> > way when suspending. But to use that I need to either always use
> > pm_runtime_put_sync, or add an extra boolean which marks that we're
> > suspending, and pass that around, or make it a DSS global variable.
>=20
> I'm not sure why can't you use the sync version just in the suspend
> callback?

To do that the suspend callback should be the one that disables the
device and calls pm_runtime_suspend. With DSS that's not the case, it's
the panel drivers that are in charge of enabling/disabling DSS (by
calling appropriate functions in omapdss).

The only thing that the omapdss suspend callback does is to call the
normal disable functions on the display drivers. This leads to calls to
disable-functions on the dss hwmod drivers, and then pm_runtime_put
calls. But at the point the pm_runtime funcs are called, the code has no
idea that we're actually doing system suspend. Thus I'd need to pass
that information somehow, probably with a global variable.

And while that's not difficult to do, it sure feels a bit ugly.

I think I'll just change the pm_runtime_put calls to sync versions for
now. I imagine the perf impact with the change should be negligible.
I'll return to this issue after the devtree adaptation has been made, as
it changes the child-parent relations of the dss related devices, and
perhaps managing the PM states will also get a bit easier.

 Tomi


--=-lUnpAK4ziYQTPR4NiRGq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPGRS5AAoJEPo9qoy8lh71iZ4QAJdkzBfBBUFUtMQXWmwi/FK6
1jcR4Nt7qKgRjsdvbZpRCLPVzFMRCfGuBsBANXbKaSlMXYeAtcUzkpoUfR8FXmdJ
8xFYkozoDO4dn/iFn7TRfLQMcoeGkQWABw2ZzAOyAap2/4oFHEwjU7dSQ0CaZ+hu
BJr32776GmafEZGpEpjpHdrl1YlfmCfwWWN83uXIt/3Qf2FjqHPxpPzIPqrd/sLW
gh6GfIn/7rhwgoTM+x31iEzY/CN3beZJiwC49QXJ4TDHSQjHa0T6sIT2b1xwrTLE
TF9VLQJdjkeeD5cwxuG0KE1UmRFdg+Tr90beql91tvmoesNP6a3112eZ9puh4pZD
tGD46VZNmKqik2gmkRrEqD32k8QeeK3dEN30V4LrEMnZ6xHEup8CXdzi7HJgbbLm
YNkAvxKvCbYFQuZwAZKMnkSg+W9FMHRpKa60zUlHkaZev0mfdrNHBKF0MvIV4ipv
KS0gOPXb91k0SMHNjEcjs0p6jp07e0K6ZqXg4W+ouGlL5PjB6WjT9Yzk9M9oyEGB
y9Jq3XqyScyKY2vuYbCPvg2icNA6ZQQeH3FpDsz7Nywb4eBgTjkKgxjnlSwHr9Zk
z+2D508H/E4RfyE1EQoswUjpEUcrmf0EaVXq/X8cmAUrZwdSIeoRl+7QU+0wPdbt
yzjnUa4yf36e3kzA4L4t
=3FST
-----END PGP SIGNATURE-----

--=-lUnpAK4ziYQTPR4NiRGq--


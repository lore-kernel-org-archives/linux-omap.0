From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm: omap: fix: Defer probe if an omapdss device requests
 for it at connect
Date: Fri, 20 Sep 2013 11:55:10 +0300
Message-ID: <523C0D6E.30701@ti.com>
References: <1379502502-8781-1-git-send-email-archit@ti.com> <523C02C8.30207@ti.com> <523C0BFE.5010409@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="r7lmgKDxvwpxfTwOd4BssrhmuxODOKHoL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51333 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112Ab3ITIzN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Sep 2013 04:55:13 -0400
In-Reply-To: <523C0BFE.5010409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: robdclark@gmail.com, linux-omap@vger.kernel.org

--r7lmgKDxvwpxfTwOd4BssrhmuxODOKHoL
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 20/09/13 11:49, Archit Taneja wrote:

> I suppose we would hit this case if all of the displays are deferred
> because of some dependency and are probed after omapdrm probes.
>=20
> Is that the case with beagle-xm?

Yes, DVI is probed after omapdrm. There's also analog TV out on beagle.
I'm not sure why that wasn't ready earlier, or was it available at all.
I didn't study it further.

If the analog tv would've been available, omapdrm would have started
with only tv out, and DVI would have been left out. So it's still not
perfect.

> I think we need to move this from pdev_probe() anyway. I don't see othe=
r
> drivers doing much in pdev_probe(), they do most of their stuff in
> dev_load() itself. I'll try with that along with disabling of the
> dssdevs in encoder's destroy.

Ok. The dssdevs are disabled in omap_connector already, though.

 Tomi



--r7lmgKDxvwpxfTwOd4BssrhmuxODOKHoL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSPA1uAAoJEPo9qoy8lh71La0QAIOIqWlJWcXOGuQYP7kK4iGu
uGLbd4NE5dCYAWlg2QbNcpAJI8AqpSAa+uvv6ZzEqCJJZQtvpmvj2wgMEoJRFzEL
3sntEBZbl+n4FM5M5hk+rgmQ5vhlnmRtb4GoieHtsyGSNJeD1jSqwIqklC0PPNdd
SjZvz8+LVgnul1B4g2vSDz8eZCGbeH9iJe1eYQLNeiWhOxjxkMqM+qIOJufY8w6o
WTUVAwVrfJRAcv2ZAOcIet+p2+leilzksDxI5tb1zmsgdv8Oansx5+EtRiHvaFY2
RSaogKprF2PPWBHyL48zlVvphYlVB3VIJzxWc16BHS0jiXp0BEbna2w5F8344qOS
IeShr2VPMwxvXjoRZ1WqWaQU+YbnqE754aDPkNUKjO1MEdIii8EoWPBX0GEwrtF0
fz7WWKSVXise9AIBo25vZ45AjgtWhSTkj5FCw3cR2kS6L6JDDkjpgYMI50i2QeWM
wTSJvBSC5qTWuFlIWtJAR9Sh57K5a2YWweyoAUAG0slATz+PMPmv+Fu+HJUYcHQ9
uNJWuAk/m8AkdKl19UZQ13YuC+VEC0NLEv6gh2uVlMzyzlpk6rU1KenCuEdtprt4
IUFbJ9j/3BVBFwBHn7QGYJSu0lgBdy0wBqzo+bqaF4qqtxfo+/x7R9LbZFHusGUJ
ZB0SW/MM8hsjjGRw+BVl
=WJ08
-----END PGP SIGNATURE-----

--r7lmgKDxvwpxfTwOd4BssrhmuxODOKHoL--

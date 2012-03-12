From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS pwrdm usecount, disabling autodeps for DSS
Date: Mon, 12 Mar 2012 11:00:47 +0200
Message-ID: <1331542847.2097.4.camel@deskari>
References: <87r4x27gh0.fsf@ti.com> <1331291641.1927.38.camel@deskari>
	 <alpine.DEB.2.00.1203091055150.7039@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-ErZ8N0TqJDKOstVDCrTq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:59547 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752793Ab2CLJAw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 05:00:52 -0400
Received: by mail-lb0-f174.google.com with SMTP id gm6so1135744lbb.5
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 02:00:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1203091055150.7039@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>


--=-ErZ8N0TqJDKOstVDCrTq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-03-09 at 10:57 -0700, Paul Walmsley wrote:
> On Fri, 9 Mar 2012, Tomi Valkeinen wrote:
>=20
> > I didn't get very far with the patch =3D(. Tested on omap3 overo, with
> > -rc6 based dss tree.
>=20
> Thanks for testing and the .config.  Probably the best thing to do in the=
=20
> medium term is to fix the hwmod iclk handling; I think that will also fix=
=20
> the DSS autodeps problem.

Btw, I don't know if it affects omap2/3, but I'm making a change with
the dss hwmod devices so that the dss_core will be a parent device to
all the other dss hwmod devices. This solves the mess on omap4, the
modulemode bit, and the sequence in which the dss clocks need to be
enabled, as dss_core will always be enabled first.

This requires two patches for omap_device, "ARM: OMAP: remove
omap_device_parent", "ARM: OMAP: omap_device: Expose omap_device_{alloc,
delete, register}" which I hope are going in in the next merge window.

So, it may not affect omap2/3 in any way, but just thought to mention.

 Tomi


--=-ErZ8N0TqJDKOstVDCrTq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPXbs7AAoJEPo9qoy8lh710XEP/jZp5GPmwGypvakemQTiVNft
qTRA6OYxDbU1L+FUQD4TEtdrTuA2oFk8q7ipGEgTVJq6/qDu97NhHoMs+DumHvoG
1kIg0M69fCZwSvAXjCvdBaozBoMaTStrYyRyDryLGe+Kzn4WrlGq7n1mh6eqSQoH
5myXtm0OFuXKOaR0i1db0lSTyKuI6Qzn+kvR0+ptGYCv2EkywVv2t4UfMGpnxhUV
8J2zTAk3oBgmSA82BzP/9MyAQ574Jdc7J3qYfgv1GBMN1Ixl5tV+L5lQxUuREwvZ
Ov/Sn378P2C/dExW25AdNJvEhoa4O0u+JID91HKK7OQJ0F+hiXgke5j8M/lb4iPL
rWe6eWUpMy3hBM5Xdd6Rquo1Vzn1/PEYTM039YmdjVAnUkUNGLDfonyNgEhdWuVZ
/eTPuv6qpUxqCY9x3DRETQo96xH247H2mc4Q3aDhozqs5IZ9gj0bM4eM3qxichsL
lYMGyrdx44XnjDzOyyERyckJ1DmK0CWpVyiPe0EcJop8Tb1ccjWNKkxkpg/CI8gk
QM3liG8J1CH7Frb+P48LvYjd8S1S4O8Kbl9BtPmSjHWMKv70HMN9zg0wzpbdesq2
GSOI6ZdQAHN7T6H8LGK2P7/U3lL2p0bYD2Y5spaH6yyYHSR185Ko12uBPXi9sQi/
2RmvDUQL6TSGWINFbXxE
=/h/N
-----END PGP SIGNATURE-----

--=-ErZ8N0TqJDKOstVDCrTq--


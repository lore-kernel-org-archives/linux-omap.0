From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 08/65] OMAPDSS: remove partial update from panel-taal
Date: Tue, 22 Nov 2011 14:32:10 +0200
Message-ID: <1321965130.1887.46.camel@deskari>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
	 <1321953724-6350-9-git-send-email-tomi.valkeinen@ti.com>
	 <4ECB8D39.4000005@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Hw62SVb8fVt252pLSmQF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:42876 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750851Ab1KVMcP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 07:32:15 -0500
In-Reply-To: <4ECB8D39.4000005@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com


--=-Hw62SVb8fVt252pLSmQF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-11-22 at 17:23 +0530, Archit Taneja wrote:
> > -     r =3D taal_set_update_window(td, x, y, w, h);
> > +     /* XXX no need to send this every frame, but dsi break if not
> done */
> > +     r =3D taal_set_update_window(td, 0, 0,
> > +                     td->panel_config->timings.x_res,
> > +                     td->panel_config->timings.y_res);
>=20
> How about sending a null short packet, and a BTA after that. This
> will=20
> keep automatic TE mode in place, and we'll need to send 1 short
> packet=20
> instead of 2 long packets every frame.

To be honest, I didn't spend any time with this. True, sending a null
packet and BTA instead of the 2 long packets is possible. But probably
even better would be to track the TE status, and send a BTA only when
needed.

 Tomi


--=-Hw62SVb8fVt252pLSmQF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOy5ZKAAoJEPo9qoy8lh71euYP/2oabFOKxDkjqxTbCCBVSB6t
Q7loyosJLTtoK0JI4M8A5YRHmglCo6BGeUSvXFLdC9b62qJ1Z/e+GXXLXW2NEawo
5y98M6QmcIkwtLS/wLy8oeTFnIdXZJOGfKA0VoDR2vQ8mRQVPybottsLW0NgVW1y
gP+62CPo+cCMAfjbtn+dIpOA6fDJPy2BdodnyJg+o4thtuYRCKZcxQJwTJghWHfV
bsbWSHKgebS7U2LvqTEhWASTQN0rKm+tBqYErDEMtEV3WRrInM8IWYn6aWj+0yvB
2eXw9ol0PORYa6q9Afv/d8jRDlMYjSqHl6yzcqJnCLDx4/WRpFIYUHY0nxsODN7c
oPYACrAvmS51GJr+O0h2Sqv6FqQOq9l2VgTB2Q6j/TCVVF1ZKJ2wEU6aeraYF62s
eDDLGLWD972hVYNHc3aZt76+xoIOK2HcByvJvVDibBmb32cqn6N/BGhvRFrvKc1B
yYH19irbpnxNfbBABSHySwJ6S2xy6YOPTWorN3lQ/xPldJyTC/BON6AVws5pCeyi
DQhKokRvSb1/mkkAcmqLdUwzMooSCbBR1iFP0s9fkKmDD4TXOxAS/DsAQrLbJNGt
3M3OHLvr1/6wpwwBt6qeEOorpMms8S6/oOrfvCZrVtk3jQI+8Tsg4Njxn3lHbVqD
s5+zp1uDM7e9UYlug6nD
=cTqZ
-----END PGP SIGNATURE-----

--=-Hw62SVb8fVt252pLSmQF--


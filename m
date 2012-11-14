From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH] i2c: omap: Move the remove constraint
Date: Wed, 14 Nov 2012 11:57:34 +0100
Message-ID: <20121114105734.GE5954@pengutronix.de>
References: <1352195673-31559-1-git-send-email-shubhrajyoti@ti.com>
 <CAORVsuW_VAiemnauUs-yW+GcQpv+qpESP4kzyQm=Unmofa4k_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X3gaHHMYHkYqP6yf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55199 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab2KNK5g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 05:57:36 -0500
Content-Disposition: inline
In-Reply-To: <CAORVsuW_VAiemnauUs-yW+GcQpv+qpESP4kzyQm=Unmofa4k_Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, b-cousson@ti.com


--X3gaHHMYHkYqP6yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Currently we just queue the transfer and release the
> > qos constraints, however we donot wait for the transfer
> > to complete to release the constraint. Move the remove
> > constraint after the bus busy as we are sure that the
> > transfers are completed by then.
> >
> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>=20
> Good catch, the change definitely makes sense. Feel free to add:
>=20
> Acked-by: Jean Pihet <j-pihet@ti.com>

Since I just reverted the QoS patch, I suppose this gets merged into the
original patch when resent?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--X3gaHHMYHkYqP6yf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCjeR4ACgkQD27XaX1/VRuJogCfRvZ3l1XfWHZvGFR5PoraYtNK
mC0AoI+oiVsw/CsWG8yTQySPmd+eHcTm
=VNS8
-----END PGP SIGNATURE-----

--X3gaHHMYHkYqP6yf--

From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 06/12] ARM: dts: AM43xx: Add aliases to d_can nodes
Date: Tue, 09 Sep 2014 17:08:54 +0200
Message-ID: <540F1806.9000302@pengutronix.de>
References: <1410274534-22826-1-git-send-email-rogerq@ti.com> <1410274534-22826-7-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="orGakVKpL2QXt5Tvo8PWaBUT1vjl8trHl"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52006 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbaIIPJG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2014 11:09:06 -0400
In-Reply-To: <1410274534-22826-7-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: wg@grandegger.com, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--orGakVKpL2QXt5Tvo8PWaBUT1vjl8trHl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/09/2014 04:55 PM, Roger Quadros wrote:
> The d_can driver expects appropriately named aliases for
> the d_can nodes for the RAMINIT control register access.
>=20
> Provide those, otherwise RAMINIT register won't be configured.
> Get's rid of the following messages during boot.

With your patch set this is not true anymore, is it?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--orGakVKpL2QXt5Tvo8PWaBUT1vjl8trHl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQPGAYACgkQjTAFq1RaXHO+UACdH4E3E7bHc5I+hvsJwUi9RZ3d
kC0An2fyayEoVC267k6hUjGZ12thMblN
=+wrx
-----END PGP SIGNATURE-----

--orGakVKpL2QXt5Tvo8PWaBUT1vjl8trHl--

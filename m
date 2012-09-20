From: "Maximilian Schwerin" <Maximilian.Schwerin@tigris.de>
Subject: AW: AW: USB problem on beagleboard clone
Date: Thu, 20 Sep 2012 09:40:06 +0200
Message-ID: <5448984682E7954C9BFF27F747A9C6CA56E36F@dolphin.TIGRIS.local>
References: <alpine.DEB.2.00.1209191557210.5264@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-kFm+axe3Qd9+ohHAl8JB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www45.your-server.de ([213.133.104.45]:38150 "EHLO
	www45.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab2ITHmX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 03:42:23 -0400
Received: from [77.12.97.12] (helo=IT-AstaroSecurityGateway)
	by www45.your-server.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.74)
	(envelope-from <prvs=0610406807=maximilian.schwerin@tigris.de>)
	id 1TEbOt-0005Cj-OM
	for linux-omap@vger.kernel.org; Thu, 20 Sep 2012 09:42:19 +0200
In-Reply-To: <alpine.DEB.2.00.1209191557210.5264@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

--=-kFm+axe3Qd9+ohHAl8JB
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> -----Urspr=FCngliche Nachricht-----
> Von: Paul Walmsley [mailto:paul@pwsan.com]=20
> Gesendet: Mittwoch, 19. September 2012 18:07
> An: Maximilian Schwerin
> Cc: linux-omap@vger.kernel.org; linux-usb@vger.kernel.org
> Betreff: Re: AW: USB problem on beagleboard clone
>=20
> On Wed, 19 Sep 2012, Maximilian Schwerin wrote:
>=20
> > They're BeagleBoard XM clones. We're still trying to find=20
> out what the=20
> > real problem is. The problem persists across three separate layouts=20
> > using the same USB device and application. We're currently=20
> trying to see=20
> > if this is related to MUSB only by using an EHCI port on=20
> the same board=20
> > with the same device and application.
>=20
> Perhaps you might try this patch:
>=20
> http://marc.info/?l=3Dlinux-omap&m=3D132976109928744&w=3D2
>=20
> Background is here:
>=20
> http://comments.gmane.org/gmane.linux.ports.arm.omap/71633
>=20
> The patch is for an EHCI issue, but MUSB is clocked from the=20
> same DPLL.
>=20
>=20
> - Paul
>=20

Thanks for the hint. I had this in my 3.2 kernel which also failed. I'll =
try if adding this to 3.6 has any effect.

--=-kFm+axe3Qd9+ohHAl8JB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAlBayNgACgkQ6nqkzTWctv64qACgkKhwLR1xWfaN0Ugqfn+wevIl
FPIAnRzSeq93hb61dKNU8yBlFY3zoDMv
=nMc8
-----END PGP SIGNATURE-----

--=-kFm+axe3Qd9+ohHAl8JB--

From: "Maximilian Schwerin" <Maximilian.Schwerin@tigris.de>
Subject: Multiple NAND flash chips on OMAP3
Date: Wed, 6 Jul 2011 10:05:51 +0200
Message-ID: <5448984682E7954C9BFF27F747A9C6CA4EAC62@dolphin.TIGRIS.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-/eIpySI2VYjlzTPz6crW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www45.your-server.de ([213.133.104.45]:53546 "EHLO
	www45.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab1GFIg6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 04:36:58 -0400
Received: from [217.91.135.48] (helo=IT_AstaroMailGateway)
	by www45.your-server.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.72)
	(envelope-from <prvs=0168d4b72f=maximilian.schwerin@tigris.de>)
	id 1QeN7X-0001ki-EW
	for linux-omap@vger.kernel.org; Wed, 06 Jul 2011 10:06:07 +0200
Received: from dolphin.tigris.local ([192.168.0.10]:1053)
	by IT_AstaroMailGateway with esmtp (Exim 4.69)
	(envelope-from <Maximilian.Schwerin@tigris.de>)
	id 1QeN7H-0000ZR-2T
	for linux-omap@vger.kernel.org; Wed, 06 Jul 2011 10:05:51 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

--=-/eIpySI2VYjlzTPz6crW
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm currently working on a beagleboard clone that has two NAND chips on
OMAP3 CS0 and CS1. The flash on CS0 works as expected. What would be the
correct way to get both chips to work?

Thanks, Maximilian

--=-/eIpySI2VYjlzTPz6crW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.8 (GNU/Linux)

iEYEABECAAYFAk4UF2kACgkQ6nqkzTWctv43rgCfUNYiYIvwqQYDoWzzAPS7GQaG
0oMAnjBU2ZYC2VUBoNwaWPSW6anipCLO
=aRtf
-----END PGP SIGNATURE-----

--=-/eIpySI2VYjlzTPz6crW--

From: "Maximilian Schwerin" <Maximilian.Schwerin@tigris.de>
Subject: Beagleboard xM crashes when being set to 800MHz with smartreflex on linux-omap-3.6-rc6
Date: Fri, 21 Sep 2012 08:45:16 +0200
Message-ID: <5448984682E7954C9BFF27F747A9C6CA56E38E@dolphin.TIGRIS.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-mP/it4MoxKS3XaOAntn5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www45.your-server.de ([213.133.104.45]:39330 "EHLO
	www45.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab2IUGpZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Sep 2012 02:45:25 -0400
Received: from [217.91.135.48] (helo=IT-AstaroSecurityGateway)
	by www45.your-server.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.74)
	(envelope-from <prvs=0611d79f6e=maximilian.schwerin@tigris.de>)
	id 1TEwzM-0000DD-59
	for linux-omap@vger.kernel.org; Fri, 21 Sep 2012 08:45:24 +0200
Received: from [192.168.0.10] (port=2262 helo=dolphin.TIGRIS.local)
	by IT-AstaroSecurityGateway with esmtp (Exim 4.76)
	(envelope-from <Maximilian.Schwerin@tigris.de>)
	id 1TEwz8-0006w1-0A
	for linux-omap@vger.kernel.org; Fri, 21 Sep 2012 08:45:10 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

--=-mP/it4MoxKS3XaOAntn5
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I've just built a linux-omap kernel at 3.6-rc6 using omap2plus_defconfig
as basis for the kernel config.

When I enable smartreflex and switch to 800MHz via

echo 1 > /sys/kernel/debug/smartreflex/smartreflex_core/autocomp
echo 1 > /sys/kernel/debug/smartreflex/smartreflex_mpu_iva/autocomp
cpufreq-set -f 800MHz

the board crashes. If I switch to 800MHz and enable smartreflex later
nothing happens. This used to work in my 3.3 based kernel.

Regards, Maximilian

--=-mP/it4MoxKS3XaOAntn5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAlBcDQAACgkQ6nqkzTWctv74yQCgwk5ZUDEP3lLJAuNbm/uFuJyU
2yIAoL22UIzyy1ugNLv8M0+K/U9ofUNY
=mGos
-----END PGP SIGNATURE-----

--=-mP/it4MoxKS3XaOAntn5--

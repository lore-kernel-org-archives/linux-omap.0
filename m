From: Sebastian Reichel <sre@debian.org>
Subject: rx51 platform code for bq27x00
Date: Thu, 16 Jun 2011 13:23:23 +0200
Message-ID: <20110616112323.GA31389@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comu.ring0.de ([46.4.151.82]:44562 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754495Ab1FPLXk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 07:23:40 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Mika Laitio <ext-mika.1.laitio@nokia.com>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

There is a battery driver for the N900 battery in the mainline
kernel, but it's not exposed in the rx51 board file. I found an
existing patch on [0]. Can this be pulled into the mainline kernel?

Mika Laitio: Can you send this patch to the linux-omap mailinglist?

[0] https://build.pub.meego.com/package/view_file?file=linux-2.6-omap-rx51-bq27x00-i2c-address.patch&package=kernel-adaptation-n900&project=Project%3ADE%3ATrunk&srcmd5=8ca3e6ef69d03055c4046e47e7bf6391

-- Sebastian

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJN+eeqAAoJENju1/PIO/qaRccP/Ruz2MeZAe597sbuES8U/wBH
mTA6OTJmuZVBD+BeXvmX6443sO8+qbdpkOwor1WbEC0d3dxqjM9A47areP8ZBXzW
GqLolBHpIXltQAPSNquGqLJlul3/DrxwUkuEau6famrVi0uk+ObOHlQsItlqY/JS
UVmqF886ljc7OBtCvJJl+FEbNXq9xMUoE4yH1VNc6eA5kHL5Jmhq89IsfMQvEAvu
/ggAGftkkRdZfRgyEpSqxLAPqAgs0JDlp7EPTQHVuPfBZHkwHIimMEiOEa6NQ6gN
aDmp/ewRHk9W5OzVoV0ucy8jobpe0a22oUjFOU0E1ypSiPGYw1XhOH6LLLNrqeCI
ddMBt7r5BgwEqXHif7VGKwRSzcIqEZGhAWLxJekBPOibCIrBl9EK84voTBCuRIdS
vyXLtucvef8GfirrhRmsTDLx9WdEFLIYBpkaxUU0OiLQGccmSxKR0hsr3Qi9HAoQ
DKTsQKY00L61VAyfeI/hn4h2aZ8bAH5FSpaVWjb23cheL5CrxwHe0vE4x5GFPMuu
OKS40svQH8cqSBv0rzkhSbXopnO+g3ZFzYWKD+0A312rnmJeBdQzaD471X7ZD41t
Kw8czx4hn1VpFIHYNxxFNVx7FXx5h6P0wBj9j+tbzb98zRgFlyFVrCsLOwROkUHP
DtTcj5WV7Oy71TS2TbFk
=PAwc
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

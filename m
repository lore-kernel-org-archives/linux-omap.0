From: Sebastian Reichel <sre@debian.org>
Subject: Re: It looks like snd-soc-rx51 only works as built-in, not as a
 module
Date: Sat, 10 Dec 2011 09:27:44 +0100
Message-ID: <20111210082741.GA32605@earth.universe>
References: <CAMP44s1DPE3ey+Cf48ShbAu_-vv2NC8ppkABT7fDmsE3_j9AmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comu.ring0.de ([46.4.151.82]:45337 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428Ab1LJI2D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 Dec 2011 03:28:03 -0500
Content-Disposition: inline
In-Reply-To: <CAMP44s1DPE3ey+Cf48ShbAu_-vv2NC8ppkABT7fDmsE3_j9AmQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Felipe,

Using RX51 audio as module works on 3.1 mainline kernel after loading
the following modules:

$ modprobe snd-soc-rx51
$ modprobe snd-soc-omap

-- Sebastian

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJO4xf9AAoJENju1/PIO/qaxZkQAIaqC5SBXhd6QbF0sPFpFxHK
M/6duQuef/ltDqrATcaZRGd+TcER0Vmvyo5m7gLXOYtyp97oEJflCd/2l2ajAV2+
m4y807sUNf6w94T/4jG1uN084KmhJG9Qf+fcd38xcXsK/ASLA3i4yCbkFQyxY/NW
letNnqh4oj2z54ozMFvM7/gj1ircWO7frU53xhPNLFF3mvYxGHPlvb6vVqfRILxb
O3eO3aStUlO07J8sEzsnAv9BnnHvs7f4o+K5npyonzQ73qeNTefE9qpkCZn5rLWL
1xoXQ7RD2WlPDdHTCW73ivcHywYKHoJH+Z0yVnUCQnw0eFjvRVuQ4b9zFR6Qobni
2aYeoWJcMb3F488Vt4PFXFz+lsU1UZhgwB0FalkTsjvwdY1CdOhu4WQjnPrJoTCD
It4hUe3HfcCLCMhblGG6Vq05c/0afoyH2yfy5FDZ0cfgGJN7k88YjoIxpvTXhBRl
+WtnIFjpBQ2VplnW38CxQwJpdjg260OgVfGW/WhfhqOdqt7WNfCvjmk/iyGeeDjx
afbStEFOC23iU7cJ9TJHkhLv6JzTuTCFTPnWkjmfK2/W8sMc4AviybYsH1ejdkYE
jgSfDyWaCeP/aBnWbcL/LlL4JvFQvSOZz7pguXHuPNVsd5+KOhcFPWsUOq010aAu
l9C0AlkqcMqpgaQX2N3u
=iOx2
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

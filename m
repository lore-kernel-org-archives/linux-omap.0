From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: tpo-td043 panel: fix data passing between SPI/DSS
 parts
Date: Mon, 18 Feb 2013 10:40:20 +0200
Message-ID: <5121E8F4.5090707@ti.com>
References: <1361061792-2350-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6EE5F5303265013AE3C13BFB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37235 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752500Ab3BRIkX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Feb 2013 03:40:23 -0500
In-Reply-To: <1361061792-2350-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

--------------enig6EE5F5303265013AE3C13BFB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-02-17 02:43, Grazvydas Ignotas wrote:
> This driver uses omap_dss_device that it gets from a board file through=

> SPI platfrom_data pointer to pass data from SPI to DSS portion of the
> driver by using dev_set_drvdata(). However this trick no longer works,
> as DSS core no longer uses omap_dss_device from a board file to create
> the real device, so use a global pointer to accomplish this instead,
> like other SPI panel drivers do.

Thanks, looks fine to me.

As a side note, I'm working on removing the omap_dss_device stuff, and
after that change this driver can be a plain SPI driver. That should
make things simpler.

 Tomi



--------------enig6EE5F5303265013AE3C13BFB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRIej0AAoJEPo9qoy8lh71QKcQAJf7bV8Q42vIMriLjUELAlWC
abynTt6sxCigesoMrz8EGg4N/CB48wLJr4t2RddDu0dOZtsAVdFIZKoVC9XdxETR
Jd9WoZbGlOrKPnX+z09ZmrrW7iUcB6Zsn9C/E4BCqaDhC966DVU/gw2d9IC6HYDz
um3zSTf0OqVP1ya8t988JEpnAeiAvRHyAPtsheMGGpyjK0uMTq875wlzaeWNjI9H
oyQmZ2P7QywDbJY4EIpbCBMJfeDCNW1mIe4wACal2h9PwdanCNl59IdFG9dn70ro
diD5ATrNpRaXI5gLeFjcDy58+4qA05XRWIuqoaDtrqhJWaVKb5NEU7OIwy7WsH9a
LX/09TXrJtWHDueJD9jt14YjyYS0em0QY9vEt4R2gcX8PAkzks41NrKviLiYfXpW
d+x47mrJQ4djWnK9h7aaQ+M3lV6tk7EJh8u1Z+EGisZidkyZMDjD2JTKFv9kaxL4
JBqQ4Gb16gJaLsusX/wQ6wkC0S0gRni+SS1jKwzcL7rBzJ9Gk5phrzFzgFTLhN7F
1+AARi1ijI2pkwRPrRe0Rj9y8Rb7JE39+tYK3kAT6Kun515k/NLtRM7ieoQHob+0
LTqoO+1s/O5tR77qA7UF5+aEj6UWhJ6PzWX4w2O5/+jQ6zWhL0xmegJZpi99flNP
P3weoyrK7V4rQSwEPMpQ
=PHVV
-----END PGP SIGNATURE-----

--------------enig6EE5F5303265013AE3C13BFB--

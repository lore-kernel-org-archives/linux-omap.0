From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 205/493] gpio: remove use of __devinit
Date: Tue, 20 Nov 2012 10:33:06 +0900
Message-ID: <20121120013304.GM4483@opensource.wolfsonmicro.com>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-205-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2YJj5f1P6Th4nBRw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:56976 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751987Ab2KTBdP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Nov 2012 20:33:15 -0500
Content-Disposition: inline
In-Reply-To: <1353349642-3677-205-git-send-email-wfp5p@virginia.edu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, Kevin Hilman <khilman@ti.com>, Linus Walleij <linus.walleij@linaro.org>, patches@opensource.wolfsonmicro.com, Grant Likely <grant.likely@secretlab.ca>, Peter Tyser <ptyser@xes-inc.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, device-drivers-devel@blackfin.uclinux.org, linux-omap@vger.kernel.org


--2YJj5f1P6Th4nBRw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 19, 2012 at 01:22:34PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--2YJj5f1P6Th4nBRw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQqt3IAAoJELSic+t+oim9D9UP+wUV4vR/oZACNxW5q56kjCpr
612yCmZcINvUioR59u4f0MCd0oW9YJJF0bINVhFxbXxT28r6GHJdZKj5hIp3rfCM
XrLJkyH5VHBDifmU6aA/u1bdGz+lufdZkbBaReEErPCcSJsZSU3N6iVXpLIRTVPn
914uNtW0gv2Z5u41czvBx6w2DUO0HjGqpzLdyyyisVS+szfOTzyykqGHmVm5aXIY
/bSLYrV3gbHdIpTCUFTziZIgxLoEsMHD+TML/gGruDg6HuNkxhz4kjeuIdPGfWbt
ReFExNt0sXjYuZi6tyv2Em7EktQHszdVHypclrkZZMcXJkcvRKmHaVF3gTgSShJ6
nl+wDOX3lCpC7J9tIDDbVudJD6NVskwiFCqGTVCbE9XxoWk84SB8qjgrR56kVzRQ
heA/3AbRjI4BF+kbA/Y80R2ZVEJ7bu6fM8WutkVRSBNQYe0aMqewLURkLKQF/7nh
LgAR/gyJzihoDGTeddKtTYkprlAfyzhCpoqs4mwnGPbLrQnJB9CEinCQUWyr2yFL
dIrl3QdNn9yIRUqxSxxJXe4RkD2/nkatvU/KtOCf6iA2kWI847M5BSQBXF4Ce99I
Y2lgDzJ5fkWJTkLp+QzXasO1IYj9EAzgu+l0Ykoxf1N6F+jEMFIW2jvHw8astULK
lSR5og4FIZ+LW2shgHzD
=p6uz
-----END PGP SIGNATURE-----

--2YJj5f1P6Th4nBRw--

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix build error in sound/soc/omap/n810.c
Date: Fri, 10 Feb 2012 11:38:47 +0000
Message-ID: <20120210113847.GA6472@opensource.wolfsonmicro.com>
References: <1328856877.27353.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:33175 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758808Ab2BJLit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Feb 2012 06:38:49 -0500
Content-Disposition: inline
In-Reply-To: <1328856877.27353.1.camel@phoenix>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lrg@ti.com>, linux-omap@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 10, 2012 at 02:54:37PM +0800, Axel Lin wrote:
> Fix below build error which is introduced by
> commit 022658 "ASoC: core: Add support for DAI and machine kcontrols".

Applied, thanks.

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPNQG4AAoJEBus8iNuMP3dQ4AP/2nZPRfyDJIaaTeoNVTdGtmC
MnFjopKzE89wpCXCYRpAvwNl5tF4v9dpUCcoAaFkje6VkEwSYl0r4DUkzHQMQGnz
Pw5NTrtUew1gCnOUEKErXJEmtfzCdDVhbRbbgH4JNACTLFyukINHodMJDAGTQO9i
w6MmjGPw7KIZgU9Ao61bLXjrhJkJ4HwEV2BWQ8hA8iyD0UsYZY/ODOwwdM8vQxUL
hoGB0UdH8dO5340H7uqavmZAxydhruA/NQAPMbxyVEfVi0ECrR/UqlRrmGlOKSlo
Qy5GlzISPXzH3ZPkEZ5b2Q1RiECnYFya3OGAY4eMaJVtTRlaEqlmhiQiOIukGDNq
PPpsK4JG98tgbMsPtOusiqzU7jzgBggsN6tf8cYQYeUF3MyHmViWkaGS1leFTIug
k1C7Z1brCiVXW/4QA0aQqvx7a9uUSsPFU2Vj+HPrQiAlPvm04Sk57i3gcJ96uxgj
RDmduqHl3KFHUPzNQ/SUHWvgogUK9uYu5kEQOI3vPWfMXFMsMwD/Pc/CJcOCDFDQ
GHdxkJaNNOKCQAaZIGTf02tTMHufzoP/4Ut4NMRxsYb+BtQcODnfidAwVyf7/vPe
Jtb/VhNY3XMAyJJLlK0IGjzaOhyxAyqEIFRnfZnOB0KnIJd31IWDXvWZguLEFUS4
CYJnnOiA7bOYGhtqcDNg
=T7X+
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--

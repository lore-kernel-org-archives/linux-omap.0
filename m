From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/4] ARM: dts: Add LCD panel sharp ls037v7dw01 support
 for omap3-evm and ldp
Date: Wed, 28 May 2014 09:34:33 +0300
Message-ID: <53858379.4050401@ti.com>
References: <1398815562-24113-5-git-send-email-tony@atomide.com> <CAGhQ9Vwa8xXQEo5dNEKAvmaS9DoBjVSthtd8=owk+atVdFuiiA@mail.gmail.com> <20140430174751.GA12362@atomide.com> <20140505183919.GA15463@atomide.com> <20140508233628.GJ2198@atomide.com> <536C7EA7.5000306@ti.com> <20140509153723.GD17814@atomide.com> <20140513213205.GB18001@atomide.com> <537C9FC6.8020104@ti.com> <20140521145053.GG17417@atomide.com> <20140527205910.GE32336@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="GqAk0cWqsK2d11Sq7VxJ7N8nlXimBRmWI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53280 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbaE1GfH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 May 2014 02:35:07 -0400
In-Reply-To: <20140527205910.GE32336@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Joachim Eastwood <manabian@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>

--GqAk0cWqsK2d11Sq7VxJ7N8nlXimBRmWI
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 27/05/14 23:59, Tony Lindgren wrote:

> In case you did not yet do it, here's this patch updated for you. I'm
> assuming you'll apply this to your panel dts branch. Let me know when t=
he
> dependencies are in linux next and I'll test it one more time. The omap=

> changes finally hit linux next as of today, so I'm only doing fixes
> and minimal changes for now.

I haven't pushed the dts changes to linux-next as the base branch was
missing. Now that it's there, I have pushed the DSS dts changes also.

You can do a manual merge if you want to try before linux-next is updated=
:

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git for-next

 Tomi



--GqAk0cWqsK2d11Sq7VxJ7N8nlXimBRmWI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJThYN5AAoJEPo9qoy8lh71TjcP/1Bc+EQ+fwDSDr2dkyUyk6Am
Fn867ZdIQVuhtemQz2cl59+B4e665AwdRQD+HK9n7RuH3pD6ddtmvt4jM8aioq9R
iRFjRmVoeznky/c22zdyUj/VrJ8lmAflZe4oJK6xIzXSPD+UzaQVqrQCtVHNXsQW
VbZLacY/CecnxdZWjZD5y1+r3zFUSN2VHfXemxfP2phsPu2YN4IWQTvL3B+BHyh/
Dtfx1xhSaoUC8dL6KTw2pNoPJJ6+QYvMUP94iqP2bKcPt//T5nRmCPtMVAD3QHLL
IMH4onaE+wRYbbGVjYM5J63inM03eoVvVNunjWa6QU4ZQIwO8QMsLkTOc4rt+I2f
/fsz16lhRDVxdiBsFZXJ33dbL7n7HEgAxQ9SGkvuCa6+P50yB939E+wLiAq3569o
4ZPpm0W0TpIU5WPFV7Ov2imI7UJ3lzh96ra12iAGt6A00SzRZeol3HRnlj8yx+jl
P0ikZIAfCIHXE+n3voSqAwUqrUHVcp4CI8GqeWCqSGGHHq6AZd6OENHmBItgM9r9
Z6uRHjE+KSdKOM02R+iSxxcZxgscPs25zS0OmAvbiWW7ZC8NGjo8nyk6E6xdLVsH
/tYwSA9wI9QbKJagAxCS7no7oSIjoBu8hRo8g2l8stRrb36l/WK7Y84X1K5IjL56
PGbkI1a5aJnZGJksoe6a
=unUc
-----END PGP SIGNATURE-----

--GqAk0cWqsK2d11Sq7VxJ7N8nlXimBRmWI--

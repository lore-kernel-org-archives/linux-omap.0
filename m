From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] ARM: OMAP2+: don't try to register the main clock twice.
Date: Thu, 8 May 2014 09:02:58 +0200
Message-ID: <20140508070258.GA2656@katana>
References: <1396007435-20100-1-git-send-email-wsa@the-dreams.de>
 <alpine.DEB.2.02.1404111829520.14347@utopia.booyaka.com>
 <20140417085539.GA7804@katana>
 <alpine.DEB.2.02.1405072233470.23579@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37730 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942AbaEHHDG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 May 2014 03:03:06 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1405072233470.23579@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: mporter@linaro.org, Benoit Cousson <bcousson@baylibre.com>, joelagnel@ti.com, NeilBrown <neilb@suse.de>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@sang-engineering.com>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I also get this message printed for the d_can driver with am335x; they=
=20
> > have two entries in drivers/clk/ti/clk-33xx.c. Probably as a workaround=
=20
> > to match the desired clock name for the d_can driver? Didn't really=20
> > investigate yet.
>=20
> That's pretty weird.  I wonder where the second fck alias is coming from?=
 =20
> The DT & hwmod data for those devices looks relatively straightforward. =
=20
> Is the hwmod code adding fck aliases for both of the entries from the=20
> clock file?

$ grep 'can' drivers/clk/ti/clk-33xx.c=20
 * This program is free software; you can redistribute it and/or
	DT_CLK(NULL, "dcan0_fck", "dcan0_fck"),
	DT_CLK("481cc000.d_can", NULL, "dcan0_fck"),
	DT_CLK(NULL, "dcan1_fck", "dcan1_fck"),
	DT_CLK("481d0000.d_can", NULL, "dcan1_fck"),

I quickly tried to remove the entries not specifying platform devices
but that prevented my system from booting (Huh?). Still, no time to
really check it, though.

Thanks,

   Wolfram


--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTaywiAAoJEBQN5MwUoCm2MysP/1C7On1TEBgqTnVbLYdP/HqW
ugp44EKfJqMRyFObaqX7Bc6ubyWbxQZjkooipvYhXGciY2IALHJMtxMWFd6S63Zl
3x2b4PWUxb5yLaQVXrckQZLb2EorpjvIbp2DlI4cMZ9/LVLlOCNA0CLY190ATyfW
CVnYzPK+f8dc6qm3kbBuQ9r+wcmDkb3+zDuCxYvDulEq/KnvI/poDFEabLQxBZ7o
5sUQ5k426dGfAsdMjWjGOoojb7+yJ1bwd2XY83nKqfLkSr8Acl2xs5grbqMun3uW
RhGZlQuK1Wg2NK61AR0HhnocIkx2EAZxz1+POgzGd2oTGpDgzfrGzm6278I/4eLs
ojuBXG34OMZoUEHR1IIV5cr9sjYJSwy07MLq2BQFuWCbX2az1Guf1J2u0b026mr7
C9neX0teIo73toGI9NAri2ypdP8hK1emfsKzPLYTZ47xkF0lI8rMp7omBmg95Ypl
HWjxw7WW9Dnc6klveHLKjtYqveKN1CAoDuYNuofoHEMYS3UMKhMl+zamHXJUxqaJ
AKdZ9YwMNmJ1mK4q4nHuATLXQzb2ieebmKRhOdlftfBDgGxvZmmb6ostzjXq5o6R
g4aUoBfrhD9Abx3D/ge5Jo1nwwWHKrdpncupp8fmVOS+7yubOzmAHhlTkz5Gpu/6
4pWB8EvTdXmCH89wwAQn
=h0VR
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--

From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Fri, 16 May 2014 19:41:58 +0200
Message-ID: <20140516174158.GA11733@earth.universe>
References: <20140512155132.GH31772@atomide.com>
 <5371F923.80000@ti.com>
 <CABxcv==_LCw1kPYm17g=h8VfSN2V_qsgXjTnsy-JOetawSv4pA@mail.gmail.com>
 <20140513152518.GA16837@atomide.com>
 <53730AFB.2090800@ti.com>
 <20140514160216.GD18463@atomide.com>
 <537487AE.3060906@ti.com>
 <20140515182133.GC23659@atomide.com>
 <5375A8A8.7080306@ti.com>
 <20140516160717.GD22031@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:60690 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757402AbaEPRmF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 May 2014 13:42:05 -0400
Content-Disposition: inline
In-Reply-To: <20140516160717.GD22031@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2014 at 09:07:17AM -0700, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140515 22:57]:
> > On 15/05/14 21:21, Tony Lindgren wrote:
> > >> But you're right, having "sharp,ls037v7dw01-omap-dss" in the .dts is=
 an
> > >> alternative for the compatible-string conversion we do now. I guess =
it's
> > >> a matter of taste, but I rather hide it inside the kernel, in an
> > >> internal omapdss file, than pollute the .dts files with those compat=
ible
> > >> strings.
> > >=20
> > > Well it avoid you parsing through all the nodes during booting
> > > and leaves out the function to do remapping. And removes the need
> > > for maintaining a custom display mapping table. I'd say that's a
> > > pretty good list of advantages right there :)
> >=20
> > Yep... I don't know. Maybe I'm being too careful about doing wrong
> > things with .dts. I just like it more if any hacks are in kernel code,
> > which I can remove without anyone noticing.
> >=20
> > Anyway, we already have board.dts files using the non-omapified
> > compatible strings in the mainline, so if I would now add the omapified
> > compatible strings to .dts files, those old board.dts files would break.
> >=20
> > So I guess the choice has already been made.
>=20
> I really think you should remove this misuse of device tree code ASAP.
> It's better to fix it up now than carry the hack for next two years
> and keep on adding to it.

IMHO appending -omap-dss to a random device is an even bigger hack,
since its adding lots of bloat to the API. Let's assume there is
another OS using DT for ARM, but has no proper API for SPI
controllers and it introduces your hack to SPI devices. That would
mean each SPI device has -omap-spi appended (or -exynos-spi,
-foo-spi, ...). At least I would blame them for creating a huge
unmaintainable mess.

I think Tomi's workaround is a much better hack, since it keeps the
API clean. If the code simply prefixes "omapdss," to all
"child"-devices of omapdss it can be left mostly untouched, too.

-- Sebastian

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTdk3lAAoJENju1/PIO/qag38P/joQ3hECekb2lctdzrohWi96
JpGW69XruUVOUS1mS+Gx1QXb3uIuexnbIGrFIEuop/y0EWYPLfUzFyk22G4Jt2qL
FQEv8d5il2GSGaiYGPntk3spIfSJmiIBhvr/w1GOI9EsykNBSFwVJPtb3cmtIorz
/h1KPPIsQ1X7omQZMJdxQtvP4FkCWliktcHMpF21swMAjjXWYtbYYjMfR9H8jo/L
ShuIin612hH+QpdzbdOUZZIpFmpPhabjtz38iAm5ix1/lMKJ3aywbfQ9ezUQtIUT
tIYFVaWIh1S8ngiYfq6lknmjqah+UblnAJDgUnv2asIn0NDx+BCLn8G18IUOhUoI
4rd0RvCdGEhLLcEixAyd3NKVEBFeJOpssFi7TrR06dx2SO+SQGniqD5ItG6XZtnC
FGlqL3sWmJkBBn9mh0C7yjFCprkPIICrkjYt6rQpLOlhLX0t4ONbyINm7DYO6aMC
d8Sr2HeWnrbrFEgpVUMV56k/0PZW8gtrjGA3vF1kiTc/PjqaZkh3Bqr8uqJU9XPb
OPULnVKS2J7QAacnGMyny2R9yv4srrNhZhh0ZHfwddQ5KTJQdN/D4mCuaJxIDdAJ
ezzhFVHHTUEnB2wJutvAVfFgzdbjPrI0kK1S/u6X7dPlukuuwjfW3GIvRTSxxWMJ
ejwcgvxq0/4wBnzIB3JZ
=T7Rn
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--

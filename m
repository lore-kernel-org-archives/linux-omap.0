From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Mon, 12 May 2014 10:38:12 +0300
Message-ID: <53707A64.2060203@ti.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com> <1398815562-24113-4-git-send-email-tony@atomide.com> <5369EAE7.3030705@ti.com> <20140507150343.GA9502@atomide.com> <536A5920.1020908@ti.com> <20140507175919.GH9502@atomide.com> <20140508233300.GI2198@atomide.com> <536C8293.4070506@ti.com> <20140509155504.GE17814@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="aN4lrGsNv5aprSa1wEgrbQLIN7hEEnIbk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33270 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385AbaELHij (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 May 2014 03:38:39 -0400
In-Reply-To: <20140509155504.GE17814@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

--aN4lrGsNv5aprSa1wEgrbQLIN7hEEnIbk
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/05/14 18:55, Tony Lindgren wrote:

>> Although if the MO gpio is not controlled by the driver, we should tel=
l
>> the driver whether that gpio is high or low.
>=20
> What do you have in mind for telling that? We should also tell the
> orientation of the panel:
>=20
> EVM	VGA	omapfb.rotate=3D3
> LDP	QVGA	omapfb.rotate=3D0
>=20
> Do you have something in mind for that?

Hmm, right. I guess all we can do is have boolean flags in the .dts for
MO, LR and UD, which tells if the respective pins are hard-wires high or
low. And say in the documentation that you must either have a proper
GPIO, or use the flag, but not both.

The panel mounting orientation is a different matter. But I think it is
also something we should specify in the .dts. However, we don't have any
SW support to handle it, and it's a bit unclear to me how it should be
handled, so I think that has to be left for later.

>> At the moment our display drivers are OMAP specific, and for that reas=
on
>> we should prefix the compatible strings with "omapdss,". For example,
>> drivers/video/fbdev/omap2/displays-new/panel-dsi-cm.c:
>>
>> 	{ .compatible =3D "omapdss,panel-dsi-cm", },
>>
>> But we should still have the right compatible string in the .dts, so w=
e
>> convert the compatible name in arch/arm/mach-omap2/display.c, with
>> 'dss_compat_conv_list' array, to which this panel's name should be add=
ed.
>=20
> Oh so what do you want to have in the .dts file then?

The .dts should have the proper names. The idea of this hackery is that
in the .dts we can have the proper compatible string. So in the .dts, we
have, say:

"sony,panel-foobar"

Then, at boot time, omap's platform code changes that to:

"omapdss,sony,panel-foobar".

And our (omap specific) panel-foobar driver use that
"omapdss,sony,panel-foobar" string.

This way some other platform could do the same, and have their platform
specific drivers handle the panel.

At some point in the future we hopefully will have common panel drivers,
and at that point we can remove that hackery. The .dts files will
already be correct.

 Tomi



--aN4lrGsNv5aprSa1wEgrbQLIN7hEEnIbk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTcHpkAAoJEPo9qoy8lh71P9MP/R3by/ToNjeQb6ItsiIHK/Co
t4JJ36+91rQr+xIh5kOjk9GEBjTUCN92aBY+IuK3ppHg1KOVWvMfQQ6vxXpvolwL
CKZXX3lvlLQTjimBKiIQNRvuUHLqBoy1KgKhAuNLLO9NE+L+RKLlX8nqTqXoyFKb
INbX3VV72EBLVOgSAyfCOGWkvLwZAPuf7GEnkuhAmgZMCxfR9yB8KG0Q5TjhOYhB
XHfZndo6k1lHek009p75YqX89mt9E27uVw5/V86kse1GJjpyyNL+Z7k7lRL5xIwJ
fdrU43QFA3MvaBDJ2NDfjD/dqbu7gNtC59wD8xNzS9nm495eTpFbOlq4qhHSZleo
kzKldW3Zh3m8nzq18Lw79fPsTDe+5lDYEno22tIJKNlQTQ9xybFZiVY0NT/EODdT
WDqsC+TSrLvw20jRNVtufOibdqPd/Juw55amOiQmojw/p4svT0tER4HhT9br++nu
s2EtDK3y4t8R7waVktw8uH5UEZDUpbMaoXYup9Xeom2Xys0YUI2FhWvkQe0r7rvn
MsEsq7TgqH9nHvSD4QiYtjwfA/k3mWDuJ9wTd+PIWFRwr6WKQLTzywsVNNx2w98M
6Q2W56uvM23qjok839tTCGjJzNbLkkuVTEW3gBGok0Ex8HX1UuO4tc9nyb1c6hSs
bLq7mtGF9gtUMcWk//MO
=I6OZ
-----END PGP SIGNATURE-----

--aN4lrGsNv5aprSa1wEgrbQLIN7hEEnIbk--

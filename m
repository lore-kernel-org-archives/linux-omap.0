From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Mon, 19 May 2014 12:21:40 +0300
Message-ID: <5379CD24.6040508@ti.com>
References: <5371F923.80000@ti.com> <CABxcv==_LCw1kPYm17g=h8VfSN2V_qsgXjTnsy-JOetawSv4pA@mail.gmail.com> <20140513152518.GA16837@atomide.com> <53730AFB.2090800@ti.com> <20140514160216.GD18463@atomide.com> <537487AE.3060906@ti.com> <20140515182133.GC23659@atomide.com> <5375A8A8.7080306@ti.com> <20140516160717.GD22031@atomide.com> <20140516174158.GA11733@earth.universe> <20140516180154.GG22031@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="1oWDmGTTTDDx2lOErM2D2gbCPtt0rVX9q"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140516180154.GG22031-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>
Cc: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--1oWDmGTTTDDx2lOErM2D2gbCPtt0rVX9q
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 16/05/14 21:01, Tony Lindgren wrote:

>> IMHO appending -omap-dss to a random device is an even bigger hack,
>> since its adding lots of bloat to the API. Let's assume there is
>> another OS using DT for ARM, but has no proper API for SPI
>> controllers and it introduces your hack to SPI devices. That would
>> mean each SPI device has -omap-spi appended (or -exynos-spi,
>> -foo-spi, ...). At least I would blame them for creating a huge
>> unmaintainable mess.
>=20
> I think you're misunderstanding. I do not want the naming to
> be Linux specific. The naming should naturally be as hardware
> specific as possible. In this case something like:
>=20
> compatible =3D "sharp,ls037v7dw01-dss", "sharp,ls037v7dw01";
>=20
> Or we should probably use:
>=20
> compatible =3D "sharp,ls037v7dw01-dpi", "sharp,ls037v7dw01";
>=20
> As dpi here reflects the hardware it's connected to. The dss
> is probably a Linux name.

Well, "dss" or "omapdss" is as much a hardware term as "dpi". And "dpi"
wouldn't really be a good extension, as what we want is an omapdss
driver specific compatible string. So I think "-omapdss" is the best
extension if that method is used.

But I don't think that's really the point. The point is that the panel's
compatible string should be "sharp,ls037v7dw01", nothing else.

All the variations of "sharp,ls037v7dw01-dss" are not correct, and are
only made for Linux SW reasons. So I would say they are Linux specific
SW names, even if the words themselves are also HW terms.

> Not use what you're after with the SPI example though, but sounds
> like that's something different.

I think Sebastien's example is just like the issue here.

 Tomi



--1oWDmGTTTDDx2lOErM2D2gbCPtt0rVX9q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTec0tAAoJEPo9qoy8lh71xKIP/jlXpwFkbMY5/eHkquYV2ZU+
RXBQwl4E6BfQ1857/QT9ASF5NKbnKeh1CaZ4Q/9NjluX+dYmqA2aWjMu3LalSMod
v4OB5h4ULsd6aUis7SQPwiZ1D7IVqyzwbhWGNPkkhrCnAAGk+TySSLNyAftKMdKZ
fuHuU8IzVx9TEK0doA4PS3I7KsyGr1h1aDY3NaLiYNA2gA4o84Q0yhcP4ItIifKR
35pVBUbGr9y0L5+EuhoqsQIjrS5bQOQH3ymv9xw1lqPkAwJivKvhHvfJELUaeXYS
Dd0JSfWKxOemJpFGzOit2+ZIsdaUwdXBDB9mfYnjSiZIiDCWaVDDuPfIErUouci4
wvjPa0Xap+CZ1BMaMAkg+8B036RgWwa/LO0KrYJsUeg7bp6h4JxSjolcWD7+tFRB
3UY4gSaa0HaNsS644UJaJML+Gzuw2unjRhL2CZEnP26RXeyIur8wMhePoDtR0z/D
E7BNx1f6+RHINWD+TvhahmFSf0L90iSSviQ37rqKib/87ZiqjN5Z+2m7c8MGRHj4
8iugY8gI9Ivc2rr9HwlhP0sHuY0eExcm/qvnNQwiX/6NUi6uDlyClFchI6jvQBeq
4/s6b8pQoIi6QLeLHWiLBrut6sWrPBqdI3CZAJiLOe/OHefimL278AKivihI07mu
BtRmL3uLq7frVG/i9pET
=KvbB
-----END PGP SIGNATURE-----

--1oWDmGTTTDDx2lOErM2D2gbCPtt0rVX9q--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

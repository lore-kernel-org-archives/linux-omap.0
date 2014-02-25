From: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: dts: duovero-parlor: Add HDMI output
Date: Tue, 25 Feb 2014 14:41:48 +0100
Message-ID: <20140225134139.GA23898@earth.universe>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch>
 <1393261669-32039-3-git-send-email-florian.vaussard@epfl.ch>
 <20140224180336.GU27282@n2100.arm.linux.org.uk>
 <CABxcv=kKxidVJWcMrueB+edW=g_6gcucvi6=7p=EZ_WooCpbMA@mail.gmail.com>
 <20140225123921.GY27282@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140225123921.GY27282-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ash Charles <ash-EiDWdcs9+yZBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 25, 2014 at 12:39:21PM +0000, Russell King - ARM Linux wrote:
> > That compatible string is correct according to the latest series
> > posted by Tomi Valkeinen to add DT bindings for the OMAP Display
> > SubSystem (DSS) [0].
>=20
> in which case:
>=20
> N    N   AA     CCCC  K  K
> NN   N  A  A   C    C K K
> N N  N A    A C       KK
> N  N N AAAAAA C       KK
> N   NN A    A  C    C K K
> N    N A    A   CCCC  K  K
>=20
> Yes, that's a very big nack.  Two things:
>=20
> 1. OMAP really doesn't have the right to define a compatible string which
>    is as generic as "hdmi-connector".

AFAIK the idea was to have "hdmi-connector" as part of the common
display framework [1]. It's not really platform specific, since it's
just a connector.

Since omapdss does not yet implement the common display framework,
but wants to keep a stable DT API it rewrites "hdmi-connector" to
"omapdss,hdmi-connector" for now.

> 2. Even with "omapdss," before it, the convention that DT people have ado=
pted
>    is for the prefix to be "companyname," and not a subsystem.
>
> I'm not the only one with this concern - I discussed it with Arnd last
> night and his comments were about it being "obviously bogus".
>=20
> > The property is added on this patch [1] and as far as I understood the
> > idea is that it could be a generic DT binding that can be used by
> > platform specific HDMI connectors like the omap dss HDMI connector [2].
>=20
> Why do the physical connectors need a DT binding?

This is the termination of the video bus and useful information for
xrandr.

> Surely what needs the DT binding is the HDMI encoder - and that
> certainly should no way be a generic name, because there's no such
> thing as a generic HDMI encoder chip.

The HDMI encoder and companion chips are described separatly and
properly prefixed [0].

[0] http://www.spinics.net/lists/linux-omap/msg102522.html
[1] https://lwn.net/Articles/563157/

-- Sebastian

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTDJ2TAAoJENju1/PIO/qaip8P/2hCPKiB/YhERusHQ6EWgH1N
X3MBkiOqdGHrIv04HenS7jcL0meuUhtBU/YrrZKxMQ2BrOYtuQDt6kfgcwLCcEGK
npLklusvqYdpDsvCp/CEwE5Kbi03H7TAwCys7yL6nr3DerKGGXkrBy3mELs9t4fQ
KLkl7o7Mztp7BjWYBV2IGjJEdf+A7ZDRDE1yxoDUXubNkAcMPUjgdkBpX2aNuw0n
zbe3nmBdte07/frfon4Pa2kvKb/YPZknyR19hQuDmLxAE3G0hatAnLQZbOsRcQ+O
kr3xygu5Y6VCaWMlVWyBd0TrepFA7qD3T1NrphWVTDJbR20AsihgxSbdMVLzrwOC
FJ71/otQ7XuCPNaRkmOSHftsg+gq3+LQp6cxfdD4nQAv1cwU3ah8Ov/l9R3qoRPH
sDwROxqo/uHtFEmo91qZKGNMQLpPJJog6e3Qvt0zhgUtd9WW4lzc44mxBmZElIUL
E0ecxVrmjTm+wh/ekypDjVn5CTZ+Ein90EOx6VFw9pG76B8dVH7/JslDzG5DetsA
ANk+GYnTkWNXImpWzLmlfDqHDyadmKtlMzwby2I5wiMIXa4Vdhte7fMy+p9QYXYh
4QTx2nEp85JRi7ocol2Ad7a2O+kbXFY0jdv/rOquMRziN1zwpftDA9xf5shbPtLY
XtsvihVxR9FnbiLxJwn2
=0B4c
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

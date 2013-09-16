From: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>
Subject: Re: [RFCv2 3/3] ARM: dts: N900: Add SSI information
Date: Mon, 16 Sep 2013 21:27:22 +0200
Message-ID: <20130916192722.GB21903@earth.universe>
References: <1379277856-24571-1-git-send-email-sre@debian.org>
 <1379277856-24571-4-git-send-email-sre@debian.org>
 <CAAwP0s0e-gYkNA78eQH7x2VJbM1byaisUeqU8YbbeWUbKwsxCQ@mail.gmail.com>
 <20130916150147.GA14047@earth.universe>
 <20130916181032.GB30568@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130916181032.GB30568-R3WNPi76c83LsdW6vOPryG4HOFkwEHDbMR2xtNvyitY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: Javier Martinez Canillas <martinez.javier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Carlos Chinea <cch.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap@>
List-Id: linux-omap@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2013 at 09:10:32PM +0300, Aaro Koskinen wrote:
> On Mon, Sep 16, 2013 at 05:01:47PM +0200, Sebastian Reichel wrote:
> > > Is the Synchronous Serial Interface (SSI)  only supported by
> > > OMAP34xx/OMAP35xx SoC and not by OMAP36xx/OMAP37xx SoC?
> > >=20
> > > I'm asking this since if SSI is supported by both we should add the
> > > device nodes in omap3.dtsi instead of omap34xx.dtsi.
> > >=20
> > > I thought that all OMAP3 SoC supported SSI and all OMAP4 SoC supported
> > > HSI but I guess I was wrong...
> >=20
> > I just do not know. Information about the SSI core is not included
> > in the public OMAP TRM. It only lists the memory space as reserved.
> >=20
> > Thus I only included it in OMAP34xx, which is used in Nokia N900 and
> > must support SSI.
>=20
> I think N9 and N950 (OMAP3630) are using pretty much the same driver.

OK. I've checked the N950 kernel from [0] and it uses the same data.
I will move the data from omap34xx.dtsi to omap3.dtsi in the next
RFC.

Thanks for the hint.

[0] https://github.com/nemomobile/kernel-adaptation-n950-n9/

-- Sebastian

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCAAGBQJSN1uZAAoJENju1/PIO/qaYZMQAKag/PnkRZD1Z5sL72wzwlow
nLzrbXSaY09Re18fgC32YHESnhwtoxUrWKNZIk1qQf8ppzeAbdjCBifsTTWB4X4q
RrlZ1u6UfwO8cfqTtHKNrz2uA2MVWQpcLqb7j9zw/OLqDIDwhlZ/DEA7zF3fQgWA
GdJxtjkLXAvoB5meTumn1iBuqe2NQGWolrUi8YL0zrabt1mrfhXQKHDaPv54WsHO
G2UMURtQRXsjI5+kumX342TBbup4gGG8+ohZ/H8tOIbm6FWQa6jBp3PYn4UlybbX
PUxxnqEkAKB44Pf4o4i2dPNg4Ehe0KdcIKXR8DYZbg46Nl+wQa/wtgqJ9/U4413Z
6wViT4Xdtv3lxq4p/OrMUhU8uZWr2UTaZ6w5i6grWFRKhsPqVfXm1hnll3z8OBwo
cDyYG2h/KP7IROYCMShP2FNEb43AdSxW84pv1c0G35LEyE5ehBVNujMzbM2bgL2R
67swmCBvSAxaumtkY5vJ8+cMR4mt47iWMCfe5sN9hp6uCXZICk1u9kb5KRgkNgSe
QdbXfvNwNKlQOmwAhIawLxolnaji1w+7V3abPf7qZuP2GnJsCsuhdTvhUYwShQkA
LCZ99aAbmtyfM9z9a7RmSmsjUHLwdGZsT0Kq5AX7ON3KUajhX+7kEnVPy7VMmKIZ
Efuk9Z4VkqZ+nfAeHMGh
=KlmL
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

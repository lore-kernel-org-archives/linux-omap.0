From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/1] usb: Include generic_interrupt for OMAP2_PLUS
Date: Mon, 24 Sep 2012 16:02:17 +0300
Message-ID: <20120924130216.GA5603@arwen.pp.htv.fi>
References: <1348487604-7202-1-git-send-email-philippe.deswert@jollamobile.com>
 <20120924121538.GH2892@arwen.pp.htv.fi>
 <CAPsFW+RTLpgXFOOh9fD=K1wCPMpBe4MummhWoqEBEEYYzMay=Q@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:33854 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753931Ab2IXNHL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Sep 2012 09:07:11 -0400
Received: by lbbgj3 with SMTP id gj3so6666115lbb.19
        for <linux-omap@vger.kernel.org>; Mon, 24 Sep 2012 06:07:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPsFW+RTLpgXFOOh9fD=K1wCPMpBe4MummhWoqEBEEYYzMay=Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philippe De Swert <philippedeswert@gmail.com>
Cc: balbi@ti.com, Philippe De Swert <philippe.deswert@jollamobile.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 24, 2012 at 03:54:22PM +0300, Philippe De Swert wrote:
> Hi,
>=20
> On 24/09/2012, Felipe Balbi <balbi@ti.com> wrote:
> > SoB's mail doesn't From mail.
>=20
> Well still in the progress of migrating of my personal to work laptop.
> Since the patch does not seem correct the replacement will have
> matching addresses.
>=20
> >> /*--------------------------------------------------------------------=
-----*/
> >>
> >>  #if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_SOC_OMAP3430) || \
> >> -	defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_U8500)
> >> +	defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_U8500) || \
> >> +	defined(CONFIG_ARCH_OMAP2PLUS)
> >
> > Weird, how can you build OMAP2PLUS without SOC_OMAPXXXX ??
>=20
> It seems entirely possible. I quickly tried to look if it got defined
> somewhere and it does not seem to be set anywhere.  That is why I got
> the impression it was replaced by CONFIG_ARCH_OMAP2PLUS. I'll dig
> deeper to find out why SOC_OMAPXXXX is not set if it should be.
>=20
> From the .config I got (used menuconfig)
>=20
> #
> # TI OMAP2/3/4 Specific Features
> #
> CONFIG_ARCH_OMAP2PLUS_TYPICAL=3Dy
> CONFIG_SOC_HAS_OMAP2_SDRC=3Dy
> # CONFIG_ARCH_OMAP2 is not set
> CONFIG_ARCH_OMAP3=3Dy
> # CONFIG_ARCH_OMAP4 is not set
> # CONFIG_SOC_OMAP5 is not set
> # CONFIG_SOC_OMAP3430 is not set
> # CONFIG_SOC_TI81XX is not set
> # CONFIG_SOC_AM33XX is not set
> CONFIG_OMAP_PACKAGE_CBB=3Dy
>=20
> Not a mention of CONFIG_SOC_OMAP2430 and  CONFIG_SOC_OMAP3430 did not
> get set (while it is not a 3430 but a 3630 I am using). Maybe
> CONFIG_ARCH_OMAP3 would have been a better choice then?

that's quite f**ked up. Tony, why doesn't SOC_OMAP3430 get set for all
OMAP3 boards ? And another question: why don't we have a matching
SOC_OMAP3530, SOC_OMAP3630 and so on ?

> > BTW, this is also wrong as OMAP2PLUS is also used to enable AM3xxx and
> > TI8xxx, and those platforms don't use generic_interrupt().
>=20
> It would not break them from what I could see in musb_core.c
>=20
>         musb->isr =3D generic_interrupt;
>         status =3D musb_platform_init(musb); <--- isr would be (re)set he=
re

good point. Still that code would be hanging there with no users... Fair
enough, it's better to have extra code when it's not needed, then having
no code when it's needed :-)

That entire musb->isr crap is quite screwed up anyway and it's just
because TI's non-OMAP processors (daxxx, amxxx, ti8xxx, etc) decided
that the wrapper should read MUSB's address space (including IRQ
registers) and since MUSB's IRQ registers are clear-on-read we need to
handle the IRQ from wrapper drivers, which is pretty screwed up as well.

Ideally, we wouldn't have all of these exposed symbols flying around :-s

--=20
balbi

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQYFnYAAoJEIaOsuA1yqREvxcP/iji/8hPYf1mKmjZQxryNFqm
xnQQKfMC72ObY1G3e1+eInXO3LKyHJ0M5+1qp1N7EyNJrbzTb1jc5PROIqBUyuzh
pul3Os5Bo684yU9t1tG7LaKZxjrSKURLPhalDXCn/XN24aX7k+QEeyh1hfZm3pfY
U+2o0njPr1PFe/1Ad+ic+syW+ey4cuCRzyDUeWJGxrG2PNENv2MCcw/2dC30zFJ3
Uw2dzwaz4255zlq1WQkGHwQaO0IINY0akmg/Mr8iuOfqZwLDVRFFEaPMVivY3mem
s6LIbYXRcmh9EJPs9m7VAZz6NQdCmHHK8E2x3LGOpbBRjJ19zAvSedUK/MT//bkg
A4iK7gXkB71zScwMo1xoUyxY1gdUNAo4IYPUJEn2qMnFUzWc3l4kB/Srkw6NCR3Z
sktLr3lHwk/DhylmDJBlQaOse8K+oWOKn6rs4A9BYjHcbr81aN78CwZ3nnHAGIVV
WnXpIIIH6RNuxknUpxIXRVNKz0feAsSzkt17HEfJgNJs1+p8ieMYzBjbSSckQuE2
rxLllNqZL33aMpbuFwogmA++hQ0q1dsr2fjPOxzjXUD5HYyiuUfTevYV1ZIeHsCi
6crZ+IcuXxL8XPKciDVxRmb1bVrHaws5McOp/kmNzwY3v0/DzWGZd2VkPdHhM9tw
5rirKTGQYcs2GT22T//Z
=R+Y5
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--

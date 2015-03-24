From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: Enable EXTCON_USB_GPIO
Date: Tue, 24 Mar 2015 11:44:22 -0500
Message-ID: <20150324164422.GG31024@saruman.tx.rr.com>
References: <1427192359-19168-1-git-send-email-rogerq@ti.com>
 <20150324142647.GA9145@kahuna>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nhYGnrYv1PEJ5gA2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47476 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbbCXQpO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2015 12:45:14 -0400
Content-Disposition: inline
In-Reply-To: <20150324142647.GA9145@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, tony@atomide.com, balbi@ti.com, linux-omap@vger.kernel.org

--nhYGnrYv1PEJ5gA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2015 at 09:26:48AM -0500, Nishanth Menon wrote:
> On 12:19-20150324, Roger Quadros wrote:
> > We need to enable EXTCON_USB_GPIO_USB and not
> > EXTCON_GPIO_USB.
> >=20
> > Fixes: c08a54c0ebeb ("ARM: omap2plus_defconfig: Enable EXTCON_GPIO_USB")
> >=20
> > Reported-by: Nishant Menon <nm@ti.com>
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > ---
> >  arch/arm/configs/omap2plus_defconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/om=
ap2plus_defconfig
> > index 04b4c8e..daf9412 100644
> > --- a/arch/arm/configs/omap2plus_defconfig
> > +++ b/arch/arm/configs/omap2plus_defconfig
> > @@ -391,7 +391,7 @@ CONFIG_TI_EDMA=3Dy
> >  CONFIG_DMA_OMAP=3Dy
> >  # CONFIG_IOMMU_SUPPORT is not set
> >  CONFIG_EXTCON=3Dm
> > -CONFIG_EXTCON_GPIO=3Dm
> > +CONFIG_EXTCON_USB_GPIO=3Dm
> >  CONFIG_EXTCON_PALMAS=3Dm
> >  CONFIG_TI_EMIF=3Dm
> >  CONFIG_PWM=3Dy
> > --=20
> > 2.1.0
>=20
> Yep and it finally works! Yipiee!!
> http://pastebin.ubuntu.com/10669565/

I don't see the peripheral side IRQ in /proc/interrupts. What's going
on? Can you load g_zero or g_mass_storage and verify peripheral side
also works ?

--=20
balbi

--nhYGnrYv1PEJ5gA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVEZRmAAoJEIaOsuA1yqREdbYP/A+fde+nfbApf+E8FAiGIdG2
K4KyNJVAXh4WxyuSkZRdOGeX8gqmtwOVTe6/Nply32ILDQG+hUIZLOeGQm1PUL8J
N9xQTAGCn/F0C8tjTBFKceibWH5Zuf1gdOwMGlkEHhm9BVJfC0/YmhYVBIwNR231
5EZg6ex7g1SIoFX5MYxMWiu8N8K+f3o1ybfjR3dYsyAzcvvxak2zAclG8Bgrp6tI
7FQ3fQgXQhyH4FzxM0DFCjfT6PQ6BhwwSpDKyuju7tSxEYhpazakfpNsCYl+ZV4J
5OgWKzbXTqbdoWc28m/bVXv8T6x3sR9eM1WLe/wfXP7kcLnbKspPkAn5w5YHmDVl
05XNExkR5BAUS2pqmxgUnpFWBTYRJVC3pW6VWnhbRJ5OaffcYzVJb7k+ptM3yCXH
XW/dLyTBYLfmIvf+cd+cFBGgrJVuIhzlu492t6Mp+RqWPBCJrdNn1VDDfdcfPkQZ
fzQMXkAl4WuXcNKuBQkUX61FybScBWJu0AFiEGvUK19hRJosTWC1ISfG/4uUl+5s
M/APKfof6Ag2OQCXUeOW0Au5rnESe7JPhxm9j6gkCjQXDuZl1KVyVJGWQAMtH4KO
k04L8Og2StKuoVkqJtfXQCyBMve+rVaBbIxUxXw/Z/EsbM5yb51fdYRAkcaCupve
M6C0aU8hDrfhJz+Qs3tP
=h8cd
-----END PGP SIGNATURE-----

--nhYGnrYv1PEJ5gA2--

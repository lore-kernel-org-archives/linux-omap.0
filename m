From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/5 RESEND] ARM: OMAP: USB: HOST TLL platform driver
Date: Tue, 20 Mar 2012 13:01:36 +0200
Message-ID: <20120320110135.GR9157@arwen.pp.htv.fi>
References: <1332139715-1495-1-git-send-email-keshava_mgowda@ti.com>
 <1332139715-1495-2-git-send-email-keshava_mgowda@ti.com>
 <20120319100603.GB20279@arwen.pp.htv.fi>
 <CAP05o4LkWpANqibBXsY-FbCTOsioUq4qPdA8k=Ct4HHGYfL4Ng@mail.gmail.com>
 <20120320095914.GE9157@arwen.pp.htv.fi>
 <CAP05o4+tjD__yr-vgq29QpUUCAxgqSJiGW0ibVn2CFQU_3y+bw@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8N5nZmKALFZnI1Hj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:43266 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753638Ab2CTLBy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Mar 2012 07:01:54 -0400
Received: by mail-lpp01m010-f52.google.com with SMTP id i5so9560761lah.39
        for <linux-omap@vger.kernel.org>; Tue, 20 Mar 2012 04:01:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAP05o4+tjD__yr-vgq29QpUUCAxgqSJiGW0ibVn2CFQU_3y+bw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, sameo@linux.intel.com, parthab@india.ti.com, govindraj.raja@ti.com, paul@pwsan.com, b-cousson@ti.com


--8N5nZmKALFZnI1Hj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2012 at 04:21:18PM +0530, Munegowda, Keshava wrote:
> On Tue, Mar 20, 2012 at 3:29 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Tue, Mar 20, 2012 at 03:00:50PM +0530, Munegowda, Keshava wrote:
> >> >> +MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
> >> >> +MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
> >> >> +MODULE_LICENSE("GPL v2");
> >> >> +MODULE_DESCRIPTION("usb tll driver for TI OMAP EHCI and OHCI contr=
ollers");
> >> >> +
> >> >> +static int __init omap_usbtll_drvinit(void)
> >> >> +{
> >> >> + =A0 =A0 return platform_driver_probe(&usbtll_omap_driver, usbtll_=
omap_probe);
> >> >
> >> > please don't. Make sure you use platform_driver_register, instead.
> >>
> >>
> >> Here , omap_usbtll_drvinit is registered through fs_initcall call;
> >> this is required because, the TLL driver is required to initialized
> >> before the UHH ( usb host core) driver.
> >
> > no issues with fs_initcall. The issue is with platform_driver_probe()
> > only.
> >
> > --
> > balbi
>=20
> Thanks , I got it.
> I will take the same comment make the same change in usbhs driver too;

cool, thanks

--=20
balbi

--8N5nZmKALFZnI1Hj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaGOPAAoJEIaOsuA1yqREvjAP/1cmMq/Pwkt9YGyhtlLe0LAZ
oG9ecPRni23tb+BH7CmNqWvx5YqAxHnBLbtY7CMY1YTD5smteQvCj+Zdb9B9zaTQ
uUmKUUjxUJR64CYaTXO7Sz4B8SG6R73JJjMheHvkVBP2afBRvwig5rAkyRvaCclJ
qRMKTAOfdaWwCiFp+5FUkyZRp0iyOGDDfdkSx5jOYN1ihIk5zOLM59qbDhk0NhlN
y5QHEFUyaeG4A9iDQ+SKoTzWRqa8bvhoeskEa1QdWQj16cxfhgV9+s2WIGbExqT3
BHu0AMs0QJMif/FQqmXvGEMUSctUPwsDvt9wW4993uo3NWT2Ta36WRgALCktxXpz
+CY/T9D3fxKsg6WFkXRpEa/WK/jvA4taUGZfHNc3QAdPPPd8bEqX+CaCPqB5LwVu
dquIRUytoiWv0yz77XcdtKChts486bS6jA1fZoNXN3KSgg35mat8hIk/zca5B+rF
aYG4i2UmOqJGHMZlbJ/j9IaYz9QZtx4ZAbVYclmpemveVQd3DEw/5tuJwnI6Bv67
/TCFyrQS6s/ebXOgZJ4VYFl9eeNq2+a3OlZOpTU7eSbRp1CXd8esGTbgThPkfNM8
YndSXZaIc76Oug1TBj6bxHO6KIZoNRq67MhBnYZMEVRpPGzEFGolcppbmDp36ZZL
gZOGQA8XulO2md7d9/mV
=ESQk
-----END PGP SIGNATURE-----

--8N5nZmKALFZnI1Hj--

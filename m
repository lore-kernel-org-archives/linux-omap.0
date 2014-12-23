From: Felipe Balbi <balbi@ti.com>
Subject: Re: USB OTG doesn't work in HOST mode on OMAP3 processor on 3.18-rc5
Date: Tue, 23 Dec 2014 12:41:26 -0600
Message-ID: <20141223184126.GJ9147@saruman>
References: <CAJt7siu_JiSe3CfM2=0UZLQjRevdLuX+=UL566fiW6XefTTWGA@mail.gmail.com>
 <CAPjucKaEodpFtv533az+axecjsOahDsWV=V-M6sX84Z27KovsQ@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LG0Ll82vYr46+VA1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47542 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbaLWSly (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2014 13:41:54 -0500
Content-Disposition: inline
In-Reply-To: <CAPjucKaEodpFtv533az+axecjsOahDsWV=V-M6sX84Z27KovsQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduard Gavin <egavin@iseebcn.com>
Cc: =?iso-8859-1?Q?Agust=ED?= Fontquerni <af@iseebcn.com>, Tony Lindgren <tony@atomide.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, linux-omap@vger.kernel.org, balbi@ti.com

--LG0Ll82vYr46+VA1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

(no top-posting)

On Fri, Dec 19, 2014 at 12:16:04PM +0100, Eduard Gavin wrote:
> Hi Everybody,
>=20
> After several test with IGEPv2 board (OMAP3) and linux kernel 3.17 and
> 3.18, the OTG works but, (from my point of view) with an weird
> behaviour.
>=20
> The OTG like a Host only is activated after load a gadget driver, I
> mean that, If I plug a USB memory dongle in the OTG port before load a
> Gadget driver like "g_ether" the dongle is not recognized. After load
> g_ether driver, the usb dongle is recognized without problems.
> I miss something in the configuration?
> It this the normal behaviour?

it's normal. If you configured your kernel for OTG/dual-role, you must
have both roles ready to go.

that should be considered common sense.

cheers

--=20
balbi

--LG0Ll82vYr46+VA1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUmbdWAAoJEIaOsuA1yqRE1KcP+gOVn1Tt3KI5PGJFwC/bEKui
ZpcEGXR5xnViohkwRcDIsXwSCrFCYnT9FMZ1H1S3LWSzU3NBINdzkpTrlHhDlBfg
7Pkn6AJoMshPFWhX8tYI04wJqZa3BePwKRW5+wyBUghh5HOygfZ/8cvEJPTJcDNO
0D72Vx6zRCcU4fTLYcm8Jp4B2sW0b9Qpw9o5ao2POHRv526WD6uzgJ09B4QekOJq
yxej9NKSdnmKr7zSMO6Hno6Mf1oRilqTKEvqF8fI8K3pxQte58dkC/ONSRuxO1Qb
lFDsKLRrhOwAEvoAUIPzkrCBzwWqZM2UKoEdh2Qa0B/hEo+JttDXspk9Uon3P1wL
IcxTdcM0Wk3T8Yi09mHudA1E4p7FGRo6cK0ycdDzadBPDQ9S0HU2cbYW3OwbFFk6
zBtuc3Va6VA9J9A4E4pEgkLrQgxPDaaDWG1UI51f0WlLAkic7xbu5a+a34UpI9Qd
pirEZk2cp5hYaBxHsUOWDneAQMrhI13m3oMj+MGWrMhlhs3FtbpZmI5F7op0DxT+
V7aDabfLyNsXaWsvKlG8ritsSz5oewwIIDRKsnfmorRTxmn5JZCDnWi1ibp5JFoA
6ViLv1ASe9pPBVK7uB7dl2WsO0W/sjKRJRSVFkNlMlbK8A8SxjQluehbYdSbW0l6
VCDw4wvgKOowdI6buZMd
=vsbg
-----END PGP SIGNATURE-----

--LG0Ll82vYr46+VA1--

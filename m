From: Sebastian Reichel <sre@kernel.org>
Subject: Re: ARM errata 430973 on multi platform kernels (was: OMAP3-N900:
 Add microphone bias voltages)
Date: Mon, 6 Apr 2015 19:38:15 +0200
Message-ID: <20150406173815.GD18145@earth>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com>
 <201504051526.14575@pali>
 <20150405134528.GD9186@earth>
 <201504051552.10522@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40602 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891AbbDFRiq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Apr 2015 13:38:46 -0400
Content-Disposition: inline
In-Reply-To: <201504051552.10522@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Robert Nelson <robertcnelson@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 05, 2015 at 03:52:10PM +0200, Pali Roh=E1r wrote:
> > So I suggest to enable the IBE bit in the kernel (that part is
> > already done) *and* in u-boot.
> >=20
> > -- Sebastian
>=20
> Yes. Code for both (U-Boot and linux kernel) exists and are=20
> already included.
>=20
> In linux kernel code is since 3.14-rc6 and in U-Boot code is=20
> there since beginning of Nokia N900 support (2013.04) directly in=20
> board code.

ah. I wasn't aware, that u-boot already sets the IBE bit on the N900.
Thanks for the information.

-- Sebastian

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVIsSFAAoJENju1/PIO/qaZDsP/1G3KyvNnoev+eSFtI1t4NIk
JW3oJnrSeltLBU8cctN5xAWrTdOrAKMNjH5DXRKAOuvs8u+ZjkCtlv3sHUiEbQaU
KQbrM4Of7XYItfYRhK/4pE1uagYaj9I6dGQsMUikGfm6LjLyjYjKauKQDmSqXBOg
YWbKC/kteZ+Uiyh6pfKO80Z7UsTCXpoPlsOKyTpJ9z6a1dzkGsDc6gzM3hd3zL/p
+J9aJ/f/miRNzRbe+1RJrt6CLJWq6MZpGJcyQkhcT/uMgE93GF9fuh83hzZexSDc
Ot/yObUj0D0yUMZtpiAzaJyY2ZY15t0aQ21bdQzlxg7boNarBCcaBBU5083HKGJE
O1Vw35UCLTD0JjvgqK9C6O9khY1RH5qzzN1Dx0qKhc69xS+jGidZ9bzAfFH/B6ll
WFN2O+tu84j5DsYDxGvYvEqQaNLVBw6zR+iHdEW9SCFOkKhgnRCb58skjmGwOgGE
AeKA0hYMgIuEublxyrSJjSjhfuNaO5XFyWHf++X/XbSK6txG2DUh2k0hRronI4FX
DBwAwqSnxkRZrZSnihPvQ9eVJ2M4XmXAmGpZtV96jG195PLLkbT7D9tshD7X4yIJ
+fI6C+jYamxd5bfb8Ely9SA9djFysUPW1qukjGN+zb0YtQVGzn+fH0YhHA+DlbZy
rl+jk2mA4nWfsv6NEKcH
=soY3
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--

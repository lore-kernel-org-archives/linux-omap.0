From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/4] Drop legacy support for omap3517
Date: Thu, 15 Jan 2015 15:25:36 +0100
Message-ID: <20150115142536.GC512@earth.universe>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
 <10549142.7lWnPtPtZG@wuerfel>
 <20150113204219.GJ2419@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52283 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753570AbbAOOZu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Jan 2015 09:25:50 -0500
Content-Disposition: inline
In-Reply-To: <20150113204219.GJ2419@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2015 at 12:42:20PM -0800, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [150113 12:27]:
> > On Tuesday 13 January 2015 09:57:41 Tony Lindgren wrote:
> > >=20
> > > It seems we can now drop omap3517 legacy booting support to get
> > > a bit closer to making all of omap3 boot in device tree only mode.
> > >=20
> > > All these boards have at least minimal support for booting with
> > > device tree, and pretty much anything supported with the legacy
> > > board files can be configured also for device tree based booting
> > > if not done already.
> >=20
> > Ah, very nice.
> >=20
> > Just out of curiosity, what are the remaining showstoppers for
> > the 3430 and 3530 based boards?
>=20
> Not much really. We're now printing a warning to get a people to
> upgrade their systems. So with some boards we need to wait a while.
>=20
> Then here are the remaining items that I'm aware of:
>=20
> - A regression at least on some n900 with appended DTB not booting
>   properly any longer reported by Pali
>=20
> - A regression where the legacy ATAGs don't seem to get properly
>   translated by the uncompress code for atag_rev at least reported
>   by Pali
>=20
> - A few missing .dts files for devkit8000, omap3logic, omap3stalker,
>   omap3pandora and omap3touchbook
>=20
> Pali and Sebastian probably know best of any other remaining
> issues to drop n900 legacy booting.

Apart from the bugs there is only one feature-wise regression when
the system is booted via DT, which is the accelerometer. I will
(re)send patches for that in the next days.

-- Sebastian

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUt83dAAoJENju1/PIO/qaF8YP/1oifU6pHNbOF/a2VTIUkbfl
zzbxL8CVKLnmMTsliVAQBtTnXxAqj/RQBkVdzT59MHeAU90q/DM48ACshL9LG3m+
BhDl41meZMYVpJ9Not6p+zjWmQe5jrR/URMiQgctLih/CmeeJ/0YELwebrRKID/x
T6o11Qsk84J2JVh2VdAnAvOrftrn6LgTFco39ySQGGtecQJUGr0d1ESK0vMGjFKC
LQo6n8m5jlewrLCxHCNcDtuZdH5ZQWrEwrpfQIiow3b2Jz5LK1B3jxyU3yB15jpB
RxOFnq7llJDz94c5gh6+NxVVkjCV68Bz5kh/UobWx3xDZCo4oTBz3t9BxFNs8MH8
tYCFnt1x4nZpI2AjE/NfAuzCT/fIwyoHbsBngX0KH2bsnrsshVR2QBvS8S4FURo9
kcXGVW1uyJ8PTXUYYososLZy1Rf22gHYBy71Dl/+jK5nIRup/GeGOrA90Q9ZsBbL
el2b4oLO52wlBd2vusois4VQ6MF1LnjXLuZuWkxxIEroGUfZDGoMgSz2yqYiMOtA
VBCWyejyY6L7dZxdAIQc0zZ56Tr97VbdKhjh4aUXTiup2gdmWzbJzqLeWUaM0tHE
dMnnYv/urPIMH/1qE5JM9cRjKyKhHZjw1elD1O5Zirbeoz7QfCN92ElMp2FORp6W
+t6Cs/54VjJqvysrYeqc
=Epww
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--

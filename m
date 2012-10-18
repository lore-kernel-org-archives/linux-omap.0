From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] arm: omap: move OMAP USB platform data to
 <linux/platform_data/omap-usb.h>
Date: Thu, 18 Oct 2012 08:49:34 +0300
Message-ID: <20121018054934.GE11137@arwen.pp.htv.fi>
References: <20121016230040.GP15569@atomide.com>
 <1350488838-6289-1-git-send-email-balbi@ti.com>
 <20121017203404.GY15569@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3O1VwFp74L81IIeR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41323 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754255Ab2JRFzJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 01:55:09 -0400
Content-Disposition: inline
In-Reply-To: <20121017203404.GY15569@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 17, 2012 at 01:34:04PM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [121017 08:54]:
> > In order to make single zImage work for ARM architecture,
> > we need to make sure we don't depend on private headers.
> >=20
> > Move USB platform_data to <linux/platform_data/omap-usb.h>
> > and keep only internal functions in <plat/usb.h>.
>=20
> Thanks, looks like I can't make this apply against v3.7-rc1:
>=20
> patching file arch/arm/plat-omap/include/plat/usb.h
> Hunk #1 FAILED at 1.
> Hunk #2 FAILED at 26.
> Hunk #3 FAILED at 44.
> Hunk #4 FAILED at 65.
> Hunk #5 FAILED at 81.
> Hunk #6 succeeded at 28 with fuzz 2 (offset -128 lines).
> 5 out of 6 hunks FAILED -- rejects in file arch/arm/plat-omap/include/pla=
t/usb.h
>=20
> Can you please check it?

Are you sure you have a clean v3.7-rc1 ?

commit 9b1ebba0f43e7bf6a8fdd8aa84da65e5e0344fb7
Author: Felipe Balbi <balbi@ti.com>
Date:   Fri Sep 28 09:51:01 2012 +0300

    arm: omap: move OMAP USB platform data to <linux/platform_data/omap-usb=
=2Eh>
   =20
    In order to make single zImage work for ARM architecture,
    we need to make sure we don't depend on private headers.
   =20
    Move USB platform_data to <linux/platform_data/omap-usb.h>
    and keep only internal functions in <plat/usb.h>.
   =20
    Signed-off-by: Felipe Balbi <balbi@ti.com>

commit ddffeb8c4d0331609ef2581d84de4d763607bd37
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Oct 14 14:41:04 2012 -0700

    Linux 3.7-rc1


That's my branch. Patch is right on top of v3.7-rc1 commit.

--=20
balbi

--3O1VwFp74L81IIeR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQf5huAAoJEIaOsuA1yqREd/QQAIde9vVgZEQ8rabSdxc+1sVb
IKbOOj4z9i//8AWYkqFK+ybxaEmVj/sKLYl1QZqaieJ6/FsSwsBq7RlSy5PD62Wc
HgB4e1YJHbe2EjuEZO/TY3qPHabz/zXc+x1kDr99GmswF/6d31qY2d6c30pbpNfh
wApt6GaexECfGOaPd7Kg0R7yN2q6s96wWnyqYBVEh2xCEx8ktU4pcXdB40ucXrKr
zpAHZYK0A1WAUVdyn5+chkUAcyzKff5ioA3QJxmZHD60mF5tpPihwdRr4IDElRBh
jx8VOSDJSdm42NsAgtXoiH8e4OEf9I92m+a9NUN4shr2guCJRybewSqonx+kRIXQ
vkO0I50+3rLf70npUZyzMtAiozqrnt5x13O6F8wfKjtsEzF3KvEqRsgOfcqXo+/m
PV7TGuHy+6DhubNFk6WpyennH2tdEx83bmDrCEjftcdubcW/Skc3cbexUFLQl9rZ
74W0ykCEaHnIFzHPup8p5loA5Xw7RMvpSjRh0wdJ+1TBXi0stL4PHe02kOGgh+c6
ow6n6wb9sn7PkWkYl8fCwi/WZU2XNz3uoHSrItmmJBKBRbKTiSTVrjDqiK91tCX7
hdiaNQpoz10fV5EqZNIkS7fkcUhMTmURGT5iqRW82kIafOAxypegSrxzYkgv7n8T
boLscBNVg2MpFqvQ8nwV
=yAk5
-----END PGP SIGNATURE-----

--3O1VwFp74L81IIeR--

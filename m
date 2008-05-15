From: green <greenfreedom10@gmail.com>
Subject: Re: N810: linux-2.6.26-rc2-omap1 with muru.com N810 patches
Date: Thu, 15 May 2008 14:33:33 -0500
Message-ID: <20080515193333.GA11713@swansys>
References: <20080515140914.GA30594@swansys> <20080515165448.GB8875@swansys> <20080515182840.GS8928@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:54614 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604AbYEOTdw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 May 2008 15:33:52 -0400
Received: by py-out-1112.google.com with SMTP id u52so502806pyb.10
        for <linux-omap@vger.kernel.org>; Thu, 15 May 2008 12:33:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080515182840.GS8928@atomide.com>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP List <linux-omap@vger.kernel.org>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2008.05.15, 136, Tony Lindgren wrote:
> * green <greenfreedom10@gmail.com> [080515 10:03]:
> > On Thu, 2008.05.15, 136, green wrote:
> > > I have built a Debian Sid armel chroot on the N810 and have compiled =
many=20
> > > kernels in the chroot.  I send the kernels to the N810 using the flas=
her (-f=20
> > > -k $IMAGE -R).
> >=20
> > I've also built 2.6.26-rc2-omap1 (with muru.com N810 patches) on my amd=
64=20
> > system using the gnueabi tools from emdebian.org.
> >=20
> > gcc 4.3.0-4
> > binutils 2.18.1~cvs20080103-4
> >=20
> > Same results.
> > >  - The NOKIA splash screen is displayed for about 20 seconds and then=
 the N810=20
> > > powers off.
>=20
> Hmm, the patches I've posted should work fine to mount root from
> internal MMC card (assuming you have both cards inserted right now...)
>=20
> You should see the white Nokia splash screen for few seconds, then
> the black framebuffer console with penguin.
>=20
> I tarred up my n810 hacks to http://muru.com/linux/n8x0/ with the
> keyboard patches included.
>=20
> Here's also a temporary test zImage:
>=20
> http://muru.com/linux/n8x0/zImage-n8x0-2008-05-15
>=20
> You can test that with:
>=20
> $ flasher -k zImage-n8x0-2008-05-15 -l -b
>=20
> I'll remove that zImage at some point soon because of my limited
> server bandwidth.. This zImage works with n810, and seemed to boot
> on n800 too.

Okay, I've got the zImage and updated patches; thanks.  This zImage does wo=
rk,=20
but fails to mount root device (maybe something I did wrong; I'll worry abo=
ut=20
that later).  Could you send the config you used?  Or maybe I'm doing=20
something wrong when compiling.

I'm compiling on an amd64 system with the following packages (and their=20
dependencies) from emdebian.org:
binutils-arm-linux-gnueabi 2.18.1~cvs20080103-4
cpp-4.3-arm-linux-gnueabi 4.3.0-4
g++-4.3-arm-linux-gnueabi 4.3.0-4
gcc-4.3-arm-linux-gnueabi 4.3.0-4

and in the Makefile:
CROSS_COMPILE   ?=3D arm-linux-gnueabi-

For now I'll try with the latest from linux-omap-2.6 with your patches.

> BTW, you need to disable rd mode with flasher --disable-rd-mode with
> the serial clock hack applied. Otherwise the boot won't complete. Or
> at least you should not have --set-rd-flags=3Dserial-console set.

I don't have the serial-console flag set.


Thanks!

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFILJAN682C+dBP+oQRAns4AKDkwHca0G6Vv+zIFtMY9MFbxTkwMACfelz1
AGyM6dn8VmulEo0tGs2C5Eg=
=cvjs
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--

From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: ARM errata 430973 on multi platform kernels (was: OMAP3-N900: Add microphone bias voltages)
Date: Sun, 5 Apr 2015 15:52:10 +0200
Message-ID: <201504051552.10522@pali>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com> <201504051526.14575@pali> <20150405134528.GD9186@earth>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1434434.Sytk88sGA8";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36513 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbbDENwN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Apr 2015 09:52:13 -0400
Received: by wizk4 with SMTP id k4so10396636wiz.1
        for <linux-omap@vger.kernel.org>; Sun, 05 Apr 2015 06:52:12 -0700 (PDT)
In-Reply-To: <20150405134528.GD9186@earth>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Robert Nelson <robertcnelson@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

--nextPart1434434.Sytk88sGA8
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 05 April 2015 15:45:28 Sebastian Reichel wrote:
> Hi,
>=20
> On Sun, Apr 05, 2015 at 03:26:14PM +0200, Pali Roh=C3=A1r wrote:
> > > > > Yes so it seems, and the bootloaders should really set
> > > > > it. It's also disabled for multiplatform builds.
> > > >=20
> > > > These are now done in u-boot as of: v2015.04-rc4
> > > >=20
> > > > http://git.denx.de/?p=3Du-boot.git;a=3Dcommit;h=3Dc6f90e1418a8
> > > > 4fe5 fa463b38403bd1845cb6a59c
> > >=20
> > > Seems like "include/configs/nokia_rx51.h" has been
> > > forgotten. Note, that the kernel must still be able to
> > > enable the bit itself (in case NOLO is used without
> > > u-boot).
> >=20
> > You must not expect that bootloader set something. Nokia
> > N900 has closed and signed bootloader which cannot be
> > easily replaced and or fixed.
> >=20
> > For N900 there is U-Boot but it does not support lot of
> > things (load kernel via usb or serial) so for developers it
> > is better to use original Nokia bootloader.
>=20
> Yes, I'm aware of that. I think having the IBE bit set in
> u-boot has advantages nevertheless. I think the kernel can't
> enable the bit sufficiently early if its compiled in
> thumb-mode itself (CONFIG_THUMB2_KERNEL).
>=20
> So I suggest to enable the IBE bit in the kernel (that part is
> already done) *and* in u-boot.
>=20
> -- Sebastian

Yes. Code for both (U-Boot and linux kernel) exists and are=20
already included.

In linux kernel code is since 3.14-rc6 and in U-Boot code is=20
there since beginning of Nokia N900 support (2013.04) directly in=20
board code.

I believe that you guys do not remove or break that code :-)

Nokia N900 needs slightly different code for setting IBE bit as=20
other omap3 boards. For info is in commit message of commit=20
4748a7240284b0f68bd47a66365c2cd561939830.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1434434.Sytk88sGA8
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUhPgoACgkQi/DJPQPkQ1L8ZACeMdk+d2JuqdAggH5pLLheJfCu
COEAoL74sBnmgn3JVilMkpYVhppCvpml
=gy+i
-----END PGP SIGNATURE-----

--nextPart1434434.Sytk88sGA8--

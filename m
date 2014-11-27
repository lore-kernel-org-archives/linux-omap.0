From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Thu, 27 Nov 2014 12:32:47 +0100
Message-ID: <201411271232.47231@pali>
References: <20141027200008.GR2560@atomide.com> <201411270038.01312@pali> <20141127011203.GR2817@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart13629102.RTXyN0Aayy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:53638 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105AbaK0Lcu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2014 06:32:50 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so6218550wgh.34
        for <linux-omap@vger.kernel.org>; Thu, 27 Nov 2014 03:32:49 -0800 (PST)
In-Reply-To: <20141127011203.GR2817@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--nextPart13629102.RTXyN0Aayy
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 27 November 2014 02:12:04 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [141126 15:40]:
> > With enabled CONFIG_ARM_APPENDED_DTB=3Dy file /proc/atags is
> > missing.
>=20
> OK I guess it should not be needed for DT based booting.
>=20

If I do not enable CONFIG_ARM_APPENDED_DTB=3Dy then kernel is=20
booting in legacy mode (not in DT).

> > > The build_tag_list() should parse ATAG_REVISION and then
> > > parse_tag_revision() should copy it to system_rev. Maybe
> > > try adding some printks to see if those functions get
> > > called?
> >=20
> > Now I see... Problem is that build_tag_list() is called from
> > convert_to_tag_list() which is called from
> > setup_machine_tags() which is called from setup_arch() only
> > if setup_machine_fdt() call fails. And it fails for *non*
> > DT boot. You can check this chain too.
>=20
> Thinking about this probably the best long term solution is
> to pass optional board_revision in the kernel cmdline that
> can be parsed early and copied to system_rev variable.
>=20

Not possible. Our bootloader is closed & proprietary. I tried to=20
replace it with u-boot I was not able to do that. So we will use=20
that Nokia closed bootloader forever and it can provide data only=20
in ATAG structure.

> Or if you can think of some other way to get it, we can set
> system_rev in pdata-quirks.c.
>=20
> Or maybe add some code to copy the ATAGs somewhere where
> they are out of the way and don't conflict with the device
> tree data? Then we can query ATAG_REVISION from pdata-quirks.c
> and set system_rev.
>=20
> Regards,
>=20
> Tony

If we are able to read ATAG from pdata-quirks, then we can parse=20
it there and fix problems... But I do not know if address of ATAG=20
structure is available there...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart13629102.RTXyN0Aayy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlR3C98ACgkQi/DJPQPkQ1K14wCeKz+doTV4TTqQuz2gSUmMkxyP
PKYAoL4wOjxQgci99b4vLzOKcSdUCx22
=xGDR
-----END PGP SIGNATURE-----

--nextPart13629102.RTXyN0Aayy--

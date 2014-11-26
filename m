From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Thu, 27 Nov 2014 00:38:01 +0100
Message-ID: <201411270038.01312@pali>
References: <20141027200008.GR2560@atomide.com> <201411270001.44871@pali> <20141126231435.GQ2817@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5834737.7bDdQZy9x5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:46397 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbaKZXiE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2014 18:38:04 -0500
Received: by mail-wg0-f48.google.com with SMTP id y19so5008090wgg.21
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2014 15:38:03 -0800 (PST)
In-Reply-To: <20141126231435.GQ2817@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--nextPart5834737.7bDdQZy9x5
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 27 November 2014 00:14:36 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [141126 15:03]:
> > On Wednesday 26 November 2014 21:08:06 Tony Lindgren wrote:
> >=20
> > With your patch I'm getting:
> >=20
> > Hardware        : Nokia RX-51 board
> >=20
> > So patch is good.
>=20
> Is that a Tested-by: then? :)
>=20

Yes for Hardware line you can add my:

Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

> > > > Revision comes from bootloader (via ATAG) and it is HW
> > > > revision of N900 device. It cannot be hardcoded into
> > > > kernel or DTS as it it depends on HW.
> > >=20
> > > Well for the "Revision" line problem, we could pass the
> > > revision in cmdline or .dts if not passed in the legacy
> > > ATAGs. It sounds like were just not copying it to
> > > system_rev for DT based booting? Maybe it's just some
> > > missing CONFIG_ATAG option that needs to be enabled?
> >=20
> > Yes it looks like DT code does not read Revision ATAG... I
> > tried to enable everything but always same problem...
>=20
> Maybe check if it shows up properly in /proc/atags or whatever
> the interface for it was?
>=20

With enabled CONFIG_ARM_APPENDED_DTB=3Dy file /proc/atags is=20
missing.

> The build_tag_list() should parse ATAG_REVISION and then
> parse_tag_revision() should copy it to system_rev. Maybe try
> adding some printks to see if those functions get called?
>=20
> Regards,
>=20
> Tony

Now I see... Problem is that build_tag_list() is called from=20
convert_to_tag_list() which is called from setup_machine_tags()=20
which is called from setup_arch() only if setup_machine_fdt()=20
call fails. And it fails for *non* DT boot. You can check this=20
chain too.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart5834737.7bDdQZy9x5
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlR2ZFkACgkQi/DJPQPkQ1LW4gCeL6mVEHhEQGkenb3/bEMNa/mS
pdAAniZ4dMBPKukXA0lOt+Xk17mh50XX
=jEGo
-----END PGP SIGNATURE-----

--nextPart5834737.7bDdQZy9x5--

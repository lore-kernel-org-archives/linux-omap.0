From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: ARM errata 430973 on multi platform kernels (was: OMAP3-N900: Add microphone bias voltages)
Date: Sun, 5 Apr 2015 15:26:14 +0200
Message-ID: <201504051526.14575@pali>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com> <CAOCHtYjCtmJNrkD0x78bm9b7hNvTKsZD2C2m5N=nR7p73R4zcg@mail.gmail.com> <20150405130045.GB9186@earth>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7768368.FXNzO8oAd1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34347 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbbDEN0S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Apr 2015 09:26:18 -0400
Received: by widjs5 with SMTP id js5so7328488wid.1
        for <linux-omap@vger.kernel.org>; Sun, 05 Apr 2015 06:26:16 -0700 (PDT)
In-Reply-To: <20150405130045.GB9186@earth>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Robert Nelson <robertcnelson@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

--nextPart7768368.FXNzO8oAd1
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 05 April 2015 15:00:45 Sebastian Reichel wrote:
> On Fri, Apr 03, 2015 at 02:21:48PM -0500, Robert Nelson wrote:
> > >> And yes, for armhf userland one gets random oopses at
> > >> least on the Nokia N900. AFAIK this is not true for all
> > >> ARMv7 processors (especially non omaps), though.
> > >>=20
> > >> > http://www.spinics.net/lists/linux-omap/msg108511.html
> > >> >=20
> > >> > See also 5c86c5339c56 ("ARM: omap2plus_defconfig:
> > >> > Enable ARM erratum 430973 for omap3").
> > >>=20
> > >> For me the random oopses occur without this config flag
> > >> and are fixed by it. The workaround is not very suitable
> > >> for multi platform kernels, though, since its enabled
> > >> also for unaffected platforms.
> > >>=20
> > >> As far as I can see the CONFIG_ARM_ERRATA_430973 flag is
> > >> checked in proc-v7.S and in proc-v7-2level.S. I think
> > >> the first file is irrelevant, since it can be fixed
> > >> later (see workaround in nokia_n900_legacy_init in
> > >> pdata-quirks.c).
> > >=20
> > > Yes so it seems, and the bootloaders should really set it.
> > > It's also disabled for multiplatform builds.
> >=20
> > These are now done in u-boot as of: v2015.04-rc4
> >=20
> > http://git.denx.de/?p=3Du-boot.git;a=3Dcommit;h=3Dc6f90e1418a84fe5
> > fa463b38403bd1845cb6a59c
>=20
> Seems like "include/configs/nokia_rx51.h" has been forgotten.
> Note, that the kernel must still be able to enable the bit
> itself (in case NOLO is used without u-boot).
>=20
> -- Sebastian

You must not expect that bootloader set something. Nokia N900 has=20
closed and signed bootloader which cannot be easily replaced and=20
or fixed.

=46or N900 there is U-Boot but it does not support lot of things=20
(load kernel via usb or serial) so for developers it is better to=20
use original Nokia bootloader.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart7768368.FXNzO8oAd1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlUhN/YACgkQi/DJPQPkQ1JVKwCeOYNpnhwTGRDxa3SBbayg9He4
DDUAoMlreNfbRZbrFubSehn4EaWHlxXo
=/idH
-----END PGP SIGNATURE-----

--nextPart7768368.FXNzO8oAd1--

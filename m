From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Fri, 28 Nov 2014 23:49:00 +0100
Message-ID: <201411282349.00487@pali>
References: <20141027200008.GR2560@atomide.com> <201411282241.12095@pali> <20141128224134.GB1382@fuloong-minipc.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3237069.yYvnvcaRni";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:55143 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbaK1WtE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2014 17:49:04 -0500
Received: by mail-wi0-f170.google.com with SMTP id bs8so21929958wib.1
        for <linux-omap@vger.kernel.org>; Fri, 28 Nov 2014 14:49:02 -0800 (PST)
In-Reply-To: <20141128224134.GB1382@fuloong-minipc.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--nextPart3237069.yYvnvcaRni
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 28 November 2014 23:41:35 Aaro Koskinen wrote:
> Hi,
>=20
> On Fri, Nov 28, 2014 at 10:41:12PM +0100, Pali Roh=C3=A1r wrote:
> > uboot (in mode when is loaded from NOLO) has those issues:
> >=20
> > 1) uboot cannot read n900 onenand mtd (uboot onenand driver
> > not working, do not know why)
> > 2) missing support for battery charging (can totally
> > discharge battery)
>=20
> NOLO enables watchdogs when booting. So if you get stuck in
> the U-boot for whatever reason the device will power off
> after ~30 secs or so.
>=20
> A.

Not truth!

Uboot RX51 code periodically kick watchdogs if are enabled. I=20
implemented that before RX51 uboot was merged into mainline.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3237069.yYvnvcaRni
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlR4+9wACgkQi/DJPQPkQ1KkoQCgsff6m+eclGj2Pd2A5j8IH9s+
sjYAoIS6qStDNa2dwkc8oZTFmXyyootE
=Q3tz
-----END PGP SIGNATURE-----

--nextPart3237069.yYvnvcaRni--

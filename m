From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Thu, 8 Jan 2015 10:01:34 +0100
Message-ID: <201501081001.34938@pali>
References: <20150105230228.GO4081@atomide.com> <54AD5447.2070601@ti.com> <20150107164005.GD4081@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4821368.B3uQCsnizq";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:63471 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbbAHJBj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2015 04:01:39 -0500
Received: by mail-wi0-f172.google.com with SMTP id n3so1819312wiv.5
        for <linux-omap@vger.kernel.org>; Thu, 08 Jan 2015 01:01:38 -0800 (PST)
In-Reply-To: <20150107164005.GD4081@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>

--nextPart4821368.B3uQCsnizq
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 07 January 2015 17:40:06 Tony Lindgren wrote:
> [   1.943] getting value of option 'R&D flags set'
> [   1.948] SETUP: WR VND DEVICE    req 42 value 0000 index
> 0000 length 001b
> [   1.956] Image 'kernel' won't fit to the
> partition, still loading it (4814592 bytes, while maximum is
> 2097152 bytes)
> [   1.967] Receiving kernel (length 4814592)
> [   2.298] Image successfully received
> [   2.302] SETUP: WR VND DEVICE    req 82 value 0000 index
> 0000 length 0000
> [   2.309] SETUP: WR STD INTERFACE
> SET_INTERFACE      value 0000 index 0002 length 0000
> [   2.363] Boot requested (normal mode)
> [   2.367] Serial console enabled

Tony, how did you get above verbose log from NOLO bootloader? Is=20
there any switch of R&D flag for it?

NOLO in qemu (on serial console) show few messages...

[   0.179] Loading kernel image info
Loading kernel (202 kB)... done in 27 ms (7457 kB/s)
[   0.202] Loading initfs image info
[   0.203] Total bootup time 286 ms
[   0.206] Serial console enabled

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4821368.B3uQCsnizq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlSuR24ACgkQi/DJPQPkQ1JN1gCeN1TdAX2pUUWO9/L169F20m/v
o24AmgLe3Qs5tLi/x3l4+rP6xSNOluP5
=2Tmp
-----END PGP SIGNATURE-----

--nextPart4821368.B3uQCsnizq--

From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] ARM: dts: Revert disabling of smc91x for n900
Date: Thu, 19 Feb 2015 11:59:57 +0100
Message-ID: <201502191159.57981@pali>
References: <20150105230228.GO4081@atomide.com> <201502182352.16203@pali> <20150219045047.GE32521@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4334981.PnggV7RlPR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:47026 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883AbbBSLAB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2015 06:00:01 -0500
In-Reply-To: <20150219045047.GE32521@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Nishanth Menon <nm@ti.com>

--nextPart4334981.PnggV7RlPR
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 19 February 2015 05:50:48 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150218 15:58]:
> > On Wednesday 18 February 2015 23:42:06 Tony Lindgren wrote:
> > > Of course it's always possible to do do a
> > > omap3-n900-qemu.dts if larger changes are needed :)
> >=20
> > I would like to avoid using separate DTS for qemu. When we
> > have only one DTS file (for both qemu and real HW), we can
> > test for regression in qemu and we are sure that we have
> > same software configuration...
>=20
> Agreed, and I'd rather take the extra warning on rare to find
> hardware to avoid an etra .dts file.
>=20
> Are there any reasons whey the n900 qemu support could not
> be in the mainline qemu btw?
>=20
> Regards,
>=20
> Tony

Missing lot of omap stuff (in mainline qemu) which linaro have=20
not sent to mainline yet...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4334981.PnggV7RlPR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTlwi0ACgkQi/DJPQPkQ1LjJACghAEOrWM2jhBAp3Gsngkfd9HW
aVAAn2OMvVJNASGoMKik0iYj4u2N3Pg2
=wEtP
-----END PGP SIGNATURE-----

--nextPart4334981.PnggV7RlPR--

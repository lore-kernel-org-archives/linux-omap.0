From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re: 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Sat, 24 Jan 2015 11:40:34 +0100
Message-ID: <201501241140.34479@pali>
References: <20131206213613.GA19648@earth.universe> <20131207230305.GA9103@earth.universe> <20131207232205.GS26766@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart11567302.RfjF2xuMdB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:48171 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbbAXKkh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jan 2015 05:40:37 -0500
Received: by mail-we0-f181.google.com with SMTP id k48so1594098wev.12
        for <linux-omap@vger.kernel.org>; Sat, 24 Jan 2015 02:40:36 -0800 (PST)
In-Reply-To: <20131207232205.GS26766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@ring0.de>

--nextPart11567302.RfjF2xuMdB
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 08 December 2013 00:22:06 Tony Lindgren wrote:
> * Sebastian Reichel <sre@ring0.de> [131207 15:04]:
> > On Sat, Dec 07, 2013 at 01:11:37PM -0800, Tony Lindgren=20
wrote:
> > > > I asked Pali to send me his copy of the updated NOLO
> > > > bootloader, so that I can test this. I just checked the
> > > > omap documentation (I only have access to the public
> > > > one) and crypto related stuff is not documented for the
> > > > L3_PM_READ_PERMISSION register. There are a couple of
> > > > reserved bits, which may be used for this, though.
> > > >=20
> > > > I also CC'd Joel Fernandes, since he worked on the
> > > > driver before and may have access to the documentation.
> > >=20
> > > Looks like at least the 36xx public version referenced
> > > here has them:
> > >=20
> > > http://www.spinics.net/lists/linux-omap/msg21857.html
> > >=20
> > > I'd assume the registers are the same for 34xx since we
> > > don't have them defined separately in the kernel.
> >=20
> > I can't find it in the omap36xx documentation either. Maybe
> > I search at the wrong position. I tried to find something
> > crypto related in
> >=20
> > Table 9-89. L3_PM_READ_PERMISSION_i
>=20
> Hmm maybe it's done based on the address in
> L3_PM_ADDR_MATCH_k?
>=20
> I guess the thing to do would be to compare the register
> output between the two different firmware versions.
>=20
> Regards,
>=20
> Tony

Joel Fernandes, you are author of omap-des driver. Do you know=20
something about crashing kernel when omap crypto support (via L3=20
firewall) is not enabled by bootloader? Do you know something=20
about runtime detection of crypto support to prevent kernel/board=20
crash?

Problem with kernel log of omap-aes is reported there:
http://thread.gmane.org/gmane.linux.ports.arm.omap/108397/

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart11567302.RfjF2xuMdB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTDdqIACgkQi/DJPQPkQ1LOFwCeKo6x5sgF1G/59Y30sywgTrLg
CkcAoLYXxTqFLTBAH4hSfaAKv08aH8IT
=jofD
-----END PGP SIGNATURE-----

--nextPart11567302.RfjF2xuMdB--

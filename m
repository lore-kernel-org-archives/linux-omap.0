From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re: 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Sat, 31 Jan 2015 20:09:58 +0100
Message-ID: <201501312009.58483@pali>
References: <20131206213613.GA19648@earth.universe> <201501241140.34479@pali> <CAALWOA92XmRoJwg5vcL+bLQU-O+6Guxgq4cq+76kYRbLOL+i6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6502069.v56LZhVcfT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:50208 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbbAaTKB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jan 2015 14:10:01 -0500
Received: by mail-wg0-f45.google.com with SMTP id x12so32169963wgg.4
        for <linux-omap@vger.kernel.org>; Sat, 31 Jan 2015 11:10:00 -0800 (PST)
In-Reply-To: <CAALWOA92XmRoJwg5vcL+bLQU-O+6Guxgq4cq+76kYRbLOL+i6Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Joel Fernandes <joelf@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@ring0.de>

--nextPart6502069.v56LZhVcfT
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 31 January 2015 15:38:28 Matthijs van Duin wrote:
> On Sunday 08 December 2013 00:22:06 Tony Lindgren wrote:
> > * Sebastian Reichel <sre@ring0.de> [131207 15:04]:
> > > On Sat, Dec 07, 2013 at 01:11:37PM -0800, Tony Lindgren=20
> > > wrote:
> > > > > I asked Pali to send me his copy of the updated NOLO
> > > > > bootloader, so that I can test this. I just checked
> > > > > the omap documentation (I only have access to the
> > > > > public one) and crypto related stuff is not
> > > > > documented for the L3_PM_READ_PERMISSION register.
> > > > > There are a couple of reserved bits, which may be
> > > > > used for this, though.
> > > > >=20
> > > > > I also CC'd Joel Fernandes, since he worked on the
> > > > > driver before and may have access to the
> > > > > documentation.
> > > >=20
> > > > Looks like at least the 36xx public version referenced
> > > > here has them:
> > > >=20
> > > > http://www.spinics.net/lists/linux-omap/msg21857.html
> > > >=20
> > > > I'd assume the registers are the same for 34xx since we
> > > > don't have them defined separately in the kernel.
> > >=20
> > > I can't find it in the omap36xx documentation either.
> > > Maybe I search at the wrong position.
>=20
> I've checked a few of the oldest (in case it was later
> removed) and newest (in case it was later added) omap3-series
> public TRMs I have, none of them list the aes module or
> associated interconnect info. The region is either "reserved"
> or just silently skipped over. The practice of pretending
> something doesn't exist in the TRM while simultaneously
> releasing a linux driver continues to puzzle me.
>=20
> > > I tried to find something crypto related in
> > >=20
> > > Table 9-89. L3_PM_READ_PERMISSION_i
> >=20
> > Hmm maybe it's done based on the address in
> > L3_PM_ADDR_MATCH_k?
>=20
> According to the address (aes@480c5000) it's attached to the
> L4-Core interconnect, so why would an L3 firewall be
> involved?  Its access control would be configured in the
> L4-Core AP (2KB @ 0x48040000), and since they have an
> integrated memory map you'd automatically know which entry is
> responsible, assuming you can access the AP at all.

Do you have idea if it is possible to write such check in kernel=20
if address (aes@480c5000) is readable or not?

I have configured two testing N900 devices. One with signed=20
bootloader which enable omap aes support and one device with=20
signed bootloader which does not enable omap aes support.

So I can run any code/kernel patch and compare results/dumps=20
between those two devices.

Just I do not know what to do, or what to test...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart6502069.v56LZhVcfT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTNKIYACgkQi/DJPQPkQ1KC0QCfaMG130AZGoKpMGIB/ducpxuk
kU8An1NwbgjdMQTPw8imOHt14RHt+YlN
=qNAR
-----END PGP SIGNATURE-----

--nextPart6502069.v56LZhVcfT--

From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 0/3] Drop more omap3 legacy board-*.c files for v4.2
Date: Tue, 5 May 2015 18:39:36 +0200
Message-ID: <201505051839.36882@pali>
References: <1430769717-4088-1-git-send-email-tony@atomide.com> <20150505145407.GK18002@pali> <20150505150638.GC21061@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1743657.bMkLDIcCOR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:36509 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933283AbbEEQjk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 May 2015 12:39:40 -0400
Received: by wgiu9 with SMTP id u9so26455414wgi.3
        for <linux-omap@vger.kernel.org>; Tue, 05 May 2015 09:39:39 -0700 (PDT)
In-Reply-To: <20150505150638.GC21061@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

--nextPart1743657.bMkLDIcCOR
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 05 May 2015 17:06:38 Tony Lindgren wrote:
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [150505 07:55]:
> > On Tuesday 05 May 2015 07:43:08 Tony Lindgren wrote:
> > > * Arnd Bergmann <arnd@arndb.de> [150505 03:56]:
> > > > On Monday 04 May 2015 13:01:54 Tony Lindgren wrote:
> > > > > For dropping the remaining omap3 legacy boot support,
> > > > > we still have the following board-*.c files:
> > > > >=20
> > > > > BOARD                   REASON NEEDED
> > > > > board-ldp.c             Still used in RMKs boot test
> > > > > system board-omap3logic.c      Getting a .dts file
> > > > > for v4.2 board-omap3pandora.c    Got a .dts file for
> > > > > v4.1 board-rx51-*.c          Needs /proc/atags
> > > > > support for user space
> > > > >=20
> > > > > I'm hoping we can drop those for v4.3 merge window,
> > > > > then keep the platform data around for one more merge
> > > > > window in case of reverting needed, then drop the
> > > > > platform data too for v4.4 if no issues needing
> > > > > reverting are found.
> > > >=20
> > > > Sounds great. Has there been a conclusion about what to
> > > > do for the rx51 /proc/atags support?
> > >=20
> > > I believe we just need to enable /proc/atags also for
> > > device tree based booting if CONFIG_ARM_ATAG_DTB_COMPAT.
> > > Pali may have more info on that.
> > >=20
> > > Then looks like Pali's two patches for showing the
> > > revision are still pending in thread "[PATCH v2 0/2] ARM:
> > > /proc/cpuinfo: DT: Add support for Revision":
> > >=20
> > > http://www.spinics.net/lists/arm-kernel/msg401535.html
> >=20
> > I think I already sent all need patches to ML. But I did not
> > check if you merged them or not. I did not get any new
> > comments for them for a while and right now I do not have
> > time for looking at it again.
>=20
> Oh OK, do you have link to the /proc/atags patch somewhere?
>=20
> Maybe Arnd and Nico can pick them up and sort out how we
> should queue them with Russell?
>=20

https://lkml.org/lkml/2015/1/26/648

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1743657.bMkLDIcCOR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlVI8kgACgkQi/DJPQPkQ1KIWwCeLJPHEEGgXAXDh7mIla/l1fck
vzgAoK178OtbwkzyqtTJMSSo1B1b/uT/
=W1to
-----END PGP SIGNATURE-----

--nextPart1743657.bMkLDIcCOR--

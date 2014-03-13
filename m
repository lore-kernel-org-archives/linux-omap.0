From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP4: hwmod data: correct the idlemodes for
 spinlock
Date: Thu, 13 Mar 2014 21:02:58 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1403132101490.25824@utopia.booyaka.com>
References: <1387838928-57745-1-git-send-email-s-anna@ti.com> <alpine.DEB.2.02.1312260447320.15949@utopia.booyaka.com> <20140313202547.GD5981@atomide.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-659868596-1394744578=:25824"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52141 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755382AbaCMVC7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2014 17:02:59 -0400
In-Reply-To: <20140313202547.GD5981@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>
Cc: Suman Anna <s-anna@ti.com>, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-659868596-1394744578=:25824
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 13 Mar 2014, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [131225 20:51]:
> > (cc Beno=C3=AEt)
> >=20
> > On Mon, 23 Dec 2013, Suman Anna wrote:
> >=20
> > > The spinlock module's SYSCONFIG register does not support
> > > smart wakeup, so remove this flag from the idle modes in
> > > the spinlock hwmod definition.
> > >=20
> > > Signed-off-by: Suman Anna <s-anna@ti.com>
> >=20
> > Beno=C3=AEt Cousson is the primary maintainer of this file that you're=
=20
> > changing:
> >=20
> > $ scripts/get_maintainer.pl -f arch/arm/mach-omap2/omap_hwmod_44xx_data=
=2Ec
> > "Beno=C3=AEt Cousson" <bcousson@baylibre.com> (maintainer:OMAP HWMOD DA=
TA F...)
> > Tony Lindgren <tony@atomide.com> (maintainer:OMAP SUPPORT)
> > Russell King <linux@arm.linux.org.uk> (maintainer:ARM PORT)
> > linux-omap@vger.kernel.org (open list:OMAP HWMOD DATA F...)
> > linux-arm-kernel@lists.infradead.org (moderated list:ARM SUB-ARCHITECT.=
=2E.)
> > linux-kernel@vger.kernel.org (open list)
> > $
> >=20
> > Please make sure that he's part of the address list when patches are se=
nt=20
> > that apply against this file. =20
>=20
> FYI untagging this in my inbox assuming it's being resent or queued by Pa=
ul.

Hmm, seems like it's either you or Beno=C3=AEt who is on the hook for this =
one. =20

Beno=C3=AEt?

Am happy to queue it if either of you want.


- Paul
--843723315-659868596-1394744578=:25824--

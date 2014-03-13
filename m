From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: hwmod data: correct the idlemodes for
 spinlock
Date: Thu, 13 Mar 2014 13:25:48 -0700
Message-ID: <20140313202547.GD5981@atomide.com>
References: <1387838928-57745-1-git-send-email-s-anna@ti.com>
 <alpine.DEB.2.02.1312260447320.15949@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36481 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197AbaCMUZw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2014 16:25:52 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1312260447320.15949@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Suman Anna <s-anna@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [131225 20:51]:
> (cc Beno=C3=AEt)
>=20
> On Mon, 23 Dec 2013, Suman Anna wrote:
>=20
> > The spinlock module's SYSCONFIG register does not support
> > smart wakeup, so remove this flag from the idle modes in
> > the spinlock hwmod definition.
> >=20
> > Signed-off-by: Suman Anna <s-anna@ti.com>
>=20
> Beno=C3=AEt Cousson is the primary maintainer of this file that you'r=
e=20
> changing:
>=20
> $ scripts/get_maintainer.pl -f arch/arm/mach-omap2/omap_hwmod_44xx_da=
ta.c
> "Beno=C3=AEt Cousson" <bcousson@baylibre.com> (maintainer:OMAP HWMOD =
DATA F...)
> Tony Lindgren <tony@atomide.com> (maintainer:OMAP SUPPORT)
> Russell King <linux@arm.linux.org.uk> (maintainer:ARM PORT)
> linux-omap@vger.kernel.org (open list:OMAP HWMOD DATA F...)
> linux-arm-kernel@lists.infradead.org (moderated list:ARM SUB-ARCHITEC=
T...)
> linux-kernel@vger.kernel.org (open list)
> $
>=20
> Please make sure that he's part of the address list when patches are =
sent=20
> that apply against this file. =20

=46YI untagging this in my inbox assuming it's being resent or queued b=
y Paul.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

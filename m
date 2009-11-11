From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/8] omap1: Amstrad Delta defconfig fixes
Date: Wed, 11 Nov 2009 10:56:09 -0800
Message-ID: <20091111185609.GE24837@atomide.com>
References: <20091111025907.31793.84134.stgit@localhost>
 <20091111030057.31793.60438.stgit@localhost>
 <200911111825.00281.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50669 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758380AbZKKS4O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 13:56:14 -0500
Content-Disposition: inline
In-Reply-To: <200911111825.00281.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jonathan McDowell <noodles@earth.li>, e3-hacking@earth.li

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091111 09:24]:
> Wednesday 11 November 2009 04:00:57 Tony Lindgren napisa=C5=82(a):
> > From: Janusz Krzysztofik <jkrzysz@tis.icnet.pl>
> >
> > The patch provides the following fixes:
> >
> > - keep kernel small enough to boot with standard tools,
> > - ensure compatibility with both new and legacy distros,
> > - turn on support for recently added or fixed hardware features.
> >
> > Created and tested against linux-2.6.32-rc5.
> >
> > Signed-off-by: Janusz Krzysztofik <jkrzysz@tis.icnet.pl>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> Tony,
>=20
> Please do not apply this patch yet, or revert it if already applied. =
It would=20
> exhibit the LCD DMA not working bug when CONFIG_PM=3Dy, as I tried to=
 state=20
> while submitting v2 of my fix that corrected the issue=20
> (http://www.spinics.net/lists/linux-omap/msg19963.html).
>=20
> Sorry for not stating that again with this submission (or not waiting=
 with=20
> the submission after the bug is fixed first). That happened after I=20
> misinterpreted your comment "Sounds good to me." =20
> (http://www.spinics.net/lists/linux-omap/msg19965.html) as your accep=
tance=20
> for the patch v2 as posted, with my self proposed changes, that resul=
ted in v3 =20
> submission directly (http://www.spinics.net/lists/linux-omap/msg20059=
=2Ehtml),=20
> that has been objected by you next.

OK, sorry looks like I forgot that issue..

I suggest we keep this patch, and also add your v3 patch before this on=
e.

I'll post your v3 patch to this thread with an added comment about
moving the OMAP_LCDC_ defines during the next merge cycle.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

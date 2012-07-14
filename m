From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP3: clockdomain: fix accidental duplicate
 registration
Date: Sat, 14 Jul 2012 11:54:52 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207141150340.3876@utopia.booyaka.com>
References: <alpine.DEB.2.00.1207120448120.25585@utopia.booyaka.com> <87394wg97u.fsf@ti.com> <20120713064713.GI1122@atomide.com> <20120714085257.GB6522@atomide.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-2014395355-1342288492=:3876"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34629 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab2GNRyx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Jul 2012 13:54:53 -0400
In-Reply-To: <20120714085257.GB6522@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-2014395355-1342288492=:3876
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 14 Jul 2012, Tony Lindgren wrote:

> As the tmp-merge branch has other branches and never goes upstream, the
> commit should say:
>=20
> Commit 472fd5401561f94698f4c8f9dbbbfbf76ab55626 (Merge branch 'cleanup-hw=
mod'
> into cleanup)... So I've updated the patch and applied it into l-o master=
=2E

Thanks for fixing it.

> The patch seems to produce a new warning against arm soc tree=20
> next/cleanup branch:
>=20
> warning: =E2=80=98mpu_3xxx_clkdm=E2=80=99 defined but not used
>=20
> Paul, care to check if a change is needed for the arm soc tree
> next/cleanup branch version of this patch?

arm-soc next/cleanup branch doesn't include commit 16e5e2c4 ("ARM: OMAP=20
AM35x: clockdomain data: Fix clockdomain dependencies").  So that patch=20
won't apply there, and the copy of mach-omap2/clockdomains3xxx_data.c in=20
that branch is clean.


- Paul
--155748971-2014395355-1342288492=:3876--

From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP3: clockdomain: fix accidental duplicate
 registration
Date: Sat, 14 Jul 2012 01:52:58 -0700
Message-ID: <20120714085257.GB6522@atomide.com>
References: <alpine.DEB.2.00.1207120448120.25585@utopia.booyaka.com>
 <87394wg97u.fsf@ti.com>
 <20120713064713.GI1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:16440 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab2GNIxC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Jul 2012 04:53:02 -0400
Content-Disposition: inline
In-Reply-To: <20120713064713.GI1122@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Joe Woodward <jw@terrafix.co.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120712 23:52]:
> * Kevin Hilman <khilman@ti.com> [120712 10:55]:
> > Paul Walmsley <paul@pwsan.com> writes:
> >=20
> > > Commit 3dd50d0545bd5a8ad83d4339f07935cd3e883271 ("Merge tag=20
> > > 'omap-cleanup-for-v3.6' into tmp-merge") inadvertently caused a=20
> > > clockdomain to be registered twice on OMAP3 boards.  This causes =
warnings=20
> > > on boot, wild pointer dereferences, and PM regressions.  Fix the =
double=20
> > > registration and add some clockdomain code to prevent this from h=
appening=20
> > > again.

As the tmp-merge branch has other branches and never goes upstream, the
commit should say:

Commit 472fd5401561f94698f4c8f9dbbbfbf76ab55626 (Merge branch 'cleanup-=
hwmod'
into cleanup)... So I've updated the patch and applied it into l-o mast=
er.

The patch seems to produce a new warning against arm soc tree next/clea=
nup
branch:

warning: =E2=80=98mpu_3xxx_clkdm=E2=80=99 defined but not used

Paul, care to check if a change is needed for the arm soc tree
next/cleanup branch version of this patch?

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

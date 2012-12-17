From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: Split vrfb.c to remove last remaining
 cpu_is_omap usage
Date: Mon, 17 Dec 2012 09:19:38 -0800
Message-ID: <20121217171938.GS4989@atomide.com>
References: <20121216200236.24238.38151.stgit@muffinssi.local>
 <20121216200314.24238.9481.stgit@muffinssi.local>
 <50CEE65C.20009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:19412 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752988Ab2LQRTo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Dec 2012 12:19:44 -0500
Content-Disposition: inline
In-Reply-To: <50CEE65C.20009@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [121217 01:33]:
> On 2012-12-16 22:03, Tony Lindgren wrote:
> > Looks like we missed plat-omap/fb.c for cpu_is_omap usage
> > mach-omap2. This is the last user of cpu_is_omap, so let's
> > quickly fix it up so we can finally remove plat/cpu.h for
> > omap2lus.
> > 
> > We want to limit cpu_is_omap macro usage to mach-omap2 only so
> > we can make plat/cpu.h private. After this we can finally drop
> > plat/cpu.h for omap2+.
> > 
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap1/Makefile |    2 +
> >  arch/arm/mach-omap1/fb.c     |   80 ++++++++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/Makefile |    2 +
> >  arch/arm/mach-omap2/fb.c     |   50 +-------------------------
> >  arch/arm/plat-omap/Makefile  |    2 +
> >  5 files changed, 85 insertions(+), 51 deletions(-)
> >  create mode 100644 arch/arm/mach-omap1/fb.c
> >  rename arch/arm/{plat-omap/fb.c => mach-omap2/fb.c} (76%)
> 
> Ok, I didn't realize that plat-omap cannot refer to cpu_is_omap either.

We could, but I'd rather not as what we have left in plat-omap should
all be just drivers eventually. And in this case the fb code is already
completely separate for omap1 and omap2+, so it's better just to split
it up. It makes fixing up the initcalls for omap2+ multiplatform easier
when booting on other SoCs than omap.

> The patch looks fine, except the subject should say "split fb.c", not
> "split vrfb.c".

Thanks I'll update the subject.

Regards,

Tony

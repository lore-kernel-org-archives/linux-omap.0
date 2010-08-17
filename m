From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/4] omap: Fix SMP on UP interrupt handling for
 multi-omap
Date: Tue, 17 Aug 2010 14:30:45 +0300
Message-ID: <20100817113045.GH12184@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
 <20100817105332.19061.44765.stgit@baageli.muru.com>
 <1282043269.32205.13.camel@bnru01>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62155 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755646Ab0HQLar (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 07:30:47 -0400
Content-Disposition: inline
In-Reply-To: <1282043269.32205.13.camel@bnru01>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: srinidhi <srinidhi.kasagar@stericsson.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>

* srinidhi <srinidhi.kasagar@stericsson.com> [100817 14:00]:
> On Tue, 2010-08-17 at 12:53 +0200, Tony Lindgren wrote:
> > Fix SMP on UP interrupt handling for multi-omap
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/mach-omap2/include/mach/entry-macro.S |   22 ++++++++++++++++++++++
> >  arch/arm/mach-omap2/omap-smp.c                 |   16 ++++++++++++----
> >  arch/arm/mach-omap2/timer-gp.c                 |    7 +++++--
> >  3 files changed, 39 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
> > index 06e64e1..75c67aa 100644
> > --- a/arch/arm/mach-omap2/include/mach/entry-macro.S
> > +++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
> 
> There is one patch lying in Russell's tracker (6284/1) which attempts to
> use the common IRQ helper macros instead of platforms duplicating this
> file. Perhaps you may need to re-base to that if Russell is ok with that
> patch, of course.

Nice to see. Ideally test_for_ipi and test_for_ltirq would return
early automatically when running SMP kernel on UP.

BTW, did you test patch 6284/1 with omap3_defconfig to make sure
that still boots on omap3 & 4?

Regards,

Tony

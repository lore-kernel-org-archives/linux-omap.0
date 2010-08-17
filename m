From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 4/4] omap: Fix SMP on UP interrupt handling for
 multi-omap
Date: Tue, 17 Aug 2010 20:37:22 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6721FAD@dbde02.ent.ti.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
 <20100817105332.19061.44765.stgit@baageli.muru.com>
 <1282043269.32205.13.camel@bnru01> <20100817113045.GH12184@atomide.com>
 <1282047250.32205.17.camel@bnru01> <20100817141428.GK12184@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44851 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837Ab0HQPHh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 11:07:37 -0400
In-Reply-To: <20100817141428.GK12184@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, srinidhi <srinidhi.kasagar@stericsson.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Tuesday, August 17, 2010 7:44 PM
> To: srinidhi
> Cc: linux-arm-kernel@lists.infradead.org; linux-omap@vger.kernel.org;
> bryan.wu@canonical.com; Shilimkar, Santosh
> Subject: Re: [PATCH 4/4] omap: Fix SMP on UP interrupt handling for multi-
> omap
> 
> * srinidhi <srinidhi.kasagar@stericsson.com> [100817 15:07]:
> > On Tue, 2010-08-17 at 13:30 +0200, Tony Lindgren wrote:
> > > * srinidhi <srinidhi.kasagar@stericsson.com> [100817 14:00]:
> > > > On Tue, 2010-08-17 at 12:53 +0200, Tony Lindgren wrote:
> > > > > Fix SMP on UP interrupt handling for multi-omap
> > > > >
> > > > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > > > ---
> > > > >  arch/arm/mach-omap2/include/mach/entry-macro.S |   22
> ++++++++++++++++++++++
> > > > >  arch/arm/mach-omap2/omap-smp.c                 |   16
> ++++++++++++----
> > > > >  arch/arm/mach-omap2/timer-gp.c                 |    7 +++++--
> > > > >  3 files changed, 39 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S
> b/arch/arm/mach-omap2/include/mach/entry-macro.S
> > > > > index 06e64e1..75c67aa 100644
> > > > > --- a/arch/arm/mach-omap2/include/mach/entry-macro.S
> > > > > +++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
> > > >
> > > > There is one patch lying in Russell's tracker (6284/1) which
> attempts to
> > > > use the common IRQ helper macros instead of platforms duplicating
> this
> > > > file. Perhaps you may need to re-base to that if Russell is ok with
> that
> > > > patch, of course.
> > >
> > > Nice to see. Ideally test_for_ipi and test_for_ltirq would return
> > > early automatically when running SMP kernel on UP.
> > >
> > > BTW, did you test patch 6284/1 with omap3_defconfig to make sure
> > > that still boots on omap3 & 4?
> >
> > Just build tested for all other machines and boot tested on ux500
> > machine. I do not have omap and other boards :(
> 
> OK, I'll give your patch a try on some omap3 board, maybe Santosh
> can test it on omap4.
> 
I tested patch 6284/1 on OMAP4 and OMAP3 SDPs with multi-omap and
normal build. Both boots well

Regards,
Santosh

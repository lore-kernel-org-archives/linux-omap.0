From: srinidhi <srinidhi.kasagar@stericsson.com>
Subject: Re: [PATCH 4/4] omap: Fix SMP on UP interrupt handling for
 multi-omap
Date: Tue, 17 Aug 2010 17:44:10 +0530
Message-ID: <1282047250.32205.17.camel@bnru01>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
	 <20100817105332.19061.44765.stgit@baageli.muru.com>
	 <1282043269.32205.13.camel@bnru01>  <20100817113045.GH12184@atomide.com>
Reply-To: srinidhi.kasagar@stericsson.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:51447 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751340Ab0HQMO2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Aug 2010 08:14:28 -0400
In-Reply-To: <20100817113045.GH12184@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>

On Tue, 2010-08-17 at 13:30 +0200, Tony Lindgren wrote:
> * srinidhi <srinidhi.kasagar@stericsson.com> [100817 14:00]:
> > On Tue, 2010-08-17 at 12:53 +0200, Tony Lindgren wrote:
> > > Fix SMP on UP interrupt handling for multi-omap
> > > 
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > ---
> > >  arch/arm/mach-omap2/include/mach/entry-macro.S |   22 ++++++++++++++++++++++
> > >  arch/arm/mach-omap2/omap-smp.c                 |   16 ++++++++++++----
> > >  arch/arm/mach-omap2/timer-gp.c                 |    7 +++++--
> > >  3 files changed, 39 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
> > > index 06e64e1..75c67aa 100644
> > > --- a/arch/arm/mach-omap2/include/mach/entry-macro.S
> > > +++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
> > 
> > There is one patch lying in Russell's tracker (6284/1) which attempts to
> > use the common IRQ helper macros instead of platforms duplicating this
> > file. Perhaps you may need to re-base to that if Russell is ok with that
> > patch, of course.
> 
> Nice to see. Ideally test_for_ipi and test_for_ltirq would return
> early automatically when running SMP kernel on UP.
> 
> BTW, did you test patch 6284/1 with omap3_defconfig to make sure
> that still boots on omap3 & 4?

Just build tested for all other machines and boot tested on ux500
machine. I do not have omap and other boards :(

Srinidhi



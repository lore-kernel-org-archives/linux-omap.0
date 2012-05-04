From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap: add minimal support for Nokia RM-696
Date: Fri, 4 May 2012 11:11:05 -0700
Message-ID: <20120504181105.GL5613@atomide.com>
References: <1330967337-9634-1-git-send-email-aaro.koskinen@nokia.com>
 <20120501104801.GA23559@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:31164 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab2EDSLM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 14:11:12 -0400
Content-Disposition: inline
In-Reply-To: <20120501104801.GA23559@elf.ucw.cz>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Pavel,

* Pavel Machek <pavel@ucw.cz> [120501 03:51]:
> Hi!
> 
> > Add minimal support for Nokia RM-696 board.
> > 
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> > ---
> > 
> > 	The patch is based & boot-tested with 3.3-rc6.
> > 
> > 
> >  arch/arm/mach-omap2/Kconfig                  |    3 ++-
> >  arch/arm/mach-omap2/board-rm680.c            |   14 +++++++++++++-
> >  arch/arm/plat-omap/include/plat/uncompress.h |    1 +
> >  3 files changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > index e20c8ab..b740c2e 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -245,10 +245,11 @@ config MACH_NOKIA_N8X0
> >  	select MACH_NOKIA_N810_WIMAX
> >  
> >  config MACH_NOKIA_RM680
> > -	bool "Nokia RM-680 board"
> > +	bool "Nokia RM-680/696 board"
> >  	depends on ARCH_OMAP3
> >  	default y
> >  	select OMAP_PACKAGE_CBB
> > +	select MACH_NOKIA_RM696
> >
> 
> AFAICT, this is nokia N9. At least help text should state that...
> 
> >  config MACH_NOKIA_RX51
> >  	bool "Nokia RX-51 board"
> > diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
> > index 8678b38..094473e 100644
> > --- a/arch/arm/mach-omap2/board-rm680.c
> > +++ b/arch/arm/mach-omap2/board-rm680.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * Board support file for Nokia RM-680.
> > + * Board support file for Nokia RM-680/696.
> >   *
> 
> And a comment.

Sorry this is already in mainline tree as commit
63fc5f3bb3d0ca9ab4767a801b518aa6335f87ad.

Care to do a follow-up patch to add some N9 comments to Kconfig and
board-rm680.c?

Tony

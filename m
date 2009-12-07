From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: cm-t35: add mux initialization
Date: Mon, 7 Dec 2009 08:22:09 -0800
Message-ID: <20091207162209.GV24013@atomide.com>
References: <cover.1259481545.git.mike@compulab.co.il>
 <4B1BCE62.1050005@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60837 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbZLGQWF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 11:22:05 -0500
Content-Disposition: inline
In-Reply-To: <4B1BCE62.1050005@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-omap@vger.kernel.org

* Mike Rapoport <mike@compulab.co.il> [091206 07:30]:
> Tony,
> Any chance this can go to 2.6.33?

Sure, I was just waiting to hear back if the OUTPUT_PULLUP is
needed for sure? Or is just OUTPUT enough for musb to work?

Tony


 
> Mike Rapoport wrote:
> > Tony,
> > 
> > These patches are follow-ups to your mux rework series.
> > The first one is pretty trivial and adds OUTPUT_PULL{UP,DOWN} to shorten
> > the lines in omap_board_mux arrays. 
> > The second patch adds the mux configuration for CM-T35. This is actually
> > the most compact subset of 'cat /sys/kernel/debug/omap_mux/board' that makes
> > CM-T35 functional :)
> > 
> > The following changes since commit d8bfa71e2e9d794f9c7e5b019f316804f7f50582:
> >   Tony Lindgren (1):
> >           omap: mux: Add data for 2430
> > 
> > Mike Rapoport (2):
> >   omap3: mux: add shorthands for OUTPUT_PULL{UP,DOWN}
> >   omap3: cm-t35: add mux initialization
> > 
> >  arch/arm/mach-omap2/Kconfig        |    1 +
> >  arch/arm/mach-omap2/board-cm-t35.c |   95 +++++++++++++++++++++++++++++++++--
> >  arch/arm/mach-omap2/mux.h          |    2 +
> >  3 files changed, 92 insertions(+), 6 deletions(-)
> > 
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 

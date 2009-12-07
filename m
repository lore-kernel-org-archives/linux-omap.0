From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH] omap3: cm-t35: add mux initialization
Date: Mon, 7 Dec 2009 22:05:01 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0309C863C8@dbde02.ent.ti.com>
References: <cover.1259481545.git.mike@compulab.co.il>
 <4B1BCE62.1050005@compulab.co.il>,<20091207162209.GV24013@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56015 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbZLGQgv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 11:36:51 -0500
In-Reply-To: <20091207162209.GV24013@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Mike Rapoport <mike@compulab.co.il>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony Lindgren wrote: 
> * Mike Rapoport <mike@compulab.co.il> [091206 07:30]:
> > Tony,
> > Any chance this can go to 2.6.33?
> 
> Sure, I was just waiting to hear back if the OUTPUT_PULLUP is
> needed for sure? Or is just OUTPUT enough for musb to work?
> 
> Tony
> 

OUTPUT should work too. The ULPI spec recommends a weak pull-up
on STP line, but we needn't really have that. Plain OUTPUT is sufficient.

Regards,
Anand

> 
> 
> > Mike Rapoport wrote:
> > > Tony,
> > >
> > > These patches are follow-ups to your mux rework series.
> > > The first one is pretty trivial and adds OUTPUT_PULL{UP,DOWN} to shorten
> > > the lines in omap_board_mux arrays.
> > > The second patch adds the mux configuration for CM-T35. This is actually
> > > the most compact subset of 'cat /sys/kernel/debug/omap_mux/board' that makes
> > > CM-T35 functional :)
> > >
> > > The following changes since commit d8bfa71e2e9d794f9c7e5b019f316804f7f50582:
> > >   Tony Lindgren (1):
> > >           omap: mux: Add data for 2430
> > >
> > > Mike Rapoport (2):
> > >   omap3: mux: add shorthands for OUTPUT_PULL{UP,DOWN}
> > >   omap3: cm-t35: add mux initialization
> > >
> > >  arch/arm/mach-omap2/Kconfig        |    1 +
> > >  arch/arm/mach-omap2/board-cm-t35.c |   95 +++++++++++++++++++++++++++++++++--
> > >  arch/arm/mach-omap2/mux.h          |    2 +
> > >  3 files changed, 92 insertions(+), 6 deletions(-)
> > >
> > >
> >
> > --
> > Sincerely yours,
> > Mike.
> >

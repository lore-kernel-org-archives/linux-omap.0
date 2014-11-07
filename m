From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] arm: omap: hwmod: drop unnecessary list initialization
Date: Fri, 7 Nov 2014 14:09:55 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1411071408200.25985@utopia.booyaka.com>
References: <1405455492-1087-1-git-send-email-balbi@ti.com> <alpine.DEB.2.02.1407280524160.24161@utopia.booyaka.com> <20141104053952.GA15760@saruman> <20141106161940.GE16896@saruman>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41325 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971AbaKGOJ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2014 09:09:56 -0500
In-Reply-To: <20141106161940.GE16896@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi

On Thu, 6 Nov 2014, Felipe Balbi wrote:

> On Mon, Nov 03, 2014 at 11:39:52PM -0600, Felipe Balbi wrote:
> > Hi,
> > 
> > On Mon, Jul 28, 2014 at 05:24:34AM +0000, Paul Walmsley wrote:
> > > On Tue, 15 Jul 2014, Felipe Balbi wrote:
> > > 
> > > > ml->node and sl->node are currently initialized
> > > > by means of INIT_LIST_HEAD(). That initialiation
> > > > is followed by a list_add() call.
> > > > 
> > > > Looking at what both these functions do we will have:
> > > > 
> > > > 	ml->node.next = &ml->node;
> > > > 	ml->node.prev = &ml->node;
> > > > 	oi->master->master_ports.next.prev = &ml->node;
> > > > 	ml->node.next = &oi->master->master_ports.next;
> > > > 	ml->node.prev = &oi->master->master_ports;
> > > > 	oi->master->master_ports.next = &ml->node;
> > > > 
> > > > from this, it's clear that both INIT_LIST_HEAD() calls
> > > > are unnecessary and can be safely removed.
> > > > 
> > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > > ---
> > > > 
> > > > found by code inspection, boot tested on am437x SK on today's
> > > > linux-next + pending patches.
> > > 
> > > Thanks, queued for v3.18.
> > 
> > This is not on v3.18, what happened ?
> > 
> > $ git log --author=balbi@ti.com linus/master ^v3.17 -- arch/arm/mach-omap2/omap_hwmod.c
> > $
> 
> ping

I wound up not sending any OMAP patches upstream for the v3.18 merge 
window - instead just acking them.   This one has been requeued for v3.19.


- Paul

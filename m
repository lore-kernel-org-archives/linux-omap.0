From: Tony Lindgren <tony@atomide.com>
Subject: Re: RFC: Reclaim address space on omaps, Tony on vacation in July
Date: Fri, 26 Jun 2009 11:57:52 +0300
Message-ID: <20090626085752.GE7352@atomide.com>
References: <20090626062539.GX7352@atomide.com> <20090626083722.GP8354@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49758 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660AbZFZI6A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Jun 2009 04:58:00 -0400
Content-Disposition: inline
In-Reply-To: <20090626083722.GP8354@trinity.fluff.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

* Ben Dooks <ben-linux@fluff.org> [090626 11:37]:
> On Fri, Jun 26, 2009 at 09:25:40AM +0300, Tony Lindgren wrote:
> > Hi all,
> > 
> > Last week I posted some more omap io.h clean-up patches to the linux-omap
> > list [1], and started looking at what it would take to reclaim lost address
> > space on top of the io.h clean-up patches.
> > 
> > Looks like we should be able to reclaim about 454MB of the 640MB
> > of the lost IO address space by doing the following:
> > 
> > 1. Start converting drivers using omap_read/write to use ioremap +
> >    __raw_read/write
> 
> ioremap implies readl/writel, the __raw stuff is for items that have been
> mapped by iodesc (iirc).

Thanks, will take a look at the iodesc.

Tony

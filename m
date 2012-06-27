From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/11] Prepare for OMAP2+ movement to Common Clk
Date: Wed, 27 Jun 2012 13:59:21 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206271344200.27496@utopia.booyaka.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1206271033500.27496@utopia.booyaka.com> <1854687.1eeiLuW4oH@avalon> <2606265.VPQJMxIymh@avalon>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43843 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738Ab2F0T7V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 15:59:21 -0400
In-Reply-To: <2606265.VPQJMxIymh@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Rajendra Nayak <rnayak@ti.com>, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sakari Ailus <sakari.ailus@iki.fi>, khilman@ti.com

+ Kevin

On Wed, 27 Jun 2012, Laurent Pinchart wrote:

> OK, I think I've found the information. I'll give this a try.

That sounds great.

> What is still not clear to me is how runtime PM and system PM interact. For 
> instance the OMAP3 ISP driver disables its clocks in the system PM suspend 
> handler, and restarts them in the system PM resume handler. How do I port that 
> to runtime PM, can I just call pm_runtime_put() and pm_runtime_get_sync() in 
> the system PM handlers ?

I've lost track of what the official guidance on this is.  But we have 
plenty of drivers that do this.  A few examples are 
drivers/mmc/host/omap_hsmmc.c, drivers/spi/spi-omap2-mcspi.c, and the DSS 
drivers.

IMHO, if possible, for the driver's system suspend call, the best thing to 
do is to check to see if the driver is currently doing something.  If it 
is, then ask it to stop.  Then wait until it does.  When it stops, that 
other part of the driver is ideally what should do the pm_runtime_put*().  

It's been a long time since I've looked, but I'd be surprised if we had 
many drivers that operated like that...

- Paul

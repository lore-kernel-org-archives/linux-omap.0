From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: DMA: clear interrupt status correctly
Date: Wed, 19 Jan 2011 14:44:07 -0800
Message-ID: <20110119224406.GK4957@atomide.com>
References: <20101130132341.13286.25157.sendpatchset@ahunter-work.research.nokia.com>
 <20101130132355.13286.77389.sendpatchset@ahunter-work.research.nokia.com>
 <541b3a50479779f3e814aa93d506cbdd@mail.gmail.com>
 <20101221202914.GK5829@atomide.com>
 <4D2440E0.7040008@nokia.com>
 <87mxnfz2f4.fsf@ti.com>
 <4D36BBC8.2000305@nokia.com>
 <20110119222327.GJ4957@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:31877 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775Ab1ASWoU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 17:44:20 -0500
Content-Disposition: inline
In-Reply-To: <20110119222327.GJ4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Manjunath Kondaiah G <manjugk@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Tony Lindgren <tony@atomide.com> [110119 14:23]:
> * Adrian Hunter <adrian.hunter@nokia.com> [110119 02:23]:
> > 
> > From fffa19df17d73c1ed2e8c65c0b6604ee1dddff84 Mon Sep 17 00:00:00 2001
> > From: Adrian Hunter <adrian.hunter@nokia.com>
> > Date: Wed, 24 Nov 2010 13:23:21 +0200
> > Subject: [PATCH] OMAP: DMA: clear interrupt status correctly
> > 
> > When clearing the DMA channel, clear all status bits.
> > 
> > When handling a DMA interrupt, clear only the interrupt
> > status bits that have been read and are passed to the
> > channel's interrupt handler, not every status bit.
> > 
> > Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> 
> Thanks, will queue as a fix.

This did not apply for some reason, I've applied it manually.
Please check that I got it right in omap-fixes branch soonish.
Let me know if it needs updating.

Tony

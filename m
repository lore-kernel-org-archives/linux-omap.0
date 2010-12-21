From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] OMAP: DMA: clear interrupt status correctly
Date: Tue, 21 Dec 2010 12:29:14 -0800
Message-ID: <20101221202914.GK5829@atomide.com>
References: <20101130132341.13286.25157.sendpatchset@ahunter-work.research.nokia.com>
 <20101130132355.13286.77389.sendpatchset@ahunter-work.research.nokia.com>
 <541b3a50479779f3e814aa93d506cbdd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19557 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab0LUU3X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 15:29:23 -0500
Content-Disposition: inline
In-Reply-To: <541b3a50479779f3e814aa93d506cbdd@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Manjunath Kondaiah G <manjugk@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [101130 06:15]:
> > -----Original Message-----
> > From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
> > Sent: Tuesday, November 30, 2010 6:54 PM
> > To: Tony Lindgren
> > Cc: Santosh Shilimkar; Manjunatha GK; Adrian Hunter; linux-omap Mailing
> > List
> > Subject: [PATCH 2/2] OMAP: DMA: clear interrupt status correctly
> >
> > From 85934ded48552fde84b083575ac2006f1542324b Mon Sep 17 00:00:00 2001
> > From: Adrian Hunter <adrian.hunter@nokia.com>
> > Date: Wed, 24 Nov 2010 13:23:21 +0200
> > Subject: [PATCH 2/2] OMAP: DMA: clear interrupt status correctly
> >
> > When clearing the DMA channel, clear all status bits.
> >
> > When handling a DMA interrupt, clear only the interrupt
> > status bits that have been read and are passed to the
> > channel's interrupt handler, not every status bit.
> >
> > Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Adrian, care to refresh this one against the devel-dma
branch that has the hwmod changes?

Looks like at least the CSR_CLEAR_MASK is still wrong
in the current code.

Regards,

Tony

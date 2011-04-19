From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] OMAP: convert boards that use SMSC911x to use
 gpmc-smsc911x
Date: Tue, 19 Apr 2011 14:47:47 +0300
Message-ID: <20110419114746.GD15620@atomide.com>
References: <cover.1302992702.git.mike@compulab.co.il>
 <20110418112153.GK12272@atomide.com>
 <BANLkTimHO1TUZsKHZ4akbGG9+C+AmVrP=A@mail.gmail.com>
 <20110419114547.GC15620@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59787 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995Ab1DSLrv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Apr 2011 07:47:51 -0400
Content-Disposition: inline
In-Reply-To: <20110419114547.GC15620@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike.rapoport@gmail.com>
Cc: Mike Rapoport <mike@compulab.co.il>, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [110419 14:42]:
> * Mike Rapoport <mike.rapoport@gmail.com> [110419 14:32]:
> > Hi Tony,
> > 
> > On Mon, Apr 18, 2011 at 2:21 PM, Tony Lindgren <tony@atomide.com> wrote:
> > > * Mike Rapoport <mike@compulab.co.il> [110417 01:21]:
> > > Nice job Mike :)
> > 
> > There's a _lot_ of very similar code in different board files. If
> > you'd like to I can try to create something like
> > common-board-devices.c and move most of that code there. It's not the
> > real consolidation Linus wanted, but at least all the copy-pasted
> > device initialization code would be removed.
> 
> Yes please do if you can, that helps a lot. Also most beagle
> related boards could probably have a common board-beagle.c file.
> 
> Eventually the board configuration will come from device tree.
> But until that's available, we can consolidate the code within
> arch/arm/*omap*/ as the common platform init functions will still
> be needed with configuration coming from DT.

Oh one more thing, can you please repost this series with
linux-arm-kernel list also Cc'd? That way I can apply it
without having to repost it for review.

Tony

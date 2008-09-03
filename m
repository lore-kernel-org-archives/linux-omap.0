From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Thu, 4 Sep 2008 00:16:20 +0100
Message-ID: <20080903231620.GQ19980@flint.arm.linux.org.uk>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <20080903203720.GV23085@atomide.com> <20080903210412.GJ19980@flint.arm.linux.org.uk> <200809031435.52620.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42675 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342AbYICXQi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 19:16:38 -0400
Content-Disposition: inline
In-Reply-To: <200809031435.52620.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>, linux-omap@vger.kernel.org

On Wed, Sep 03, 2008 at 02:35:52PM -0700, David Brownell wrote:
> On Wednesday 03 September 2008, Russell King - ARM Linux wrote:
> > - virtual addresses are pointer like.
> > - physical addresses are integer like.
> > 
> > So, if it's a physical address, it should be stored in an integer type
> > large enough to contain it, and that means something like u32, or
> > unsigned long.
> 
> And to complete the puzzle:  in the absense of IOMMU technologies
> what's the difference between a "physical address" and a dma_addr_t?
> (DMA addreses being integer-like.)

That's a valid point, and related, but one which I don't wish to get
into at present (mainly because it isn't a problem on current hardware.)

I'm not out to solve world hunger at this point, just to shake out some
of the real problems that OMAP currently suffers from, which we can use
the standard compiler to find.  That's why I'm trying to keep this thread
narrowly focussed.

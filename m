From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 0/3] Add cyclic DMA support to OMAP DMA engine driver
Date: Tue, 26 Jun 2012 19:34:42 +0100
Message-ID: <20120626183442.GA27261@n2100.arm.linux.org.uk>
References: <20120622085911.GA19026@n2100.arm.linux.org.uk> <1340642293.1562.59.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33743 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755159Ab2FZSe6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 14:34:58 -0400
Content-Disposition: inline
In-Reply-To: <1340642293.1562.59.camel@vkoul-udesk3>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Dan Williams <dan.j.williams@intel.com>, Liam Girdwood <lrg@ti.com>

On Mon, Jun 25, 2012 at 10:08:13PM +0530, Vinod Koul wrote:
> Hi Russell,
> 
> What is the status of the virtual dma and the series you have posted
> previously. Is it ready for merge?
> 
> I would be away for 10days starting coming Thursday. So please let me
> know

I have no idea.

I've just rebased all the DMA stuff onto -rc4, because -rc3 is just a
whole load of problems for OMAP, and I'm still struggling with the
stupid OMAP audio crap.  And what with people who know how the SDP4430
works and/or OMAP audio works going on holiday too, I don't see much
progress being made until August time.

I've found that the only way I can get any audio out of the SDP4430
platform is if I have something connected to the 3.5mm jack before
powering up the board, and keep it connected.  So provided I do that
I can test the OMAP audio stuff.

Of course, finding out crap like that takes time away from my _one_
day a _week_ that I'm working on OMAP stuff...

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V6 1/2] of: Add generic device tree DMA helpers
Date: Sat, 15 Sep 2012 01:14:31 +0100
Message-ID: <20120915001431.GB12445@n2100.arm.linux.org.uk>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com> <1347662517-4210-2-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33406 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab2IOAO7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Sep 2012 20:14:59 -0400
Content-Disposition: inline
In-Reply-To: <1347662517-4210-2-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>

On Fri, Sep 14, 2012 at 05:41:56PM -0500, Jon Hunter wrote:
> 3. Supporting legacy devices not using DMA Engine
> 
>    These devices present a problem, as there may not be a uniform way to easily
>    support them with regard to device tree. Ideally, these should be migrated
>    to DMA engine. However, if this is not possible, then they should still be
>    able to use this binding, the only constaint imposed by this implementation
>    is that when requesting a DMA channel via of_dma_request_slave_channel(), it
>    will return a type of dma_chan.

As far as devices not using DMA engine, the answer is we don't support
their specification in the DT model.  Note that the legacy OMAP DMA
API is scheduled for removal next year, so it's not going to be around
that much longer.

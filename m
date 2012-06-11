From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: RFC: changing DMA slave configuration API
Date: Mon, 11 Jun 2012 09:24:24 +0100
Message-ID: <20120611082424.GE11404@n2100.arm.linux.org.uk>
References: <20120610102023.GC11404@n2100.arm.linux.org.uk> <CAGsJ_4xHNdEcfsmtypDHcJ0uyhtFz43xBojgHw2RSvrH8ohRcA@mail.gmail.com> <20120610112217.GD11404@n2100.arm.linux.org.uk> <1339390249.1927.1623.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53644 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab2FKIYn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 04:24:43 -0400
Content-Disposition: inline
In-Reply-To: <1339390249.1927.1623.camel@vkoul-udesk3>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Barry Song <21cnbao@gmail.com>, Dan Williams <dan.j.williams@intel.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jun 11, 2012 at 10:20:49AM +0530, Vinod Koul wrote:
> I think it is a good idea. And I would like to extend it even a little
> bit. Do we have any users of peripheral to peripheral slave dma?
> IIRC  that is not the case, or does anyone know of existence or plans
> for such a h/w?
> 
> If not, lets junk the src/dst fields and keep burst, length, addr fields
> which point to the peripheral values.
> 
> Alternatively if we need both, then we can't have union and Russell's
> idea seems good one :)

We don't need the union whatever way that goes.

The question over whether we have the src/dst fields is whether we want
to support a different configuration for DMA_DEV_TO_MEM/DMA_MEM_TO_DEV
without having to reconfigure the channel each time its direction is
switched.

Out of the following users:
drivers/mmc/host/mmci.c
drivers/spi/spi-pl022.c
drivers/tty/serial/amba-pl011.c

with amba-pl08x, I don't see any which set a different configuration
depending on direction, and sa11x0 and OMAP DMA engine drivers only
support one direction per channel.

So, the question really comes down to whether we _want_ to support this,
and how painful it would be to re-introduce this if we did need it.
Maybe the right answer is to use the control command value to sort that
out when we come to it.

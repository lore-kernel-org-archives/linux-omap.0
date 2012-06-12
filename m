From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: RFC: changing DMA slave configuration API
Date: Tue, 12 Jun 2012 11:34:39 +0530
Message-ID: <1339481079.1927.1635.camel@vkoul-udesk3>
References: <20120610102023.GC11404@n2100.arm.linux.org.uk>
	 <CAGsJ_4xHNdEcfsmtypDHcJ0uyhtFz43xBojgHw2RSvrH8ohRcA@mail.gmail.com>
	 <20120610112217.GD11404@n2100.arm.linux.org.uk>
	 <1339390249.1927.1623.camel@vkoul-udesk3>
	 <20120611082424.GE11404@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:25832 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496Ab2FLGLu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 02:11:50 -0400
In-Reply-To: <20120611082424.GE11404@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Barry Song <21cnbao@gmail.com>, Dan Williams <dan.j.williams@intel.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 2012-06-11 at 09:24 +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 11, 2012 at 10:20:49AM +0530, Vinod Koul wrote:
> > I think it is a good idea. And I would like to extend it even a little
> > bit. Do we have any users of peripheral to peripheral slave dma?
> > IIRC  that is not the case, or does anyone know of existence or plans
> > for such a h/w?
> > 
> > If not, lets junk the src/dst fields and keep burst, length, addr fields
> > which point to the peripheral values.
> > 
> > Alternatively if we need both, then we can't have union and Russell's
> > idea seems good one :)
> 
> We don't need the union whatever way that goes.
Based on comment we need to support both.

> 
> The question over whether we have the src/dst fields is whether we want
> to support a different configuration for DMA_DEV_TO_MEM/DMA_MEM_TO_DEV
> without having to reconfigure the channel each time its direction is
> switched.
The biggest issue here is the design of the API. IMO the slave_config
should be passed along with respective prepare API for slave and not
thru separate slave config. That will remove the unnecessary limitation
and allow the same channel to be used for tx for one transfer and rx for
subsequent etc.

In the .device_prep_slave_sg() we should add the struct slave_config as
an argument. Obviously the slave_config will have _one_ pair of members
(not both src/dstn fields then).

For DMA_DEV_TO_DEV, anyway we need a new API, which can have both src
and dstn slave_config

Thoughts..?


-- 
~Vinod


From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Tue, 31 Jul 2012 16:42:12 +0530
Message-ID: <1343733132.1726.14418.camel@vkoul-udesk3>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
	 <201207171924.33756.arnd@arndb.de> <1342756850.1726.74.camel@vkoul-udesk3>
	 <201207200839.24259.arnd@arndb.de> <1342777047.1726.435.camel@vkoul-udesk3>
	 <500EF27F.6050905@ti.com> <1343284960.1726.8978.camel@vkoul-udesk3>
	 <501181C3.1020301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33199 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755715Ab2GaLLU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Jul 2012 07:11:20 -0400
In-Reply-To: <501181C3.1020301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Thu, 2012-07-26 at 12:43 -0500, Jon Hunter wrote:
> >> So yes I can see that a channel itself could be configured to
> support a
> >> given direction, but when we ask for a channel via
> dma_request_channel()
> >> we are going to get a channel that matches the criteria we pass
> using
> >> the filter parameter. So here the thinking was that "flags" is a
> filter
> >> parameter that the user could specify and one example being
> direction
> >> but it could be something else too.
> > Yes that can be done, but I am leaning towards clients not have to
> do
> > anything :) DMAEngine needs to know mapping and when
> > dma_request_channel() is called it _always_ gives you the right
> channel.
> 
> Ok, so are you proposing to remove the filter function and parameter
> from the dma_request_channel()?
No. But add a new request call, dma_request_slave_channel() which is
exclusive for slave usages and takes into account the mapping to be done
for channels
> 
> > Maybe for slave case we need to create dma_request_slave_channel()
> which
> > has additional arguments for dmaengine to do the filtering.
Yup
> 
> Ok, so what is not clear to me is if you envision that
> dma_request_slave_channel() is using a mapping table based look-up or
> the DT scheme or both.
The API should not worry about it. It would be good to have DT/ other be
behind this API, so it is transparent to users. They just request a
slave channel.
> 
> As Arnd highlighted the DT convention is to store the DMA info in each
> of the device nodes and not store in a global mapping table which
> conflicts with having a mapping table approach for non-DT usage. So I
> am
> still not sure how you envision this function working for both the
> non-DT and DT use-cases. 
I expect the clients to pass the mapping information to dmaengine in way
dmaengine understands. This information can come from DT or other
places. That way dmaengine gets info from any system being used and be
able to allocate slave channel properly.
-- 
~Vinod


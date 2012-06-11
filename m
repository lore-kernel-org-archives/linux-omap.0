From: David Brown <davidb@codeaurora.org>
Subject: Re: RFC: changing DMA slave configuration API
Date: Mon, 11 Jun 2012 13:36:07 -0700
Message-ID: <20120611203607.GA16899@codeaurora.org>
References: <20120610102023.GC11404@n2100.arm.linux.org.uk>
 <CAGsJ_4xHNdEcfsmtypDHcJ0uyhtFz43xBojgHw2RSvrH8ohRcA@mail.gmail.com>
 <20120610112217.GD11404@n2100.arm.linux.org.uk>
 <1339390249.1927.1623.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:62930 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab2FKUgR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jun 2012 16:36:17 -0400
Content-Disposition: inline
In-Reply-To: <1339390249.1927.1623.camel@vkoul-udesk3>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, linux-omap@vger.kernel.org, Barry Song <21cnbao@gmail.com>, linux-arm-kernel@lists.infradead.org

On Mon, Jun 11, 2012 at 10:20:49AM +0530, Vinod Koul wrote:

> I think it is a good idea. And I would like to extend it even a little
> bit. Do we have any users of peripheral to peripheral slave dma?
> IIRC  that is not the case, or does anyone know of existence or plans
> for such a h/w?

We have hardware that supports this, and I suspect it will become more
common in our future chips.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

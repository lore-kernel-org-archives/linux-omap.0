From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Tue, 24 Jul 2012 19:27:04 +0000
Message-ID: <201207241927.04542.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <1342777047.1726.435.camel@vkoul-udesk3> <500EF27F.6050905@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61973 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609Ab2GXT1Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 15:27:16 -0400
In-Reply-To: <500EF27F.6050905@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, linux-arm-kernel@lists.infradead.org, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, dan.j.williams@intel.com, linux-omap <linux-omap@vger.kernel.org>

On Tuesday 24 July 2012, Jon Hunter wrote:
> Ok. The thought was that the user would have the following means of
> requesting a channel ...
> 
> 1. By name
> 2. By a filter parameter (flags)
> 3. By name and a filter parameter
> 
> So we would have the following APIs ...
> 
> struct dma_chan
> *of_dma_request_channel(struct device_node *node, unsigned int flags);
> struct dma_chan
> *of_dma_request_named channel(struct device_node *node, char *name,
> unsigned int flags);
> 
> In both of these the filter parameter flags is optional.
> 
> Let me know your thoughts on this.

I definitely like this version. I was thinking of a different variant
where we have separate functions for each flag value, but I think yours
is actually better.

	Arnd

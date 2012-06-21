From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Thu, 21 Jun 2012 14:56:56 +0000
Message-ID: <201206211456.56933.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <201206151127.24386.arnd@arndb.de> <Pine.LNX.4.64.1206211250190.3513@axis700.grange>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:58045 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757690Ab2FUO5h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jun 2012 10:57:37 -0400
In-Reply-To: <Pine.LNX.4.64.1206211250190.3513@axis700.grange>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Jon Hunter <jon-hunter@ti.com>, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Jassi Brar <jaswinder.singh@linaro.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Magnus Damm <magnus.damm@gmail.com>

On Thursday 21 June 2012, Guennadi Liakhovetski wrote:
> Indeed, this solution should be good enough, thanks! I'm not sure, whether 
> making this multiplexing available requires any additional code to the 
> generic DMA DT binding implementation. If it does - please, let's make 
> this a part of the implementation.

It depends how the dma engine gets represented in Linux then: Either
we make the common dmaengine code handle multiple dma-engines with the
same of_node pointer, or you make the driver register a single dma-engine
to Linux that is backed by the three physical devices but just one
of_node pointer. I think either way will work, and someone has to
try it to determine which one is simpler.

> It is also important to provide a flexible multiple channel per device 
> configuration support to let slave drivers distinguish between different 
> DMA channels, that they get back from the API. But I think this is a part 
> of the current proposal and is being taken care of.

Yes, it is.

	Arnd

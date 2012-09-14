From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V5 1/2] of: Add generic device tree DMA helpers
Date: Fri, 14 Sep 2012 15:26:17 +0000
Message-ID: <201209141526.17791.arnd@arndb.de>
References: <1347635923-30166-1-git-send-email-jon-hunter@ti.com> <1347635923-30166-2-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:51753 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab2INP0a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Sep 2012 11:26:30 -0400
In-Reply-To: <1347635923-30166-2-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>

On Friday 14 September 2012, Jon Hunter wrote:
> 
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Thanks for all this work, looks great!

My final (tiny) comment on this:

> +2. A single read-write channel with two alternative dma controllers:
> +
> +	dmas = <&dma1 5
> +		&dma2 7
> +		&dma3 2>;
> +	dma-names = "rx-tx", "rx-tx", "rx-tx"

*three* alternative dma controllers, not two.

	Arnd

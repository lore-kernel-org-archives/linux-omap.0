From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v2] of: dma: fix typos in generic dma binding definition
Date: Mon, 24 Sep 2012 17:27:03 -0500
Message-ID: <5060DE37.4080001@ti.com>
References: <1348066188-17937-1-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47856 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789Ab2IXW10 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Sep 2012 18:27:26 -0400
In-Reply-To: <1348066188-17937-1-git-send-email-mporter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>, Rob Herring <rob.herring@calxeda.com>, Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>

Hi Matt,

On 09/19/2012 09:49 AM, Matt Porter wrote:
> Some semicolons were left out in the examples.
> 
> The #dma-channels and #dma-requests properties have a prefix
> that is, by convention, reserved for cell size properties.
> Rename those properties to dma-channels and dma-requests.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>

Acked-by: Jon Hunter <jon-hunter@ti.com>

Thanks for catching and fixing these!

Cheers
Jon

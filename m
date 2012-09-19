From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH V6 1/2] of: Add generic device tree DMA helpers
Date: Wed, 19 Sep 2012 09:10:22 -0500
Message-ID: <5059D24E.20707@gmail.com>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com> <1347662517-4210-2-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60143 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab2ISOK2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 10:10:28 -0400
Received: by obbuo13 with SMTP id uo13so413142obb.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Sep 2012 07:10:26 -0700 (PDT)
In-Reply-To: <1347662517-4210-2-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Stephen Warren <swarren@nvidia.com>, Vinod Koul <vinod.koul@intel.com>, Rob Herring <rob.herring@calxeda.com>, Dan Williams <djbw@fb.com>, Russell King <linux@arm.linux.org.uk>

On 09/14/2012 05:41 PM, Jon Hunter wrote:
> This is based upon the work by Benoit Cousson [1] and Nicolas Ferre [2]
> to add some basic helpers to retrieve a DMA controller device_node and the
> DMA request/channel information.

[snip]

> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  Documentation/devicetree/bindings/dma/dma.txt |   81 +++++++++
>  drivers/of/Makefile                           |    2 +-
>  drivers/of/dma.c                              |  219 +++++++++++++++++++++++++

We've been moving in the direction of not putting subsystem related code
under drivers/of, but rather with the subsystem. Although in some cases
(i2c), the maintainers didn't want the OF code there.

In any case, I guess this will go thru Vinod's tree, so:

Acked-by: Rob Herring <rob.herring@calxeda.com>


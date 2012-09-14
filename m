From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V4 1/2] of: Add generic device tree DMA helpers
Date: Fri, 14 Sep 2012 10:28:57 -0600
Message-ID: <50535B49.7070706@wwwdotorg.org>
References: <1347573629-21299-1-git-send-email-jon-hunter@ti.com> <1347573629-21299-2-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:37538 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384Ab2INQ3A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Sep 2012 12:29:00 -0400
In-Reply-To: <1347573629-21299-2-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Stephen Warren <swarren@nvidia.com>, Vinod Koul <vinod.koul@intel.com>, Rob Herring <rob.herring@calxeda.com>, Dan Williams <djbw@fb.com>, Russell King <linux@arm.linux.org.uk>

On 09/13/2012 04:00 PM, Jon Hunter wrote:
> This is based upon the work by Benoit Cousson [1] and Nicolas Ferre [2]
> to add some basic helpers to retrieve a DMA controller device_node and the
> DMA request/channel information.

> diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt

> +* Generic DMA Controller and DMA request bindings
> +
> +Generic binding to provide a way for a driver using DMA Engine to retrieve the
> +DMA request or channel information that goes from a hardware device to a DMA
> +controller.
> +
> +
> +* DMA controller
> +
> +Required property:
> +- #dma-cells: 		Must be at least 1. Used to provide DMA controller
> +			specific information. See DMA client binding below for
...
> +* DMA client
> +
> +Client drivers should specify the DMA property using a phandle to the controller
> +followed by DMA controller specific data.
> +
> +Required property:
> +- dmas:			List of one or more DMA specifiers, each consisting of
> +			- A phandle pointing to DMA controller node
> +			- A single integer cell containing DMA controller
> +			  specific information. This typically contains a dma
> +			  request line number or a channel number, but can
> +			  contain any data that is used required for configuring
> +			  a channel.

"A single integer cell" doesn't sound correct; shouldn't this be
something like "a number of integer cells, as determined by the
#dma-cells property in the node referenced by phandle"?

> +- dma-names: 		Contains one identifier string for each dma specifier in
> +			the dmas property. The specific strings that can be used
> +			are defined in the binding of the DMA client device.


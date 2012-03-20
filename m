From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 1/2] of: Add generic device tree DMA helpers
Date: Tue, 20 Mar 2012 09:38:55 -0600
Message-ID: <4F68A48F.2000803@wwwdotorg.org>
References: <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com> <6b5dc1fadfd03a48093338b6981c0a7ae7662212.1332237596.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:49431 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760585Ab2CTPi6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Mar 2012 11:38:58 -0400
In-Reply-To: <6b5dc1fadfd03a48093338b6981c0a7ae7662212.1332237596.git.nicolas.ferre@atmel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: b-cousson@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, vinod.koul@linux.intel.com, Stephen Warren <swarren@nvidia.com>, Rob Herring <rob.herring@calxeda.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 03/20/2012 04:13 AM, Nicolas Ferre wrote:
> Add some basic helpers to retrieve a DMA controller device_node and the
> DMA request specifications. By making DMA controllers register a generic
> translation function, we allow the management of any type of DMA requests
> specification.
> The void * output of an of_dma_xlate() function that will be implemented
> by the DMA controller can carry any type of "dma-request" argument.
> 
> The DMA client will search its associated DMA controller in the list and
> call the registered of_dam_xlate() function to retrieve the request values.
> 
> One simple xlate function is provided for the "single number" type of
> request binding.
> 
> This implementation is independent from dmaengine so it can also be used
> by legacy drivers.

> +++ b/Documentation/devicetree/bindings/dma/dma.txt

> +* DMA client
> +
> +Client drivers should specify the DMA request property using a phandle to
> +the controller. If needed, the DMA request identity on that controller is then
> +added followed by optional request specifications.
> +
> +Required property:
> +    - dma-request: List of phandle + dma-request + request specifications,
> +      one group per request "line".

Should the property name be plural, i.e. "dma-requests"? For PWM I
believe we settled on "pwms" not "pwm", and that was for consistency
with other bindings like interrupts and GPIOs.

From: Mitch Bradley <wmb@firmworks.com>
Subject: Re: [PATCH V6 1/2] of: Add generic device tree DMA helpers
Date: Thu, 20 Sep 2012 05:25:04 +0800
Message-ID: <505A3830.7090307@firmworks.com>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com> <1347662517-4210-2-git-send-email-jon-hunter@ti.com> <20120919140705.GB16522@beef> <201209191424.56086.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rs130.luxsci.com ([72.32.115.17]:39569 "EHLO rs130.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941Ab2ISVZa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 17:25:30 -0400
In-Reply-To: <201209191424.56086.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Matt Porter <mporter@ti.com>, Stephen Warren <swarren@nvidia.com>, Vinod Koul <vinod.koul@intel.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, Dan Williams <djbw@fb.com>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 9/19/2012 10:24 PM, Arnd Bergmann wrote:
> On Wednesday 19 September 2012, Matt Porter wrote:
>>> +Optional properties:
>>> +- #dma-channels:     Number of DMA channels supported by the controller.
>>> +- #dma-requests:     Number of DMA requests signals supported by the
>>> +                     controller.
>>
>> Shouldn't these two optional properties drop the prefix #?  By
>> convention adopted from the various original OF/ePAPR/etc specs, the
>> only properties I would expect to see with this prefix are the
>> "*-cells" cell sizes. A quick search indicates this is the case
>> throughout all the current bindings.
> 
> I always assumed that the # prefix is used to indicate that we are counting
> things instead of listing them.

Your assumption is historically correct.  It seems that usage has
drifted somewhat.


> 
> 	Arnd
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 

From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH V6 1/2] of: Add generic device tree DMA helpers
Date: Wed, 19 Sep 2012 09:36:36 -0500
Message-ID: <5059D874.6040107@gmail.com>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com> <1347662517-4210-2-git-send-email-jon-hunter@ti.com> <20120919140705.GB16522@beef> <201209191424.56086.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:39882 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab2ISOgk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 10:36:40 -0400
Received: by oago6 with SMTP id o6so1104231oag.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Sep 2012 07:36:40 -0700 (PDT)
In-Reply-To: <201209191424.56086.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Matt Porter <mporter@ti.com>, Jon Hunter <jon-hunter@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>

On 09/19/2012 09:24 AM, Arnd Bergmann wrote:
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

Lots of properties count things, but don't have a #. nr_gpios or spi
chipselect counts for example. I'd say drop the #.

Rob

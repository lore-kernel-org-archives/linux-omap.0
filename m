From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V5 1/2] of: Add generic device tree DMA helpers
Date: Fri, 14 Sep 2012 12:20:45 -0500
Message-ID: <5053676D.8020602@ti.com>
References: <1347635923-30166-1-git-send-email-jon-hunter@ti.com> <1347635923-30166-2-git-send-email-jon-hunter@ti.com> <201209141526.17791.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37914 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754673Ab2INRVF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Sep 2012 13:21:05 -0400
In-Reply-To: <201209141526.17791.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>


On 09/14/2012 10:26 AM, Arnd Bergmann wrote:
> On Friday 14 September 2012, Jon Hunter wrote:
>>
>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Cc: Stephen Warren <swarren@nvidia.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Vinod Koul <vinod.koul@intel.com>
>> Cc: Dan Williams <djbw@fb.com>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thanks for all this work, looks great!

Thanks!

> My final (tiny) comment on this:
> 
>> +2. A single read-write channel with two alternative dma controllers:
>> +
>> +	dmas = <&dma1 5
>> +		&dma2 7
>> +		&dma3 2>;
>> +	dma-names = "rx-tx", "rx-tx", "rx-tx"
> 
> *three* alternative dma controllers, not two.

Oops! I have been starring at this so long I can no longer see the wood
for the trees!

Jon

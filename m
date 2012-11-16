From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH V6 2/2] dmaengine: add helper function to request a slave
 DMA channel
Date: Fri, 16 Nov 2012 09:39:31 +0100
Message-ID: <50A5FBC3.4000302@atmel.com>
References: <1347662517-4210-1-git-send-email-jon-hunter@ti.com> <1347662517-4210-3-git-send-email-jon-hunter@ti.com> <1347852805.1943.130.camel@vkoul-udesk3> <201209171159.27359.arnd@arndb.de> <20120917223619.GC12445@n2100.arm.linux.org.uk> <1347938035.1943.162.camel@vkoul-udesk3> <5060DDEB.4000600@ti.com> <1348547701.1943.190.camel@vkoul-udesk3> <20121016024318.GF24393@S2101-09.ap.freescale.net> <1350355144.1648.5259.camel@vkoul-udesk3>  <509D6108.1060304@ti.com> <1353029876.7077.56.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:48094 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075Ab2KPIjc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Nov 2012 03:39:32 -0500
In-Reply-To: <1353029876.7077.56.camel@vkoul-udesk3>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Jon Hunter <jon-hunter@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, device-tree <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, Dan Williams <djbw@fb.com>, Stephen Warren <swarren@nvidia.com>, linux-arm <linux-arm-kernel@lists.infradead.org>

On 11/16/2012 02:37 AM, Vinod Koul :
> On Fri, 2012-11-09 at 14:01 -0600, Jon Hunter wrote:
>> Hi Vinod,
>>
>> A few people have been asking me if getting device-tree support for DMA
>> engine is plan for record for v3.8. I know that you were working through
>> implementing a common interface and so I wanted to check how that is
>> going. Do you have any insight to when device-tree support may get added?
>>
> I have not been able to do much work on this for last couple of weeks. I
> hope to do it in by this weekend. If not I will merge yours and then
> uppdate.
> 
> Anyway, DT would be there in 3.8 with or without my changes.

Vinod,

So, can we imagine having this tree in linux-next rapidly (with or
without your changes)?

Thanks, best regards,
-- 
Nicolas Ferre

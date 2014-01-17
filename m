From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [PATCH RFC 00/26] Migrate more OMAP DMA code to DMA engine
Date: Fri, 17 Jan 2014 19:53:26 +0530
Message-ID: <52D93CDE.4010101@ti.com>
References: <20140102150621.GJ16456@n2100.arm.linux.org.uk> <52CFE494.4010702@ti.com> <20140113141713.GC27282@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58583 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbaAQOYC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Jan 2014 09:24:02 -0500
In-Reply-To: <20140113141713.GC27282@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Tony Lindgren <tony@atomide.com>, Vinod Koul <vinod.koul@intel.com>, sricharan.az@gmail.com

On Monday 13 January 2014 07:47 PM, Russell King - ARM Linux wrote:
> On Fri, Jan 10, 2014 at 05:46:20PM +0530, Sricharan R wrote:
>> I tested this series on DRA7 with mmc peripheral dma and it looked
>> fine. Some how dmaengine test cases were not fine. But that may not
>> have anything to do with this series. I will check more on that and
>> will come back with that results as well.
> 
> Not fine in what sense?
> 
Sorry for delayed response.

So in the case of dmaengine test case, it looks for channels
with DMA_MEMCPY, DMA_XOR, DMA_PQ capabilities. But the omap-dma
 device is not registered with MEMCPY capabilities, hence the
testcase fails as no channels are available.

Regards,
 Sricharan


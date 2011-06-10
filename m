From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] dmaengine: add new api for preparing simple slave
	transfer
Date: Fri, 10 Jun 2011 11:43:18 +0100
Message-ID: <20110610104318.GC24636@n2100.arm.linux.org.uk>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940301FE2DED@dbde02.ent.ti.com> <20110609124723.GA24636@n2100.arm.linux.org.uk> <E0D41E29EB0DAC4E9F3FF173962E9E940301FE2EFB@dbde02.ent.ti.com> <20110609163206.GB24636@n2100.arm.linux.org.uk> <1307686397.10976.116.camel@vkoul-udesk3> <E0D41E29EB0DAC4E9F3FF173962E9E940301FE337F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45754 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484Ab1FJKnk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jun 2011 06:43:40 -0400
Content-Disposition: inline
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940301FE337F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raju, Sundaram" <sundaram@ti.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Dan <dan.j.williams@intel.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jun 10, 2011 at 03:51:41PM +0530, Raju, Sundaram wrote:
> Consider a simple video use case of de-interlacing a video buffer.
> Odd lines have to be transferred first, and then the even lines are 
> transferred separately. This can be done by programming the 
> inter frame gap as the line size of the video buffer in the DMAC.
> This will require you to have only 2 descriptors, one for the
> odd lines and another for the even lines. This results in only
> 2 descriptors being written to DMAC registers.

How would this be handled with DMACs which can't 'skip' bytes in the
buffer?  You would have to generate a list of LLIs separately
describing each 'line' of video and chain them together.

How do you handle the situation where a driver uses your new proposed
API, but it doesn't support that in hardware.

> Actually we can deduce the chunk_size from the 
> dma_slave_config itself. It is either the src_addr_width or
> dst_addr_width based on the direction. Because at a stretch
> DMAC cannot transfer more than the slave register width.

I think you're misinterpreting those fields.  (dst|src)_addr_width tells
the DMA controller the width of each transaction - whether to issue a
byte, half-word, word or double-word read or write to the peripheral.
It doesn't say how many of those to issue, it just says what the
peripheral access size is to be.

In other words, they describe the width of the FIFO register.

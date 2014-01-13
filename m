From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RFC 00/26] Migrate more OMAP DMA code to DMA engine
Date: Mon, 13 Jan 2014 14:03:04 -0800
Message-ID: <20140113220304.GC7993@atomide.com>
References: <20140109152437.GB27282@n2100.arm.linux.org.uk>
 <20140113141811.GD27282@n2100.arm.linux.org.uk>
 <20140113173744.GA7746@atomide.com>
 <20140113185503.GE27282@n2100.arm.linux.org.uk>
 <20140113192630.GB7746@atomide.com>
 <20140113203404.GF27282@n2100.arm.linux.org.uk>
 <20140113210242.GA7993@atomide.com>
 <20140113211130.GG27282@n2100.arm.linux.org.uk>
 <20140113212117.GB7993@atomide.com>
 <20140113212815.GH27282@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56690 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbaAMWDL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Jan 2014 17:03:11 -0500
Content-Disposition: inline
In-Reply-To: <20140113212815.GH27282@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [140113 13:30]:
> On Mon, Jan 13, 2014 at 01:21:18PM -0800, Tony Lindgren wrote:
> > Yes that's correct, here are all the DMA related lines:
> > 
> > DMA: preallocated 256 KiB pool for atomic coherent allocations
> > OMAP DMA hardware version 1
> > DMA capabilities: 0000000c:00000000:01ff:003f:007f
> > omap-dma-engine omap-dma-engine: failed to get L1 IRQ: -6
> > omap-dma-engine omap-dma-engine: OMAP DMA engine driver
> > omap-dma-engine omap-dma-engine: allocating channel 0 for 54
> > omap-dma-engine omap-dma-engine: allocating channel 1 for 55
> > DMA timeout with device 55
> 
> Hmm, that's annoying, and will be annoying to debug remotely.  Would
> you like a new set of patches to try bisecting to find the culpret?

Sure that would help.

Regards,

Tony

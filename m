From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 00/26] Migrate more OMAP DMA code to DMA engine
Date: Mon, 13 Jan 2014 21:28:16 +0000
Message-ID: <20140113212815.GH27282@n2100.arm.linux.org.uk>
References: <20140108012110.GL5074@atomide.com> <20140109152437.GB27282@n2100.arm.linux.org.uk> <20140113141811.GD27282@n2100.arm.linux.org.uk> <20140113173744.GA7746@atomide.com> <20140113185503.GE27282@n2100.arm.linux.org.uk> <20140113192630.GB7746@atomide.com> <20140113203404.GF27282@n2100.arm.linux.org.uk> <20140113210242.GA7993@atomide.com> <20140113211130.GG27282@n2100.arm.linux.org.uk> <20140113212117.GB7993@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:35996 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751778AbaAMV2W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jan 2014 16:28:22 -0500
Content-Disposition: inline
In-Reply-To: <20140113212117.GB7993@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jan 13, 2014 at 01:21:18PM -0800, Tony Lindgren wrote:
> Yes that's correct, here are all the DMA related lines:
> 
> DMA: preallocated 256 KiB pool for atomic coherent allocations
> OMAP DMA hardware version 1
> DMA capabilities: 0000000c:00000000:01ff:003f:007f
> omap-dma-engine omap-dma-engine: failed to get L1 IRQ: -6
> omap-dma-engine omap-dma-engine: OMAP DMA engine driver
> omap-dma-engine omap-dma-engine: allocating channel 0 for 54
> omap-dma-engine omap-dma-engine: allocating channel 1 for 55
> DMA timeout with device 55

Hmm, that's annoying, and will be annoying to debug remotely.  Would
you like a new set of patches to try bisecting to find the culpret?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".

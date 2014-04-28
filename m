From: Joel Fernandes <joelf@ti.com>
Subject: Re: [patch V2 0/6] dma: edma: Provide granular residue accounting
Date: Mon, 28 Apr 2014 15:47:37 -0500
Message-ID: <535EBE69.6060803@ti.com>
References: <20140428104416.464002156@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36910 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754374AbaD1UsH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Apr 2014 16:48:07 -0400
In-Reply-To: <20140428104416.464002156@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, dmaengine@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, dan.j.williams@intel.com, vinod.koul@intel.com, nsekhar@ti.com, Peter Ujfalusi <peter.ujfalusi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 04/28/2014 05:49 AM, Thomas Gleixner wrote:
> A simpler version to provide granular residue accounting and readout
> for EDMA.
> 
> Delta to V1:
> 
>       - Removed the double read of the address in PaRAM
> 
>       - Simplified the stats update in the interrupt callback for
>         intermediate transfers
> 
> Thanks,
> 
> 	tglx
> 

Thanks for the series. I went over all the patches and it looks great.
Acked-by: Joel Fernandes <joelf@ti.com>

The patches however didn't apply and had some conflicts with my dma
memcpy series and peter's cyclic series so I resolved conflicts and
created a single branch based on Vinod's slave-dma next branch (commit
406efb1a745c1dc512dc9c3c859e302e7b7f907e) that Vinod can pull.

I also renamed subject line of patches in Thomas's series to be
"dmaengine: edma" and documented some of the variables used.

https://github.com/joelagnel/linux-kernel.git (for-vinod branch)

Vinod, could you pull if it looks OK?

regards,
-Joel

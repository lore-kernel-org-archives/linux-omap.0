From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] dmaengine: omap-dma: Add support for memcpy
Date: Tue, 08 Sep 2015 14:24:49 +0300
Message-ID: <3187470.tKXzQaPa1m@avalon>
References: <1429688069-31765-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1429688069-31765-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, linux@arm.linux.org.uk, tony@atomide.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dan.j.williams@intel.com
List-Id: linux-omap@vger.kernel.org

Hi Peter,

Thank you for the patch.

While trying to port the omap_vout driver to the DMA engine API I noticed that 
the driver makes use of double-indexed transfers, which are not supported by 
the omap-dma driver. I haven't checked in details what would be required, but 
the interleaved API might be a good candidate for this. Do you have any plan 
to add support for double-indexed transfers to the omap-dma driver ?

On Wednesday 22 April 2015 10:34:29 Peter Ujfalusi wrote:
> The sDMA controller is capable of performing memory copy operation. It need
> to be configured to software triggered mode and without HW synchronization.
> The sDMA can copy data which is aligned to 8, 16 or 32 bits.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/omap-dma.c | 51 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 49 insertions(+), 2 deletions(-)

-- 
Regards,

Laurent Pinchart

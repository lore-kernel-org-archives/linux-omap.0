From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/3] dmaengine: ti-dma-crossbar: dra7: Support for
 reserving DMA event ranges
Date: Fri, 6 Nov 2015 15:53:10 -0600
Message-ID: <20151106215310.GA20278@rob-hp-laptop>
References: <1446192038-11158-1-git-send-email-peter.ujfalusi@ti.com>
 <1446192038-11158-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446192038-11158-3-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, nsekhar@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com, r.schwebel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 30, 2015 at 10:00:37AM +0200, Peter Ujfalusi wrote:
> In eDMA the events are directly mapped to a DMA channel (for example DMA
> event 14 can only be handled by DMA channel 14). If the memcpy is enabled
> on the eDMA, there is a possibility that the crossbar driver would assign
> DMA event number already allocated in eDMA for memcpy. Furthermore the
> eDMA can be shared with DSP in which case the crossbar driver should also
> avoid mapping xbar events to DSP used event numbers (or channels).
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../devicetree/bindings/dma/ti-dma-crossbar.txt    |  6 +++
>  drivers/dma/ti-dma-crossbar.c                      | 47 ++++++++++++++++++++--
>  2 files changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt b/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
> index b152a75dceae..aead5869a28d 100644
> --- a/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
> +++ b/Documentation/devicetree/bindings/dma/ti-dma-crossbar.txt
> @@ -14,6 +14,10 @@ The DMA controller node need to have the following poroperties:
>  
>  Optional properties:
>  - ti,dma-safe-map: Safe routing value for unused request lines
> +- ti,reserved-dma-request-ranges: DMA request ranges which should not be used
> +		when mapping xbar input to DMA request, they are either
> +		allocated to be used by for example the DSP or they are used as
> +		memcpy channels in eDMA.

How many requests are there? I think I'd rather see this as a mask 
value.

Rob

From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/5] dt-bindings: dma: ti-edma: Add option for reserved
 channel ranges
Date: Thu, 29 Aug 2019 17:47:28 -0500
Message-ID: <20190829224728.GA1198@bogus>
References: <20190823125618.8133-1-peter.ujfalusi@ti.com>
 <20190823125618.8133-5-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190823125618.8133-5-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vkoul@kernel.org, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 23, 2019 at 03:56:17PM +0300, Peter Ujfalusi wrote:
> Similarly to paRAM slots, channels can be used by other cores.
> 
> Add optional property to configure the reserved channel ranges.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  Documentation/devicetree/bindings/dma/ti-edma.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/ti-edma.txt b/Documentation/devicetree/bindings/dma/ti-edma.txt
> index 4bbc94d829c8..1198682ada99 100644
> --- a/Documentation/devicetree/bindings/dma/ti-edma.txt
> +++ b/Documentation/devicetree/bindings/dma/ti-edma.txt
> @@ -42,6 +42,9 @@ Optional properties:
>  - ti,edma-reserved-slot-ranges: PaRAM slot ranges which should not be used by
>  		the driver, they are allocated to be used by for example the
>  		DSP. See example.
> +- ti,edma-reserved-chan-ranges: channel ranges which should not be used by
> +		the driver, they are allocated to be used by for example the
> +		DSP. See example.

Based on the other thread, I think extending dma-channel-mask to a 
uint32-array makes sense here.

Rob

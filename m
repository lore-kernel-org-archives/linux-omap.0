From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 1/3] dt/bindings: da8xx-usb: Add binding for the CPPI
 4.1 DMA controller
Date: Tue, 17 Jan 2017 20:14:07 +0300
Message-ID: <d2d19518-5758-1af1-71cd-ab38f26734e7@cogentembedded.com>
References: <20170117142016.11163-1-abailon@baylibre.com>
 <20170117142016.11163-2-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170117142016.11163-2-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 01/17/2017 05:20 PM, Alexandre Bailon wrote:

> DT binding for the TI DA8xx/OMAP-L1x/AM17xx/AM18xx cppi41 dma controller.

    "CPPI 4.1 DMA" again.

>
> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  .../devicetree/bindings/usb/da8xx-usb.txt          | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/da8xx-usb.txt b/Documentation/devicetree/bindings/usb/da8xx-usb.txt
> index ccb844a..aed3169 100644
> --- a/Documentation/devicetree/bindings/usb/da8xx-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/da8xx-usb.txt
> @@ -18,10 +18,26 @@ Required properties:
>
>   - phy-names: Should be "usb-phy"
>
> + - dmas: specifies the dma channels
> +
> + - dma-names: specifies the names of the channels. Use "rxN" for receive
> +   and "txN" for transmit endpoints. N specifies the endpoint number.
> +
>  Optional properties:
>  ~~~~~~~~~~~~~~~~~~~~
>   - vbus-supply: Phandle to a regulator providing the USB bus power.
>
> +DMA
> +~~~
> +- compatible: ti,da8xx-cppi41
> +- reg: offset and length of the following register spaces: CPPI DMA Controller,
> +  CPPI DMA Scheduler, Queue Manager
> +- reg-names: "controller", "scheduler", "queuemgr"
> +- #dma-cells: should be set to 2. The first number represents the
> +  channel number (0 … 3 for endpoints 1 … 4).
> +  The second number is 0 for RX and 1 for TX transfers.
> +- #dma-channels: should be set to 4 representing the 4 endpoints.

    Shouldn't the # of channels be a part of the glue data?

[...]
> @@ -39,5 +58,28 @@ Example:
>  		phys = <&usb_phy 0>;
>  		phy-names = "usb-phy";
>
> +		dmas = <&cppi41dma 0 0 &cppi41dma 1 0
> +			&cppi41dma 2 0 &cppi41dma 3 0
> +			&cppi41dma 0 1 &cppi41dma 1 1
> +			&cppi41dma 2 1 &cppi41dma 3 1>;
> +		dma-names =
> +			"rx1", "rx2", "rx3", "rx4",
> +			"tx1", "tx2", "tx3", "tx4";
> +
>  		status = "okay";
> +
> +		cppi41dma: dma-controller@201000 {
> +			compatible = "ti,da8xx-cppi41";
> +			reg =  <0x201000 0x1000
> +				0x202000 0x1000
> +				0x204000 0x4000>;
> +			reg-names = "controller", "scheduler", "queuemgr";
> +			interrupts = <58>;
> +			interrupt-names = "glue";
> +			#dma-cells = <2>;
> +			#dma-channels = <4>;
> +			#dma-requests = <256>;

    Not seeing this prop documented...

> +			status = "okay";

    Can be omitted.

> +		};
> +
>  	};
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 07/11] dt/bindings: da8xx-usb: Add binding for the cppi41
 dma controller
Date: Mon, 9 Jan 2017 21:41:01 +0300
Message-ID: <6ae72fe4-ddb7-4dfc-8c8c-29b63636171b@cogentembedded.com>
References: <20170109160656.3470-1-abailon@baylibre.com>
 <20170109160656.3470-8-abailon@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170109160656.3470-8-abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello!

On 01/09/2017 07:06 PM, Alexandre Bailon wrote:

> DT binding for the TI DA8xx/OMAP-L1x/AM17xx/AM18xx cppi41 dma controller.

    It's called CPPI 4.1, not cppi41.
    Let me introduce myself: I was the author of the 1st CPPI 4.1 drivers 
(never merged).

> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> ---
>  .../devicetree/bindings/usb/da8xx-usb.txt          | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/da8xx-usb.txt b/Documentation/devicetree/bindings/usb/da8xx-usb.txt
> index ccb844a..2a4d737 100644
> --- a/Documentation/devicetree/bindings/usb/da8xx-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/da8xx-usb.txt
> @@ -18,10 +18,26 @@ Required properties:
[...]
>  Optional properties:
>  ~~~~~~~~~~~~~~~~~~~~
>   - vbus-supply: Phandle to a regulator providing the USB bus power.
>
> +DMA
> +~~~
> +- compatible: ti,da8xx-cppi41
> +- reg: offset and length of the following register spaces: USBSS, USB

    I don't understand what you mean by USBSS and how it's related to CPPI 4.1.

> +  CPPI DMA Controller, USB CPPI DMA Scheduler, USB Queue Manager

    I'd drop "USB" everywhere, the DMAC scheduler and queue manager are not a 
part of any USB logic.

> +- reg-names: glue, controller, scheduler, queuemgr

    Quoted, maybe?

> +- #dma-cells: should be set to 2. The first number represents the
> +  endpoint number (0 … 3 for endpoints 1 … 4).

    Not sure why you need EPs here. Is that required by the DMA driver?
The DMA controller operates with channels...

[...]

MBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

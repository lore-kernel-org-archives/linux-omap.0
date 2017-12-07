From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] Documentation: dt: memory: ti-emif: add edac support
 under emif
Date: Thu, 7 Dec 2017 11:03:30 +0200
Message-ID: <823a5602-52fb-a97f-ae09-c9af343f5bc8@ti.com>
References: <1510087139-21885-1-git-send-email-t-kristo@ti.com>
 <1510087139-21885-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1510087139-21885-2-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-edac-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org, mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Rob,

Any comments on this? I guess the series is only pending an ack on this one.

(Added devicetree ML to delivery, it seems I missed this on the original 
post.)

-Tero

On 07/11/17 22:38, Tero Kristo wrote:
> Certain revisions of the TI EMIF IP contain ECC support in them. Reflect
> this in the DT binding.
> 
> Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>   .../devicetree/bindings/memory-controllers/ti/emif.txt   | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
> index 0db6047..f56a347 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
> @@ -3,12 +3,16 @@
>   EMIF - External Memory Interface - is an SDRAM controller used in
>   TI SoCs. EMIF supports, based on the IP revision, one or more of
>   DDR2/DDR3/LPDDR2 protocols. This binding describes a given instance
> -of the EMIF IP and memory parts attached to it.
> +of the EMIF IP and memory parts attached to it. Certain revisions
> +of the EMIF IP controller also contain optional ECC support, which
> +corrects one bit errors and detects two bit errors.
>   
>   Required properties:
>   - compatible	: Should be of the form "ti,emif-<ip-rev>" where <ip-rev>
>     is the IP revision of the specific EMIF instance.
>   		  For am437x should be ti,emif-am4372.
> +		  For dra7xx should be ti,emif-dra7xx.
> +		  For k2x family, should be ti,emif-keystone.
>   
>   - phy-type	: <u32> indicating the DDR phy type. Following are the
>     allowed values
> @@ -42,6 +46,10 @@ Optional properties:
>   - hw-caps-temp-alert	: Have this property if the controller
>     has capability for generating SDRAM temperature alerts
>   
> +- interrupts		: A list of interrupt specifiers for memory
> +  controller interrupts, if available. Required for EMIF instances
> +  that support ECC.
> +
>   Example:
>   
>   emif1: emif@0x4c000000 {
> @@ -54,3 +62,9 @@ emif1: emif@0x4c000000 {
>   	hw-caps-ll-interface;
>   	hw-caps-temp-alert;
>   };
> +
> +emif1: emif@4c000000 {
> +	compatible = "ti,emif-dra7";
> +	reg = <0x4c000000 0x200>;
> +	interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> +};
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

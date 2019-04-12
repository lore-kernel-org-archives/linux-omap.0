From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] dt-binding: arm: omap: Add information for AM5748
Date: Fri, 12 Apr 2019 09:56:43 -0700
Message-ID: <20190412165643.GZ2839@atomide.com>
References: <20190405132806.20772-1-rogerq@ti.com>
 <20190405132806.20772-2-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190405132806.20772-2-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: robh+dt@kernel.org, s-anna@ti.com, nm@ti.com, lokeshvutla@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190405 13:28]:
> Add DT binding details for AM5748 SoC and AM5748 IDK.

Seems trivial enough for me to pick up with no acks.
Adding into omap-for-v5.2/dt.

Regards,

Tony

> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  Documentation/devicetree/bindings/arm/omap/omap.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index 2ecc712bf707..1c1e48fd94b5 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -92,6 +92,9 @@ SoCs:
>  - DRA718
>    compatible = "ti,dra718", "ti,dra722", "ti,dra72", "ti,dra7"
>  
> +- AM5748
> +  compatible = "ti,am5748", "ti,dra762", "ti,dra7"
> +
>  - AM5728
>    compatible = "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
>  
> @@ -184,6 +187,9 @@ Boards:
>  - AM57XX SBC-AM57x
>    compatible = "compulab,sbc-am57x", "compulab,cl-som-am57x", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
>  
> +- AM5748 IDK
> +  compatible = "ti,am5748-idk", "ti,am5748", "ti,dra762", "ti,dra7";
> +
>  - AM5728 IDK
>    compatible = "ti,am5728-idk", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
>  
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

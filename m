From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/8] ARM: OMAP2+: board-generic: add support for dra76x
 family
Date: Mon, 24 Jul 2017 14:02:36 -0500
Message-ID: <20170724190236.k3xbxrmgdfc5nogj@rob-hp-laptop>
References: <20170718195503.1700-1-lokeshvutla@ti.com>
 <20170718195503.1700-2-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170718195503.1700-2-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Praneeth Bajjuri <praneeth-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 19, 2017 at 01:24:56AM +0530, Lokesh Vutla wrote:
> Adding board generic support for dra76 family.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/arm/omap/omap.txt | 3 +++
>  arch/arm/mach-omap2/board-generic.c                 | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index 8219b2c6bb29..ffe02755a285 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -80,6 +80,9 @@ SoCs:
>  - OMAP5432
>    compatible = "ti,omap5432", "ti,omap5"
>  
> +- DRA762
> +  compatible = "ti,dra76", "ti,dra7"

76 or 762?

How many of these 2 or 3 compatible strings actually get used? I'd 
prefer to see one of these less specific compatibles get dropped.

> +
>  - DRA742
>    compatible = "ti,dra742", "ti,dra74", "ti,dra7"
>  
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index dc9e34e670a2..e5d9d769a76e 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -312,6 +312,7 @@ MACHINE_END
>  
>  #ifdef CONFIG_SOC_DRA7XX
>  static const char *const dra74x_boards_compat[] __initconst = {
> +	"ti,dra76",
>  	"ti,am5728",
>  	"ti,am5726",
>  	"ti,dra742",
> -- 
> 2.13.0
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

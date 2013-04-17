From: Lars Poeschel <poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH v3 3/3] ARM: OMAP2+: Add GPMC DT support for Ethernet
 child nodes
Date: Wed, 17 Apr 2013 16:41:23 +0200
Message-ID: <201304171641.23871.poeschel@lemonage.de>
References: <1363298051-24574-1-git-send-email-javier.martinez@collabora.co.uk>
 <201304171140.52529.poeschel@lemonage.de> <516E9026.8070804@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <516E9026.8070804-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Enric Balletbo i Serra <eballetbo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 17 April 2013 at 14:05:58, Javier Martinez Canillas wrote:

...

> Yes, in fact I just realized that for_each_node_by_name() expand to:
> 
> #define for_each_node_by_name(dn, name) \
>         for (dn = of_find_node_by_name(NULL, name); dn; \
>              dn = of_find_node_by_name(dn, name))
> 
> which means that it will search for a node with "name" on the complete
> DeviceTree and this is wrong. It should only search on GPMC childs.
> 
> Could you please test the following patch? If it works for you I'll add
> a proper description and submit it as a PATCH.

I see discussion is already going on, I just want to report:
I tested the patch and it work as intended. Probing of the gpmc childs 
succeeds on am335x with another ethernet node in device tree.


Lars

> From d8dab9ae9a0284f17553875c2fddd806d9f6ab2e Mon Sep 17 00:00:00 2001
> From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
> Date: Wed, 17 Apr 2013 13:50:30 +0200
> Subject: [PATCH] ARM: OMAP2+: only search for GPMC DT child nodes on
>  probe
> 
> Signed-off-by: Javier Martinez Canillas
> <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> ---
>  arch/arm/mach-omap2/gpmc.c |   51
> ++++++++++++++++++++----------------------- 1 files changed, 24
> insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index ed946df..58e2415 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1520,35 +1520,32 @@ static int gpmc_probe_dt(struct platform_device
> *pdev) return ret;
>  	}
> 
> -	for_each_node_by_name(child, "nand") {
> -		ret = gpmc_probe_nand_child(pdev, child);
> -		if (ret < 0) {
> -			of_node_put(child);
> -			return ret;
> -		}
> -	}
> -
> -	for_each_node_by_name(child, "onenand") {
> -		ret = gpmc_probe_onenand_child(pdev, child);
> -		if (ret < 0) {
> -			of_node_put(child);
> -			return ret;
> -		}
> -	}
> +	for_each_child_of_node(pdev->dev.of_node, child) {
> +		if (child->name) {
> +			if (of_node_cmp(child->name, "nand") == 0) {
> +				ret = gpmc_probe_nand_child(pdev, child);
> +				if (ret < 0) {
> +					of_node_put(child);
> +					return ret;
> +				}
> +			}
> 
> -	for_each_node_by_name(child, "nor") {
> -		ret = gpmc_probe_generic_child(pdev, child);
> -		if (ret < 0) {
> -			of_node_put(child);
> -			return ret;
> -		}
> -	}
> +			if (of_node_cmp(child->name, "onenand") == 0) {
> +				ret = gpmc_probe_onenand_child(pdev, child);
> +				if (ret < 0) {
> +					of_node_put(child);
> +					return ret;
> +				}
> +			}
> 
> -	for_each_node_by_name(child, "ethernet") {
> -		ret = gpmc_probe_generic_child(pdev, child);
> -		if (ret < 0) {
> -			of_node_put(child);
> -			return ret;
> +			if (of_node_cmp(child->name, "ethernet") == 0 ||
> +			    of_node_cmp(child->name, "nor") == 0) {
> +				ret = gpmc_probe_generic_child(pdev, child);
> +				if (ret < 0) {
> +					of_node_put(child);
> +					return ret;
> +				}
> +			}
>  		}
>  	}

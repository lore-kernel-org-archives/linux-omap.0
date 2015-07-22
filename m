From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/omap: Add support for configuring dsp iommus
 on DRA7xx
Date: Tue, 21 Jul 2015 22:26:01 -0700
Message-ID: <20150722052600.GF17550@atomide.com>
References: <1437522936-19758-1-git-send-email-s-anna@ti.com>
 <1437522936-19758-3-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437522936-19758-3-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> [150721 16:58]:
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -26,6 +26,8 @@
>  #include <linux/of_iommu.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
>  
>  #include <asm/cacheflush.h>
>  
> @@ -112,6 +114,18 @@ void omap_iommu_restore_ctx(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(omap_iommu_restore_ctx);
>  
> +static void dra7_cfg_dspsys_mmu(struct omap_iommu *obj, bool enable)
> +{
> +	u32 val, mask;
> +
> +	if (!obj->syscfg)
> +		return;
> +
> +	mask = (1 << (obj->id * DSP_SYS_MMU_CONFIG_EN_SHIFT));
> +	val = enable ? mask : 0;
> +	regmap_update_bits(obj->syscfg, DSP_SYS_MMU_CONFIG, mask, val);
> +}
> +
>  static void __iommu_set_twl(struct omap_iommu *obj, bool on)

I don't like using syscon for tinkering directly with SoC registers.

We should use some Linux generic framework for configuring these
bits to avoid nasty dependencies between various hardware modules
on the SoC.

What does DSP_SYS_MMU_CONFIG register do? It seems it's probably
a regulator or a gate clock? If so, it should be set up as a
regulator or a clock and then the omap-iommu driver can just
use regulator or clcok framework to request the resource.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

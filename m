From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 2/4] ARM: OMAP2+: hwmod: add omap_hwmod_get_main_clk()
 API
Date: Fri, 20 Apr 2012 17:10:35 +0200
Message-ID: <4F917C6B.8060409@ti.com>
References: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com> <1334925563-20768-3-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41815 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932307Ab2DTPKn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 11:10:43 -0400
In-Reply-To: <1334925563-20768-3-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi Tarun,

Thanks for this series, it will help us cleaning a little bit more the 
legacy stuff we have inside our data files.

On 4/20/2012 2:39 PM, Tarun Kanti DebBarma wrote:
> Add an API to get main clock name associated with a given @oh.
> This will avoid the need to construct fclk names during early
> initialization in order to get fclk handle using clk_get().
>
> Cc: Cousson, Benoit<b-cousson@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> Cc: Tony Lindgren<tony@atomide.com>
> Cc: Kevin Hilman<khilman@ti.com>
> Cc: Rajendra Nayak<rnayak@ti.com>
> Cc: Santosh Shilimkar<santosh.shilimkar@ti.com>
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>

Acked-by: Benoit Cousson <b-cousson@ti.com>

Regards,
Benoit

> ---
>   arch/arm/mach-omap2/omap_hwmod.c             |   15 +++++++++++++++
>   arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 ++
>   2 files changed, 17 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 2c27fdb..2c6214d 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2775,3 +2775,18 @@ int omap_hwmod_pad_route_irq(struct omap_hwmod *oh, int pad_idx, int irq_idx)
>
>   	return 0;
>   }
> +
> +/**
> + * omap_hwmod_get_main_clk - get pointer to main clock name
> + * @oh: struct omap_hwmod *
> + *
> + * Returns the main clock name assocated with @oh upon success,
> + * or NULL if @oh is NULL.
> + */
> +const char *omap_hwmod_get_main_clk(struct omap_hwmod *oh)
> +{
> +	if (!oh)
> +		return NULL;
> +
> +	return oh->main_clk;
> +}
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 8070145..f3c0697 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -608,6 +608,8 @@ int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
>
>   int omap_hwmod_pad_route_irq(struct omap_hwmod *oh, int pad_idx, int irq_idx);
>
> +const char *omap_hwmod_get_main_clk(struct omap_hwmod *oh);
> +
>   /*
>    * Chip variant-specific hwmod init routines - XXX should be converted
>    * to use initcalls once the initial boot ordering is straightened out


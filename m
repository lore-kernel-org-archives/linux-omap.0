From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 4/13] dmtimer: hwmod: OMAP: api to read omap_hwmod _clk
Date: Mon, 23 Aug 2010 15:50:45 -0700
Message-ID: <87k4nhuenu.fsf@deeprootsystems.com>
References: <1281800283-15185-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56150 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215Ab0HWWus (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Aug 2010 18:50:48 -0400
Received: by pwi7 with SMTP id 7so2268574pwi.19
        for <linux-omap@vger.kernel.org>; Mon, 23 Aug 2010 15:50:48 -0700 (PDT)
In-Reply-To: <1281800283-15185-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Sat, 14 Aug 2010 21:08:03 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Thara Gopinath <thara@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> This patch adds the omap_hwmod_get_clk() to access the _clk
> field needed while setting clock sources of the timers.
>
> Signed-off-by: Partha Basak <p-basak2@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Tony Lindgren <tony@atomide.com>

To help understand the motivation for the change, please explain in the
changelog the intended usage of the API, e.g. what drivers/devices will
use this API and why.

Also, this patch (with a more descriptive changelog) should be separate
from this series as it affects the omap_hwmod core.

I see it's usage later in this series, but this change (if accepted)
would upstream separately from the dmtimer series.

Kevin

> ---
>  arch/arm/mach-omap2/omap_hwmod.c             |   21 +++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
>  2 files changed, 22 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 arch/arm/mach-omap2/omap_hwmod.c
>  mode change 100644 => 100755 arch/arm/plat-omap/include/plat/omap_hwmod.h
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 7f3c023..7188f0c
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1759,6 +1759,27 @@ void __iomem *omap_hwmod_get_mpu_rt_va(struct omap_hwmod *oh)
>  }
>  
>  /**
> + * omap_hwmod_get_clk - returns pointer to this module's struct clk
> + * @oh: struct omap_hwmod *
> + *
> + * Return the struct clk pointer associated with the OMAP module
> + * Returns NULL on error, or a struct clk * on success.
> + */
> +struct clk *omap_hwmod_get_clk(struct omap_hwmod *oh)
> +{
> +	if (!oh)
> +		return NULL;
> +
> +	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
> +		return NULL;
> +
> +	if (oh->_state == _HWMOD_STATE_UNKNOWN)
> +		return NULL;
> +
> +	return oh->_clk;
> +}
> +
> +/**
>   * omap_hwmod_add_initiator_dep - add sleepdep from @init_oh to @oh
>   * @oh: struct omap_hwmod *
>   * @init_oh: struct omap_hwmod * (initiator)
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 6adbb63..a2b85a5
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -538,6 +538,7 @@ int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res);
>  
>  struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh);
>  void __iomem *omap_hwmod_get_mpu_rt_va(struct omap_hwmod *oh);
> +struct clk *omap_hwmod_get_clk(struct omap_hwmod *oh);
>  
>  int omap_hwmod_add_initiator_dep(struct omap_hwmod *oh,
>  				 struct omap_hwmod *init_oh);

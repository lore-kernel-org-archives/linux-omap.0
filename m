From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2/3/4: ioremap address space
Date: Tue, 26 Jan 2010 07:46:08 -0800
Message-ID: <20100126154608.GA17449@atomide.com>
References: <1264495210-17344-1-git-send-email-santosh.shilimkar@ti.com>
 <1264495210-17344-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59504 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754041Ab0AZPpv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 10:45:51 -0500
Content-Disposition: inline
In-Reply-To: <1264495210-17344-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [100126 00:37]:
> This patch update the sdrc, prcm, tap and control module to
> allocate iospace dynamically
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> CC: Kevin Hilman <khilman@deeprootsystems.com>
> CC: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/control.c |    6 +++++-
>  arch/arm/mach-omap2/id.c      |    7 ++++++-
>  arch/arm/mach-omap2/prcm.c    |   16 +++++++++++++---
>  arch/arm/mach-omap2/sdrc.c    |   11 +++++++++--
>  4 files changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
> index cdd1f35..43f8a33 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -140,7 +140,11 @@ static struct omap3_control_regs control_context;
>  
>  void __init omap2_set_globals_control(struct omap_globals *omap2_globals)
>  {
> -	omap2_ctrl_base = omap2_globals->ctrl;
> +	/* Static mapping, never released */
> +	if (omap2_globals->ctrl) {
> +		omap2_ctrl_base = ioremap(omap2_globals->ctrl, SZ_4K);
> +		WARN_ON(!omap2_ctrl_base);
> +	}
>  }
>  
>  void __iomem *omap_ctrl_base_get(void)
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index a091b53..fb5921b 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -407,7 +407,12 @@ void __init omap2_check_revision(void)
>  void __init omap2_set_globals_tap(struct omap_globals *omap2_globals)
>  {
>  	omap_revision = omap2_globals->class;
> -	tap_base = omap2_globals->tap;
> +
> +	/* Static mapping, never released */
> +	if (omap2_globals->tap) {
> +		tap_base = ioremap(omap2_globals->tap, SZ_4K);
> +		WARN_ON(!tap_base);
> +	}
>  
>  	if (cpu_is_omap34xx())
>  		tap_prod_id = 0x0210;

Nice clean-up.

We need to check carefully that the cpu detection is done by the time
we do the ioremap.. Initially we only know the machine class such as
34xx/24xx.

We have at least cpu_is_omap2420 and cpu_is_omap2430 being used in io.c,
so all these mappings may not work properly.

Also, we should merge this as one patch to keep the system booting
between the patches.

Regards,

Tony

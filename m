From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 1/2] ARM: OMAP2+: omap_hwmod: Add api to
 enable/disable module level wakeup events
Date: Tue, 24 Apr 2012 09:07:40 -0700
Message-ID: <20120424160740.GJ3739@atomide.com>
References: <1335276552-24340-1-git-send-email-govindraj.raja@ti.com>
 <1335276552-24340-2-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:20430 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755395Ab2DXQHo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 12:07:44 -0400
Content-Disposition: inline
In-Reply-To: <1335276552-24340-2-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Govindraj.R <govindraj.raja@ti.com> [120424 07:12]:
> From: "Govindraj.R" <govindraj.raja@ti.com>
> 
> On 24xx/34xx/36xx Module level wakeup events are enabled/disabled using
> PM_WKEN1_CORE/PM_WKEN_PER regs.
> 
> Add api to control the module level wakeup mechanism from info provided from
> hwmod data.
> 
> omap_hwmod_enable/disable_wakeup is used from serial.c which should
> configure PM_WKEN register to enable or disable the module level wakeup.
> 
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c   |   22 ++++++++++++++++++++++
>  arch/arm/mach-omap2/prm2xxx_3xxx.c |   16 ++++++++++++++++
>  arch/arm/mach-omap2/prm2xxx_3xxx.h |    9 +++++++++
>  3 files changed, 47 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 2c27fdb..4f10619 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -382,6 +382,26 @@ static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
>  }
>  
>  /**
> + * _enable_module_level_wakeup - enable/disable module level wakeup on hwmod.
> + * @oh: struct omap_hwmod *
> + * @set_wake: bool value indicating to set (true) or clear (false) module level
> + *		wakeup enable
> + *
> + * Set or clear the  module level wakeup capability the
> + * hwmod @oh. This function configures th PM_WKEN reg bits if they
> + * are available from hwmod. No return value
> + */
> +static void _enable_module_level_wakeup(struct omap_hwmod *oh, bool set_wake)
> +{
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx())
> +		omap2_prm_enable_prcm_module_wakeup(
> +				oh->prcm.omap2.module_offs,
> +				oh->prcm.omap2.prcm_reg_id,
> +				oh->prcm.omap2.idlest_idle_bit,
> +				set_wake);
> +}

Please don't sprinkle cpu_is_omap tests into code that gets called multiple times.
Initialize things properly during init instead.

Regards,

Tony

From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 01/15] ARM: OMAP4+: PM: Consolidate MPU subsystem PM code
 for re-use
Date: Fri, 1 Mar 2013 07:50:01 -0600
Message-ID: <20130301135001.GB20420@kahuna>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
 <1362139864-9233-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36782 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902Ab3CANuH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Mar 2013 08:50:07 -0500
Content-Disposition: inline
In-Reply-To: <1362139864-9233-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

On 17:40-20130301, Santosh Shilimkar wrote:
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c |   56 +++++++++++++++++++++++------
>  1 file changed, 45 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> index abdd0f6..ee8a1e4 100644
> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> @@ -71,10 +71,37 @@ struct omap4_cpu_pm_info {
>  	void (*secondary_startup)(void);
>  };
>  
> +struct cpu_pm_ops {
> +	int (*finish_suspend)(unsigned long cpu_state);
> +	void (*resume)(void);
> +	void (*scu_prepare)(unsigned int cpu_id, unsigned int cpu_state);
> +};
> +
> +extern int omap4_finish_suspend(unsigned long cpu_state);
> +extern void omap4_cpu_resume(void);
> +
>  static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
>  static struct powerdomain *mpuss_pd;
>  static void __iomem *sar_base;
>  
> +static int default_finish_suspend(unsigned long cpu_state)
> +{
> +	omap_do_wfi();
> +	return 0;
> +}
> +
> +static void dummy_cpu_resume(void)
> +{}
> +
> +void dummy_scu_prepare(unsigned int cpu_id, unsigned int cpu_state)
static?
> +{}
> +
> +struct cpu_pm_ops omap_pm_ops = {
> +	.finish_suspend		= default_finish_suspend,
> +	.resume			= dummy_cpu_resume,
> +	.scu_prepare		= dummy_scu_prepare,
> +};
> +
Otherwise,
Acked-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon

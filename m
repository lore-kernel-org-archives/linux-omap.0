From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 20/25] OMAP4: PM: Add L2X0 cache lowpower support
Date: Fri, 16 Sep 2011 10:23:44 -0700
Message-ID: <87iposqu3j.fsf@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-21-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:53483 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752964Ab1IPRXu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 13:23:50 -0400
Received: by yxj17 with SMTP id 17so6211116yxj.6
        for <linux-omap@vger.kernel.org>; Fri, 16 Sep 2011 10:23:48 -0700 (PDT)
In-Reply-To: <1315144466-9395-21-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sun, 4 Sep 2011 19:24:21 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> When MPUSS hits off-mode e, L2 cache is lost. This patch adds L2X0
                          ^^^
extra 'e' ?

> necessary maintenance operations and context restoration in the
> low power code.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

[...]

> @@ -135,6 +138,33 @@ static void scu_pwrst_prepare(unsigned int cpu_id, unsigned int cpu_state)
>  	__raw_writel(scu_pwr_st, pm_info->scu_sar_addr);
>  }
>  
> +/*
> + * Store the CPU cluster state for L2X0 low power operations.
> + */
> +static void l2x0_pwrst_prepare(unsigned int cpu_id, unsigned int save_state)
> +{
> +	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu_id);
> +
> +	__raw_writel(save_state, pm_info->l2x0_sar_addr);
> +}
> +
> +/*
> + * Save the L2X0 AUXCTRL and POR value to SAR memory. Its used to
> + * in every restore MPUSS OFF path.
> + */
> +static void save_l2x0_context(void)
> +{
> +#ifdef CONFIG_CACHE_L2X0
> +	u32 val;
> +	void __iomem *l2x0_base = omap4_get_l2cache_base();
> +
> +	val = __raw_readl(l2x0_base + L2X0_AUX_CTRL);
> +	__raw_writel(val, sar_base + L2X0_AUXCTRL_OFFSET);
> +	val = __raw_readl(l2x0_base + L2X0_PREFETCH_CTRL);
> +	__raw_writel(val, sar_base + L2X0_PREFETCH_CTRL_OFFSET);
> +#endif

nit:  (c.f. '#ifdefs are ugly' in Documentatin/SubmittingPatches)

This should probably be more like

#ifdef CONFIG_CACHE_L2X0
static void save_l2x0_context(void)
{
        /* real function */
}
#else
static void save_l2x0_context(void) {}
#endif

Kevin

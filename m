From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 20/25] OMAP4: PM: Add L2X0 cache lowpower support
Date: Sun, 18 Sep 2011 14:16:26 +0530
Message-ID: <4E75AFE2.5030706@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>	<1315144466-9395-21-git-send-email-santosh.shilimkar@ti.com> <87iposqu3j.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:49798 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754396Ab1IRIqd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 18 Sep 2011 04:46:33 -0400
Received: by yie16 with SMTP id 16so4309694yie.24
        for <linux-omap@vger.kernel.org>; Sun, 18 Sep 2011 01:46:31 -0700 (PDT)
In-Reply-To: <87iposqu3j.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com

On Friday 16 September 2011 10:53 PM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> When MPUSS hits off-mode e, L2 cache is lost. This patch adds L2X0
>                           ^^^
> extra 'e' ?
> 
>> necessary maintenance operations and context restoration in the
>> low power code.
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Kevin Hilman <khilman@ti.com>
> 
> [...]
> 
>> @@ -135,6 +138,33 @@ static void scu_pwrst_prepare(unsigned int cpu_id, unsigned int cpu_state)
>>  	__raw_writel(scu_pwr_st, pm_info->scu_sar_addr);
>>  }
>>  
>> +/*
>> + * Store the CPU cluster state for L2X0 low power operations.
>> + */
>> +static void l2x0_pwrst_prepare(unsigned int cpu_id, unsigned int save_state)
>> +{
>> +	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu_id);
>> +
>> +	__raw_writel(save_state, pm_info->l2x0_sar_addr);
>> +}
>> +
>> +/*
>> + * Save the L2X0 AUXCTRL and POR value to SAR memory. Its used to
>> + * in every restore MPUSS OFF path.
>> + */
>> +static void save_l2x0_context(void)
>> +{
>> +#ifdef CONFIG_CACHE_L2X0
>> +	u32 val;
>> +	void __iomem *l2x0_base = omap4_get_l2cache_base();
>> +
>> +	val = __raw_readl(l2x0_base + L2X0_AUX_CTRL);
>> +	__raw_writel(val, sar_base + L2X0_AUXCTRL_OFFSET);
>> +	val = __raw_readl(l2x0_base + L2X0_PREFETCH_CTRL);
>> +	__raw_writel(val, sar_base + L2X0_PREFETCH_CTRL_OFFSET);
>> +#endif
> 
> nit:  (c.f. '#ifdefs are ugly' in Documentatin/SubmittingPatches)
> 
> This should probably be more like
> 
> #ifdef CONFIG_CACHE_L2X0
> static void save_l2x0_context(void)
> {
>         /* real function */
> }
> #else
> static void save_l2x0_context(void) {}
> #endif
> 
Ok. Will fix this.

Regards
Santosh

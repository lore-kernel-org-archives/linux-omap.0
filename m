From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v7 RESEND] ARM: omap: edma: add suspend suspend/resume
 hooks
Date: Tue, 26 Aug 2014 12:06:04 +0530
Message-ID: <53FC2AD4.4070400@ti.com>
References: <1408693562-18068-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45877 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757247AbaHZGgc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Aug 2014 02:36:32 -0400
In-Reply-To: <1408693562-18068-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Daniel Mack <zonque@gmail.com>, Nishanth Menon <nm@ti.com>

On Friday 22 August 2014 01:16 PM, Dave Gerlach wrote:
> From: Daniel Mack <zonque@gmail.com>
> 
> This patch makes the edma driver resume correctly after suspend. Tested
> on an AM33xx platform with cyclic audio streams and omap_hsmmc.
> 
> All information can be reconstructed by already known runtime
> information.
> 
> As we now use some functions that were previously only used from __init
> context, annotations had to be dropped.
> 
> [nm@ti.com: added error handling for runtime + suspend_late/early_resume]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Tested-by: Joel Fernandes <joelf@ti.com>
> Acked-by: Joel Fernandes <joelf@ti.com>
> [d-gerlach@ti.com: updated to remove queue_tc_mapping use]
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
> 
> Needed for am335x suspend, but never got picked up. Previously
> sent here: http://marc.info/?l=linux-arm-kernel&m=138556067416051&w=2
> 
>  arch/arm/common/edma.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 84 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 8809917..ece1e3d 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -244,6 +244,8 @@ struct edma {
>  	/* list of channels with no even trigger; terminated by "-1" */
>  	const s8	*noevent;
>  
> +	struct edma_soc_info *info;
> +
>  	/* The edma_inuse bit for each PaRAM slot is clear unless the
>  	 * channel is in use ... by ARM or DSP, for QDMA, or whatever.
>  	 */
> @@ -295,7 +297,7 @@ static void map_dmach_queue(unsigned ctlr, unsigned ch_no,
>  			~(0x7 << bit), queue_no << bit);
>  }
>  
> -static void __init assign_priority_to_queue(unsigned ctlr, int queue_no,
> +static void assign_priority_to_queue(unsigned ctlr, int queue_no,
>  		int priority)
>  {
>  	int bit = queue_no * 4;
> @@ -314,7 +316,7 @@ static void __init assign_priority_to_queue(unsigned ctlr, int queue_no,
>   * included in that particular EDMA variant (Eg : dm646x)
>   *
>   */
> -static void __init map_dmach_param(unsigned ctlr)
> +static void map_dmach_param(unsigned ctlr)
>  {
>  	int i;
>  	for (i = 0; i < EDMA_MAX_DMACH; i++)
> @@ -1791,15 +1793,95 @@ static int edma_probe(struct platform_device *pdev)
>  			edma_write_array2(j, EDMA_DRAE, i, 1, 0x0);
>  			edma_write_array(j, EDMA_QRAE, i, 0x0);
>  		}
> +		edma_cc[j]->info = info[j];
>  		arch_num_cc++;
>  	}
>  
>  	return 0;
>  }
>  
> +static int edma_pm_suspend(struct device *dev)
> +{
> +	int j, r;
> +
> +	r = pm_runtime_get_sync(dev);
> +	if (r < 0) {
> +		dev_err(dev, "%s: get_sync returned %d\n", __func__, r);
> +		return r;
> +	}

The driver currently does a pm_runtime_get_sync() once during probe. And
does not do a put(). So this should actually be not required. In fact
looks like this additional get() call will prevent the clock from
getting disabled which is probably not what you intend.

> +
> +	for (j = 0; j < arch_num_cc; j++) {
> +		struct edma *ecc = edma_cc[j];
> +
> +		disable_irq(ecc->irq_res_start);
> +		disable_irq(ecc->irq_res_end);

Do we really need to disable these irqs?

> +	}
> +
> +	pm_runtime_put_sync(dev);
> +
> +	return 0;
> +}
> +
> +static int edma_pm_resume(struct device *dev)
> +{
> +	int i, j, r;
> +
> +	r = pm_runtime_get_sync(dev);
> +	if (r < 0) {
> +		dev_err(dev, "%s: get_sync returned %d\n", __func__, r);
> +		return r;
> +	}
> +
> +	for (j = 0; j < arch_num_cc; j++) {
> +		struct edma *cc = edma_cc[j];
> +
> +		s8 (*queue_priority_mapping)[2];
> +
> +		queue_priority_mapping = cc->info->queue_priority_mapping;
> +
> +		/* Event queue priority mapping */
> +		for (i = 0; queue_priority_mapping[i][0] != -1; i++)
> +			assign_priority_to_queue(j,
> +						 queue_priority_mapping[i][0],
> +						 queue_priority_mapping[i][1]);
> +
> +		/*
> +		 * Map the channel to param entry if channel mapping logic
> +		 * exist
> +		 */
> +		if (edma_read(j, EDMA_CCCFG) & CHMAP_EXIST)
> +			map_dmach_param(j);
> +
> +		for (i = 0; i < cc->num_channels; i++) {
> +			if (test_bit(i, cc->edma_inuse)) {
> +				/* ensure access through shadow region 0 */
> +				edma_or_array2(j, EDMA_DRAE, 0, i >> 5,
> +					       BIT(i & 0x1f));
> +
> +				setup_dma_interrupt(i,
> +						    cc->intr_data[i].callback,
> +						    cc->intr_data[i].data);
> +			}
> +		}
> +
> +		enable_irq(cc->irq_res_start);
> +		enable_irq(cc->irq_res_end);
> +	}
> +
> +	pm_runtime_put_sync(dev);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops edma_pm_ops = {
> +	.suspend_late	= edma_pm_suspend,
> +	.resume_early	= edma_pm_resume,
> +};

You can use SET_LATE_SYSTEM_SLEEP_PM_OPS() as some other DMA drivers are
doing too.

Thanks,
Sekhar


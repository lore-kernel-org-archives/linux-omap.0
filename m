From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v9] ARM: omap: edma: add suspend resume hook
Date: Wed, 5 Nov 2014 09:57:37 -0600
Message-ID: <545A48F1.8060607@ti.com>
References: <1409043173-24357-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48790 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755770AbaKEP6C (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Nov 2014 10:58:02 -0500
In-Reply-To: <1409043173-24357-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>, nsekhar@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com

On 08/26/2014 03:52 AM, Daniel Mack wrote:
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
> ---
> Changes from v8:
> 
> 	* Drop the edma_suspend hook altogether. Even though back then
> 	  when I wrote the code I was sure disabling the interrupts
> 	  during suspend is necessary, tests now show it in fact isn't.
> 	  My test setup still works if that code is omitted.
> 	* Use SET_LATE_SYSTEM_SLEEP_PM_OPS in the dev_pm_ops
> 	  declaration.
> 
> 	Thanks to Sekhar for pointing out the above.
> 
>  arch/arm/common/edma.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 58 insertions(+), 2 deletions(-)

Doesn't seem to be any comments here, any chance this can be picked up? This
patch always seems to get missed but will be needed for suspend/resume on both
AM335x and AM437x.

Regards,
Dave

> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 485be42..c623dd0 100644
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
> @@ -1762,15 +1764,69 @@ static int edma_probe(struct platform_device *pdev)
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
> +	}
> +
> +	pm_runtime_put_sync(dev);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops edma_pm_ops = {
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(NULL, edma_pm_resume)
> +};
> +
>  static struct platform_driver edma_driver = {
>  	.driver = {
>  		.name	= "edma",
> +		.pm	= &edma_pm_ops,
>  		.of_match_table = edma_of_ids,
>  	},
>  	.probe = edma_probe,
> 


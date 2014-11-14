From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v9] ARM: omap: edma: add suspend resume hook
Date: Fri, 14 Nov 2014 22:33:23 +0530
Message-ID: <546635DB.4020202@ti.com>
References: <1409043173-24357-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59373 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933486AbaKNRDy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2014 12:03:54 -0500
In-Reply-To: <1409043173-24357-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>, d-gerlach@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com

On Tuesday 26 August 2014 02:22 PM, Daniel Mack wrote:
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

I think I have asked this before, and I am still not sure why this call 
to pm_runtime_get_sync() is needed here. From my testing today, this 
does seem to be a a no-op and this call returns from rpm_resume() 
because of this check:

	else if (dev->power.disable_depth == 1 && dev->power.is_suspended
	    && dev->power.runtime_status == RPM_ACTIVE)
		retval = 1;

So, AFAICS, the net effect is an increment of dev->power.usage_count
(which is already greater than 0) and its subsequent decrement at the
end of the function.

After removing this call I did not see any EDMA malfunction as well 
(can access MMC/SD just fine after suspend/resume cycle).

So, any objections to merging this patch with the attached hunk 
applied?

Thanks,
Sekhar

---8<---
diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 1f492d5be9c0..79de6a23047b 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1803,13 +1803,7 @@ static int edma_probe(struct platform_device *pdev)
 
 static int edma_pm_resume(struct device *dev)
 {
-       int i, j, r;
-
-       r = pm_runtime_get_sync(dev);
-       if (r < 0) {
-               dev_err(dev, "%s: get_sync returned %d\n", __func__, r);
-               return r;
-       }
+       int i, j;
 
        for (j = 0; j < arch_num_cc; j++) {
                struct edma *cc = edma_cc[j];
@@ -1844,8 +1838,6 @@ static int edma_pm_resume(struct device *dev)
                }
        }
 
-       pm_runtime_put_sync(dev);
-
        return 0;
 }



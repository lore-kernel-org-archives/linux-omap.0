From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v6] ARM: omap: edma: add suspend suspend/resume hooks
Date: Wed, 27 Nov 2013 19:05:56 +0530
Message-ID: <5295F53C.8040101@ti.com>
References: <1384726754-27875-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1384726754-27875-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, joelf@ti.com, gururaja.hebbar@ti.com, balajitk@ti.com
Cc: nm@ti.com, Kevin Hilman <khilman@linaro.org>, s.neumann@raumfeld.com, Russ.Dill@ti.com, vaibhav.bedia@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

+ Kevin

On Monday 18 November 2013 03:49 AM, Daniel Mack wrote:
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
> 
> v6:
>   amended version from Nishanth Menon, adding error handling for runtime,
>   and using suspend_late/early_resume.
> 
> 
>  arch/arm/common/edma.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 91 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index 8e1a024..e2b9638 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -239,6 +239,8 @@ struct edma {
>  	/* list of channels with no even trigger; terminated by "-1" */
>  	const s8	*noevent;
>  
> +	struct edma_soc_info *info;
> +
>  	/* The edma_inuse bit for each PaRAM slot is clear unless the
>  	 * channel is in use ... by ARM or DSP, for QDMA, or whatever.
>  	 */
> @@ -290,13 +292,13 @@ static void map_dmach_queue(unsigned ctlr, unsigned ch_no,
>  			~(0x7 << bit), queue_no << bit);
>  }
>  
> -static void __init map_queue_tc(unsigned ctlr, int queue_no, int tc_no)
> +static void map_queue_tc(unsigned ctlr, int queue_no, int tc_no)
>  {
>  	int bit = queue_no * 4;
>  	edma_modify(ctlr, EDMA_QUETCMAP, ~(0x7 << bit), ((tc_no & 0x7) << bit));
>  }
>  
> -static void __init assign_priority_to_queue(unsigned ctlr, int queue_no,
> +static void assign_priority_to_queue(unsigned ctlr, int queue_no,
>  		int priority)
>  {
>  	int bit = queue_no * 4;
> @@ -315,7 +317,7 @@ static void __init assign_priority_to_queue(unsigned ctlr, int queue_no,
>   * included in that particular EDMA variant (Eg : dm646x)
>   *
>   */
> -static void __init map_dmach_param(unsigned ctlr)
> +static void map_dmach_param(unsigned ctlr)
>  {
>  	int i;
>  	for (i = 0; i < EDMA_MAX_DMACH; i++)
> @@ -1785,15 +1787,101 @@ static int edma_probe(struct platform_device *pdev)
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
> +	if (IS_ERR_VALUE(r)) {

So IS_ERR_VALUE() is only for functions which may return a negative
number outside of MAX_ERRNO as a success indication.
pm_runtime_get_sync() does not appear to be one of them so just use"

if (r < 0) { .. }

> +		dev_err(dev, "%s: get_sync returned %d\n", __func__, r);
> +		return r;
> +	}
> +
> +	for (j = 0; j < arch_num_cc; j++) {
> +		struct edma *ecc = edma_cc[j];
> +
> +		disable_irq(ecc->irq_res_start);
> +		disable_irq(ecc->irq_res_end);
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
> +	if (IS_ERR_VALUE(r)) {

Same here as above.

> +		dev_err(dev, "%s: get_sync returned %d\n", __func__, r);
> +		return r;
> +	}
> +
> +	for (j = 0; j < arch_num_cc; j++) {
> +		struct edma *cc = edma_cc[j];
> +
> +		s8 (*queue_priority_mapping)[2];
> +		s8 (*queue_tc_mapping)[2];
> +
> +		queue_tc_mapping = cc->info->queue_tc_mapping;
> +		queue_priority_mapping = cc->info->queue_priority_mapping;
> +
> +		/* Event queue to TC mapping */
> +		for (i = 0; queue_tc_mapping[i][0] != -1; i++)
> +			map_queue_tc(j, queue_tc_mapping[i][0],
> +					queue_tc_mapping[i][1]);
> +
> +		/* Event queue priority mapping */
> +		for (i = 0; queue_priority_mapping[i][0] != -1; i++)
> +			assign_priority_to_queue(j,
> +						queue_priority_mapping[i][0],
> +						queue_priority_mapping[i][1]);
> +
> +		/* Map the channel to param entry if channel mapping logic
> +		 * exist
> +		 */

Please follow the multi-line commenting style.

> +		if (edma_read(j, EDMA_CCCFG) & CHMAP_EXIST)
> +			map_dmach_param(j);
> +
> +		for (i = 0; i < cc->num_channels; i++) {
> +			if (test_bit(i, cc->edma_inuse)) {
> +				/* ensure access through shadow region 0 */
> +				edma_or_array2(j, EDMA_DRAE, 0, i >> 5,
> +						BIT(i & 0x1f));

There are some checkpatch checks that result from lines like this.
Please fix these as well.

CHECK: Alignment should match open parenthesis
#179: FILE: arch/arm/common/edma.c:1841:
+			map_queue_tc(j, queue_tc_mapping[i][0],
+					queue_tc_mapping[i][1]);

CHECK: Alignment should match open parenthesis
#184: FILE: arch/arm/common/edma.c:1846:
+			assign_priority_to_queue(j,
+						queue_priority_mapping[i][0],

CHECK: Alignment should match open parenthesis
#197: FILE: arch/arm/common/edma.c:1859:
+				edma_or_array2(j, EDMA_DRAE, 0, i >> 5,
+						BIT(i & 0x1f));

total: 0 errors, 0 warnings, 3 checks, 132 lines checked

Thanks,
Sekhar

From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH v4] ARM: omap: edma: add suspend suspend/resume hooks
Date: Thu, 7 Nov 2013 10:34:32 -0600
Message-ID: <527BC118.1050609@ti.com>
References: <1383164468-4610-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1383164468-4610-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Mack <zonque@gmail.com>
Cc: balajitk@ti.com, nsekhar@ti.com, s.neumann@raumfeld.com, gururaja.hebbar@ti.com, Russ.Dill@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Daniel,

Thanks for your followup patch on this. It looks much better now using existing
functions to save/restore the state.

On 10/30/2013 03:21 PM, Daniel Mack wrote:
> This patch makes the edma driver resume correctly after suspend. Tested
> on an AM33xx platform with cyclic audio streams and omap_hsmmc.
> 
> All information can be reconstructed by already known runtime
> information.
> 
> As we now use some functions that were previously only used from __init
> context, annotations had to be dropped.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
> There was actually only a v3 ever, I made a mistake when formating the
> first version of this patch. To prevent confusion though, I named this
> one v4.
> 
> v3 -> v4:
> 	* dropped extra allocations, and reconstruct register values
> 	  from already known driver states.
> 
> 
> 
> Hi Joel, Gururaja, Balaji,
> 
> thanks a lot for your feedback. I successfully tested this version with
> davinci mcasp as well as omap_hsmmc. I'd appreciate another round of
> reviews :)
> 
> 
> Thanks,
> Daniel
> 
>  arch/arm/common/edma.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 79 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
[..]
> +static int edma_pm_resume(struct device *dev)
> +{
> +	int i, j;
> +
> +	pm_runtime_get_sync(dev);
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

I know ti,edma-regions property is not currently being used, but we should
future proof this by setting up DRAE for like done in probe:

                for (i = 0; i < info[j]->n_region; i++) {
                        edma_write_array2(j, EDMA_DRAE, i, 0, 0x0);
                        edma_write_array2(j, EDMA_DRAE, i, 1, 0x0);
                        edma_write_array(j, EDMA_QRAE, i, 0x0);
                }


> +
> +		/* Map the channel to param entry if channel mapping logic
> +		 * exist
> +		 */
> +		if (edma_read(j, EDMA_CCCFG) & CHMAP_EXIST)
> +			map_dmach_param(j);
> +
> +		for (i = 0; i < cc->num_channels; i++)
> +			if (test_bit(i, cc->edma_inuse)) {
> +				/* ensure access through shadow region 0 */
> +				edma_or_array2(j, EDMA_DRAE, 0, i >> 5,
> +						BIT(i & 0x1f));
> +
> +				setup_dma_interrupt(i,
> +						    cc->intr_data[i].callback,
> +						    cc->intr_data[i].data);
> +			}
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
> +static SIMPLE_DEV_PM_OPS(edma_pm_ops, edma_pm_suspend, edma_pm_resume);

I agree with Nishanth here, it is better to do this in .suspend/resume _noirq
stage to rule out any ordering bugs that may show up in the future, since such
an issue already showed up in earlier testing.

I would appreciate it if you can make these 2 changes and post a v5. Thanks for
a lot for all the hardwork.

Acked-by: Joel Fernandes <joelf@ti.com>

regards,

-Joel

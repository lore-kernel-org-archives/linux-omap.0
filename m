From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCHv3 05/15] remoteproc/omap: Add the rproc ops .da_to_va()
 implementation
Date: Tue, 17 Dec 2019 17:38:15 -0700
Message-ID: <20191218003815.GC16271@xps15>
References: <20191213125537.11509-1-t-kristo@ti.com>
 <20191213125537.11509-6-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191213125537.11509-6-t-kristo@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: bjorn.andersson@linaro.org, ohad@wizery.com, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 13, 2019 at 02:55:27PM +0200, Tero Kristo wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> An implementation for the rproc ops .da_to_va() has been added
> that provides the address translation between device addresses
> to kernel virtual addresses for internal RAMs present on that
> particular remote processor device. The implementation provides
> the translations based on the addresses parsed and stored during
> the probe.
> 
> This ops gets invoked by the exported rproc_da_to_va() function
> and allows the remoteproc core's ELF loader to be able to load
> program data directly into the internal memories.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/remoteproc/omap_remoteproc.c | 39 ++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
> index 844703507a74..28f14e24b389 100644
> --- a/drivers/remoteproc/omap_remoteproc.c
> +++ b/drivers/remoteproc/omap_remoteproc.c
> @@ -232,10 +232,49 @@ static int omap_rproc_stop(struct rproc *rproc)
>  	return 0;
>  }
>  
> +/**
> + * omap_rproc_da_to_va() - internal memory translation helper
> + * @rproc: remote processor to apply the address translation for
> + * @da: device address to translate
> + * @len: length of the memory buffer
> + *
> + * Custom function implementing the rproc .da_to_va ops to provide address
> + * translation (device address to kernel virtual address) for internal RAMs
> + * present in a DSP or IPU device). The translated addresses can be used
> + * either by the remoteproc core for loading, or by any rpmsg bus drivers.
> + * Returns the translated virtual address in kernel memory space, or NULL
> + * in failure.
> + */
> +static void *omap_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
> +{
> +	struct omap_rproc *oproc = rproc->priv;
> +	int i;
> +	u32 offset;
> +
> +	if (len <= 0)
> +		return NULL;
> +
> +	if (!oproc->num_mems)
> +		return NULL;
> +
> +	for (i = 0; i < oproc->num_mems; i++) {
> +		if (da >= oproc->mem[i].dev_addr && da + len <=

Shouldn't this be '<' rather than '<=' ?

> +		    oproc->mem[i].dev_addr +  oproc->mem[i].size) {

One space too many after the '+' .

> +			offset = da -  oproc->mem[i].dev_addr;

One space too many after then '-' .

> +			/* __force to make sparse happy with type conversion */
> +			return (__force void *)(oproc->mem[i].cpu_addr +
> +						offset);
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
>  static const struct rproc_ops omap_rproc_ops = {
>  	.start		= omap_rproc_start,
>  	.stop		= omap_rproc_stop,
>  	.kick		= omap_rproc_kick,
> +	.da_to_va	= omap_rproc_da_to_va,
>  };
>  
>  static const char * const ipu_mem_names[] = {
> -- 
> 2.17.1
> 
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

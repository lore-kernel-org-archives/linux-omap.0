From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/2] memory: ti-emif-sram: introduce relocatable
 suspend/resume handlers
Date: Fri, 1 Sep 2017 12:26:46 +0200
Message-ID: <20170901102646.GQ20634@localhost>
References: <20170724212454.27574-1-d-gerlach@ti.com>
 <20170724212454.27574-3-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170724212454.27574-3-d-gerlach-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy J <j-keerthy-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 24, 2017 at 04:24:54PM -0500, Dave Gerlach wrote:
> Certain SoCs like Texas Instruments AM335x and AM437x require parts
> of the EMIF PM code to run late in the suspend sequence from SRAM,
> such as saving and restoring the EMIF context and placing the memory
> into self-refresh.
> 
> One requirement for these SoCs to suspend and enter its lowest power
> mode, called DeepSleep0, is that the PER power domain must be shut off.
> Because the EMIF (DDR Controller) resides within this power domain, it
> will lose context during a suspend operation, so we must save it so we
> can restore once we resume. However, we cannot execute this code from
> external memory, as it is not available at this point, so the code must
> be executed late in the suspend path from SRAM.
> 
> This patch introduces a ti-emif-sram driver that includes several
> functions written in ARM ASM that are relocatable so the PM SRAM
> code can use them. It also allocates a region of writable SRAM to
> be used by the code running in the executable region of SRAM to save
> and restore the EMIF context. It can export a table containing the
> absolute addresses of the available PM functions so that other SRAM
> code can branch to them. This code is required for suspend/resume on
> AM335x and AM437x to work.
> 
> In addition to this, to be able to share data structures between C and
> the ti-emif-sram-pm assembly code, we can automatically generate all of
> the C struct member offsets and sizes as macros by making use of the ARM
> asm-offsets file. In the same header that we define our data structures
> in we also define all the macros in an inline function and by adding a
> call to this in the asm_offsets file all macros are properly generated
> and available to the assembly code without cluttering up the asm-offsets
> file.
> 
> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> ---
> v2->v3:
> * Move all static vars into common struct and instead point to one static
>   instance of this struct and pass this struct around for internal calls.
> * Rename ti_emif_prepare_push_sram to ti_emif_alloc_sram
> * Clean up probe path to avoid leftover vairable values from being used
>   after probe defer or failure.
> * Fix mistake in ASM code that stored EMIF_POWER_MANAGEMENT_CONTROL into
>   location for shadow register.
> * Avoid extern definition for asm-offsets definition and use a stub instead
>   of defining out in asm-offsets.
> * A few general fixups to code.

Just got back from my vacation this week, so sorry about the late reply.

It indeed looks like you've addressed my comments on v2, but I still
have few comments below. Just minor nits.

> +	/* Save physical address to calculate resume offset during pm init */
> +	emif_data->ti_emif_sram_data_phys =
> +		gen_pool_virt_to_phys(emif_data->sram_pool_data,

I try to indent continuation lines at least two tabs further (at least
when not matching open parentheses) which tends to improve readability
and conforms better to the coding standard.

> +				      emif_data->ti_emif_sram_data_virt);

> +/**
> + * ti_emif_copy_pm_function_table - copy mapping of pm funcs in sram
> + * @sram_pool: pointer to struct gen_pool where dst resides
> + * @dst: void * to address that table should be copied
> + *
> + * Returns 0 if success other error code if table is not available
> + */
> +int ti_emif_copy_pm_function_table(struct gen_pool *sram_pool, void *dst)
> +{
> +	void *copy_addr;
> +
> +	if (!(emif_instance && emif_instance->ti_emif_sram_virt))
> +		return -EINVAL;

Perhaps this can now be simplified as 

	if (!emif_instance)
		return -EINVAL;

since when the driver has been successfully bound all fields would have
been initialised.

Use -ENODEV for consistency?

> +
> +	copy_addr = sram_exec_copy(sram_pool, dst,
> +				   &emif_instance->pm_functions,
> +				   sizeof(emif_instance->pm_functions));
> +	if (!copy_addr)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ti_emif_copy_pm_function_table);
> +
> +/**
> + * ti_emif_get_mem_type - return type for memory type in use
> + *
> + * Returns memory type value read from EMIF or error code if fails
> + */
> +int ti_emif_get_mem_type(void)
> +{
> +	unsigned long temp;
> +
> +	if (!(emif_instance &&
> +	      !IS_ERR_OR_NULL(emif_instance->pm_data.ti_emif_base_addr_virt)))

And this would also be more readable as simply !emif_instance.

> +		return -ENODEV;
> +
> +	temp = readl(emif_instance->pm_data.ti_emif_base_addr_virt +
> +		     EMIF_SDRAM_CONFIG);
> +
> +	temp = (temp & SDRAM_TYPE_MASK) >> SDRAM_TYPE_SHIFT;
> +	return temp;
> +}
> +EXPORT_SYMBOL_GPL(ti_emif_get_mem_type);

> +static int ti_emif_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +
> +	ti_emif_free_sram(emif_instance);
> +
> +	emif_instance = NULL;

Nothing is of course preventing the remove() callback from racing with
the global functions above, but I'd still prefer to reset emif_instance
before releasing the memory.

In fact, given the register access in ti_emif_get_mem_type() you may
even want to clear emif_instance before the pm_runtime_put_sync().

> +
> +	return 0;
> +}

Thanks,
Johan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

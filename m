From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/2] memory: ti-emif-sram: introduce relocatable
 suspend/resume handlers
Date: Thu, 6 Jul 2017 13:59:08 -0500
Message-ID: <577c4595-74b4-c10d-2dbf-07b58e87a263@ti.com>
References: <20170519175708.6070-1-d-gerlach@ti.com>
 <20170519175708.6070-3-d-gerlach@ti.com> <20170703161716.GA27842@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170703161716.GA27842@localhost>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy J <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 07/03/2017 11:17 AM, Johan Hovold wrote:
> On Fri, May 19, 2017 at 12:57:08PM -0500, Dave Gerlach wrote:
>> Certain SoCs like Texas Instruments AM335x and AM437x require parts
>> of the EMIF PM code to run late in the suspend sequence from SRAM,
>> such as saving and restoring the EMIF context and placing the memory
>> into self-refresh.
>>
>> One requirement for these SoCs to suspend and enter its lowest power
>> mode, called DeepSleep0, is that the PER power domain must be shut off.
>> Because the EMIF (DDR Controller) resides within this power domain, it
>> will lose context during a suspend operation, so we must save it so we
>> can restore once we resume. However, we cannot execute this code from
>> external memory, as it is not available at this point, so the code must
>> be executed late in the suspend path from SRAM.
>>
>> This patch introduces a ti-emif-sram driver that includes several
>> functions written in ARM ASM that are relocatable so the PM SRAM
>> code can use them. It also allocates a region of writable SRAM to
>> be used by the code running in the executable region of SRAM to save
>> and restore the EMIF context. It can export a table containing the
>> absolute addresses of the available PM functions so that other SRAM
>> code can branch to them. This code is required for suspend/resume on
>> AM335x and AM437x to work.
> 
> Thanks for pushing this forward, Dave. 
> 
> I did a quick review of this one and found a few issues.
> 
>> +static phys_addr_t ti_emif_sram_phys, ti_emif_sram_data_phys;
>> +static unsigned long ti_emif_sram_virt, ti_emif_sram_data_virt;
>> +static struct gen_pool *sram_pool_code, *sram_pool_data;
>> +static struct ti_emif_pm_data pm_data;
>> +static struct ti_emif_pm_functions pm_functions;
> 
> Should these not be driver private data rather than static as you also
> are tying (and need to tie) this into the device model?
> 
> Sure there might never be two of these devices in practise, but in
> theory there could be. A proper device abstraction would probably allow
> for a cleaner implementation and help with some of the dependency issues
> (more below).
> 

Well, I would say that at this point the hardware is well defined and there is
no case where we would have two instances of this. Allowing two instances of
this code would also unnecessarily complicate the assembly portions because of
the absolute SRAM memory addresses that some of the variables are stored in.

>> +static int ti_emif_prepare_push_sram(struct device *dev)
>> +{
>> +	struct device_node *np = dev->of_node;
>> +	int ret;
>> +
>> +	sram_pool_code = of_gen_pool_get(np, "sram", 0);
>> +	if (!sram_pool_code) {
>> +		dev_err(dev, "Unable to get sram pool for ocmcram code\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	ti_emif_sram_virt = gen_pool_alloc(sram_pool_code, ti_emif_sram_sz);
>> +	if (!ti_emif_sram_virt) {
>> +		dev_err(dev, "Unable to allocate code memory from ocmcram\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	/* Save physical address to calculate resume offset during pm init */
>> +	ti_emif_sram_phys = gen_pool_virt_to_phys(sram_pool_code,
>> +						  ti_emif_sram_virt);
>> +
>> +	/* Get sram pool for data section and allocate space */
>> +	sram_pool_data = of_gen_pool_get(np, "sram", 1);
>> +	if (!sram_pool_data) {
>> +		dev_err(dev, "Unable to get sram pool for ocmcram data\n");
>> +		ret = -ENODEV;
>> +		goto err_free_sram_code;
>> +	}
>> +
>> +	ti_emif_sram_data_virt = gen_pool_alloc(sram_pool_data,
>> +						sizeof(struct emif_regs_amx3));
>> +	if (!ti_emif_sram_data_virt) {
>> +		dev_err(dev, "Unable to allocate data memory from ocmcram\n");
>> +		return -ENOMEM;
> 
> You wanted
> 
> 	ret = -ENOMEM;
> 	
> here (to avoid leaking the code memory).

Ah thanks.

> 
>> +		goto err_free_sram_code;
>> +	}
>> +
>> +	/* Save physical address to calculate resume offset during pm init */
>> +	ti_emif_sram_data_phys = gen_pool_virt_to_phys(sram_pool_data,
>> +						       ti_emif_sram_data_virt);
>> +	/*
>> +	 * These functions are called during suspend path while MMU is
>> +	 * still on so add virtual base to offset for absolute address
>> +	 */
>> +	pm_functions.save_context =
>> +		sram_suspend_address((unsigned long)ti_emif_save_context);
>> +	pm_functions.enter_sr =
>> +		sram_suspend_address((unsigned long)ti_emif_enter_sr);
>> +	pm_functions.abort_sr =
>> +		sram_suspend_address((unsigned long)ti_emif_abort_sr);
>> +
>> +	/*
>> +	 * These are called during resume path when MMU is not enabled
>> +	 * so physical address is used instead
>> +	 */
>> +	pm_functions.restore_context =
>> +		sram_resume_address((unsigned long)ti_emif_restore_context);
>> +	pm_functions.exit_sr =
>> +		sram_resume_address((unsigned long)ti_emif_exit_sr);
>> +
>> +	pm_data.regs_virt = (struct emif_regs_amx3 *)ti_emif_sram_data_virt;
>> +	pm_data.regs_phys = ti_emif_sram_data_phys;
>> +
>> +	return 0;
>> +
>> +err_free_sram_code:
>> +	gen_pool_free(sram_pool_code, ti_emif_sram_virt, ti_emif_sram_sz);
>> +	return ret;
>> +}
> 
>> +/**
>> + * ti_emif_copy_pm_function_table - copy mapping of pm funcs in sram
>> + * @sram_pool: pointer to struct gen_pool where dst resides
>> + * @dst: void * to address that table should be copied
>> + *
>> + * Returns 0 if success other error code if table is not available
>> + */
>> +int ti_emif_copy_pm_function_table(struct gen_pool *sram_pool, void *dst)
>> +{
>> +	void *copy_addr;
>> +
>> +	if (!ti_emif_sram_virt)
>> +		return -EINVAL;
>> +
>> +	copy_addr = sram_exec_copy(sram_pool, dst, &pm_functions,
>> +				   sizeof(pm_functions));
>> +	if (!copy_addr)
>> +		return -ENODEV;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(ti_emif_copy_pm_function_table);
> 
> This is fragile as nothing guarantees that the pm_functions have been
> setup (ti_emif_sram_virt might still be non-NULL after a probe error).
> The driver can also have been unloaded (and then pm_functions is gone).
> 
> It seems you need to create a device link between your pm33xx device
> (consumer) and the ti-emif-pm device (supplier) to prevent the latter
> from going away (possibly after never having been fully initialised).
> 

After a probe error ti-emif-pm will not be loaded, and because of this, pm33xx
cannot load because it depends on ti-emif-pm directly. Furthermore, we call
these exported symbols directly from pm33xx so as long as pm33xx is loaded
ti-emif-pm cannot be unloaded.

The link between pm33xx and ti-emif-pm is already there because we call some
functions in ti-emif-pm directly.

>> +
>> +/**
>> + * ti_emif_get_mem_type - return type for memory type in use
>> + *
>> + * Returns memory type value read from EMIF or error code if fails
>> + */
>> +int ti_emif_get_mem_type(void)
>> +{
>> +	unsigned long temp;
>> +
>> +	if (!pm_data.ti_emif_base_addr_virt ||
>> +	    IS_ERR(pm_data.ti_emif_base_addr_virt))
>> +		return -ENODEV;
>> +
>> +	temp = readl(pm_data.ti_emif_base_addr_virt +
>> +		     EMIF_SDRAM_CONFIG);
>> +
>> +	temp = (temp & SDRAM_TYPE_MASK) >> SDRAM_TYPE_SHIFT;
>> +	return temp;
>> +}
>> +EXPORT_SYMBOL_GPL(ti_emif_get_mem_type);
> 
> Similar problem with this one (even if you do catch one possible probe
> error with the IS_ERR()).

Yes I will look closer at the error handling. Probably need to clear
ti_emif_base_addr_virt on a defer.

> 
>> +
>> +static const struct of_device_id ti_emif_of_match[] = {
>> +	{ .compatible = "ti,emif-am3352", .data =
>> +					(void *)EMIF_SRAM_AM33_REG_LAYOUT, },
>> +	{ .compatible = "ti,emif-am4372", .data =
>> +					(void *)EMIF_SRAM_AM43_REG_LAYOUT, },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, ti_emif_of_match);
>> +
>> +static int ti_emif_probe(struct platform_device *pdev)
>> +{
>> +	int ret = -ENODEV;
> 
> No need to initialise.

No there is not agreed.

> 
>> +	struct resource *res;
>> +	struct device *dev = &pdev->dev;
>> +	const struct of_device_id *match;
>> +
>> +	match = of_match_device(ti_emif_of_match, &pdev->dev);
>> +	if (!match)
>> +		return -ENODEV;
>> +
>> +	pm_data.ti_emif_sram_config = (u32)match->data;
> 
> Cast to (unsigned long)?
> 

Yes this would work.

>> +
>> +	pm_runtime_enable(dev);
>> +	ret = pm_runtime_get_sync(dev);
>> +
> 
> Stray newline.

Yes.

> 
>> +	if (IS_ERR_VALUE(ret)) {
> 
> pm_runtime_get_sync() returns an int so this should just be
> 
> 	if (ret < 0) {

Yes this is a mistake on my part.

> 
>> +		dev_err(dev, "pm_runtime_get_sync() failed\n");
>> +		goto fail_runtime_put;
>> +	}
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	pm_data.ti_emif_base_addr_virt = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(pm_data.ti_emif_base_addr_virt)) {
>> +		dev_err(dev, "could not ioremap emif mem\n");
>> +		ret =  PTR_ERR(pm_data.ti_emif_base_addr_virt);
>> +		goto fail_runtime_put;
>> +	}
>> +
>> +	pm_data.ti_emif_base_addr_phys = res->start;
>> +
>> +	ti_emif_configure_sr_delay();
>> +
>> +	ret = ti_emif_prepare_push_sram(dev);
>> +	if (ret)
>> +		goto fail_runtime_put;
>> +
>> +	ret = ti_emif_push_sram(dev);
>> +	if (ret)
>> +		goto fail_free_sram;
>> +
>> +	return 0;
>> +
>> +fail_free_sram:
>> +	ti_emif_free_sram();
>> +fail_runtime_put:
>> +	pm_runtime_put_sync(dev);
> 
> Missing pm_runtime_disable().

Ok will address. Thanks for all the comments and taking time to review!

Regards,
Dave

> 
>> +	return ret;
>> +}
>> +
>> +static int ti_emif_remove(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +
>> +	pm_runtime_put_sync(dev);
>> +	pm_runtime_disable(dev);
>> +
>> +	ti_emif_free_sram();
>> +
>> +	return 0;
>> +}
> 
> Johan
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

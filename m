From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v3 2/2] memory: ti-emif-sram: introduce relocatable
 suspend/resume handlers
Date: Mon, 18 Sep 2017 14:28:23 -0500
Message-ID: <0a7ae26c-fdcf-07cd-2abd-232d5e20fc6a@ti.com>
References: <20170724212454.27574-1-d-gerlach@ti.com>
 <20170724212454.27574-3-d-gerlach@ti.com> <20170901102646.GQ20634@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170901102646.GQ20634@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Johan Hovold <johan@kernel.org>
Cc: devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Keerthy J <j-keerthy@ti.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 09/01/2017 05:26 AM, Johan Hovold wrote:
> On Mon, Jul 24, 2017 at 04:24:54PM -0500, Dave Gerlach wrote:
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
>>
>> In addition to this, to be able to share data structures between C and
>> the ti-emif-sram-pm assembly code, we can automatically generate all of
>> the C struct member offsets and sizes as macros by making use of the ARM
>> asm-offsets file. In the same header that we define our data structures
>> in we also define all the macros in an inline function and by adding a
>> call to this in the asm_offsets file all macros are properly generated
>> and available to the assembly code without cluttering up the asm-offsets
>> file.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
>> v2->v3:
>> * Move all static vars into common struct and instead point to one static
>>   instance of this struct and pass this struct around for internal calls.
>> * Rename ti_emif_prepare_push_sram to ti_emif_alloc_sram
>> * Clean up probe path to avoid leftover vairable values from being used
>>   after probe defer or failure.
>> * Fix mistake in ASM code that stored EMIF_POWER_MANAGEMENT_CONTROL into
>>   location for shadow register.
>> * Avoid extern definition for asm-offsets definition and use a stub instead
>>   of defining out in asm-offsets.
>> * A few general fixups to code.
> 
> Just got back from my vacation this week, so sorry about the late reply.
> 
> It indeed looks like you've addressed my comments on v2, but I still
> have few comments below. Just minor nits.
> 
>> +	/* Save physical address to calculate resume offset during pm init */
>> +	emif_data->ti_emif_sram_data_phys =
>> +		gen_pool_virt_to_phys(emif_data->sram_pool_data,
> 
> I try to indent continuation lines at least two tabs further (at least
> when not matching open parentheses) which tends to improve readability
> and conforms better to the coding standard.

Here I had to pick this to avoid going way over 80 chars on the line.

> 
>> +				      emif_data->ti_emif_sram_data_virt);
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
>> +	if (!(emif_instance && emif_instance->ti_emif_sram_virt))
>> +		return -EINVAL;
> 
> Perhaps this can now be simplified as 
> 
> 	if (!emif_instance)
> 		return -EINVAL;
> 
> since when the driver has been successfully bound all fields would have
> been initialised.
> 
> Use -ENODEV for consistency?

Agreed to all of the above, if emif_instance has been set then that means
everything else is already populated.

> 
>> +
>> +	copy_addr = sram_exec_copy(sram_pool, dst,
>> +				   &emif_instance->pm_functions,
>> +				   sizeof(emif_instance->pm_functions));
>> +	if (!copy_addr)
>> +		return -ENODEV;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(ti_emif_copy_pm_function_table);
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
>> +	if (!(emif_instance &&
>> +	      !IS_ERR_OR_NULL(emif_instance->pm_data.ti_emif_base_addr_virt)))
> 
> And this would also be more readable as simply !emif_instance.

Yes, agreed.

> 
>> +		return -ENODEV;
>> +
>> +	temp = readl(emif_instance->pm_data.ti_emif_base_addr_virt +
>> +		     EMIF_SDRAM_CONFIG);
>> +
>> +	temp = (temp & SDRAM_TYPE_MASK) >> SDRAM_TYPE_SHIFT;
>> +	return temp;
>> +}
>> +EXPORT_SYMBOL_GPL(ti_emif_get_mem_type);
> 
>> +static int ti_emif_remove(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +
>> +	pm_runtime_put_sync(dev);
>> +	pm_runtime_disable(dev);
>> +
>> +	ti_emif_free_sram(emif_instance);
>> +
>> +	emif_instance = NULL;
> 
> Nothing is of course preventing the remove() callback from racing with
> the global functions above, but I'd still prefer to reset emif_instance
> before releasing the memory.
> 
> In fact, given the register access in ti_emif_get_mem_type() you may
> even want to clear emif_instance before the pm_runtime_put_sync().

That's a good point I will move it up, thanks.

Regards,
Dave

> 
>> +
>> +	return 0;
>> +}
> 
> Thanks,
> Johan
> 

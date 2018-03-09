From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: Nokia N900: refcount_t underflow, use after free
Date: Fri, 9 Mar 2018 12:08:35 +0000
Message-ID: <1dfc05fe-1612-f5a5-b5f1-9038b3cecfe5@arm.com>
References: <20180308143053.GA17267@amd> <20180308165903.GM5799@atomide.com>
 <57c9f17b-fc9d-8506-4b5d-70ac216c9248@ti.com> <20180308185046.GA22796@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308185046.GA22796@amd>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Suman Anna <s-anna@ti.com>
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, Tony Lindgren <tony@atomide.com>, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, martijn@brixit.nl, =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>, abcloriens@gmail.com, sakari.ailus@linux.intel.com, pali.rohar@gmail.com, clayton@craftyguy.net, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

On 08/03/18 18:50, Pavel Machek wrote:
> Hi!
> 
>>> * Pavel Machek <pavel@ucw.cz> [180308 14:31]:
>>>> Hi!
>>>>
>>>> I'm getting this warning... Has anyone seen/debugged that before?
>>>> Unfortunately the backtrace does not seem to be too useful :-(.
>>>
>>> Adding Suman to Cc, as it points to arm_iommu_release_mapping().
>>
>> Hmm, we need to find out if the failure paths in isp_probe() are
>> mismatched, or if this is coming from some mismatch between the OMAP
>> IOMMU driver and the DMA plumbing. AFAIK, the cleanup paths in this
> 
> Well, camera only started to work on N900 pretty recently. Let me add
> some debug printks...
> 
> Camera does not work in 4.16.0-rc4-next-20180308-dirty.
> 
> I see this. It looks like problem in isp error paths, indeed:

Well, there certainly seems to be an obvious bug wherein 
isp_detach_iommu() just releases the mapping directly without calling 
arm_iommu_detach_device() to balance the equivalent attach. That can't 
be helping.

Robin.

> 
> [    1.672210] bus: 'platform': driver_probe_device: matched device
> 480bc000.isp with dr
> iver omap3isp
> [    1.681976] isp_probe: 1
> [    1.684906] isp_probe: 2
> [    1.687591] isp_probe: 3
> [    1.690338] isp_probe: 4
> [    1.693054] omap3isp 480bc000.isp: 480bc000.isp supply vdd-csiphy1
> not found, using d
> ummy regulator
> [    1.702728] omap3isp 480bc000.isp: 480bc000.isp supply vdd-csiphy2
> not found, using d
> ummy regulator
> [    1.712402] isp_probe: 5
> [    1.715393] omap3isp 480bc000.isp: Revision 2.0 found
> [    1.720794] isp_probe: 6
> [    1.723815] isp_probe: 7
> [    1.726715] omap-iommu 480bd400.mmu: 480bd400.mmu: version 1.1
> [    1.732849] isp_probe: 8
> [    1.735656] isp_probe: 9
> [    1.738403] isp_probe: 10
> [    1.741241] isp_probe: f3
> [    1.744018] iommu_release_mapping... ce4d9500 ce4d949c
> [    1.749450] iommu_release_mapping... ok
> [    1.753479] isp_probe: f4
> [    1.756286] clk_unregister: unregistering prepared clock: cam_xclka
> [    1.762878] clk_unregister: unregistering prepared clock: cam_xclkb
> [    1.769500] isp_probe: f5
> [    1.772430] iommu_release_mapping... ce4d9500 ce4d949c
> [    1.777862] ------------[ cut here ]------------
> [    1.782745] WARNING: CPU: 0 PID: 1 at lib/refcount.c:187
> refcount_sub_and_test+0x94/0
> xa8
> [    1.791290] refcount_t: underflow; use-after-free.
> [    1.796356] Modules linked in:
> [    1.799591] CPU: 0 PID: 1 Comm: swapper Not tainted
> 4.16.0-rc4-next-20180308-dirty #7
> 3
> [    1.807922] Hardware name: Nokia RX-51 board
> [    1.812469] [<c010d6cc>] (unwind_backtrace) from [<c010b568>]
> (show_stack+0x10/0x14)
> [    1.820648] [<c010b568>] (show_stack) from [<c0127df4>]
> (__warn+0xe8/0x110)
> ...
> [    1.968688] iommu_release_mapping... ok
> [    1.973754] bus: 'platform': driver_probe_device: matched device
> n900-battery with driver rx51-battery
> [    1.984436] bus: 'platform': driver_probe_device: matched device
> 48002524.bandgap with driver ti-soc-thermal
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 8c398fe..16f4c69 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2251,8 +2251,11 @@ static int extend_iommu_mapping(struct dma_iommu_mapping *mapping)
>   
>   void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping)
>   {
> +	printk("iommu_release_mapping... %lx %lx\n", mapping, mapping->domain);
>   	if (mapping)
>   		kref_put(&mapping->kref, release_iommu_mapping);
> +	printk("iommu_release_mapping... ok\n");
> +	
>   }
>   EXPORT_SYMBOL_GPL(arm_iommu_release_mapping);
>   
> diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
> index 8eb000e..4d58683 100644
> --- a/drivers/media/platform/omap3isp/isp.c
> +++ b/drivers/media/platform/omap3isp/isp.c
> @@ -2193,12 +2193,14 @@ static int isp_probe(struct platform_device *pdev)
>   	int ret;
>   	int i, m;
>   
> +	printk("isp_probe: 1\n");
>   	isp = devm_kzalloc(&pdev->dev, sizeof(*isp), GFP_KERNEL);
>   	if (!isp) {
>   		dev_err(&pdev->dev, "could not allocate memory\n");
>   		return -ENOMEM;
>   	}
>   
> +		printk("isp_probe: 2\n");
>   	ret = fwnode_property_read_u32(of_fwnode_handle(pdev->dev.of_node),
>   				       "ti,phy-type", &isp->phy_type);
>   	if (ret)
> @@ -2219,6 +2221,8 @@ static int isp_probe(struct platform_device *pdev)
>   	mutex_init(&isp->isp_mutex);
>   	spin_lock_init(&isp->stat_lock);
>   
> +			printk("isp_probe: 3\n");
> +
>   	ret = v4l2_async_notifier_parse_fwnode_endpoints(
>   		&pdev->dev, &isp->notifier, sizeof(struct isp_async_subdev),
>   		isp_fwnode_parse);
> @@ -2232,6 +2236,7 @@ static int isp_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto error;
>   
> +				printk("isp_probe: 4\n");
>   	platform_set_drvdata(pdev, isp);
>   
>   	/* Regulators */
> @@ -2258,6 +2263,7 @@ static int isp_probe(struct platform_device *pdev)
>   			return PTR_ERR(isp->mmio_base[map_idx]);
>   	}
>   
> +	printk("isp_probe: 5\n");
>   	ret = isp_get_clocks(isp);
>   	if (ret < 0)
>   		goto error;
> @@ -2277,6 +2283,7 @@ static int isp_probe(struct platform_device *pdev)
>   		goto error;
>   	}
>   
> +		printk("isp_probe: 6\n");
>   	ret = isp_reset(isp);
>   	if (ret < 0)
>   		goto error_isp;
> @@ -2306,6 +2313,7 @@ static int isp_probe(struct platform_device *pdev)
>   			isp->mmio_base[OMAP3_ISP_IOMEM_CSI2A_REGS1]
>   			+ isp_res_maps[m].offset[i];
>   
> +		printk("isp_probe: 7\n");
>   	isp->mmio_hist_base_phys =
>   		mem->start + isp_res_maps[m].offset[OMAP3_ISP_IOMEM_HIST];
>   
> @@ -2316,6 +2324,8 @@ static int isp_probe(struct platform_device *pdev)
>   		goto error_isp;
>   	}
>   
> +		printk("isp_probe: 8\n");
> +
>   	/* Interrupt */
>   	ret = platform_get_irq(pdev, 0);
>   	if (ret <= 0) {
> @@ -2325,6 +2335,7 @@ static int isp_probe(struct platform_device *pdev)
>   	}
>   	isp->irq_num = ret;
>   
> +			printk("isp_probe: 9\n");
>   	if (devm_request_irq(isp->dev, isp->irq_num, isp_isr, IRQF_SHARED,
>   			     "OMAP3 ISP", isp)) {
>   		dev_err(isp->dev, "Unable to request IRQ\n");
> @@ -2332,6 +2343,7 @@ static int isp_probe(struct platform_device *pdev)
>   		goto error_iommu;
>   	}
>   
> +				printk("isp_probe: 10\n");
>   	/* Entities */
>   	ret = isp_initialize_modules(isp);
>   	if (ret < 0)
> @@ -2345,27 +2357,35 @@ static int isp_probe(struct platform_device *pdev)
>   	if (ret < 0)
>   		goto error_register_entities;
>   
> +					printk("isp_probe: 11\n");
>   	isp->notifier.ops = &isp_subdev_notifier_ops;
>   
>   	ret = v4l2_async_notifier_register(&isp->v4l2_dev, &isp->notifier);
>   	if (ret)
>   		goto error_register_entities;
>   
> +					printk("isp_probe: 12\n");	
>   	isp_core_init(isp, 1);
> +					printk("isp_probe: 13\n");		
>   	omap3isp_put(isp);
>   
>   	return 0;
>   
>   error_register_entities:
> +					printk("isp_probe: f1\n");		
>   	isp_unregister_entities(isp);
>   error_modules:
> +						printk("isp_probe: f2\n");		
>   	isp_cleanup_modules(isp);
>   error_iommu:
> +							printk("isp_probe: f3\n");		
>   	isp_detach_iommu(isp);
>   error_isp:
> +							printk("isp_probe: f4\n");		
>   	isp_xclk_cleanup(isp);
>   	__omap3isp_put(isp, false);
>   error:
> +						printk("isp_probe: f5\n");			
>   	v4l2_async_notifier_cleanup(&isp->notifier);
>   	mutex_destroy(&isp->isp_mutex);
>   
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

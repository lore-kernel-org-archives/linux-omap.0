From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCHv2 01/16] iommu/omap: convert to devm_* interfaces
Date: Tue, 25 Feb 2014 22:10:46 +0100
Message-ID: <11064948.xVKxJB3hrL@avalon>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
	<1392315347-32967-2-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1392315347-32967-2-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Suman,

Thank you for the patch.

On Thursday 13 February 2014 12:15:32 Suman Anna wrote:
> Use the various devm_ interfaces to simplify the cleanup in
> probe and remove functions.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>

Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> ---
>  drivers/iommu/omap-iommu.c | 52  ++++++++----------------------------------
>  1 file changed, 10 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index bcd78a7..fff2ffd 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -941,7 +941,7 @@ static int omap_iommu_probe(struct platform_device
> *pdev) struct resource *res;
>  	struct iommu_platform_data *pdata = pdev->dev.platform_data;
> 
> -	obj = kzalloc(sizeof(*obj) + MMU_REG_SIZE, GFP_KERNEL);
> +	obj = devm_kzalloc(&pdev->dev, sizeof(*obj) + MMU_REG_SIZE, GFP_KERNEL);
>  	if (!obj)
>  		return -ENOMEM;
> 
> @@ -958,33 +958,18 @@ static int omap_iommu_probe(struct platform_device
> *pdev) INIT_LIST_HEAD(&obj->mmap);
> 
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!res) {
> -		err = -ENODEV;
> -		goto err_mem;
> -	}
> -
> -	res = request_mem_region(res->start, resource_size(res),
> -				 dev_name(&pdev->dev));
> -	if (!res) {
> -		err = -EIO;
> -		goto err_mem;
> -	}
> -
> -	obj->regbase = ioremap(res->start, resource_size(res));
> -	if (!obj->regbase) {
> -		err = -ENOMEM;
> -		goto err_ioremap;
> -	}
> +	obj->regbase = devm_ioremap_resource(obj->dev, res);
> +	if (IS_ERR(obj->regbase))
> +		return PTR_ERR(obj->regbase);
> 
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		err = -ENODEV;
> -		goto err_irq;
> -	}
> -	err = request_irq(irq, iommu_fault_handler, IRQF_SHARED,
> -			  dev_name(&pdev->dev), obj);
> +	if (irq < 0)
> +		return -ENODEV;
> +
> +	err = devm_request_irq(obj->dev, irq, iommu_fault_handler, IRQF_SHARED,
> +			       dev_name(obj->dev), obj);
>  	if (err < 0)
> -		goto err_irq;
> +		return err;
>  	platform_set_drvdata(pdev, obj);
> 
>  	pm_runtime_irq_safe(obj->dev);
> @@ -992,34 +977,17 @@ static int omap_iommu_probe(struct platform_device
> *pdev)
> 
>  	dev_info(&pdev->dev, "%s registered\n", obj->name);
>  	return 0;
> -
> -err_irq:
> -	iounmap(obj->regbase);
> -err_ioremap:
> -	release_mem_region(res->start, resource_size(res));
> -err_mem:
> -	kfree(obj);
> -	return err;
>  }
> 
>  static int omap_iommu_remove(struct platform_device *pdev)
>  {
> -	int irq;
> -	struct resource *res;
>  	struct omap_iommu *obj = platform_get_drvdata(pdev);
> 
>  	iopgtable_clear_entry_all(obj);
> 
> -	irq = platform_get_irq(pdev, 0);
> -	free_irq(irq, obj);
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	release_mem_region(res->start, resource_size(res));
> -	iounmap(obj->regbase);
> -
>  	pm_runtime_disable(obj->dev);
> 
>  	dev_info(&pdev->dev, "%s removed\n", obj->name);
> -	kfree(obj);
>  	return 0;
>  }

-- 
Regards,

Laurent Pinchart

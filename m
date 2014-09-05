From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCHv2 2/2] iommu/omap: Fix iommu archdata name for DT-based
	devices
Date: Fri, 05 Sep 2014 14:13:41 +0300
Message-ID: <2074525.KfNHgX4Wme@avalon>
References: <1409869650-26115-1-git-send-email-s-anna@ti.com>
	<1409869650-26115-3-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409869650-26115-3-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
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
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Suman,

Thank you for the patch.

On Thursday 04 September 2014 17:27:30 Suman Anna wrote:
> A device is tied to an iommu through its archdata field. The archdata
> is allocated on the fly for DT-based devices automatically through the
> .add_device iommu ops. The current logic incorrectly assigned the name
> of the IOMMU user device, instead of the name of the IOMMU device as
> required by the attach logic. Fix this issue so that DT-based devices
> can attach successfully to an IOMMU domain.
> 
> Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>

Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> ---
>  drivers/iommu/omap-iommu.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index ea6e59d..8cf8bf1 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -26,6 +26,7 @@
>  #include <linux/of.h>
>  #include <linux/of_iommu.h>
>  #include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> 
>  #include <asm/cacheflush.h>
> 
> @@ -1243,6 +1244,7 @@ static int omap_iommu_add_device(struct device *dev)
>  {
>  	struct omap_iommu_arch_data *arch_data;
>  	struct device_node *np;
> +	struct platform_device *pdev;
> 
>  	/*
>  	 * Allocate the archdata iommu structure for DT-based devices.
> @@ -1257,13 +1259,19 @@ static int omap_iommu_add_device(struct device *dev)
> if (!np)
>  		return 0;
> 
> +	pdev = of_find_device_by_node(np);
> +	if (WARN_ON(!pdev)) {
> +		of_node_put(np);
> +		return -EINVAL;
> +	}
> +
>  	arch_data = kzalloc(sizeof(*arch_data), GFP_KERNEL);
>  	if (!arch_data) {
>  		of_node_put(np);
>  		return -ENOMEM;
>  	}
> 
> -	arch_data->name = kstrdup(dev_name(dev), GFP_KERNEL);
> +	arch_data->name = kstrdup(dev_name(&pdev->dev), GFP_KERNEL);
>  	dev->archdata.iommu = arch_data;
> 
>  	of_node_put(np);

-- 
Regards,

Laurent Pinchart

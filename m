From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCHv5 06/14] remoteproc/omap: Initialize and assign reserved
 memory node
Date: Thu, 30 Jan 2020 13:11:41 -0500
Message-ID: <249c293c-6a23-165f-1df5-4859ee47658a@ti.com>
References: <20200116135332.7819-1-t-kristo@ti.com>
 <20200116135332.7819-7-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40990 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbgA3SLo (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jan 2020 13:11:44 -0500
In-Reply-To: <20200116135332.7819-7-t-kristo@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>, bjorn.andersson@linaro.org, ohad@wizery.com, linux-remoteproc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org, s-anna@ti.com, linux-omap@vger.kernel.org

On 1/16/20 8:53 AM, Tero Kristo wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> The reserved memory nodes are not assigned to platform devices by
> default in the driver core to avoid the lookup for every platform
> device and incur a penalty as the real users are expected to be
> only a few devices.
> 
> OMAP remoteproc devices fall into the above category and the OMAP
> remoteproc driver _requires_ specific CMA pools to be assigned
> for each device at the moment to align on the location of the
> vrings and vring buffers in the RTOS-side firmware images. So,


Same comment as before, this is a firmware issue for only some firmwares
that do not handle being assigned vring locations correctly and instead
hard-code them.

This is not a requirement of the remote processor itself and so it
should not fail to probe if a specific memory carveout isn't given.

Andrew


> use the of_reserved_mem_device_init/release() API appropriately
> to assign the corresponding reserved memory region to the OMAP
> remoteproc device. Note that only one region per device is
> allowed by the framework.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> v5: no changes
> 
>  drivers/remoteproc/omap_remoteproc.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
> index 0846839b2c97..194303b860b2 100644
> --- a/drivers/remoteproc/omap_remoteproc.c
> +++ b/drivers/remoteproc/omap_remoteproc.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/err.h>
>  #include <linux/of_device.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/remoteproc.h>
> @@ -480,14 +481,22 @@ static int omap_rproc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto free_rproc;
>  
> +	ret = of_reserved_mem_device_init(&pdev->dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "device does not have specific CMA pool\n");
> +		goto free_rproc;
> +	}
> +
>  	platform_set_drvdata(pdev, rproc);
>  
>  	ret = rproc_add(rproc);
>  	if (ret)
> -		goto free_rproc;
> +		goto release_mem;
>  
>  	return 0;
>  
> +release_mem:
> +	of_reserved_mem_device_release(&pdev->dev);
>  free_rproc:
>  	rproc_free(rproc);
>  	return ret;
> @@ -499,6 +508,7 @@ static int omap_rproc_remove(struct platform_device *pdev)
>  
>  	rproc_del(rproc);
>  	rproc_free(rproc);
> +	of_reserved_mem_device_release(&pdev->dev);
>  
>  	return 0;
>  }
> 

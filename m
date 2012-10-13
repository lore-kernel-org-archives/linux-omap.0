From: kishon <kishon@ti.com>
Subject: Re: [PATCH 1/2] USB: dwc3-exynos: Add support for device tree
Date: Sat, 13 Oct 2012 19:24:31 +0530
Message-ID: <50797297.7070102@ti.com>
References: <1350136052-25583-1-git-send-email-gautam.vivek@samsung.com> <1350136052-25583-2-git-send-email-gautam.vivek@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56821 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838Ab2JMNyy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 13 Oct 2012 09:54:54 -0400
In-Reply-To: <1350136052-25583-2-git-send-email-gautam.vivek@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vivek Gautam <gautam.vivek@samsung.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, gregkh@linuxfoundation.org, balbi@ti.com, rob.herring@calxeda.com, thomas.abraham@linaro.org, av.tikhomirov@samsung.com

Hi,

On Saturday 13 October 2012 07:17 PM, Vivek Gautam wrote:
> This patch adds support to parse probe data for
> dwc3 driver for exynos using device tree
>
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
>   drivers/usb/dwc3/dwc3-exynos.c |   22 ++++++++++++++++++++++
>   1 files changed, 22 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
> index ca65978..78e6219 100644
> --- a/drivers/usb/dwc3/dwc3-exynos.c
> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> @@ -21,6 +21,7 @@
>   #include <linux/clk.h>
>   #include <linux/usb/otg.h>
>   #include <linux/usb/nop-usb-xceiv.h>
> +#include <linux/of.h>
>
>   #include "core.h"
>
> @@ -87,6 +88,8 @@ err1:
>   	return ret;
>   }
>
> +static u64 dwc3_exynos_dma_mask = DMA_BIT_MASK(32);
> +
>   static int __devinit dwc3_exynos_probe(struct platform_device *pdev)
>   {
>   	struct dwc3_exynos_data	*pdata = pdev->dev.platform_data;
> @@ -103,6 +106,16 @@ static int __devinit dwc3_exynos_probe(struct platform_device *pdev)
>   		goto err0;
>   	}
>
> +	/*
> +	 * Right now device-tree probed devices don't get dma_mask set.
> +	 * Since shared usb code relies on it, set it here for now.
> +	 * Once we move to full device tree support this will vanish off.
> +	 */
> +	if (!pdev->dev.dma_mask)
> +		pdev->dev.dma_mask = &dwc3_exynos_dma_mask;
> +	if (!pdev->dev.coherent_dma_mask)
> +		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);

of/platform.c shows coherent_dma_mask is set for dt.

Thanks
Kishon

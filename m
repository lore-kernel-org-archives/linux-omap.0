From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: dwc: pci-dra7xx: Add missing include file
Date: Fri, 5 Jul 2019 16:29:05 +0100
Message-ID: <20190705152905.GA6284@e121166-lin.cambridge.arm.com>
References: <20190614154044.4972-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190614154044.4972-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, kishon@ti.com
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 14, 2019 at 11:40:44PM +0800, YueHaibing wrote:
> Fix build error:
> 
> drivers/pci/controller/dwc/pci-dra7xx.c:
>  In function dra7xx_pcie_probe:
> drivers/pci/controller/dwc/pci-dra7xx.c:777:10:
>  error: implicit declaration of function devm_gpiod_get_optional;
>  did you mean devm_regulator_get_optional? [-Werror=implicit-function-declaration]
> 
>   reset = devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH);

Adding the reason (in particular the config options) that triggers
this error would not hurt.

Kishon please let me know if I can merge it (ACK it if so).

Thanks,
Lorenzo

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c | 1 +
>  1 file changed, 1 insertion(+)


> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 419451e..4234ddb 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -26,6 +26,7 @@
>  #include <linux/types.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
> +#include <linux/gpio/consumer.h>
>  
>  #include "../../pci.h"
>  #include "pcie-designware.h"
> -- 
> 2.7.4
> 
> 

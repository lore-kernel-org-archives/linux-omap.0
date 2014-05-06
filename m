From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [TEMP PATCH 16/17] pci: host: pcie-dra7xx: use reset framework
 APIs to reset PCIe
Date: Tue, 6 May 2014 08:41:39 -0500
Message-ID: <5368E693.1060201@ti.com>
References: <1399383244-14556-1-git-send-email-kishon@ti.com> <1399383244-14556-17-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1399383244-14556-17-git-send-email-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org
Cc: rogerq@ti.com, balajitk@ti.com
List-Id: linux-omap@vger.kernel.org

On 05/06/2014 08:34 AM, Kishon Vijay Abraham I wrote:
> Get reset nodes from dt and use reset framework APIs to reset PCIe.
> This is needed since reset is handled by the SoC.
>
> Cc: Dan Murphy <dmurphy@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/ti-pci.txt |    2 ++
>  drivers/pci/host/pci-dra7xx.c                    |   10 ++++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
> index 6cb6f09..cfb95c0 100644
> --- a/Documentation/devicetree/bindings/pci/ti-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
> @@ -9,6 +9,8 @@ This node should have the properties described in "designware-pcie.txt".
>   - phys : the phandle for the PHY device (used by generic PHY framework)
>   - phy-names : the names of the PHY corresponding to the PHYs present in the
>     *phy* phandle.
> + - resets: phandle used if reset is handled be soc
> + - reset-names: name given to the phandle

You should just refer to the ti,reset.txt document for this.

>  
>  Example:
>  pcie@51000000 {
> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> index a37c25c..17d64ee 100644
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -20,6 +20,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/resource.h>
> +#include <linux/reset.h>
>  #include <linux/types.h>
>  
>  #include "pcie-designware.h"
> @@ -281,6 +282,7 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	struct dra7xx_pcie *dra7xx;
>  	struct device *dev = &pdev->dev;
> +	struct reset_control *rstc;
>  
>  	dra7xx = devm_kzalloc(&pdev->dev, sizeof(*dra7xx), GFP_KERNEL);
>  	if (!dra7xx)
> @@ -304,6 +306,14 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  	if (!base)
>  		return -ENOMEM;
>  
> +	rstc = devm_reset_control_get(dev, "reset");
> +	if (IS_ERR(rstc))
> +		return PTR_ERR(rstc);
> +
> +	ret = reset_control_deassert(rstc);
> +	if (ret)
> +		return ret;
> +
>  	phy = devm_phy_get(dev, "pcie-phy");
>  	if (IS_ERR(phy))
>  		return PTR_ERR(phy);


-- 
------------------
Dan Murphy

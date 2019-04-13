From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v2 06/26] PCI: keystone: Move initializations to
 appropriate places
Date: Sat, 13 Apr 2019 09:30:01 -0500
Message-ID: <20190413143001.GE126710@google.com>
References: <20190325083501.8088-1-kishon@ti.com>
 <20190325083501.8088-7-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190325083501.8088-7-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 25, 2019 at 02:04:41PM +0530, Kishon Vijay Abraham I wrote:
> No functional change. Move host specific platform_get_resource to
> ks_add_pcie_port and the common platform_get_resource (applicable
> to both host and endpoint) to probe. This is in preparation for
> adding endpoint support to pci-keystone driver.

This seems to move platform_get_resource() *from* (not *to*)
ks_add_pcie_port().

You seem to be making a distinction in the commit log between (1) a
resource that's only used for host mode, and (2) a common resource
that's used for both host and endpoint mode.  But I don't see that
distinction in the patch, so it's a little confusing to mention it in
the commit log.

It must make endpoint support easier, but I can't quite connect the
dots yet.  Maybe endpoint will also use ks_pcie_add_pcie_port(), but
will have a separate .probe() function that doesn't look up the
resource that's specific to host mode?

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 27 +++++++++++++----------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 5eebef9b9ada..95997885a05c 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -806,11 +806,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
>  	struct resource *res;
>  	int ret;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbics");
> -	pci->dbi_base = devm_pci_remap_cfg_resource(dev, res);
> -	if (IS_ERR(pci->dbi_base))
> -		return PTR_ERR(pci->dbi_base);
> -
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
>  	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
>  	if (IS_ERR(pp->va_cfg0_base))
> @@ -818,13 +813,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
>  
>  	pp->va_cfg1_base = pp->va_cfg0_base;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
> -	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(ks_pcie->va_app_base))
> -		return PTR_ERR(ks_pcie->va_app_base);
> -
> -	ks_pcie->app = *res;
> -
>  	pp->ops = &ks_pcie_host_ops;
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
> @@ -895,6 +883,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  	struct dw_pcie *pci;
>  	struct keystone_pcie *ks_pcie;
>  	struct device_link **link;
> +	struct resource *res;
> +	void __iomem *base;
>  	u32 num_viewport;
>  	struct phy **phy;
>  	u32 num_lanes;
> @@ -911,6 +901,19 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  	if (!pci)
>  		return -ENOMEM;
>  
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
> +	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(ks_pcie->va_app_base))
> +		return PTR_ERR(ks_pcie->va_app_base);
> +
> +	ks_pcie->app = *res;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbics");
> +	base = devm_pci_remap_cfg_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	pci->dbi_base = base;
>  	pci->dev = dev;
>  	pci->ops = &ks_pcie_dw_pcie_ops;
>  
> -- 
> 2.17.1
> 

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: dra7xx: Invoke phy_set_mode API to set PHY mode to
 PHY_MODE_PCIE
Date: Thu, 31 Jan 2019 17:29:07 +0000
Message-ID: <20190131172907.GB31110@e107981-ln.cambridge.arm.com>
References: <20190124104537.22271-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190124104537.22271-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jan 24, 2019 at 04:15:37PM +0530, Kishon Vijay Abraham I wrote:
> Certain PHYs used with PCIe controller can also be used with other
> controllers such as USB or SATA. In order to configure the PHY
> to work with PCIe controller, invoke phy_set_mode API with mode
> set to PHY_MODE_PCIE.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied to pci/dwc for v5.1, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index efb26096ccb5..b287dbf6914c 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -517,6 +517,10 @@ static int dra7xx_pcie_enable_phy(struct dra7xx_pcie *dra7xx)
>  	int i;
>  
>  	for (i = 0; i < phy_count; i++) {
> +		ret = phy_set_mode(dra7xx->phy[i], PHY_MODE_PCIE);
> +		if (ret < 0)
> +			goto err_phy;
> +
>  		ret = phy_init(dra7xx->phy[i]);
>  		if (ret < 0)
>  			goto err_phy;
> -- 
> 2.17.1
> 

From: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH 04/13] PCI: cadence: Add support to start link and verify
 link status
Date: Tue, 17 Dec 2019 11:58:27 +0000
Message-ID: <20191217115826.GA24359@e119886-lin.cambridge.arm.com>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-5-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191209092147.22901-5-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 09, 2019 at 02:51:38PM +0530, Kishon Vijay Abraham I wrote:
> Add cdns_pcie_ops to start link and verify link status. The registers
> to start link and to check link status is in Platform specific PCIe
> wrapper. Add support for platform specific drivers to add callback
> functions for the PCIe Cadence core to start link and verify link status.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../pci/controller/cadence/pcie-cadence-ep.c  |  8 ++++++
>  .../controller/cadence/pcie-cadence-host.c    | 28 +++++++++++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.h | 23 +++++++++++++++
>  3 files changed, 59 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 560f22b4d165..088394b6be04 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -355,8 +355,10 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>  {
>  	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct cdns_pcie *pcie = &ep->pcie;
> +	struct device *dev = pcie->dev;
>  	struct pci_epf *epf;
>  	u32 cfg;
> +	int ret;
>  
>  	/*
>  	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
> @@ -367,6 +369,12 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>  		cfg |= BIT(epf->func_no);
>  	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, cfg);
>  
> +	ret = cdns_pcie_start_link(pcie, true);
> +	if (ret) {
> +		dev_err(dev, "Failed to start link\n");
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index ccf55e143e1d..0929554f5a81 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -3,6 +3,7 @@
>  // Cadence PCIe host controller driver.
>  // Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
>  
> +#include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
> @@ -201,6 +202,23 @@ static int cdns_pcie_host_init(struct device *dev,
>  	return err;
>  }
>  
> +static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
> +{
> +	struct device *dev = pcie->dev;
> +	int retries;
> +
> +	/* Check if the link is up or not */
> +	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> +		if (cdns_pcie_is_link_up(pcie)) {
> +			dev_info(dev, "Link up\n");
> +			return 0;
> +		}
> +		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> +	}
> +
> +	return -ETIMEDOUT;
> +}

This patch looks fine, except this function (above) is identical to
dw_pcie_wait_for_link, advk_pcie_wait_for_link and nwl_wait_for_link. Even
the definitions of LINK_WAIT_USLEEP_xx are the same.

I don't see any justification to duplicating this again - can you consolidate
these functions to something that all controller drivers can use?

Thanks,

Andrew Murray

> +
>  int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  {
>  	struct device *dev = rc->pcie.dev;
> @@ -254,6 +272,16 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  
>  	pcie->mem_res = res;
>  
> +	ret = cdns_pcie_start_link(pcie, true);
> +	if (ret) {
> +		dev_err(dev, "Failed to start link\n");
> +		return ret;
> +	}
> +
> +	ret = cdns_pcie_host_wait_for_link(pcie);
> +	if (ret)
> +		dev_dbg(dev, "PCIe link never came up\n");
> +
>  	ret = cdns_pcie_host_init(dev, &resources, rc);
>  	if (ret)
>  		goto err_init;
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index d0d91c69fa1d..f0395eaf9df5 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -10,6 +10,11 @@
>  #include <linux/pci.h>
>  #include <linux/phy/phy.h>
>  
> +/* Parameters for the waiting for link up routine */
> +#define LINK_WAIT_MAX_RETRIES	10
> +#define LINK_WAIT_USLEEP_MIN	90000
> +#define LINK_WAIT_USLEEP_MAX	100000
> +
>  /*
>   * Local Management Registers
>   */
> @@ -226,6 +231,8 @@ enum cdns_pcie_msg_routing {
>  struct cdns_pcie_ops {
>  	u32	(*read)(void __iomem *addr, int size);
>  	void	(*write)(void __iomem *addr, int size, u32 value);
> +	int	(*start_link)(struct cdns_pcie *pcie, bool start);
> +	bool	(*is_link_up)(struct cdns_pcie *pcie);
>  };
>  
>  /**
> @@ -447,6 +454,22 @@ static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
>  	return readl(addr);
>  }
>  
> +static inline int cdns_pcie_start_link(struct cdns_pcie *pcie, bool start)
> +{
> +	if (pcie->ops->start_link)
> +		return pcie->ops->start_link(pcie, start);
> +
> +	return 0;
> +}
> +
> +static inline bool cdns_pcie_is_link_up(struct cdns_pcie *pcie)
> +{
> +	if (pcie->ops->is_link_up)
> +		return pcie->ops->is_link_up(pcie);
> +
> +	return true;
> +}
> +
>  #ifdef CONFIG_PCIE_CADENCE_HOST
>  int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
>  #else
> -- 
> 2.17.1
> 

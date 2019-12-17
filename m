From: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH 08/13] PCI: cadence: Use local management register to
 configure Vendor ID
Date: Tue, 17 Dec 2019 12:42:39 +0000
Message-ID: <20191217124238.GE24359@e119886-lin.cambridge.arm.com>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-9-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191209092147.22901-9-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 09, 2019 at 02:51:42PM +0530, Kishon Vijay Abraham I wrote:
> PCI_VENDOR_ID in root port configuration space is read-only register
> and writing to it will have no effect. Use local management register to
> configure Vendor ID and Subsystem Vendor ID.

Is this a bug fix? Can you add a Fixes tag and make that clearer?

Thanks,

Andrew Murray

> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index cf817be237af..afb2c96a6538 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -71,6 +71,7 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>  {
>  	struct cdns_pcie *pcie = &rc->pcie;
>  	u32 value, ctrl;
> +	u32 id;
>  
>  	/*
>  	 * Set the root complex BAR configuration register:
> @@ -90,8 +91,12 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>  	cdns_pcie_writel(pcie, CDNS_PCIE_LM_RC_BAR_CFG, value);
>  
>  	/* Set root port configuration space */
> -	if (rc->vendor_id != 0xffff)
> -		cdns_pcie_rp_writew(pcie, PCI_VENDOR_ID, rc->vendor_id);
> +	if (rc->vendor_id != 0xffff) {
> +		id = CDNS_PCIE_LM_ID_VENDOR(rc->vendor_id) |
> +			CDNS_PCIE_LM_ID_SUBSYS(rc->vendor_id);
> +		cdns_pcie_writel(pcie, CDNS_PCIE_LM_ID, id);
> +	}
> +
>  	if (rc->device_id != 0xffff)
>  		cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
>  
> -- 
> 2.17.1
> 

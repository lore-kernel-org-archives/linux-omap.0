From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 11/13] PCI: j721e: Add TI J721E PCIe driver
Date: Thu, 19 Dec 2019 16:47:49 -0600
Message-ID: <20191219224749.GA4225@google.com>
References: <20191209092147.22901-12-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191209092147.22901-12-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 09, 2019 at 02:51:45PM +0530, Kishon Vijay Abraham I wrote:
> Add support for PCIe controller in J721E SoC. The controller uses the
> Cadence PCIe core programmed by pcie-cadence*.c. The PCIe controller
> will work in both host mode and device mode.
> Some of the features of the controller are:
>   *) Supports both RC mode and EP mode
>   *) Supports MSI and MSI-X support
>   *) Supports upto GEN3 speed mode
>   *) Supports SR-IOV capability
>   *) Ability to route all transactions via SMMU (support will be added
>      in a later patch).
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/Kconfig     |  23 ++
>  drivers/pci/controller/cadence/Makefile    |   1 +
>  drivers/pci/controller/cadence/pci-j721e.c | 430 +++++++++++++++++++++
>  3 files changed, 454 insertions(+)
>  create mode 100644 drivers/pci/controller/cadence/pci-j721e.c
> 
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index b76b3cf55ce5..5d30564190e1 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -42,4 +42,27 @@ config PCIE_CADENCE_PLAT_EP
>  	  endpoint mode. This PCIe controller may be embedded into many
>  	  different vendors SoCs.
>  
> +config PCI_J721E
> +	bool
> +
> +config PCI_J721E_HOST
> +	bool "TI J721E PCIe platform host controller"
> +	depends on OF
> +	select PCIE_CADENCE_HOST
> +	select PCI_J721E
> +	help
> +	  Say Y here if you want to support the TI J721E PCIe platform
> +	  controller in host mode. TI J721E PCIe controller uses Cadence PCIe
> +	  core.
> +
> +config PCI_J721E_EP
> +	bool "TI J721E PCIe platform endpoint controller"

Most drivers call these "PCIe host controller" and "PCIe endpoint
controller" or similar.  Does adding "platform" indicate something
useful?

> +	depends on OF
> +	depends on PCI_ENDPOINT
> +	select PCIE_CADENCE_EP
> +	select PCI_J721E
> +	help
> +	  Say Y here if you want to support the TI J721E PCIe platform
> +	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
> +	  core.
>  endmenu
> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> index 232a3f20876a..9bac5fb2f13d 100644
> --- a/drivers/pci/controller/cadence/Makefile
> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -3,3 +3,4 @@ obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
>  obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
>  obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
>  obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
> +obj-$(CONFIG_PCI_J721E) += pci-j721e.o
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> new file mode 100644
> index 000000000000..9ffb7e88c739
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -0,0 +1,430 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * pci-j721e - PCIe controller driver for TI's J721E SoCs
> + *
> + * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
> + * Author: Kishon Vijay Abraham I <kishon@ti.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/io.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/pci.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +#include "../../pci.h"
> +#include "pcie-cadence.h"
> +
> +#define J721E_PCIE_USER_CMD_STATUS	0x4
> +#define LINK_TRAINING_ENABLE		BIT(0)
> +
> +#define J721E_PCIE_USER_LINKSTATUS	0x14
> +#define LINK_STATUS			GENMASK(1, 0)
> +
> +enum link_status {
> +	NO_RECIEVERS_DETECTED,

s/NO_RECIEVERS_DETECTED/NO_RECEIVERS_DETECTED/

> +	LINK_TRAINING_IN_PROGRESS,
> +	LINK_UP_DL_IN_PROGRESS,
> +	LINK_UP_DL_COMPLETED,
> +};
> +
> +#define J721E_MODE_RC			BIT(7)
> +#define LANE_COUNT_MASK			BIT(8)
> +#define LANE_COUNT(n)			((n) << 8)
> +
> +#define GENERATION_SEL_MASK		GENMASK(1, 0)
> +
> +#define MAX_LANES			2
> +
> +struct j721e_pcie {
> +	struct device		*dev;
> +	struct device_node	*node;
> +	u32			mode;
> +	u32			num_lanes;
> +	struct cdns_pcie	*cdns_pcie;
> +	void __iomem		*user_cfg_base;
> +};
> +
> +enum j721e_pcie_mode {
> +	PCI_MODE_RC,
> +	PCI_MODE_EP,
> +};
> +
> +struct j721e_pcie_data {
> +	enum j721e_pcie_mode	mode;
> +};
> +
> +static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
> +{
> +	return readl(pcie->user_cfg_base + offset);
> +}
> +
> +static inline void j721e_pcie_user_writel(struct j721e_pcie *pcie, u32 offset,
> +					  u32 value)
> +{
> +	writel(value, pcie->user_cfg_base + offset);
> +}
> +
> +static int j721e_pcie_start_link(struct cdns_pcie *cdns_pcie, bool start)
> +{
> +	struct j721e_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
> +	u32 reg;
> +
> +	reg = j721e_pcie_user_readl(pcie, J721E_PCIE_USER_CMD_STATUS);
> +	if (start)
> +		reg |= LINK_TRAINING_ENABLE;
> +	else
> +		reg &= ~LINK_TRAINING_ENABLE;
> +	j721e_pcie_user_writel(pcie, J721E_PCIE_USER_CMD_STATUS, reg);
> +
> +	return 0;
> +}
> +
> +static bool j721e_pcie_is_link_up(struct cdns_pcie *cdns_pcie)

There are many *_pcie_link_up() definitions that looks essentially
like this; maybe this could be simply j721e_pcie_link_up() to match?

> +{
> +	struct j721e_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
> +	u32 reg;
> +
> +	reg = j721e_pcie_user_readl(pcie, J721E_PCIE_USER_LINKSTATUS);
> +	reg &= LINK_STATUS;
> +	if (reg == LINK_UP_DL_COMPLETED)
> +		return true;
> +
> +	return false;
> +}
> +
> +static const struct cdns_pcie_ops j721e_ops_ops = {
> +	.read = cdns_pcie_read32,
> +	.write = cdns_pcie_write32,
> +	.start_link = j721e_pcie_start_link,
> +	.is_link_up = j721e_pcie_is_link_up,
> +};

Can these match struct dw_pcie_ops more closely, e.g., ".link_up"
instead of ".is_link_up", ".start_link" and ".stop_link" instead of
".start_link(..., bool)"?

Bjorn

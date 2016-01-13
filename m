From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH v2 2/3] ARM: DRA7: add pdata-quirks to do reset of PCIe
Date: Wed, 13 Jan 2016 11:35:19 -0600
Message-ID: <56968AD7.3010108@ti.com>
References: <1452667666-17533-1-git-send-email-kishon@ti.com>
 <1452667666-17533-3-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452667666-17533-3-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>, Bjorn Helgaas <bhelgaas@google.com>, richardcochran@gmail.com
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Kishon,

On 01/13/2016 12:47 AM, Kishon Vijay Abraham I wrote:
> Use pdata-quirks to reset PCIe IP. 

This can do with some clarity. The patch adds the platform data, doesn't
do reset.

This is to be used until
> a drivers/reset/ interface is available for this purpose.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  arch/arm/mach-omap2/pdata-quirks.c       |   11 +++++++++++
>  include/linux/platform_data/pci-dra7xx.h |   22 ++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>  create mode 100644 include/linux/platform_data/pci-dra7xx.h
> 
> diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
> index 5814477..f5a65fe 100644
> --- a/arch/arm/mach-omap2/pdata-quirks.c
> +++ b/arch/arm/mach-omap2/pdata-quirks.c
> @@ -23,6 +23,7 @@
>  #include <linux/platform_data/pinctrl-single.h>
>  #include <linux/platform_data/iommu-omap.h>
>  #include <linux/platform_data/wkup_m3.h>
> +#include <linux/platform_data/pci-dra7xx.h>
>  
>  #include "common.h"
>  #include "common-board-devices.h"
> @@ -404,6 +405,14 @@ static void __init omap5_uevm_legacy_init(void)
>  }
>  #endif
>  
> +#ifdef CONFIG_SOC_DRA7XX
> +static struct pci_dra7xx_platform_data dra7xx_pci_pdata = {
> +	.reset_name = "pcie",
> +	.assert_reset = omap_device_assert_hardreset,
> +	.deassert_reset = omap_device_deassert_hardreset,
> +};
> +#endif
> +
>  static struct pcs_pdata pcs_pdata;
>  
>  void omap_pcs_legacy_init(int irq, void (*rearm)(void))
> @@ -474,6 +483,8 @@ static struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
>  #endif
>  #ifdef CONFIG_SOC_DRA7XX
>  	OF_DEV_AUXDATA("ti,dra7-padconf", 0x4a003400, "4a003400.pinmux", &pcs_pdata),
> +	OF_DEV_AUXDATA("ti,dra7-pcie", 0x51000000, "51000000.pcie", &dra7xx_pci_pdata),
> +	OF_DEV_AUXDATA("ti,dra7-pcie", 0x51800000, "51800000.pcie", &dra7xx_pci_pdata),
>  #endif
>  #ifdef CONFIG_SOC_AM43XX
>  	OF_DEV_AUXDATA("ti,am437-padconf", 0x44e10800, "44e10800.pinmux", &pcs_pdata),
> diff --git a/include/linux/platform_data/pci-dra7xx.h b/include/linux/platform_data/pci-dra7xx.h
> new file mode 100644
> index 0000000..792c8ed
> --- /dev/null
> +++ b/include/linux/platform_data/pci-dra7xx.h
> @@ -0,0 +1,22 @@
> +/*
> + * pcie-dra7xx - Platform data for PCIe controller
> + *
> + * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * Authors: Kishon Vijay Abraham I <kishon@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __PCI_DRA7XX_H
> +#define __PCI_DRA7XX_H
> +
> +struct pci_dra7xx_platform_data {

can you add kernel-doc comments for the structure?

> +	const char *reset_name;
> +
> +	int (*assert_reset)(struct platform_device *pdev, const char *name);
> +	int (*deassert_reset)(struct platform_device *pdev, const char *name);
> +};

nit, would like to see a blank line here

regards
Suman

> +#endif /* __PCI_DRA7XX_H */
> 

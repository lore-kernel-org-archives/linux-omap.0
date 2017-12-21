From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 00/18] dwc MSI fixes, ARTPEC-6 EP mode support,
 ARTPEC-7 SoC support
Date: Thu, 21 Dec 2017 10:02:59 +0000
Message-ID: <20171221100259.GB23573@red-moon>
References: <20171219232940.659-1-niklas.cassel@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171219232940.659-1-niklas.cassel-VrBV9hrLPhE@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Niklas Cassel <niklas.cassel-VrBV9hrLPhE@public.gmane.org>
Cc: linux-arm-kernel-VrBV9hrLPhE@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Niklas Cassel <niklass-VrBV9hrLPhE@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 20, 2017 at 12:29:21AM +0100, Niklas Cassel wrote:
> This is a series that adds:
> - PCI endpoint mode support in the ARTPEC-6 driver.
> - ARTPEC-7 SoC support in the ARTPEC-6 driver (the SoCs are very similar).
> - Small fixes for MSI in designware-ep and designware-host,
>   needed to get endpoint mode support working for ARTPEC-6.
> - Cleanups in pci-dra7xx to better prepare for endpoint mode in other
>   DWC based PCIe drivers.
> 
> Changes since V5:
> -Dropped GFP_DMA32 from "PCI: dwc: Use the DMA-API to get the MSI address"
>  so that we use the exact same GFP flags as before.
> -Rewrote commit message for "PCI: dwc: Make cpu_addr_fixup take struct
> dw_pcie as argument" to be more detailed.
> 
> Niklas Cassel (18):
>   PCI: dwc: Use the DMA-API to get the MSI address
>   PCI: designware-ep: dw_pcie_ep_set_msi() should only set MMC bits
>   PCI: designware-ep: Read-only registers need DBI_RO_WR_EN to be
>     writable
>   PCI: designware-ep: Pre-allocate memory for MSI in dw_pcie_ep_init
>   PCI: designware-ep: Remove static keyword from dw_pcie_ep_reset_bar()
>   PCI: designware-ep: Add generic function for raising MSI irq
>   PCI: dwc: dra7xx: Refactor Kconfig and Makefile handling for host/ep
>     mode
>   PCI: dwc: dra7xx: Assign pp->ops in dra7xx_add_pcie_port() rather than
>     in probe
>   PCI: dwc: dra7xx: Help compiler to remove unused code
>   PCI: dwc: artpec6: Remove unused defines
>   PCI: dwc: artpec6: Use BIT and GENMASK macros
>   PCI: dwc: artpec6: Split artpec6_pcie_establish_link() into smaller
>     functions
>   bindings: PCI: artpec: Add support for endpoint mode
>   PCI: dwc: artpec6: Add support for endpoint mode
>   PCI: dwc: Make cpu_addr_fixup take struct dw_pcie as argument
>   PCI: dwc: artpec6: Deassert the core before waiting for PHY
>   bindings: PCI: artpec: Add support for the ARTPEC-7 SoC
>   PCI: dwc: artpec6: Add support for the ARTPEC-7 SoC
> 
>  .../devicetree/bindings/pci/axis,artpec6-pcie.txt  |   5 +-
>  drivers/pci/dwc/Kconfig                            |  68 +--
>  drivers/pci/dwc/Makefile                           |   4 +-
>  drivers/pci/dwc/pci-dra7xx.c                       |  27 +-
>  drivers/pci/dwc/pcie-artpec6.c                     | 470 ++++++++++++++++++---
>  drivers/pci/dwc/pcie-designware-ep.c               |  59 ++-
>  drivers/pci/dwc/pcie-designware-host.c             |  15 +-
>  drivers/pci/dwc/pcie-designware.c                  |   2 +-
>  drivers/pci/dwc/pcie-designware.h                  |  22 +-
>  9 files changed, 554 insertions(+), 118 deletions(-)

Applied to pci/dwc for v4.16.

Thanks,
Lorenzo
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

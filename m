From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3 00/26] Add support for PCIe RC and EP mode in TI's
 AM654 SoC
Date: Sat, 13 Apr 2019 11:04:26 -0500
Message-ID: <20190413160426.GJ126710@google.com>
References: <20190325093947.32633-1-kishon@ti.com>
 <20190412154836.GB8730@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190412154836.GB8730@red-moon>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com, Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, Jesper Nilsson <jesper.nilsson@axis.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 12, 2019 at 04:48:36PM +0100, Lorenzo Pieralisi wrote:
> On Mon, Mar 25, 2019 at 03:09:21PM +0530, Kishon Vijay Abraham I wrote:
> > Add PCIe RC support for TI's AM654 SoC. The PCIe controller in AM654
> > uses Synopsys core revision 4.90a and uses the same TI wrapper as used
> > in keystone2 with certain modification. Hence AM654 will use the same
> > pci wrapper driver pci-keystone.c
> > 
> > This series was initially part of [1]. This series only includes patches
> > that has to be merged via Lorenzo's tree. The PHY patches and dt patches
> > will be sent separately.
> > 
> > This series is created over keystone MSI cleanup series [2].
> > 
> > This series:
> > *) Cleanup pci-keystone driver so that both RC mode and EP mode of
> >    AM654 can be supported
> > *) Modify epc-core to support allocation of aligned buffers required for
> >    AM654
> > *) Fix ATU unroll identification
> > *) Add support for both host mode and device mode in AM654
> > 
> > Changes from v2:
> > *) Missed updating "Reviewed-by: Rob Herring <robh@kernel.org>" tags
> >    in the version that was sent to list.
> > *) Add const qualifier to struct dw_pcie_ep_ops in pci-layerscape-ep.c
> > 
> > Changes from v1:
> > *) Support for legacy interrupt in AM654 is removed (see background here
> >    [3])
> > *) Allow of_pci_get_max_link_speed to be used by Endpoint controller
> > driver
> > *) Add support to set max-link-speed from DT in pci-keystone driver
> > *) Update "Reviewed-by: Rob Herring <robh@kernel.org>" tags.
> > 
> > [1] -> https://lore.kernel.org/patchwork/cover/989487/
> > [2] -> https://lkml.org/lkml/2019/3/21/193
> > [3] -> https://lkml.org/lkml/2019/3/19/235
> > 
> > Kishon Vijay Abraham I (26):
> >   PCI: keystone: Add start_link/stop_link dw_pcie_ops
> >   PCI: keystone: Cleanup error_irq configuration
> >   dt-bindings: PCI: keystone: Add "reg-names" binding information
> >   PCI: keystone: Perform host initialization in a single function
> >   PCI: keystone: Use platform_get_resource_byname to get memory
> >     resources
> >   PCI: keystone: Move initializations to appropriate places
> >   dt-bindings: PCI: Add dt-binding to configure PCIe mode
> >   PCI: keystone: Explicitly set the PCIe mode
> >   dt-bindings: PCI: Document "atu" reg-names
> >   PCI: dwc: Enable iATU unroll for endpoint too
> >   PCI: dwc: Fix ATU identification for designware version >= 4.80
> >   PCI: keystone: Prevent ARM32 specific code to be compiled for ARM64
> >   dt-bindings: PCI: Add PCI RC dt binding documentation for AM654
> >   PCI: keystone: Add support for PCIe RC in AM654x Platforms
> >   PCI: keystone: Invoke phy_reset API before enabling PHY
> >   PCI: OF: Allow of_pci_get_max_link_speed() to be used by PCI Endpoint
> >     drivers
> >   PCI: keystone: Add support to set the max link speed from DT
> >   PCI: endpoint: Add support to allocate aligned buffers to be mapped in
> >     BARs
> >   PCI: dwc: Add const qualifier to struct dw_pcie_ep_ops
> >   PCI: dwc: Fix dw_pcie_ep_find_capability to return correct capability
> >     offset
> >   PCI: dwc: Add callbacks for accessing dbi2 address space
> >   PCI: keystone: Add support for PCIe EP in AM654x Platforms
> >   PCI: designware-ep: Configure RESBAR to advertise the smallest size
> >   PCI: designware-ep: Use aligned ATU window for raising MSI interrupts
> >   misc: pci_endpoint_test: Add support to test PCI EP in AM654x
> >   misc: pci_endpoint_test: Fix test_reg_bar to be updated in
> >     pci_endpoint_test
> > 
> >  .../bindings/pci/designware-pcie.txt          |   7 +-
> >  .../devicetree/bindings/pci/pci-keystone.txt  |  14 +-
> >  drivers/misc/pci_endpoint_test.c              |  18 +
> >  drivers/pci/Makefile                          |   2 +-
> >  drivers/pci/controller/dwc/Kconfig            |  25 +-
> >  drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
> >  drivers/pci/controller/dwc/pci-keystone.c     | 577 +++++++++++++++---
> >  .../pci/controller/dwc/pci-layerscape-ep.c    |   2 +-
> >  drivers/pci/controller/dwc/pcie-artpec6.c     |   2 +-
> >  .../pci/controller/dwc/pcie-designware-ep.c   |  55 +-
> >  .../pci/controller/dwc/pcie-designware-host.c |  19 -
> >  .../pci/controller/dwc/pcie-designware-plat.c |   2 +-
> >  drivers/pci/controller/dwc/pcie-designware.c  |  52 ++
> >  drivers/pci/controller/dwc/pcie-designware.h  |  15 +-
> >  drivers/pci/endpoint/functions/pci-epf-test.c |   5 +-
> >  drivers/pci/endpoint/pci-epf-core.c           |  10 +-
> >  drivers/pci/of.c                              |  44 +-
> >  include/linux/pci-epc.h                       |   2 +
> >  include/linux/pci-epf.h                       |   3 +-
> >  19 files changed, 683 insertions(+), 173 deletions(-)
> 
> Hi Kishon,
> 
> I have applied the series, after rewriting the commit logs we
> discussed, branch: pci/keystone, please have a look and let me know
> if that's good to go.

It all looks good to me; I responded to a few things I noticed while
writing the notes for merging the branch.  I don't think there were
any must-fix things, but if you update the branch for any other
reason, I'll happily remerge it (I remerge the "next" branch from
scratch every time I add things anyway, so it's no work on my side).

Bjorn

From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 00/15] PCI: endpoint: Cleanup EPC features
Date: Mon, 7 Jan 2019 12:11:33 +0530
Message-ID: <20190107064148.10152-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Alan Douglas <adouglas@cadence.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, kishon@ti.com, linux-rockchip@lists.infradead.org, Jia-Ju Bai <baijiaju1990@gmail.com>, Cyrille Pitchen <cyrille.pitchen@free-electrons.com>, linux-pci@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Lorenzo,

The Endpoint controller driver uses features member in 'struct pci_epc'
to advertise the list of supported features to the endpoint function
driver.

There are a few shortcomings with this approach.
  *) Certain endpoint controllers support fixed size BAR (e.g. TI's
     AM654 uses Designware configuration with fixed size BAR). The
     size of each BARs cannot be passed to the endpoint function
     driver.
  *) Too many macros for handling EPC features.
     (EPC_FEATURE_NO_LINKUP_NOTIFIER, EPC_FEATURE_BAR_MASK,
      EPC_FEATURE_MSIX_AVAILABLE, EPC_FEATURE_SET_BAR,
      EPC_FEATURE_GET_BAR)
  *) Endpoint controllers are directly modifying struct pci_epc
     members. (I have plans to move struct pci_epc to
     drivers/pci/endpoint so that pci_epc members are referenced
     only by endpoint core).

To overcome the above shortcomings, introduced pci_epc_get_features()
API, pci_epc_features structure and a ->get_features() callback.

Also added a patch to set BAR flags in pci_epf_alloc_space and
remove it from pci-epf-test function driver.

Tested on TI's DRA7xx platform.

Thanks
Kishon

Kishon Vijay Abraham I (15):
  PCI: endpoint: Add new pci_epc_ops to get EPC features
  PCI: dwc: Add ->get_features() callback function in dw_pcie_ep_ops
  PCI: designware-plat: Populate ->get_features() dw_pcie_ep_ops
  PCI: pci-dra7xx: Populate ->get_features() dw_pcie_ep_ops
  PCI: rockchip: Populate ->get_features() dw_pcie_ep_ops
  PCI: cadence: Populate ->get_features() cdns_pcie_epc_ops
  PCI: endpoint: Add helper to get first unreserved BAR
  PCI: endpoint: Fix pci_epf_alloc_space to set correct MEM TYPE flags
  PCI: pci-epf-test: Remove setting epf_bar flags in function driver
  PCI: pci-epf-test: Do not allocate next BARs memory if current BAR is
    64Bit
  PCI: pci-epf-test: Use pci_epc_get_features to get EPC features
  PCI: cadence: Remove pci_epf_linkup from Cadence EP driver
  PCI: rockchip: Remove pci_epf_linkup from Rockchip EP driver
  PCI: designware-plat: Remove setting epc->features in Designware plat
    EP driver
  PCI: endpoint: Remove features member in struct pci_epc

 drivers/pci/controller/dwc/pci-dra7xx.c       | 13 +++
 .../pci/controller/dwc/pcie-designware-ep.c   | 12 +++
 .../pci/controller/dwc/pcie-designware-plat.c | 17 +++-
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 drivers/pci/controller/pcie-cadence-ep.c      | 25 +++---
 drivers/pci/controller/pcie-rockchip-ep.c     | 16 +++-
 drivers/pci/endpoint/functions/pci-epf-test.c | 80 ++++++++++---------
 drivers/pci/endpoint/pci-epc-core.c           | 52 ++++++++++++
 drivers/pci/endpoint/pci-epf-core.c           |  3 +
 include/linux/pci-epc.h                       | 30 +++++--
 10 files changed, 185 insertions(+), 64 deletions(-)

-- 
2.17.1

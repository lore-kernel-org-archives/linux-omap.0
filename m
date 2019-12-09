From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 00/13] Add PCIe support to TI's J721E SoC
Date: Mon, 9 Dec 2019 14:51:34 +0530
Message-ID: <20191209092147.22901-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andrew Murray <andrew.murray@arm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

TI's J721E SoC uses Cadence PCIe core to implement both RC mode
and EP mode.

The high level features are:
  *) Supports Legacy, MSI and MSI-X interrupt
  *) Supports upto GEN4 speed mode
  *) Supports SR-IOV
  *) Supports multiple physical function
  *) Ability to route all transactions via SMMU

This patch series
  *) Add support in Cadence PCIe core to be used for TI's J721E SoC
  *) Add a driver for J721E PCIe wrapper

This is a trimmed down series of the initial RFC series [1].

Changes from RFC [1]:
  *) Ability to route all transactions via SMMU is removed
  *) SR-IOV support is removed
  *) Miscellaneous improvement to endpoint core is removed

All these will be sent as smaller series.

I've also pushed the series along with device tree changes [2].

[1] -> https://lkml.org/lkml/2019/6/4/619
[2] -> https://github.com/kishon/linux-wip.git j7_pci_v1

Kishon Vijay Abraham I (13):
  PCI: cadence: Remove stray "pm_runtime_put_sync()" in error path
  linux/kernel.h: Add PTR_ALIGN_DOWN macro
  PCI: cadence: Add support to use custom read and write accessors
  PCI: cadence: Add support to start link and verify link status
  PCI: cadence: Add read and write accessors to perform only 32-bit
    accesses
  PCI: cadence: Allow pci_host_bridge to have custom pci_ops
  PCI: cadence: Add new *ops* for CPU addr fixup
  PCI: cadence: Use local management register to configure Vendor ID
  dt-bindings: PCI: Add host mode dt-bindings for TI's J721E SoC
  dt-bindings: PCI: Add EP mode dt-bindings for TI's J721E SoC
  PCI: j721e: Add TI J721E PCIe driver
  misc: pci_endpoint_test: Add J721E in pci_device_id table
  MAINTAINERS: Add Kishon Vijay Abraham I for TI J721E SoC PCIe

 .../bindings/pci/ti,j721e-pci-ep.yaml         | 113 +++++
 .../bindings/pci/ti,j721e-pci-host.yaml       | 161 +++++++
 MAINTAINERS                                   |   3 +-
 drivers/misc/pci_endpoint_test.c              |   9 +
 drivers/pci/controller/cadence/Kconfig        |  23 +
 drivers/pci/controller/cadence/Makefile       |   1 +
 drivers/pci/controller/cadence/pci-j721e.c    | 430 ++++++++++++++++++
 .../pci/controller/cadence/pcie-cadence-ep.c  |  10 +-
 .../controller/cadence/pcie-cadence-host.c    |  55 ++-
 drivers/pci/controller/cadence/pcie-cadence.c |  48 +-
 drivers/pci/controller/cadence/pcie-cadence.h | 133 +++++-
 include/linux/kernel.h                        |   1 +
 12 files changed, 958 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
 create mode 100644 drivers/pci/controller/cadence/pci-j721e.c

-- 
2.17.1

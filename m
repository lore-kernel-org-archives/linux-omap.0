From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 07/26] dt-bindings: PCI: Add dt-binding to configure PCIe mode
Date: Mon, 25 Mar 2019 15:09:28 +0530
Message-ID: <20190325093947.32633-8-kishon@ti.com>
References: <20190325093947.32633-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325093947.32633-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com, Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, Jesper Nilsson <jesper.nilsson@axis.com>
List-Id: linux-omap@vger.kernel.org

Add "ti,syscon-pcie-mode" dt-binding to hold phandle to the syscon
register that should be used to configure PCIe in RC mode or EP mode.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/pci-keystone.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci-keystone.txt b/Documentation/devicetree/bindings/pci/pci-keystone.txt
index 3a551687cfa2..8ee07197a063 100644
--- a/Documentation/devicetree/bindings/pci/pci-keystone.txt
+++ b/Documentation/devicetree/bindings/pci/pci-keystone.txt
@@ -23,6 +23,8 @@ pcie_msi_intc : Interrupt controller device node for MSI IRQ chip
 
 ti,syscon-pcie-id : phandle to the device control module required to set device
 		    id and vendor id.
+ti,syscon-pcie-mode : phandle to the device control module required to configure
+		      PCI in either RC mode or EP mode.
 
  Example:
 	pcie_msi_intc: msi-interrupt-controller {
-- 
2.17.1

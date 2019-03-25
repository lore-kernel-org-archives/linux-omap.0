From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 13/26] dt-bindings: PCI: Add PCI RC dt binding documentation for AM654
Date: Mon, 25 Mar 2019 14:04:48 +0530
Message-ID: <20190325083501.8088-14-kishon@ti.com>
References: <20190325083501.8088-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325083501.8088-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com
List-Id: linux-omap@vger.kernel.org

Add devicetree binding documentation for PCIe in RC mode present in
AM654 SoC.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/pci/pci-keystone.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-keystone.txt b/Documentation/devicetree/bindings/pci/pci-keystone.txt
index 8ee07197a063..5c60e911b8b1 100644
--- a/Documentation/devicetree/bindings/pci/pci-keystone.txt
+++ b/Documentation/devicetree/bindings/pci/pci-keystone.txt
@@ -11,7 +11,8 @@ described here as well as properties that are not applicable.
 
 Required Properties:-
 
-compatibility: "ti,keystone-pcie"
+compatibility: Should be "ti,keystone-pcie" for RC on Keystone2 SoC
+	       Should be "ti,am654-pcie-rc" for RC on AM654x SoC
 reg: Three register ranges as listed in the reg-names property
 reg-names: "dbics" for the DesignWare PCIe registers, "app" for the
 	   TI specific application registers, "config" for the
@@ -20,6 +21,9 @@ reg-names: "dbics" for the DesignWare PCIe registers, "app" for the
 pcie_msi_intc : Interrupt controller device node for MSI IRQ chip
 	interrupt-cells: should be set to 1
 	interrupts: GIC interrupt lines connected to PCI MSI interrupt lines
+	(required if the compatible is "ti,keystone-pcie")
+msi-map: As specified in Documentation/devicetree/bindings/pci/pci-msi.txt
+	 (required if the compatible is "ti,am654-pcie-rc".
 
 ti,syscon-pcie-id : phandle to the device control module required to set device
 		    id and vendor id.
-- 
2.17.1

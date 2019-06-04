From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 03/30] dt-bindings: PCI: cadence: Update host DT bindings with TI specific compatible
Date: Tue, 4 Jun 2019 18:44:49 +0530
Message-ID: <20190604131516.13596-4-kishon@ti.com>
References: <20190604131516.13596-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190604131516.13596-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Frank Rowand <frowand.list@gmail.com>, Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

Update DT bindings for Cadence PCIe host controller with TI specific
compatible.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
index cbd16519ae13..afebfec102af 100644
--- a/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
+++ b/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
@@ -5,6 +5,7 @@ host-generic-pci.txt.
 
 Required properties:
 - compatible: Should contain "cdns,cdns-pcie-host" to identify the IP used.
+	      Should contain "ti,j721e-cdns-pcie-host" for TI platforms.
 - reg: Should contain the controller register base address, PCIe configuration
   window base address, and AXI interface region base address respectively.
 - reg-names: Must be "reg", "cfg" and "mem" respectively.
-- 
2.17.1

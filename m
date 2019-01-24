From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 2/3] dt-bindings: PCI: dra7xx: Add properties to enable x2 lane in dra7
Date: Thu, 24 Jan 2019 13:59:56 +0530
Message-ID: <20190124082957.29077-3-kishon@ti.com>
References: <20190124082957.29077-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124082957.29077-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh+dt@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

Add syscon properties required for configuring PCIe in x2 lane mode.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 Documentation/devicetree/bindings/pci/ti-pci.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index e03d23631f5b..d5cbfe6b0d89 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -13,6 +13,9 @@ PCIe DesignWare Controller
  - ti,hwmods : Name of the hwmod associated to the pcie, "pcie<X>",
 	       where <X> is the instance number of the pcie from the HW spec.
  - num-lanes as specified in ../designware-pcie.txt
+ - ti,syscon-lane-sel : phandle/offset pair. Phandle to the system control
+			module and the register offset to specify lane
+			selection.
 
 HOST MODE
 =========
-- 
2.17.1

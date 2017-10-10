From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 1/4] dt-bindings: PCI: dra7xx: Add SoC specific compatible strings
Date: Tue, 10 Oct 2017 15:46:03 +0530
Message-ID: <20171010101606.15951-2-kishon@ti.com>
References: <20171010101606.15951-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171010101606.15951-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Add new compatible strings for dra74x SoC (also used by dra76x) and
dra72x. This can be used to perform SoC specific configuration
(like configuring PCIe in x2 lane mode).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 Documentation/devicetree/bindings/pci/ti-pci.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index 7f7af3044016..82cb875e4cec 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -1,8 +1,12 @@
 TI PCI Controllers
 
 PCIe DesignWare Controller
- - compatible: Should be "ti,dra7-pcie" for RC
-	       Should be "ti,dra7-pcie-ep" for EP
+ - compatible: Should be "ti,dra7-pcie" for RC (deprecated)
+	       Should be "ti,dra7-pcie-ep" for EP (deprecated)
+	       Should be "ti,dra746-pcie-rc" for dra74x/dra76 in RC mode
+	       Should be "ti,dra746-pcie-ep" for dra74x/dra76 in EP mode
+	       Should be "ti,dra726-pcie-rc" for dra72x in RC mode
+	       Should be "ti,dra726-pcie-ep" for dra72x in EP mode
  - phys : list of PHY specifiers (used by generic PHY framework)
  - phy-names : must be "pcie-phy0", "pcie-phy1", "pcie-phyN".. based on the
 	       number of PHYs as specified in *phys* property.
-- 
2.11.0

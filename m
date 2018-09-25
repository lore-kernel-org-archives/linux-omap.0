From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH v5 1/2] dt-bindings: PCI: dra7xx: Add bindings for unaligned access in host mode
Date: Tue, 25 Sep 2018 14:00:23 +0530
Message-ID: <20180925083024.6960-2-vigneshr@ti.com>
References: <20180925083024.6960-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925083024.6960-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

Update device tree binding documentation of TI's dra7xx PCI controller
for enabling unaligned mem access as applicable not just in EP mode but
in host mode as well.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pci/ti-pci.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index 7f7af3044016..452fe48c4fdd 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -26,6 +26,11 @@ HOST MODE
    ranges,
    interrupt-map-mask,
    interrupt-map : as specified in ../designware-pcie.txt
+ - ti,syscon-unaligned-access: phandle to the syscon DT node. The 1st argument
+			       should contain the register offset within syscon
+			       and the 2nd argument should contain the bit field
+			       for setting the bit to enable unaligned
+			       access.
 
 DEVICE MODE
 ===========
-- 
2.19.0

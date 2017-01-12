From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 30/37] dt-bindings: PCI: dra7xx: Add dt bindings to enable legacy mode
Date: Thu, 12 Jan 2017 15:56:19 +0530
Message-ID: <1484216786-17292-31-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484216786-17292-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@axis.com, linux-arm-msm@vger.kernel.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

Update device tree binding documentation of TI's dra7xx PCI
controller to include property for enabling legacy mode.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/pci/ti-pci.txt |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
index 62f5f59..ed85e8e 100644
--- a/Documentation/devicetree/bindings/pci/ti-pci.txt
+++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
@@ -39,6 +39,10 @@ DEVICE MODE
  - interrupts : one interrupt entries must be specified for main interrupt.
  - num-ib-windows : number of inbound address translation windows
  - num-ob-windows : number of outbound address translation windows
+ - syscon-legacy-mode: phandle to the syscon dt node. The 1st argument should
+		       contain the register offset within syscon and the 2nd
+		       argument should contain the bit field for setting the
+		       legacy mode
 
 Optional Property:
  - gpios : Should be added if a gpio line is required to drive PERST# line
-- 
1.7.9.5

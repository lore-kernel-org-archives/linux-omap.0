From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 09/26] dt-bindings: PCI: Document "atu" reg-names
Date: Mon, 25 Mar 2019 15:09:30 +0530
Message-ID: <20190325093947.32633-10-kishon@ti.com>
References: <20190325093947.32633-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325093947.32633-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Murali Karicheri <m-karicheri2@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com, Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, Jesper Nilsson <jesper.nilsson@axis.com>
List-Id: linux-omap@vger.kernel.org

Document "atu" reg-names required to get the register space for ATU in
Synopsys designware core version >= 4.80.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/pci/designware-pcie.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index c124f9bc11f3..5561a1c060d0 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -4,8 +4,11 @@ Required properties:
 - compatible:
 	"snps,dw-pcie" for RC mode;
 	"snps,dw-pcie-ep" for EP mode;
-- reg: Should contain the configuration address space.
-- reg-names: Must be "config" for the PCIe configuration space.
+- reg: For designware cores version < 4.80 contains the configuration
+       address space. For designware core version >= 4.80, contains
+       the configuration and ATU address space
+- reg-names: Must be "config" for the PCIe configuration space and "atu" for
+	     the ATU address space.
     (The old way of getting the configuration address space from "ranges"
     is deprecated and should be avoided.)
 - num-lanes: number of lanes to use
-- 
2.17.1

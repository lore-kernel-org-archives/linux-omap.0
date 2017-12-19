From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 4/7] ARM: dts: dra76-evm: Enable x2 PCIe lanes
Date: Tue, 19 Dec 2017 15:01:30 +0530
Message-ID: <20171219093133.16565-5-kishon@ti.com>
References: <20171219093133.16565-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20171219093133.16565-1-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

DRA76 EVM has a 4-lane PCIe connector and DRA76 can support x2 lanes.
Enable both the PCIe lanes here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/dra76-evm.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/dra76-evm.dts b/arch/arm/boot/dts/dra76-evm.dts
index b024a65c6e27..244e553f2247 100644
--- a/arch/arm/boot/dts/dra76-evm.dts
+++ b/arch/arm/boot/dts/dra76-evm.dts
@@ -421,3 +421,19 @@
 		spi-max-frequency = <96000000>;
 	};
 };
+
+&pcie2_phy {
+	status = "okay";
+};
+
+&pcie1_rc {
+	num-lanes = <2>;
+	phys = <&pcie1_phy>, <&pcie2_phy>;
+	phy-names = "pcie-phy0", "pcie-phy1";
+};
+
+&pcie1_ep {
+	num-lanes = <2>;
+	phys = <&pcie1_phy>, <&pcie2_phy>;
+	phy-names = "pcie-phy0", "pcie-phy1";
+};
-- 
2.11.0

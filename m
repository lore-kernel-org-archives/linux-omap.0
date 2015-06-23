From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 08/17] ARM: dts: dra7: Add dt node for the sycon pcie
Date: Tue, 23 Jun 2015 17:28:53 +0530
Message-ID: <1435060743-5511-9-git-send-email-kishon@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435060743-5511-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, balbi@ti.com, rogerq@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, kishon@ti.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

Add new device tree node for the control module register space where
PCIe registers are present.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 260f300..3f434f7 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -291,6 +291,11 @@
 			reg = <0x4a002e00 0x7c>;
 		};
 
+		dra7_ctrl_pcie: tisyscon@4a003c00 {
+			compatible = "syscon";
+			reg = <0x4a003c00 0x48>;
+		};
+
 		sdma: dma-controller@4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
-- 
1.7.9.5

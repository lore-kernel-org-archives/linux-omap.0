From: George Cherian <george.cherian@ti.com>
Subject: [PATCH v2] arm: dts: AM43x: Add usb_otg_hs node
Date: Tue, 9 Jul 2013 14:47:26 +0530
Message-ID: <1373361446-30050-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: linux@arm.linux.org.uk, benoit.cousson@linaro.org, afzal@ti.com, linux-kernel@vger.kernel.org, balbi@ti.com, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

Adds device node for HS USB Host module for AM437x

changes from v1

renamed synopsis to snps
removed flag tx-fifo-resize

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index ddc1df7..c9e0da8 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -64,5 +64,23 @@
 			compatible = "ti,am4372-counter32k","ti,omap-counter32k";
 			reg = <0x44e86000 0x40>;
 		};
+
+		usb_otg_hs1: am4372_dwc3@48380000 {
+			compatible = "ti,am437x-dwc3";
+			reg = <0x48380000 0x1ff>;
+			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			utmi-mode = <1>;
+			ranges;
+
+			dwc3@48390000 {
+				compatible = "snps,dwc3";
+				reg = <0x48390000 0xcfff>;
+				interrupts = <GIC_SPI  168 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+		};
+		
 	};
 };
-- 
1.8.1.4

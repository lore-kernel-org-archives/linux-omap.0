From: George Cherian <george.cherian@ti.com>
Subject: [PATCH 16/19] arm: dts: omap5: Add named interrupt property for dwc3
Date: Tue, 25 Nov 2014 18:41:52 +0530
Message-ID: <1416921115-10467-17-git-send-email-george.cherian@ti.com>
References: <1416921115-10467-1-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416921115-10467-1-git-send-email-george.cherian@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: peter.chen@freescale.com, sojka@merica.cz, mathias.nyman@intel.com, balbi@ti.com, gregkh@linuxfoundation.org, tony@atomide.com, bcousson@baylibre.com, kgene.kim@samsung.com, ben-linux@fluff.org, linux@arm.linux.org.uk, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

Add interrupt names so that the same can be used for OTG easily.

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 256b7f6..a712ad9 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -817,7 +817,12 @@
 			dwc3@4a030000 {
 				compatible = "snps,dwc3";
 				reg = <0x4a030000 0x10000>;
-				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "peripheral",
+						  "host",
+						  "otg";
 				phys = <&usb2_phy>, <&usb3_phy>;
 				phy-names = "usb2-phy", "usb3-phy";
 				dr_mode = "peripheral";
-- 
1.8.3.1

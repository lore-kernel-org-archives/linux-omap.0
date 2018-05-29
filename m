From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 5/5] ARM: dts: dra76-evm: Add VBUS GPIO to USB1/USB2 extcon
Date: Tue, 29 May 2018 12:00:58 +0300
Message-ID: <1527584458-6257-6-git-send-email-rogerq@ti.com>
References: <1527584458-6257-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527584458-6257-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

The board has USB VBUS detection available over GPIO. Plug it to
extcon node of USB1 and USB2 ports.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra76-evm.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/dra76-evm.dts b/arch/arm/boot/dts/dra76-evm.dts
index 2deb964..bec72ec 100644
--- a/arch/arm/boot/dts/dra76-evm.dts
+++ b/arch/arm/boot/dts/dra76-evm.dts
@@ -404,3 +404,11 @@
 	phys = <&pcie1_phy>, <&pcie2_phy>;
 	phy-names = "pcie-phy0", "pcie-phy1";
 };
+
+&extcon_usb1 {
+	vbus-gpio = <&pcf_lcd 14 GPIO_ACTIVE_HIGH>;
+};
+
+&extcon_usb2 {
+	vbus-gpio = <&pcf_lcd 15 GPIO_ACTIVE_HIGH>;
+};
-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

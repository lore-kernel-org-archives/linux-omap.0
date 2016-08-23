From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 3/3] ARM: dts: dra7: workaround silicon limitation i845
Date: Tue, 23 Aug 2016 11:57:41 +0300
Message-ID: <1471942661-1728-4-git-send-email-rogerq@ti.com>
References: <1471942661-1728-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471942661-1728-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com, tony@atomide.com
Cc: robh+dt@kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Sekhar Nori <nsekhar@ti.com>

Silicon limitation i845 documents how to cope with false
disconnection condition on USB2 PHY. Reference: AM572x
silicon errata document SPRZ429H, revised January 2016.

Using compatible "ti,dra7x-usb2" enables the recommended
software workaround for this issue. Use it for USB1 PHY.

The workaround is already in place for USB2 PHY.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d9bfb94..df0dcbc 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1413,7 +1413,7 @@
 			ti,hwmods = "ocp2scp1";
 
 			usb2_phy1: phy@4a084000 {
-				compatible = "ti,omap-usb2";
+				compatible = "ti,dra7x-usb2", "ti,omap-usb2";
 				reg = <0x4a084000 0x400>;
 				syscon-phy-power = <&scm_conf 0x300>;
 				clocks = <&usb_phy1_always_on_clk32k>,
-- 
2.7.4

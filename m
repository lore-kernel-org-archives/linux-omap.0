From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 2/5] arm: omap5: dts: fix ocp2scp DTS data
Date: Wed, 21 Aug 2013 20:01:31 +0530
Message-ID: <1377095494-15380-3-git-send-email-kishon@ti.com>
References: <1377095494-15380-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1377095494-15380-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, balbi@ti.com
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, linux@arm.linux.org.uk, javier.martinez@collabora.co.uk, devicetree@vger.kernel.org, kishon@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi@ti.com>

this patch fixes the DTS data for ocp2scp
node by adding the missing reg property.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 5c99f19..4e41409 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -652,10 +652,11 @@
 			};
 		};
 
-		ocp2scp {
+		ocp2scp@4a080000 {
 			compatible = "ti,omap-ocp2scp";
 			#address-cells = <1>;
 			#size-cells = <1>;
+			reg = <0x4a080000 0x20>;
 			ranges;
 			ti,hwmods = "ocp2scp1";
 			usb2_phy: usb2phy@4a084000 {
-- 
1.7.10.4

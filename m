From: Ricardo Salveti <ricardo.salveti@linaro.org>
Subject: [PATCH] arm: dts: boneblack-wireless: add WL1835 Bluetooth device node
Date: Mon, 22 May 2017 11:51:38 -0300
Message-ID: <1495464701-12046-1-git-send-email-ricardo.salveti@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: robertcnelson@gmail.com, Ricardo Salveti <ricardo.salveti@linaro.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This adds the serial slave device for the WL1835 Bluetooth interface.

Signed-off-by: Ricardo Salveti <ricardo.salveti@linaro.org>
---
 arch/arm/boot/dts/am335x-boneblack-wireless.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-boneblack-wireless.dts b/arch/arm/boot/dts/am335x-boneblack-wireless.dts
index 105bd10..83f49f6 100644
--- a/arch/arm/boot/dts/am335x-boneblack-wireless.dts
+++ b/arch/arm/boot/dts/am335x-boneblack-wireless.dts
@@ -97,6 +97,11 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins &bt_pins>;
 	status = "okay";
+
+	bluetooth {
+		compatible = "ti,wl1835-st";
+		enable-gpios = <&gpio0 28 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &gpio3 {
-- 
2.7.4

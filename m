From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] arm: dts: da850: Add interrupt-controller property to gpio node
Date: Wed, 24 May 2017 18:18:15 +0530
Message-ID: <1495630095-1954-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: nsekhar@ti.com, linus.walleij@linaro.org
Cc: j-keerthy@ti.com, tony@atomide.com, mark.rutland@arm.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org
List-Id: linux-omap@vger.kernel.org

The gpio node has 144 gpios. Each gpio is capable of generating
an interrupt. Hence add interrupt-controller property to the gpio
node. With this in place one can use interrupts property in device
tree to request for the gpio interrupts.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/da850.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 941d455..2693bd2 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -503,6 +503,8 @@
 			ti,ngpio = <144>;
 			ti,davinci-gpio-unbanked = <0>;
 			status = "disabled";
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 		pinconf: pin-controller@22c00c {
 			compatible = "ti,da850-pupd";
-- 
1.9.1

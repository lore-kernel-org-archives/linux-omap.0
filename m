From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 3/3] arm: boot: beaglex15: pass correct interrupt
Date: Wed, 30 Dec 2015 09:55:47 +0900
Message-ID: <1451436947-22163-4-git-send-email-cw00.choi@samsung.com>
References: <1451436947-22163-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1451436947-22163-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, robh+dt@kernel.org, lee.jones@linaro.org, balbi@ti.com
Cc: rogerq@ti.com, kishon@ti.com, george.cherian@ti.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi@ti.com>

According to latest schematics [1], GPIO_1/VBUSDET
on TPS659038 is tied to AM57x GPIO4_21. We can use
that as a VBUS interrupt, instead of relying on
PMIC's VBUS interrupts which don't seem to be firing
on x15 at all.

A follow up patch will add support for using this
GPIO-based interrupt mechanism for notifying about
VBUS.

[1] https://github.com/beagleboard/beagleboard-x15/blob/master/BeagleBoard-X15_RevA2.pdf

Signed-off-by: Felipe Balbi <balbi@ti.com>
[cw00.choi: Use the 'vbus-gpio' property instead of 'interrupts-extended']
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index be4990608c77..3887ba89d2a5 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -560,6 +560,7 @@
 		extcon_usb2: tps659038_usb {
 			compatible = "ti,palmas-usb-vid";
 			ti,enable-vbus-detection;
+			vbus-gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
 		};
 
 	};
-- 
1.9.1

From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 2/3] arm: boot: dts: beaglex15: Remove ID GPIO
Date: Wed, 30 Dec 2015 09:55:46 +0900
Message-ID: <1451436947-22163-3-git-send-email-cw00.choi@samsung.com>
References: <1451436947-22163-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1451436947-22163-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, robh+dt@kernel.org, lee.jones@linaro.org, balbi@ti.com
Cc: rogerq@ti.com, kishon@ti.com, george.cherian@ti.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi@ti.com>

According to latest schematics [1], this board
leaves ID pin floating. It's not connected to
anything at all.

So let's remove it.

[1] https://github.com/beagleboard/beagleboard-x15/blob/master/BeagleBoard-X15_RevA2.pdf

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index d9ba6b879fc1..be4990608c77 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -560,8 +560,6 @@
 		extcon_usb2: tps659038_usb {
 			compatible = "ti,palmas-usb-vid";
 			ti,enable-vbus-detection;
-			ti,enable-id-detection;
-			id-gpios = <&gpio7 24 GPIO_ACTIVE_HIGH>;
 		};
 
 	};
-- 
1.9.1

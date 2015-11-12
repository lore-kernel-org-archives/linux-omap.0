From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/2] arm: boot: beaglex15: pass correct interrupt
Date: Thu, 12 Nov 2015 11:53:01 -0600
Message-ID: <1447350781-20649-3-git-send-email-balbi@ti.com>
References: <1447350781-20649-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447350781-20649-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

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
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 6f3a1a7ec5f9..5e47162f7883 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -560,6 +560,7 @@
 		extcon_usb2: tps659038_usb {
 			compatible = "ti,palmas-usb-vid";
 			ti,enable-vbus-detection;
+			interrupts-extended = <&gpio4 21 IRQ_TYPE_EDGE_RISING>;
 		};
 
 	};
-- 
2.6.2

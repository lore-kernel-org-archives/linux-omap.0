From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/2] arm: boot: dts: beaglex15: Remove ID GPIO
Date: Thu, 12 Nov 2015 11:53:00 -0600
Message-ID: <1447350781-20649-2-git-send-email-balbi@ti.com>
References: <1447350781-20649-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447350781-20649-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

According to latest schematics [1], this board
leaves ID pin floating. It's not connected to
anything at all.

So let's remove it.

[1] https://github.com/beagleboard/beagleboard-x15/blob/master/BeagleBoard-X15_RevA2.pdf

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 00352e761b8c..6f3a1a7ec5f9 100644
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
2.6.2

From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 6/7] ARM: dts: am57xx-beagle-x15: Fix USB2 mode
Date: Mon, 26 Jan 2015 14:15:31 +0200
Message-ID: <1422274532-9488-7-git-send-email-rogerq@ti.com>
References: <1422274532-9488-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422274532-9488-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, tony@atomide.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc: george.cherian@ti.com, nsekhar@ti.com, devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On this board USB2 is meant to be used as peripheral only.
The ID pin for USB2 is hardwired HIGH.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index ad1833b..2115dda 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -436,3 +436,7 @@
 &omap_dwc3_2 {
 	extcon = <&extcon_usb2>;
 };
+
+&usb2 {
+	dr_mode = "peripheral";
+};
-- 
2.1.0

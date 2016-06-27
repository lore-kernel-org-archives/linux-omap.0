From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 11/27] ARM: dts: omap3-ha-lcd: remove unneeded unit name
Date: Mon, 27 Jun 2016 15:20:52 -0400
Message-ID: <1467055268-13194-12-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for omap3-ha-lcd.dtb:

"display@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3-ha-lcd.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-ha-lcd.dts b/arch/arm/boot/dts/omap3-ha-lcd.dts
index 11aa28d73f3a..60af7c2358a3 100644
--- a/arch/arm/boot/dts/omap3-ha-lcd.dts
+++ b/arch/arm/boot/dts/omap3-ha-lcd.dts
@@ -121,7 +121,7 @@
 		display0 = &lcd0;
 	};
 
-	lcd0: display@0 {
+	lcd0: display {
 		compatible = "panel-dpi";
 		label = "lcd";
 
-- 
2.5.5

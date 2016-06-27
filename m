From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 17/27] ARM: dts: omap3-thunder: remove unneded unit name
Date: Mon, 27 Jun 2016 15:20:58 -0400
Message-ID: <1467055268-13194-18-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for omap3-thunder.dtb:

"display@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3-thunder.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-thunder.dts b/arch/arm/boot/dts/omap3-thunder.dts
index d659515ab9b8..9736ba79bb5b 100644
--- a/arch/arm/boot/dts/omap3-thunder.dts
+++ b/arch/arm/boot/dts/omap3-thunder.dts
@@ -85,7 +85,7 @@
 		display0 = &lcd0;
 	};
 
-	lcd0: display@0 {
+	lcd0: display {
 		compatible = "samsung,lte430wq-f0c", "panel-dpi";
 		label = "lcd";
 
-- 
2.5.5

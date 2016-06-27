From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 07/27] ARM: dts: cm-t3x: remove unneeded unit name in connector
Date: Mon, 27 Jun 2016 15:20:48 -0400
Message-ID: <1467055268-13194-8-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for omap3-cm-t3517.dtb,
omap3-cm-t3530.dtb and omap3-cm-t3730.dtb:

"connector@1 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3-cm-t3x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index a8127bc31fd9..6a0df13fa0f3 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -57,7 +57,7 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
-	tv0: connector@1 {
+	tv0: connector {
 		compatible = "svideo-connector";
 		label = "tv";
 
-- 
2.5.5

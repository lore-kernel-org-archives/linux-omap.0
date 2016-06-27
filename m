From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 15/27] ARM: dts: omap3-pandora-common: remove unneded unit name
Date: Mon, 27 Jun 2016 15:20:56 -0400
Message-ID: <1467055268-13194-16-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for omap3-pandora-600mhz.dtb
and omap3-pandora-1ghz.dtb:

"connector@1 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3-pandora-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index bcf39d606b65..dbc4dc721cc2 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -27,7 +27,7 @@
 		display0 = &lcd;
 	};
 
-	tv: connector@1 {
+	tv: connector {
 		compatible = "connector-analog-tv";
 		label = "tv";
 
-- 
2.5.5

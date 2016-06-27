From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 02/27] ARM: dts: am3517-craneboard: remove unneeded unit name for fixedregulator
Date: Mon, 27 Jun 2016 15:20:43 -0400
Message-ID: <1467055268-13194-3-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for am3517-craneboard.dtb:

"fixedregulator@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/am3517-craneboard.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am3517-craneboard.dts b/arch/arm/boot/dts/am3517-craneboard.dts
index cb7de1d4e05f..f9d8f3948c4a 100644
--- a/arch/arm/boot/dts/am3517-craneboard.dts
+++ b/arch/arm/boot/dts/am3517-craneboard.dts
@@ -20,7 +20,7 @@
 		reg = <0x80000000 0x10000000>;	/* 256 MB */
 	};
 
-	vbat: fixedregulator@0 {
+	vbat: fixedregulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vbat";
 		regulator-min-microvolt = <5000000>;
-- 
2.5.5

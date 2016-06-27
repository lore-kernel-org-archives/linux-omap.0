From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 27/27] ARM: dts: am57xx: sbc-am57x: remove unneded unit name
Date: Mon, 27 Jun 2016 15:21:08 -0400
Message-ID: <1467055268-13194-28-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for am57xx-sbc-am57x.dtb:

"endpoint@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/boot/dts/am57xx-sbc-am57x.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am57xx-sbc-am57x.dts b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
index 988e99632d49..31f9be632406 100644
--- a/arch/arm/boot/dts/am57xx-sbc-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
@@ -128,7 +128,7 @@
 	vdda_video-supply = <&ldoln_reg>;
 
 	port {
-		dpi_lcd_out: endpoint@0 {
+		dpi_lcd_out: endpoint {
 			remote-endpoint = <&lcd_in>;
 			data-lines = <24>;
 		};
-- 
2.5.5

From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 24/27] ARM: dts: am437x: cm-t43: remove unneded unit names
Date: Mon, 27 Jun 2016 15:21:05 -0400
Message-ID: <1467055268-13194-25-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for am437x-sbc-t43.dtb:

"endpoint@0 has a unit name, but no reg property"
"connector@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/am437x-sbc-t43.dts   | 2 +-
 arch/arm/boot/dts/compulab-sb-som.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-sbc-t43.dts b/arch/arm/boot/dts/am437x-sbc-t43.dts
index 5f750c0ed6c9..d23260d3a581 100644
--- a/arch/arm/boot/dts/am437x-sbc-t43.dts
+++ b/arch/arm/boot/dts/am437x-sbc-t43.dts
@@ -145,7 +145,7 @@
 	pinctrl-0 = <&dss_pinctrl_default>;
 
 	port {
-		dpi_lcd_out: endpoint@0 {
+		dpi_lcd_out: endpoint {
 			remote-endpoint = <&lcd_in>;
 			data-lines = <24>;
 		};
diff --git a/arch/arm/boot/dts/compulab-sb-som.dtsi b/arch/arm/boot/dts/compulab-sb-som.dtsi
index 93d7e235bc80..4af1adfee788 100644
--- a/arch/arm/boot/dts/compulab-sb-som.dtsi
+++ b/arch/arm/boot/dts/compulab-sb-som.dtsi
@@ -40,7 +40,7 @@
 		};
 	};
 
-	hdmi_conn: connector@0 {
+	hdmi_conn: connector {
 		compatible = "hdmi-connector";
 		label = "hdmi";
 
-- 
2.5.5

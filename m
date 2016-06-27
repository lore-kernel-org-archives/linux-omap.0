From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 21/27] ARM: dts: omap4-var-om44customboard: remove unneded unit name
Date: Mon, 27 Jun 2016 15:21:02 -0400
Message-ID: <1467055268-13194-22-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for omap4-var-dvk-om44.dtb
and omap4-var-stk-om44.dtb:

"connector@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap4-var-om44customboard.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4-var-om44customboard.dtsi b/arch/arm/boot/dts/omap4-var-om44customboard.dtsi
index 6e278d7716a5..74940b6d7719 100644
--- a/arch/arm/boot/dts/omap4-var-om44customboard.dtsi
+++ b/arch/arm/boot/dts/omap4-var-om44customboard.dtsi
@@ -45,7 +45,7 @@
 		};
 	};
 
-	hdmi0: connector@0 {
+	hdmi0: connector {
 		compatible = "hdmi-connector";
 		pinctrl-names = "default";
 		pinctrl-0 = <&hdmi_hpd_pins>;
-- 
2.5.5

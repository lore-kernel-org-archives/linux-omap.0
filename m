From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 18/27] ARM: dts: omap4-duovero-parlor: remove unneded unit name
Date: Mon, 27 Jun 2016 15:20:59 -0400
Message-ID: <1467055268-13194-19-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for omap4-duovero-parlor.dtb:

"connector@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap4-duovero-parlor.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4-duovero-parlor.dts b/arch/arm/boot/dts/omap4-duovero-parlor.dts
index 06c54822ddc2..6b39808b8313 100644
--- a/arch/arm/boot/dts/omap4-duovero-parlor.dts
+++ b/arch/arm/boot/dts/omap4-duovero-parlor.dts
@@ -40,7 +40,7 @@
 		};
 	};
 
-	hdmi0: connector@0 {
+	hdmi0: connector {
 		compatible = "hdmi-connector";
 		label = "hdmi";
 
-- 
2.5.5

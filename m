From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 01/27] ARM: dts: omap2: add missing unit name to func_96m_ck
Date: Mon, 27 Jun 2016 15:20:42 -0400
Message-ID: <1467055268-13194-2-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for omap2430-sdp.dtb:

"func_96m_ck has a reg or ranges property, but no unit name"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap24xx-clocks.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap24xx-clocks.dtsi b/arch/arm/boot/dts/omap24xx-clocks.dtsi
index ca73722b5ea4..769a346de613 100644
--- a/arch/arm/boot/dts/omap24xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap24xx-clocks.dtsi
@@ -164,7 +164,7 @@
 		clock-div = <1>;
 	};
 
-	func_96m_ck: func_96m_ck {
+	func_96m_ck: func_96m_ck@540 {
 		#clock-cells = <0>;
 	};
 
-- 
2.5.5

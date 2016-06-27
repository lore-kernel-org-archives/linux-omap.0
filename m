From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 23/27] ARM: dts: am437x-gp-evm: remove unneded unit name
Date: Mon, 27 Jun 2016 15:21:04 -0400
Message-ID: <1467055268-13194-24-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for am437x-gp-evm.dtb:

"endpoint@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/am437x-gp-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 84832bf26b39..14677d599595 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -897,7 +897,7 @@
 	pinctrl-0 = <&dss_pins>;
 
 	port {
-		dpi_out: endpoint@0 {
+		dpi_out: endpoint {
 			remote-endpoint = <&lcd_in>;
 			data-lines = <24>;
 		};
-- 
2.5.5

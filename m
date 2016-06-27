From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 22/27] ARM: dts: am43xx-epos-evm: remove unneded unit name
Date: Mon, 27 Jun 2016 15:21:03 -0400
Message-ID: <1467055268-13194-23-git-send-email-javier@osg.samsung.com>
References: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467055268-13194-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings for am43xx-epos-evm.dtb:

"endpoint@0 has a unit name, but no reg property"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/am43x-epos-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 3549b8c9ac49..ad32e55532f8 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -754,7 +754,7 @@
 	pinctrl-0 = <&dss_pins>;
 
 	port {
-		dpi_out: endpoint@0 {
+		dpi_out: endpoint {
 			remote-endpoint = <&lcd_in>;
 			data-lines = <24>;
 		};
-- 
2.5.5

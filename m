From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: am437x-idk-evm: Fix incorrect OPP node names
Date: Mon, 10 Feb 2020 15:04:23 -0600
Message-ID: <20200210210423.22424-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The commit 337c6c9a69af ("ARM: dts: am437x-idk-evm: Disable
OPP50 for MPU") adjusts couple of OPP nodes defined in the
common am4372.dtsi file, but used outdated node names. This
results in these getting treated as new OPP nodes with missing
properties.

Fix this properly by using the correct node names as updated in
commit b9cb2ba71848 ("ARM: dts: Use - instead of @ for DT OPP
entries for TI SoCs").

Reported-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Fixes: 337c6c9a69af ("ARM: dts: am437x-idk-evm: Disable OPP50 for MPU")
Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am437x-idk-evm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts b/arch/arm/boot/dts/am437x-idk-evm.dts
index f3ced6df0c9b..9f66f96d09c9 100644
--- a/arch/arm/boot/dts/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/am437x-idk-evm.dts
@@ -526,11 +526,11 @@
 	 * Supply voltage supervisor on board will not allow opp50 so
 	 * disable it and set opp100 as suspend OPP.
 	 */
-	opp50@300000000 {
+	opp50-300000000 {
 		status = "disabled";
 	};
 
-	opp100@600000000 {
+	opp100-600000000 {
 		opp-suspend;
 	};
 };
-- 
2.23.0

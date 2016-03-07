From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 01/10] ARM: DTS: dra7: Move the sDMA crossbar node under l4_cfg/scm
Date: Mon, 7 Mar 2016 17:17:28 +0200
Message-ID: <1457363857-20797-2-git-send-email-peter.ujfalusi@ti.com>
References: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457363857-20797-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Move the sDMA xbar nodes under the L4 interconnect node.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/dra7.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 098b4dd14b01..db7fda97a4fa 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -161,6 +161,15 @@
 					compatible = "syscon";
 					reg = <0x1c24 0x0024>;
 				};
+
+				sdma_xbar: dma-router@b78 {
+					compatible = "ti,dra7-dma-crossbar";
+					reg = <0xb78 0xfc>;
+					#dma-cells = <1>;
+					dma-requests = <205>;
+					ti,dma-safe-map = <0>;
+					dma-masters = <&sdma>;
+				};
 			};
 
 			cm_core_aon: cm_core_aon@5000 {
@@ -315,15 +324,6 @@
 			dma-requests = <127>;
 		};
 
-		sdma_xbar: dma-router@4a002b78 {
-			compatible = "ti,dra7-dma-crossbar";
-			reg = <0x4a002b78 0xfc>;
-			#dma-cells = <1>;
-			dma-requests = <205>;
-			ti,dma-safe-map = <0>;
-			dma-masters = <&sdma>;
-		};
-
 		gpio1: gpio@4ae10000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x4ae10000 0x200>;
-- 
2.7.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

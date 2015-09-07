From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/3] ARM: dts: AM43x-epos-evm: Add AM438x compatible string for epos
Date: Mon, 7 Sep 2015 12:35:27 +0530
Message-ID: <1441609528-20344-3-git-send-email-j-keerthy@ti.com>
References: <1441609528-20344-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441609528-20344-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Add AM438x compatible property to identify the SoCs on epos evms.

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/arm/omap/omap.txt | 5 ++++-
 arch/arm/boot/dts/am43x-epos-evm.dts                | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 9f4e513..dc3b5f2 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -100,6 +100,9 @@ SoCs:
 - AM4372
   compatible = "ti,am4372", "ti,am43"
 
+- AM438x
+  compatible = "ti,am438x", "ti,am43"
+
 Boards:
 
 - OMAP3 BeagleBoard : Low cost community board
@@ -142,7 +145,7 @@ Boards:
   compatible = "ti,omap5-evm", "ti,omap5"
 
 - AM43x EPOS EVM
-  compatible = "ti,am43x-epos-evm", "ti,am4372", "ti,am43"
+  compatible = "ti,am43x-epos-evm", "ti,am438x", "ti,am43"
 
 - AM437x GP EVM
   compatible = "ti,am437x-gp-evm", "ti,am4372", "ti,am43"
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 86c2dfb..1c9b9a0 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -18,7 +18,7 @@
 
 / {
 	model = "TI AM43x EPOS EVM";
-	compatible = "ti,am43x-epos-evm","ti,am4372","ti,am43";
+	compatible = "ti,am43x-epos-evm", "ti,am438x", "ti,am43";
 
 	aliases {
 		display0 = &lcd0;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

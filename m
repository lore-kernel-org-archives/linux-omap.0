From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 1/2] ARM: dts: am43x-epos-evm: Add the am438 compatible string
Date: Fri, 19 Feb 2016 10:08:54 +0530
Message-ID: <1455856735-11515-2-git-send-email-j-keerthy@ti.com>
References: <1455856735-11515-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455856735-11515-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

The SoCs on am43x-epos-evm are named am438x.
Hence add the compatibility string and remove the am4372 string.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 Documentation/devicetree/bindings/arm/omap/omap.txt | 2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index a2bd593..739bc48 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -154,7 +154,7 @@ Boards:
   compatible = "compulab,am437x-sbc-t43", "compulab,am437x-cm-t43", "ti,am4372", "ti,am43"
 
 - AM43x EPOS EVM
-  compatible = "ti,am43x-epos-evm", "ti,am4372", "ti,am43"
+  compatible = "ti,am43x-epos-evm", "ti,am43", "ti,am438x"
 
 - AM437x GP EVM
   compatible = "ti,am437x-gp-evm", "ti,am4372", "ti,am43"
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index d580e2b..d2408c4 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -18,7 +18,7 @@
 
 / {
 	model = "TI AM43x EPOS EVM";
-	compatible = "ti,am43x-epos-evm","ti,am4372","ti,am43";
+	compatible = "ti,am43x-epos-evm","ti,am438x","ti,am43";
 
 	aliases {
 		display0 = &lcd0;
-- 
1.9.1

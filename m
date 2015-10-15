From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 2/3] ARM: dts: AM43x-epos-evm: Add AM438x compatible string
 for epos
Date: Thu, 15 Oct 2015 10:40:07 +0530
Message-ID: <1444885808-6306-3-git-send-email-j-keerthy@ti.com>
References: <1444885808-6306-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444885808-6306-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: j-keerthy@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add AM438x compatible property to identify the SoCs on epos evms.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * Rebased to latest 4.3-rc5

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

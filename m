From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2] ARM: dts: AM43XX: Remove min and max voltage values for
 dcdc3
Date: Fri, 2 Jun 2017 14:54:01 +0530
Message-ID: <1496395441-29526-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
Cc: devicetree@vger.kernel.org, j-keerthy@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

dcdc3 supplies to DDR on AM43x series. When we set both
min and max values to the same value. The regulator framework
sets that particular voltage. This is bad as we are changing
the ddr voltage when executing from ddr. Hence remove the min and
max values. The ddr supply voltage shall be set from bootloader
when not executing from ddr and not while executing from kernel.

The previous discussion can be found here:

http://www.spinics.net/lists/devicetree/msg56399.html

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * Corrected $subject

 arch/arm/boot/dts/am437x-gp-evm.dts  | 2 --
 arch/arm/boot/dts/am437x-sk-evm.dts  | 2 --
 arch/arm/boot/dts/am43x-epos-evm.dts | 2 --
 3 files changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 397e98b..29a538e 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -549,8 +549,6 @@
 
 		dcdc3: regulator-dcdc3 {
 			regulator-name = "vdcdc3";
-			regulator-min-microvolt = <1500000>;
-			regulator-max-microvolt = <1500000>;
 			regulator-boot-on;
 			regulator-always-on;
 			regulator-state-mem {
diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index a62e158..2c6bf06 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -451,8 +451,6 @@
 
 		dcdc3: regulator-dcdc3 {
 			regulator-name = "vdds_ddr";
-			regulator-min-microvolt = <1500000>;
-			regulator-max-microvolt = <1500000>;
 			regulator-boot-on;
 			regulator-always-on;
 			regulator-state-mem {
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index f6648ab..54f40f3 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -442,8 +442,6 @@
 
 		dcdc3: regulator-dcdc3 {
 			regulator-name = "vdcdc3";
-			regulator-min-microvolt = <1500000>;
-			regulator-max-microvolt = <1500000>;
 			regulator-boot-on;
 			regulator-always-on;
 		};
-- 
1.9.1

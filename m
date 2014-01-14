From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/3] ARM: dts: OMAP: Add #hwlock-cells property to hwspinlock
 nodes
Date: Mon, 13 Jan 2014 18:26:45 -0600
Message-ID: <1389659207-39445-2-git-send-email-s-anna@ti.com>
References: <1389659207-39445-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1389659207-39445-1-git-send-email-s-anna@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add a new generic property "#hwlock-cells" to the hwspinlock
DT nodes on OMAP4, OMAP5 and AM33xx. This common property allows
different platform implementations to define the args specifier
length. OMAP implementations will always use a value of 1.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 1 +
 arch/arm/boot/dts/omap4.dtsi  | 1 +
 arch/arm/boot/dts/omap5.dtsi  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index f6d8ffe..17a7cc3 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -292,6 +292,7 @@
 			compatible = "ti,omap4-hwspinlock";
 			reg = <0x480ca000 0x1000>;
 			ti,hwmods = "spinlock";
+			#hwlock-cells = <1>;
 		};
 
 		wdt2: wdt@44e35000 {
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index a1e0585..246780d 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -261,6 +261,7 @@
 			compatible = "ti,omap4-hwspinlock";
 			reg = <0x4a0f6000 0x1000>;
 			ti,hwmods = "spinlock";
+			#hwlock-cells = <1>;
 		};
 
 		i2c1: i2c@48070000 {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index fc3fad5..adb71af 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -291,6 +291,7 @@
 			compatible = "ti,omap4-hwspinlock";
 			reg = <0x4a0f6000 0x1000>;
 			ti,hwmods = "spinlock";
+			#hwlock-cells = <1>;
 		};
 
 		mcspi1: spi@48098000 {
-- 
1.8.4.3

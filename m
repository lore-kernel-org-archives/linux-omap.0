From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH-next 2/4] arm: boot: dts: am4372: add ARM timers and SCU nodes
Date: Wed, 12 Aug 2015 14:56:54 -0500
Message-ID: <1439409416-32673-3-git-send-email-balbi@ti.com>
References: <1439409416-32673-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1439409416-32673-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

AM437x devices sport SCU, TWD and Global timers,
let's add them to DTS so they have a chance to
probe and be used by Linux.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 51feccfa0e0a..7dfc9d8bd003 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -64,6 +64,27 @@
 		interrupt-parent = <&gic>;
 	};
 
+	scu: scu@48240000 {
+		compatible = "arm,cortex-a9-scu";
+		reg = <0x48240000 0x100>;
+	};
+
+	global_timer: timer@48240200 {
+		compatible = "arm,cortex-a9-global-timer";
+		reg = <0x48240200 0x100>;
+		interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&dpll_mpu_m2_ck>;
+	};
+
+	local_timer: timer@48240600 {
+		compatible = "arm,cortex-a9-twd-timer";
+		reg = <0x48240600 0x100>;
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&dpll_mpu_m2_ck>;
+	};
+
 	l2-cache-controller@48242000 {
 		compatible = "arm,pl310-cache";
 		reg = <0x48242000 0x1000>;
-- 
2.5.0

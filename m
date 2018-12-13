From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] ARM: dts: Configure wlcore wakeirq for pandaboard
Date: Thu, 13 Dec 2018 15:04:10 -0800
Message-ID: <20181213230411.5009-2-tony@atomide.com>
References: <20181213230411.5009-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181213230411.5009-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

With wlcore supporting optional wakeirqs, we can configure it
for pandaboard. This makes ssh connection usable with the SoC
entering deeper idle states.

Note that pandaboard already has a wakeirq configured for SDIO
dat1 pin although that is not currently used by wlcore.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -485,8 +485,10 @@
 	wlcore: wlcore@2 {
 		compatible = "ti,wl1271";
 		reg = <2>;
-		interrupt-parent = <&gpio2>;
-		interrupts = <21 IRQ_TYPE_EDGE_RISING>; /* gpio 53 */
+		/* gpio_53 with gpmc_ncs3 pad as wakeup */
+		interrupts-extended = <&gpio2 21 IRQ_TYPE_EDGE_RISING>,
+				      <&omap4_pmx_core 0x3a>;
+		interrupt-names = "irq", "wakeup";
 		ref-clock-frequency = <38400000>;
 	};
 };
-- 
2.19.2

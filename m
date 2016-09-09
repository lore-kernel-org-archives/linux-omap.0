From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Configure panda SDIO WLAN wakeirq
Date: Fri,  9 Sep 2016 14:00:37 -0700
Message-ID: <20160909210037.19090-1-tony@atomide.com>
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
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Otherwise we have delays on noticing interrupts from the
WLAN card when idle.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -446,6 +446,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&wl12xx_pins>;
 	vmmc-supply = <&wl12xx_vmmc>;
+	interrupts-extended = <&wakeupgen GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH
+			       &omap4_pmx_core 0x10e>;
 	non-removable;
 	bus-width = <4>;
 	cap-power-off-card;
-- 
2.9.3

From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 07/15] ARM: dts: dra7-evm: Remove mmc specific pinmux
Date: Tue, 6 Feb 2018 18:27:58 +0530
Message-ID: <20180206125806.19350-8-kishon@ti.com>
References: <20180206125806.19350-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180206125806.19350-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

mmc specific pinmux is selected from dra74x-mmc-iodelay.dtsi, so remove
it in dra7-evm.dts

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index a7385c338ee9..a2769115c8a5 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -87,33 +87,6 @@
 			DRA7XX_CORE_IOPAD(0x3818, MUX_MODE15 | PULL_UP)	/* wakeup0.off */
 		>;
 	};
-
-	mmc1_pins_default: mmc1_pins_default {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x376c, PIN_INPUT | MUX_MODE14)	/* mmc1sdcd.gpio219 */
-			DRA7XX_CORE_IOPAD(0x3754, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_clk.clk */
-			DRA7XX_CORE_IOPAD(0x3758, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_cmd.cmd */
-			DRA7XX_CORE_IOPAD(0x375c, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat0.dat0 */
-			DRA7XX_CORE_IOPAD(0x3760, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat1.dat1 */
-			DRA7XX_CORE_IOPAD(0x3764, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat2.dat2 */
-			DRA7XX_CORE_IOPAD(0x3768, PIN_INPUT_PULLUP | MUX_MODE0) /* mmc1_dat3.dat3 */
-		>;
-	};
-
-	mmc2_pins_default: mmc2_pins_default {
-		pinctrl-single,pins = <
-			DRA7XX_CORE_IOPAD(0x349c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a23.mmc2_clk */
-			DRA7XX_CORE_IOPAD(0x34b0, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_cs1.mmc2_cmd */
-			DRA7XX_CORE_IOPAD(0x34a0, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a24.mmc2_dat0 */
-			DRA7XX_CORE_IOPAD(0x34a4, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a25.mmc2_dat1 */
-			DRA7XX_CORE_IOPAD(0x34a8, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a26.mmc2_dat2 */
-			DRA7XX_CORE_IOPAD(0x34ac, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a27.mmc2_dat3 */
-			DRA7XX_CORE_IOPAD(0x348c, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a19.mmc2_dat4 */
-			DRA7XX_CORE_IOPAD(0x3490, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a20.mmc2_dat5 */
-			DRA7XX_CORE_IOPAD(0x3494, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a21.mmc2_dat6 */
-			DRA7XX_CORE_IOPAD(0x3498, PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_a22.mmc2_dat7 */
-		>;
-	};
 };
 
 &i2c1 {
-- 
2.11.0

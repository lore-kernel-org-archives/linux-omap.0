From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 05/15] ARM: dts: dra76-evm: Add pinctrl data for higher
 speed MMC/SD modes
Date: Tue, 6 Feb 2018 18:27:56 +0530
Message-ID: <20180206125806.19350-6-kishon@ti.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Sekhar Nori <nsekhar@ti.com>

The SD card interface on DRA76x EVM can support
high speed SD cards. The eMMC onboard can support
upto HS200 mode.

Enable support for these higher speed modes in the
device-tree file.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra76-evm.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra76-evm.dts b/arch/arm/boot/dts/dra76-evm.dts
index 70854be0ce6a..088853001c81 100644
--- a/arch/arm/boot/dts/dra76-evm.dts
+++ b/arch/arm/boot/dts/dra76-evm.dts
@@ -314,16 +314,20 @@
 	 * is always hardwired.
 	 */
 	cd-gpios = <&gpio6 27 GPIO_ACTIVE_LOW>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "hs";
 	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_hs>;
 };
 
 &mmc2 {
 	status = "okay";
 	vmmc-supply = <&vio_1v8>;
 	bus-width = <8>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "hs", "ddr_1_8v", "hs200_1_8v";
 	pinctrl-0 = <&mmc2_pins_default>;
+	pinctrl-1 = <&mmc2_pins_default>;
+	pinctrl-2 = <&mmc2_pins_default>;
+	pinctrl-3 = <&mmc2_pins_hs200 &mmc2_iodelay_hs200_conf>;
 };
 
 /* No RTC on this device */
-- 
2.11.0

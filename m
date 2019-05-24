From: Teresa Remmet <t.remmet@phytec.de>
Subject: [PATCH 4/7] ARM: dts: am335x-phycore-som: Enable gpmc node in dts
 files
Date: Fri, 24 May 2019 15:20:00 +0200
Message-ID: <1558704003-393769-5-git-send-email-t.remmet@phytec.de>
References: <1558704003-393769-1-git-send-email-t.remmet@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1558704003-393769-1-git-send-email-t.remmet@phytec.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Daniel Schultz <d.schultz@phytec.de>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
List-Id: linux-omap@vger.kernel.org

As nand flash is not always the primary storage device any more
disable it in the phycore-som include file. Enable it the device tree
files where it is populated.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
---
 arch/arm/boot/dts/am335x-phycore-rdk.dts  | 4 ++++
 arch/arm/boot/dts/am335x-phycore-som.dtsi | 2 +-
 arch/arm/boot/dts/am335x-wega-rdk.dts     | 4 ++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-phycore-rdk.dts b/arch/arm/boot/dts/am335x-phycore-rdk.dts
index 305f0b35d6ea..d674d91e18c7 100644
--- a/arch/arm/boot/dts/am335x-phycore-rdk.dts
+++ b/arch/arm/boot/dts/am335x-phycore-rdk.dts
@@ -13,6 +13,10 @@
 #include "am335x-pcm-953.dtsi"
 
 /* SoM */
+&gpmc {
+	status = "okay";
+};
+
 &i2c_eeprom {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 2bc2265534e1..adf04dbefe28 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -190,7 +190,7 @@
 };
 
 &gpmc {
-	status = "okay";
+	status = "disabled";
 	pinctrl-names = "default";
 	pinctrl-0 = <&nandflash_pins>;
 	ranges = <0 0 0x08000000 0x1000000>;   /* CS0: NAND */
diff --git a/arch/arm/boot/dts/am335x-wega-rdk.dts b/arch/arm/boot/dts/am335x-wega-rdk.dts
index 6431b7db8109..fd8a844ba780 100644
--- a/arch/arm/boot/dts/am335x-wega-rdk.dts
+++ b/arch/arm/boot/dts/am335x-wega-rdk.dts
@@ -13,6 +13,10 @@
 #include "am335x-wega.dtsi"
 
 /* SoM */
+&gpmc {
+	status = "okay";
+};
+
 &i2c_eeprom {
 	status = "okay";
 };
-- 
2.7.4

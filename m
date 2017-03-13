From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3/4] ARM: dts: dm8168-evm: add SATA node
Date: Mon, 13 Mar 2017 17:43:18 +0100
Message-ID: <1489423399-3824-4-git-send-email-bgolaszewski@baylibre.com>
References: <1489423399-3824-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1489423399-3824-1-git-send-email-bgolaszewski@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Neil Armstrong <narmstrong@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: devicetree@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add the SATA controller node to the dm8168-evm device tree.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/boot/dts/dm8168-evm.dts | 4 ++++
 arch/arm/boot/dts/dm816x.dtsi    | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/dm8168-evm.dts
index f13e214..547856e 100644
--- a/arch/arm/boot/dts/dm8168-evm.dts
+++ b/arch/arm/boot/dts/dm8168-evm.dts
@@ -179,3 +179,7 @@
 	pinctrl-0 = <&usb1_pins>;
 	mentor,multipoint = <0>;
 };
+
+&sata {
+	clocks = <&sysclk5_ck>, <&sata_refclk>;
+};
diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index 276211e..6131081 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -293,6 +293,13 @@
 			phy-handle = <&phy1>;
 		};
 
+		sata: sata@4a140000 {
+			compatible = "ti,dm816-ahci";
+			reg = <0x4a140000 0xffff>;
+			interrupts = <16>;
+			ti,hwmods = "sata";
+		};
+
 		mcspi1: spi@48030000 {
 			compatible = "ti,omap4-mcspi";
 			reg = <0x48030000 0x1000>;
-- 
2.9.3

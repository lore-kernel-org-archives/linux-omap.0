From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V6 08/15] ARM: dts: dra7-evm: add smps123 supply for CPU
Date: Wed, 9 Oct 2013 18:30:08 -0500
Message-ID: <1381361414-8851-7-git-send-email-nm@ti.com>
References: <1381354144-7134-1-git-send-email-nm@ti.com>
 <1381361414-8851-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1381361414-8851-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@linaro.org>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, J Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: J Keerthy <j-keerthy@ti.com>

regulator smps123 supply from Palmas PMIC powers CPU0 on DRA7 EVM.

[nm@ti.com: rebase to latest]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: J Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts |    4 ++++
 arch/arm/boot/dts/dra7.dtsi    |    2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 3abf5f4..5babba0 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -269,3 +269,7 @@
 	vmmc-supply = <&mmc2_3v3>;
 	bus-width = <8>;
 };
+
+&cpu0 {
+	cpu0-supply = <&smps123_reg>;
+};
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index c98997b..02e430b 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -32,7 +32,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0>;
-- 
1.7.9.5

From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH v2 2/8] ARM: dts: tps65217: Add the charger device
Date: Fri, 28 Oct 2016 21:36:56 +0900
Message-ID: <20161028123702.21849-3-woogyom.kim@gmail.com>
References: <20161028123702.21849-1-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161028123702.21849-1-woogyom.kim@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Support the charger driver and disable it by default.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/tps65217.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/tps65217.dtsi b/arch/arm/boot/dts/tps65217.dtsi
index 27935f8..8f77d0d 100644
--- a/arch/arm/boot/dts/tps65217.dtsi
+++ b/arch/arm/boot/dts/tps65217.dtsi
@@ -16,6 +16,11 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	charger {
+		compatible = "ti,tps65217-charger";
+		status = "disabled";
+	};
+
 	regulators {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.9.3

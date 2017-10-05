From: Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH] ARM: dts: omap3: Replace deprecated mcp prefix
Date: Thu,  5 Oct 2017 09:33:57 +0200
Message-ID: <20171005073357.9427-1-poeschel@lemonage.de>
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
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Lars Poeschel <poeschel@lemonage.de>
List-Id: linux-omap@vger.kernel.org

The devicetree prefix mcp is deprecated in favour of microchip. Thus
this replaces mcp with microchip for the mcp23017 gpio expander chip.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index fa611a5e4850..343a36d8031d 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -257,7 +257,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c3_pins>;
 		gpiom1: gpio@20 {
-			compatible = "mcp,mcp23017";
+			compatible = "microchip,mcp23017";
 			gpio-controller;
 			#gpio-cells = <2>;
 			reg = <0x20>;
-- 
2.14.2

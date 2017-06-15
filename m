From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: [RESEND PATCH v6 4/8] ARM: dts: n8x0: Add vendor prefix to retu node
Date: Thu, 15 Jun 2017 20:49:24 +0200
Message-ID: <20170615184928.12007-5-javier@dowhile0.org>
References: <20170615184928.12007-1-javier@dowhile0.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170615184928.12007-1-javier@dowhile0.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Javier Martinez Canillas <javier@dowhile0.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The retu device node doesn't have a vendor prefix
in its compatible string, fix it by adding one.

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Acked-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Wolfram Sang <wsa@the-dreams.de>

---

Changes in v6:
- Add Wolfram Sang's Reviewed-by tag.

Changes in v5:
- Add Rob Herring's Acked-by tag.
- Add Aaro Koskinen's Acked-by tag.
- Add Acked-by: Tony Lindgren <tony@atomide.com>'s Acked-by tag.

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/omap2420-n8x0-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
index 1b06430c8013..91886231e5a8 100644
--- a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
+++ b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
@@ -16,7 +16,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			retu: retu@1 {
-				compatible = "retu";
+				compatible = "nokia,retu";
 				interrupt-parent = <&gpio4>;
 				interrupts = <12 IRQ_TYPE_EDGE_RISING>;
 				reg = <0x1>;
-- 
2.9.3

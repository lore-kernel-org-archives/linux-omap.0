From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/3] ARM: dts: overo: fix gpmc nand cs0 range
Date: Sun, 24 Jul 2016 14:10:59 +0200
Message-ID: <1469362260-20066-3-git-send-email-johan@kernel.org>
References: <1469362260-20066-1-git-send-email-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469362260-20066-1-git-send-email-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Roger Quadros <rogerq@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-omap@vger.kernel.org

The gpmc ranges property for NAND at CS0 has been broken since it was
first added.

This currently prevents the nand gpmc child node from being probed:

	omap-gpmc 6e000000.gpmc: /ocp/gpmc@6e000000/nand@0,0 has
	malformed 'reg' property

and consequently the NAND device from being registered.

Fixes: 98ce6007efb4 ("ARM: dts: overo: Support PoP NAND")
Cc: stable <stable@vger.kernel.org>	# 4.3
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 arch/arm/boot/dts/omap3-overo-base.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
index de256fa8da48..b15c435439fb 100644
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -223,7 +223,7 @@
 };
 
 &gpmc {
-	ranges = <0 0 0x00000000 0x20000000>;
+	ranges = <0 0 0x30000000 0x1000000>;	/* CS0 */
 
 	nand@0,0 {
 		compatible = "ti,omap2-nand";
-- 
2.7.3

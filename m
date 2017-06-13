From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2 1/5] ARM: dts: omap4: Fix aes entry
Date: Tue, 13 Jun 2017 11:28:43 +0200
Message-ID: <20170613092847.16732-2-sebastian.reichel@collabora.co.uk>
References: <20170613092847.16732-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170613092847.16732-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

OMAP4 has a second aes module, so let's use proper name for
the first instance.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/omap4.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 578c53f08309..589690e034d3 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -900,9 +900,9 @@
 			ctrl-module = <&omap_control_usbotg>;
 		};
 
-		aes: aes@4b501000 {
+		aes1: aes@4b501000 {
 			compatible = "ti,omap4-aes";
-			ti,hwmods = "aes";
+			ti,hwmods = "aes1";
 			reg = <0x4b501000 0xa0>;
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&sdma 111>, <&sdma 110>;
-- 
2.11.0

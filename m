From: Omar Ramirez Luna <omar.luna@linaro.org>
Subject: [PATCH v2 2/2] arm/dts: OMAP2+: Add mailbox nodes
Date: Wed, 12 Sep 2012 19:08:15 -0500
Message-ID: <1347494898-16671-3-git-send-email-omar.luna@linaro.org>
References: <1347494898-16671-1-git-send-email-omar.luna@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1347494898-16671-1-git-send-email-omar.luna@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Omar Ramirez Luna <omar.luna@linaro.org>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add nodes for mailbox DT, to interface with hwmods.

Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>
Acked-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/omap2.dtsi |    5 +++++
 arch/arm/boot/dts/omap3.dtsi |    5 +++++
 arch/arm/boot/dts/omap4.dtsi |    5 +++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index 581cb08..372d55a 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -48,6 +48,11 @@
 			reg = <0x480FE000 0x1000>;
 		};
 
+		mailbox: mailbox@48094000 {
+			compatible = "ti,omap2-mailbox";
+			ti,hwmods = "mailbox";
+		};
+
 		uart1: serial@4806a000 {
 			compatible = "ti,omap2-uart";
 			ti,hwmods = "uart1";
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 8109471..ce68604 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -168,6 +168,11 @@
 			ti,hwmods = "i2c3";
 		};
 
+		mailbox: mailbox@48094000 {
+			compatible = "ti,omap3-mailbox";
+			ti,hwmods = "mailbox";
+		};
+
 		mcspi1: spi@48098000 {
 			compatible = "ti,omap2-mcspi";
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 04cbbcb..6677d80 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -210,6 +210,11 @@
 			ti,hwmods = "i2c4";
 		};
 
+		mailbox: mailbox@4a0f4000 {
+			compatible = "ti,omap4-mailbox";
+			ti,hwmods = "mailbox";
+		};
+
 		mcspi1: spi@48098000 {
 			compatible = "ti,omap4-mcspi";
 			#address-cells = <1>;
-- 
1.7.9.5

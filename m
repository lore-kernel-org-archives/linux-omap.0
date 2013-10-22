From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 2/2] DTS: ARM: OMAP3-N900: Add bq27200 battery monitor
Date: Tue, 22 Oct 2013 14:56:17 +0200
Message-ID: <1382446577-28270-2-git-send-email-sre@debian.org>
References: <1382446577-28270-1-git-send-email-sre@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382446577-28270-1-git-send-email-sre@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Russell King <linux@arm.linux.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@debian.org>
List-Id: linux-omap@vger.kernel.org

Support the bq27200 battery monitor chip.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/omap3-n900.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 60cb33f..992338c 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -240,6 +240,11 @@
 	pinctrl-0 = <&i2c2_pins>;
 
 	clock-frequency = <100000>;
+
+	bq27200: bq27200@55 {
+		compatible = "ti,bq27200";
+		reg = <0x55>;
+	};
 };
 
 &i2c3 {
-- 
1.8.4.rc3

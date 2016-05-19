From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/2] ARM: dts: am335x-icev2: Add DT node for TI PCA9536
Date: Thu, 19 May 2016 12:17:30 +0530
Message-ID: <1463640450-16762-3-git-send-email-vigneshr@ti.com>
References: <1463640450-16762-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463640450-16762-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

AM335x ICE board has a TI PCA9536 chip connected to I2C0 at address
0x41. Add DT entry for the same.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/am335x-icev2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index e271013e78a6..7d8b8fefdf08 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -206,6 +206,13 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	pca9536: gpio@41 {
+		compatible = "ti,pca9536";
+		reg = <0x41>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 #include "tps65910.dtsi"
-- 
2.8.2

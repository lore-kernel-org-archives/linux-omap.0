From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH v2] ARM: dts: add core2 padconf region for am3517
Date: Mon, 11 May 2015 18:02:13 +0300
Message-ID: <1431356533-7737-1-git-send-email-andrej.skvortzov@gmail.com>
References: <554FF488.5090805@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <554FF488.5090805@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
List-Id: linux-omap@vger.kernel.org

According to the technical reference manual for AM35xx system
controller module (SCM) PADCONFS core registers are divided in two
regions: 0x48002030..0x48002268 and 0x480025D8..0x480025FC.
First region is the same for all omap3 SoC and is described in
omap3.dtsi.
The second region is the same as in omap34xx and omap35xx.
The patch adds missing description for the second region.
This patch was tested on AM3517.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
v2:
 move omap3_pmx_core2 under l4_core -> scm

 arch/arm/boot/dts/am3517.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index f164dce..99b322e 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -63,6 +63,20 @@
 	};
 };

+&scm {
+	omap3_pmx_core2: pinmux@05D8 {
+		compatible = "ti,omap3-padconf",
+			     "pinctrl-single";
+		reg = <0x05D8 0x24>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		pinctrl-single,register-width = <16>;
+		pinctrl-single,function-mask = <0xff1f>;
+	};
+};
+
 &iva {
 	status = "disabled";
 };
-- 
2.1.4

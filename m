From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 3/7] ARM: dts: am335x-icev2: Add ADC support
Date: Fri, 7 Oct 2016 09:44:24 -0500
Message-ID: <20161007144428.16671-3-afd@ti.com>
References: <20161007144428.16671-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161007144428.16671-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

7 of the 8 ADC inputs on the am335x are connected to the Industrial I/O
header, add this here.

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/am335x-icev2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index fa3f5dc..1463df3 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -244,6 +244,13 @@
 	};
 };
 
+&tscadc {
+	status = "okay";
+	adc {
+		ti,adc-channels = <1 2 3 4 5 6 7>;
+	};
+};
+
 #include "tps65910.dtsi"
 
 &tps {
-- 
2.10.0

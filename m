From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 15/32] ARM: dts: omap3-gta04: make use of input event include file and constants
Date: Wed, 25 Jul 2018 08:58:47 +0200
Message-ID: <7e3a7135427dc9e301c1df92288c2c5f90443c97.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
In-Reply-To: <cover.1532501910.git.hns@goldelico.com>
References: <cover.1532501910.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

we can replace magic numbers by symbolic constants now.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 036a25afd003..5bf95e04392b 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -10,6 +10,7 @@
 /dts-v1/;
 
 #include "omap36xx.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "OMAP3 GTA04";
@@ -43,7 +44,7 @@
 
 		aux-button {
 			label = "aux";
-			linux,code = <169>;
+			linux,code = <KEY_PHONE>;
 			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 			wakeup-source;
 		};
-- 
2.12.2

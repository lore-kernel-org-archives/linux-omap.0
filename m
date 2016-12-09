From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH 2/4] dt-bindings: mfd: Remove TPS65217 interrupts
Date: Fri,  9 Dec 2016 15:28:31 +0900
Message-ID: <20161209062833.5768-3-woogyom.kim@gmail.com>
References: <20161209062833.5768-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161209062833.5768-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-omap@vger.kernel.org

Interrupt numbers are from the datasheet, so no need to keep them in
the ABI. Use the number in the DT file.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi |  8 +++-----
 include/dt-bindings/mfd/tps65217.h        | 26 --------------------------
 2 files changed, 3 insertions(+), 31 deletions(-)
 delete mode 100644 include/dt-bindings/mfd/tps65217.h

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 14b6269..3e32dd1 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -6,8 +6,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <dt-bindings/mfd/tps65217.h>
-
 / {
 	cpus {
 		cpu@0 {
@@ -319,13 +317,13 @@
 	ti,pmic-shutdown-controller;
 
 	charger {
-		interrupts = <TPS65217_IRQ_AC>, <TPS65217_IRQ_USB>;
-		interrupt-names = "AC", "USB";
+		interrupts = <0>, <1>;
+		interrupt-names = "USB", "AC";
 		status = "okay";
 	};
 
 	pwrbutton {
-		interrupts = <TPS65217_IRQ_PB>;
+		interrupts = <2>;
 		status = "okay";
 	};
 
diff --git a/include/dt-bindings/mfd/tps65217.h b/include/dt-bindings/mfd/tps65217.h
deleted file mode 100644
index cafb9e6..0000000
--- a/include/dt-bindings/mfd/tps65217.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * This header provides macros for TI TPS65217 DT bindings.
- *
- * Copyright (C) 2016 Texas Instruments
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef __DT_BINDINGS_TPS65217_H__
-#define __DT_BINDINGS_TPS65217_H__
-
-#define TPS65217_IRQ_USB	0
-#define TPS65217_IRQ_AC		1
-#define TPS65217_IRQ_PB		2
-
-#endif
-- 
2.9.3

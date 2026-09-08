Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93B85616D8;
	Tue,  8 Sep 2026 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881459; cv=none; b=P1TxYd4UANllAJWTC+UI5g4bTVx0ftAuWTRmDRKvsb5ktIN1aWG9IFz3YjBCWQoB5tDvEGsjU21MxpFBBghXy2PEOdjUVxJiv9JsPocdv5GLpZS5/onLXmomJWRI1oIk5QxU8RBxeyYPBNH+KRowoZC2CKV1p2upT3uY1ilkF7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881459; c=relaxed/simple;
	bh=nokVSh8HyQaXYcJYhvDvNv4Q9k7WQeg9InsaY8GIXkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hqw11bkWnhuBesZMJQTCynH3EPq9piB+xMIll1KeoFLwdBs+DwIe07zTXEFdCgHV4Pd2++gL/YRExDTcIqIvFhuz2o5w9gGwCrgA9Ne/hHd5Ln3SzgnJWvxU9ZotYiCY/HMgacBpYDKUvmLfS6RoyS3XRQO615IpXtMqKMQD7TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BClr5dzI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BClr5dzI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BFB1F00A3A;
	Tue,  8 Sep 2026 15:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788881445;
	bh=0BgL3MA5QAgGe0A9kVB0GaQhxC645f2tXU2xAfcebi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BClr5dzIrG4JMoILjWCxRiY2iETsFgUxzeNV52mLKh/W3VcX/4bv9hm9uQMIi0sJy
	 B7wLhdSC55nPd0I8mpQH6m9aUIDvTsHqeZWhjIODqkdZQ6NYKj3X05ZCNyoEVUpm3L
	 Vcr35o1KquPg9TCjN/T7v8HG/NrUcCCBm7Dxg/4EZ1eS87mkhGOieayxbIpijPEK6N
	 dlrGyly/Pri4yLqF5vWxrWZVe24FexRb7jMdX418wtLsRLL+2rHODEfbL6GGN9ndQR
	 n9icnzq+Otx+IVxSS7DOTxG83O0CLRfqBRaBoFWZYXdMtep2bui/xVfz4QjyQQ4zIT
	 1omghfBx/Oe1A==
From: Arnd Bergmann <arnd@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Linus Walleij <linusw@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: Drew Fustini <fustini@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Stefan Agner <stefan@agner.ch>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Kristoffer Ericson <kristoffer.ericson@gmail.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-omap@vger.kernel.org,
	Anders Berg <anders.berg@lsi.com>
Subject: [PATCH 13/13] ARM: axxia: remove entire platform
Date: Tue,  8 Sep 2026 17:28:03 +0200
Message-ID: <20260908152808.3928630-14-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908152808.3928630-1-arnd@kernel.org>
References: <20260908152808.3928630-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The initial Axxia port was contributed by LSI in 2014, but never completed
after the sale of the business unit to Intel, which kept supporting the
bulk of the drivers in their own downstream BSP.

The downstream work has also ended now, and there is no realistic chance
that anyone would rewrite it all into an upstreamable port.

Remove it now that the 7.3LTS release is out and can be used as the
base for one more downstream rebase of the downstream patches if needed.

Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Anders Berg <anders.berg@lsi.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../devicetree/bindings/arm/axxia.yaml        |  23 --
 MAINTAINERS                                   |   8 -
 arch/arm/Kconfig                              |   2 -
 arch/arm/Makefile                             |   2 -
 arch/arm/boot/dts/intel/Makefile              |   1 -
 arch/arm/boot/dts/intel/axm/Makefile          |   5 -
 .../boot/dts/intel/axm/axm5516-amarillo.dts   |  47 ----
 arch/arm/boot/dts/intel/axm/axm5516-cpus.dtsi | 200 ---------------
 arch/arm/boot/dts/intel/axm/axm55xx.dtsi      | 200 ---------------
 arch/arm/configs/axm55xx_defconfig            | 231 ------------------
 arch/arm/mach-axxia/Kconfig                   |  17 --
 arch/arm/mach-axxia/Makefile                  |   3 -
 arch/arm/mach-axxia/axxia.c                   |  19 --
 arch/arm/mach-axxia/platsmp.c                 |  87 -------
 14 files changed, 845 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/axxia.yaml
 delete mode 100644 arch/arm/boot/dts/intel/axm/Makefile
 delete mode 100644 arch/arm/boot/dts/intel/axm/axm5516-amarillo.dts
 delete mode 100644 arch/arm/boot/dts/intel/axm/axm5516-cpus.dtsi
 delete mode 100644 arch/arm/boot/dts/intel/axm/axm55xx.dtsi
 delete mode 100644 arch/arm/configs/axm55xx_defconfig
 delete mode 100644 arch/arm/mach-axxia/Kconfig
 delete mode 100644 arch/arm/mach-axxia/Makefile
 delete mode 100644 arch/arm/mach-axxia/axxia.c
 delete mode 100644 arch/arm/mach-axxia/platsmp.c

diff --git a/Documentation/devicetree/bindings/arm/axxia.yaml b/Documentation/devicetree/bindings/arm/axxia.yaml
deleted file mode 100644
index d60907e43efc..000000000000
--- a/Documentation/devicetree/bindings/arm/axxia.yaml
+++ /dev/null
@@ -1,23 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/arm/axxia.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Axxia AXM55xx
-
-maintainers:
-  - Anders Berg <anders.berg@lsi.com>
-
-properties:
-  $nodename:
-    const: "/"
-  compatible:
-    description: LSI AXM5516 Validation board (Amarillo)
-    items:
-      - const: lsi,axm5516-amarillo
-      - const: lsi,axm5516
-
-additionalProperties: true
-
-...
diff --git a/MAINTAINERS b/MAINTAINERS
index 292327185a08..74657b35c577 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2742,14 +2742,6 @@ F:	Documentation/devicetree/bindings/arm/axiado.yaml
 F:	arch/arm64/boot/dts/axiado/
 N:	axiado
 
-ARM/AXM LSI SOC
-M:	Krzysztof Kozlowski <krzk@kernel.org>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Odd Fixes
-F:	Documentation/devicetree/bindings/arm/axxia.yaml
-F:	arch/arm/boot/dts/intel/axm/
-F:	arch/arm/mach-axxia/
-
 ARM/BITMAIN ARCHITECTURE
 M:	Manivannan Sadhasivam <mani@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cf380b686867..760c4bfcc33a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -353,8 +353,6 @@ source "arch/arm/mach-aspeed/Kconfig"
 
 source "arch/arm/mach-at91/Kconfig"
 
-source "arch/arm/mach-axxia/Kconfig"
-
 source "arch/arm/mach-bcm/Kconfig"
 
 source "arch/arm/mach-berlin/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index d3479e374c6f..f41b3f6ab82e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -164,7 +164,6 @@ textofs-y	:= 0x00008000
 textofs-$(CONFIG_ARCH_REALTEK)  := 0x00108000
 textofs-$(CONFIG_ARCH_QCOM_RESERVE_SMEM) := 0x00208000
 textofs-$(CONFIG_ARCH_MESON) := 0x00208000
-textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
 
 # Machine directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
@@ -173,7 +172,6 @@ machine-$(CONFIG_ARCH_ALPINE)		+= alpine
 machine-$(CONFIG_ARCH_ARTPEC)		+= artpec
 machine-$(CONFIG_ARCH_ASPEED)           += aspeed
 machine-$(CONFIG_ARCH_AT91)		+= at91
-machine-$(CONFIG_ARCH_AXXIA)		+= axxia
 machine-$(CONFIG_ARCH_BCM)		+= bcm
 machine-$(CONFIG_ARCH_BERLIN)		+= berlin
 machine-$(CONFIG_ARCH_CLPS711X)		+= clps711x
diff --git a/arch/arm/boot/dts/intel/Makefile b/arch/arm/boot/dts/intel/Makefile
index c5fc845deb61..3e871d10b7f5 100644
--- a/arch/arm/boot/dts/intel/Makefile
+++ b/arch/arm/boot/dts/intel/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-subdir-y += axm
 subdir-y += ixp
 subdir-y += pxa
 subdir-y += socfpga
diff --git a/arch/arm/boot/dts/intel/axm/Makefile b/arch/arm/boot/dts/intel/axm/Makefile
deleted file mode 100644
index 7c7dc679964d..000000000000
--- a/arch/arm/boot/dts/intel/axm/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_AXXIA) += \
-	axm5516-amarillo.dtb
-dtb-$(CONFIG_ARCH_AXXIA) += \
-	axm5516-amarillo.dtb
diff --git a/arch/arm/boot/dts/intel/axm/axm5516-amarillo.dts b/arch/arm/boot/dts/intel/axm/axm5516-amarillo.dts
deleted file mode 100644
index 2e2ad3c7ee77..000000000000
--- a/arch/arm/boot/dts/intel/axm/axm5516-amarillo.dts
+++ /dev/null
@@ -1,47 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * arch/arm/boot/dts/axm5516-amarillo.dts
- *
- * Copyright (C) 2013 LSI
- */
-
-/dts-v1/;
-
-/memreserve/ 0x00000000 0x00400000;
-
-#include "axm55xx.dtsi"
-#include "axm5516-cpus.dtsi"
-
-/ {
-	model = "Amarillo AXM5516";
-	compatible = "lsi,axm5516-amarillo", "lsi,axm5516";
-
-	memory {
-		device_type = "memory";
-		reg = <0 0x00000000 0x02 0x00000000>;
-	};
-};
-
-&serial0 {
-	status = "okay";
-};
-
-&serial1 {
-	status = "okay";
-};
-
-&serial2 {
-	status = "okay";
-};
-
-&serial3 {
-	status = "okay";
-};
-
-&gpio0 {
-	status = "okay";
-};
-
-&gpio1 {
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/intel/axm/axm5516-cpus.dtsi b/arch/arm/boot/dts/intel/axm/axm5516-cpus.dtsi
deleted file mode 100644
index f13ef80b6637..000000000000
--- a/arch/arm/boot/dts/intel/axm/axm5516-cpus.dtsi
+++ /dev/null
@@ -1,200 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * arch/arm/boot/dts/axm5516-cpus.dtsi
- *
- * Copyright (C) 2013 LSI
- */
-
-/ {
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu-map {
-			cluster0 {
-				core0 {
-					cpu = <&CPU0>;
-				};
-				core1 {
-					cpu = <&CPU1>;
-				};
-				core2 {
-					cpu = <&CPU2>;
-				};
-				core3 {
-					cpu = <&CPU3>;
-				};
-			};
-			cluster1 {
-				core0 {
-					cpu = <&CPU4>;
-				};
-				core1 {
-					cpu = <&CPU5>;
-				};
-				core2 {
-					cpu = <&CPU6>;
-				};
-				core3 {
-					cpu = <&CPU7>;
-				};
-			};
-			cluster2 {
-				core0 {
-					cpu = <&CPU8>;
-				};
-				core1 {
-					cpu = <&CPU9>;
-				};
-				core2 {
-					cpu = <&CPU10>;
-				};
-				core3 {
-					cpu = <&CPU11>;
-				};
-			};
-			cluster3 {
-				core0 {
-					cpu = <&CPU12>;
-				};
-				core1 {
-					cpu = <&CPU13>;
-				};
-				core2 {
-					cpu = <&CPU14>;
-				};
-				core3 {
-					cpu = <&CPU15>;
-				};
-			};
-		};
-
-		CPU0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x00>;
-			clock-frequency = <1400000000>;
-			cpu-release-addr = <0>; // Fixed by the boot loader
-		};
-
-		CPU1: cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x01>;
-			clock-frequency = <1400000000>;
-			cpu-release-addr = <0>; // Fixed by the boot loader
-		};
-
-		CPU2: cpu@2 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x02>;
-			clock-frequency = <1400000000>;
-			cpu-release-addr = <0>; // Fixed by the boot loader
-		};
-
-		CPU3: cpu@3 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x03>;
-			clock-frequency = <1400000000>;
-			cpu-release-addr = <0>; // Fixed by the boot loader
-		};
-
-		CPU4: cpu@100 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x100>;
-			clock-frequency = <1400000000>;
-			cpu-release-addr = <0>; // Fixed by the boot loader
-		};
-
-		CPU5: cpu@101 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x101>;
-			clock-frequency = <1400000000>;
-			cpu-release-addr = <0>; // Fixed by the boot loader
-		};
-
-		CPU6: cpu@102 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x102>;
-			clock-frequency = <1400000000>;
-			cpu-release-addr = <0>; // Fixed by the boot loader
-		};
-
-		CPU7: cpu@103 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x103>;
-			clock-frequency = <1400000000>;
-			cpu-release-addr = <0>; // Fixed by the boot loader
-		};
-
-		CPU8: cpu@200 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x200>;
-			clock-frequency = <1400000000>;
-			cpu-release-addr = <0>; // Fixed by the boot loader
-		};
-
-		CPU9: cpu@201 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x201>;
-			clock-frequency = <1400000000>;
-			cpu-release-addr = <0>; // Fixed by the boot loader
-		};
-
-		CPU10: cpu@202 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x202>;
-			clock-frequency = <1400000000>;
-			cpu-release-addr = <0>; // Fixed by the boot loader
-		};
-
-		CPU11: cpu@203 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x203>;
-			clock-frequency = <1400000000>;
-			cpu-release-addr = <0>; // Fixed by the boot loader
-		};
-
-		CPU12: cpu@300 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x300>;
-			clock-frequency = <1400000000>;
-			cpu-release-addr = <0>; // Fixed by the boot loader
-		};
-
-		CPU13: cpu@301 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x301>;
-			clock-frequency = <1400000000>;
-			cpu-release-addr = <0>; // Fixed by the boot loader
-		};
-
-		CPU14: cpu@302 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x302>;
-			clock-frequency = <1400000000>;
-			cpu-release-addr = <0>; // Fixed by the boot loader
-		};
-
-		CPU15: cpu@303 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x303>;
-			clock-frequency = <1400000000>;
-			cpu-release-addr = <0>; // Fixed by the boot loader
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/intel/axm/axm55xx.dtsi b/arch/arm/boot/dts/intel/axm/axm55xx.dtsi
deleted file mode 100644
index 5277890cfad2..000000000000
--- a/arch/arm/boot/dts/intel/axm/axm55xx.dtsi
+++ /dev/null
@@ -1,200 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * arch/arm/boot/dts/axm55xx.dtsi
- *
- * Copyright (C) 2013 LSI
- */
-
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/clock/lsi,axm5516-clks.h>
-
-/ {
-	#address-cells = <2>;
-	#size-cells = <2>;
-	interrupt-parent = <&gic>;
-
-	aliases {
-		serial0	  = &serial0;
-		serial1   = &serial1;
-		serial2	  = &serial2;
-		serial3	  = &serial3;
-		timer	  = &timer0;
-	};
-
-	clocks {
-		compatible = "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		clk_ref0: clk_ref0 {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <125000000>;
-		};
-
-		clk_ref1: clk_ref1 {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <125000000>;
-		};
-
-		clk_ref2: clk_ref2 {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <125000000>;
-		};
-
-		clks: clock-controller@2010020000 {
-			compatible = "lsi,axm5516-clks";
-			#clock-cells = <1>;
-			reg = <0x20 0x10020000 0 0x20000>;
-		};
-	};
-
-	gic: interrupt-controller@2001001000 {
-		compatible = "arm,cortex-a15-gic";
-		#interrupt-cells = <3>;
-		#address-cells = <0>;
-		interrupt-controller;
-		reg = <0x20 0x01001000 0 0x1000>,
-		      <0x20 0x01002000 0 0x2000>,
-		      <0x20 0x01004000 0 0x2000>,
-		      <0x20 0x01006000 0 0x2000>;
-		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) |
-				IRQ_TYPE_LEVEL_HIGH)>;
-	};
-
-	timer {
-		compatible = "arm,armv7-timer";
-		interrupts =
-			<GIC_PPI 13
-				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 14
-				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 11
-				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			<GIC_PPI 10
-				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-	};
-
-
-	pmu {
-		compatible = "arm,cortex-a15-pmu";
-		interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	soc {
-		compatible = "simple-bus";
-		device_type = "soc";
-		#address-cells = <2>;
-		#size-cells = <2>;
-		interrupt-parent = <&gic>;
-		ranges;
-
-		syscon: syscon@2010030000 {
-			compatible = "lsi,axxia-syscon", "syscon";
-			reg = <0x20 0x10030000 0 0x2000>;
-		};
-
-		reset: reset@2010031000 {
-			compatible = "lsi,axm55xx-reset";
-			syscon = <&syscon>;
-		};
-
-		amba {
-			compatible = "simple-bus";
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
-
-			serial0: serial@2010080000 {
-				compatible = "arm,pl011", "arm,primecell";
-				reg = <0x20 0x10080000 0 0x1000>;
-				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks AXXIA_CLK_PER>;
-				clock-names = "apb_pclk";
-				status = "disabled";
-			};
-
-			serial1: serial@2010081000 {
-				compatible = "arm,pl011", "arm,primecell";
-				reg = <0x20 0x10081000 0 0x1000>;
-				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks AXXIA_CLK_PER>;
-				clock-names = "apb_pclk";
-				status = "disabled";
-			};
-
-			serial2: serial@2010082000 {
-				compatible = "arm,pl011", "arm,primecell";
-				reg = <0x20 0x10082000 0 0x1000>;
-				interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks AXXIA_CLK_PER>;
-				clock-names = "apb_pclk";
-				status = "disabled";
-			};
-
-			serial3: serial@2010083000 {
-				compatible = "arm,pl011", "arm,primecell";
-				reg = <0x20 0x10083000 0 0x1000>;
-				interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks AXXIA_CLK_PER>;
-				clock-names = "apb_pclk";
-				status = "disabled";
-			};
-
-			timer0: timer@2010091000 {
-				compatible = "arm,sp804", "arm,primecell";
-				reg = <0x20 0x10091000 0 0x1000>;
-				interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks AXXIA_CLK_PER>;
-				clock-names = "apb_pclk";
-				status = "okay";
-			};
-
-			gpio0: gpio@2010092000 {
-				#gpio-cells = <2>;
-				compatible = "arm,pl061", "arm,primecell";
-				gpio-controller;
-				reg = <0x20 0x10092000 0x00 0x1000>;
-				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks AXXIA_CLK_PER>;
-				clock-names = "apb_pclk";
-				status = "disabled";
-			};
-
-			gpio1: gpio@2010093000 {
-				#gpio-cells = <2>;
-				compatible = "arm,pl061", "arm,primecell";
-				gpio-controller;
-				reg = <0x20 0x10093000 0x00 0x1000>;
-				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks AXXIA_CLK_PER>;
-				clock-names = "apb_pclk";
-				status = "disabled";
-			};
-		};
-	};
-};
-
-/*
-  Local Variables:
-  mode: C
-  End:
-*/
diff --git a/arch/arm/configs/axm55xx_defconfig b/arch/arm/configs/axm55xx_defconfig
deleted file mode 100644
index 541e38e2205b..000000000000
--- a/arch/arm/configs/axm55xx_defconfig
+++ /dev/null
@@ -1,231 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_FHANDLE=y
-CONFIG_AUDIT=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_PREEMPT=y
-CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_BSD_PROCESS_ACCT_V3=y
-CONFIG_TASKSTATS=y
-CONFIG_TASK_DELAY_ACCT=y
-CONFIG_TASK_XACCT=y
-CONFIG_TASK_IO_ACCOUNTING=y
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_LOG_BUF_SHIFT=16
-CONFIG_NAMESPACES=y
-# CONFIG_UTS_NS is not set
-# CONFIG_IPC_NS is not set
-# CONFIG_PID_NS is not set
-# CONFIG_NET_NS is not set
-CONFIG_SCHED_AUTOGROUP=y
-CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_EXPERT=y
-CONFIG_PROFILING=y
-CONFIG_ARCH_AXXIA=y
-CONFIG_ARM_LPAE=y
-CONFIG_ARM_THUMBEE=y
-CONFIG_ARM_ERRATA_430973=y
-CONFIG_ARM_ERRATA_643719=y
-CONFIG_ARM_ERRATA_720789=y
-CONFIG_ARM_ERRATA_754322=y
-CONFIG_ARM_ERRATA_754327=y
-CONFIG_ARM_ERRATA_764369=y
-CONFIG_ARM_ERRATA_775420=y
-CONFIG_ARM_ERRATA_798181=y
-CONFIG_PCIE_AXXIA=y
-CONFIG_SMP=y
-CONFIG_NR_CPUS=16
-CONFIG_HOTPLUG_CPU=y
-CONFIG_HIGHMEM=y
-CONFIG_ARM_APPENDED_DTB=y
-CONFIG_ARM_ATAG_DTB_COMPAT=y
-CONFIG_VFP=y
-CONFIG_NEON=y
-# CONFIG_SUSPEND is not set
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-CONFIG_BINFMT_MISC=y
-# CONFIG_COMPAT_BRK is not set
-CONFIG_KSM=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_XFRM_USER=y
-CONFIG_XFRM_SUB_POLICY=y
-CONFIG_XFRM_MIGRATE=y
-CONFIG_XFRM_STATISTICS=y
-CONFIG_NET_KEY=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_INET_AH=y
-CONFIG_INET_ESP=y
-CONFIG_INET_IPCOMP=y
-# CONFIG_IPV6 is not set
-CONFIG_NETWORK_PHY_TIMESTAMPING=y
-CONFIG_BRIDGE=y
-# CONFIG_WIRELESS is not set
-CONFIG_PCI=y
-CONFIG_PCI_MSI=y
-CONFIG_DEVTMPFS=y
-CONFIG_DEVTMPFS_MOUNT=y
-CONFIG_MTD=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_AFS_PARTS=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_STAA=y
-CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_M25P80=y
-CONFIG_PROC_DEVICETREE=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_EEPROM_AT24=y
-CONFIG_EEPROM_AT25=y
-CONFIG_BLK_DEV_SD=y
-CONFIG_CHR_DEV_SG=y
-CONFIG_ATA=y
-CONFIG_PATA_PLATFORM=y
-CONFIG_PATA_OF_PLATFORM=y
-CONFIG_MD=y
-CONFIG_BLK_DEV_DM=y
-CONFIG_DM_UEVENT=y
-CONFIG_NETDEVICES=y
-CONFIG_TUN=y
-CONFIG_VETH=y
-CONFIG_VIRTIO_NET=y
-# CONFIG_NET_CADENCE is not set
-# CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_CIRRUS is not set
-# CONFIG_NET_VENDOR_FARADAY is not set
-# CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_NATSEMI is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SMSC is not set
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_VIA is not set
-# CONFIG_NET_VENDOR_WIZNET is not set
-CONFIG_BROADCOM_PHY=y
-# CONFIG_WLAN is not set
-# CONFIG_MOUSE_PS2_ALPS is not set
-# CONFIG_MOUSE_PS2_LOGIPS2PP is not set
-# CONFIG_MOUSE_PS2_SYNAPTICS is not set
-# CONFIG_MOUSE_PS2_TRACKPOINT is not set
-# CONFIG_SERIO_SERPORT is not set
-CONFIG_SERIO_AMBAKMI=y
-CONFIG_LEGACY_PTY_COUNT=16
-CONFIG_SERIAL_AMBA_PL011=y
-CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
-CONFIG_VIRTIO_CONSOLE=y
-# CONFIG_HW_RANDOM is not set
-CONFIG_I2C=y
-CONFIG_I2C_CHARDEV=y
-CONFIG_I2C_MUX=y
-CONFIG_I2C_AXXIA=y
-CONFIG_SPI=y
-CONFIG_SPI_PL022=y
-CONFIG_DP83640_PHY=y
-CONFIG_GPIOLIB=y
-CONFIG_GPIO_SYSFS=y
-CONFIG_GPIO_PL061=y
-CONFIG_GPIO_PCA953X=y
-CONFIG_POWER_RESET=y
-CONFIG_POWER_RESET_AXXIA=y
-CONFIG_POWER_SUPPLY=y
-CONFIG_SENSORS_ADT7475=y
-CONFIG_SENSORS_JC42=y
-CONFIG_SENSORS_LM75=y
-CONFIG_PMBUS=y
-CONFIG_SENSORS_LTC2978=y
-CONFIG_WATCHDOG=y
-CONFIG_ARM_SP805_WATCHDOG=y
-# CONFIG_LOGO_LINUX_MONO is not set
-# CONFIG_LOGO_LINUX_VGA16 is not set
-CONFIG_HID_A4TECH=y
-CONFIG_HID_APPLE=y
-CONFIG_HID_BELKIN=y
-CONFIG_HID_CHERRY=y
-CONFIG_HID_CHICONY=y
-CONFIG_HID_CYPRESS=y
-CONFIG_HID_DRAGONRISE=y
-CONFIG_HID_EZKEY=y
-CONFIG_HID_KYE=y
-CONFIG_HID_GYRATION=y
-CONFIG_HID_TWINHAN=y
-CONFIG_HID_KENSINGTON=y
-CONFIG_HID_LOGITECH=y
-CONFIG_HID_MICROSOFT=y
-CONFIG_HID_MONTEREY=y
-CONFIG_HID_NTRIG=y
-CONFIG_HID_ORTEK=y
-CONFIG_HID_PANTHERLORD=y
-CONFIG_HID_PETALYNX=y
-CONFIG_HID_SAMSUNG=y
-CONFIG_HID_SUNPLUS=y
-CONFIG_HID_GREENASIA=y
-CONFIG_HID_SMARTJOYPLUS=y
-CONFIG_HID_TOPSEED=y
-CONFIG_HID_THRUSTMASTER=y
-CONFIG_HID_ZEROPLUS=y
-CONFIG_USB=y
-CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-CONFIG_USB_EHCI_HCD=y
-# CONFIG_USB_EHCI_TT_NEWSCHED is not set
-CONFIG_USB_EHCI_HCD_AXXIA=y
-CONFIG_USB_STORAGE=y
-CONFIG_MMC=y
-CONFIG_MMC_ARMMMCI=y
-CONFIG_DMADEVICES=y
-CONFIG_PL330_DMA=y
-CONFIG_VIRT_DRIVERS=y
-CONFIG_VIRTIO_MMIO=y
-CONFIG_MAILBOX=y
-CONFIG_PL320_MBOX=y
-# CONFIG_IOMMU_SUPPORT is not set
-CONFIG_EXT2_FS=y
-CONFIG_EXT4_FS=y
-CONFIG_AUTOFS_FS=y
-CONFIG_FUSE_FS=y
-CONFIG_CUSE=y
-CONFIG_FSCACHE=y
-CONFIG_FSCACHE_STATS=y
-CONFIG_FSCACHE_HISTOGRAM=y
-CONFIG_FSCACHE_DEBUG=y
-CONFIG_FSCACHE_OBJECT_LIST=y
-CONFIG_CACHEFILES=y
-CONFIG_CACHEFILES_HISTOGRAM=y
-CONFIG_ISO9660_FS=y
-CONFIG_UDF_FS=y
-CONFIG_MSDOS_FS=y
-CONFIG_VFAT_FS=y
-CONFIG_NTFS_FS=y
-CONFIG_TMPFS=y
-CONFIG_JFFS2_FS=y
-CONFIG_CRAMFS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V4=y
-CONFIG_ROOT_NFS=y
-CONFIG_NFS_FSCACHE=y
-CONFIG_SUNRPC_DEBUG=y
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_CRYPTO_XCBC=y
-CONFIG_PRINTK_TIME=y
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
-CONFIG_DEBUG_FS=y
-CONFIG_MAGIC_SYSRQ=y
-# CONFIG_SCHED_DEBUG is not set
-CONFIG_RCU_CPU_STALL_TIMEOUT=60
-# CONFIG_FTRACE is not set
-CONFIG_DEBUG_USER=y
-CONFIG_CRYPTO_GCM=y
-CONFIG_CRYPTO_SHA256=y
diff --git a/arch/arm/mach-axxia/Kconfig b/arch/arm/mach-axxia/Kconfig
deleted file mode 100644
index f773a66c1402..000000000000
--- a/arch/arm/mach-axxia/Kconfig
+++ /dev/null
@@ -1,17 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-config ARCH_AXXIA
-	bool "LSI Axxia platforms (DEPRECATED)"
-	depends on ARCH_MULTI_V7 && ARM_LPAE
-	select ARM_AMBA
-	select ARM_GIC
-	select ARM_TIMER_SP804
-	select HAVE_ARM_ARCH_TIMER
-	select MFD_SYSCON
-	select ZONE_DMA
-	help
-	  This enables support for the LSI Axxia devices.
-
-	  The LSI Axxia platforms require a Flattened Device Tree to be passed
-	  to the kernel.
-
-	  This platform is scheduled for removal in early 2027
diff --git a/arch/arm/mach-axxia/Makefile b/arch/arm/mach-axxia/Makefile
deleted file mode 100644
index 8df8fe76ad47..000000000000
--- a/arch/arm/mach-axxia/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-obj-y				+= axxia.o
-obj-$(CONFIG_SMP)		+= platsmp.o
diff --git a/arch/arm/mach-axxia/axxia.c b/arch/arm/mach-axxia/axxia.c
deleted file mode 100644
index e21582a7fa11..000000000000
--- a/arch/arm/mach-axxia/axxia.c
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Support for the LSI Axxia SoC devices based on ARM cores.
- *
- * Copyright (C) 2012 LSI
- */
-#include <linux/init.h>
-#include <asm/mach/arch.h>
-
-static const char *const axxia_dt_match[] __initconst = {
-	"lsi,axm5516",
-	"lsi,axm5516-sim",
-	"lsi,axm5516-emu",
-	NULL
-};
-
-DT_MACHINE_START(AXXIA_DT, "LSI Axxia AXM55XX")
-	.dt_compat = axxia_dt_match,
-MACHINE_END
diff --git a/arch/arm/mach-axxia/platsmp.c b/arch/arm/mach-axxia/platsmp.c
deleted file mode 100644
index 2e203626eda5..000000000000
--- a/arch/arm/mach-axxia/platsmp.c
+++ /dev/null
@@ -1,87 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * linux/arch/arm/mach-axxia/platsmp.c
- *
- * Copyright (C) 2012 LSI Corporation
- */
-
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/smp.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <asm/cacheflush.h>
-
-/* Syscon register offsets for releasing cores from reset */
-#define SC_CRIT_WRITE_KEY	0x1000
-#define SC_RST_CPU_HOLD		0x1010
-
-/*
- * Write the kernel entry point for secondary CPUs to the specified address
- */
-static void write_release_addr(u32 release_phys)
-{
-	u32 *virt = (u32 *) phys_to_virt(release_phys);
-	writel_relaxed(__pa_symbol(secondary_startup), virt);
-	/* Make sure this store is visible to other CPUs */
-	smp_wmb();
-	__cpuc_flush_dcache_area(virt, sizeof(u32));
-}
-
-static int axxia_boot_secondary(unsigned int cpu, struct task_struct *idle)
-{
-	struct device_node *syscon_np;
-	void __iomem *syscon;
-	u32 tmp;
-
-	syscon_np = of_find_compatible_node(NULL, NULL, "lsi,axxia-syscon");
-	if (!syscon_np)
-		return -ENOENT;
-
-	syscon = of_iomap(syscon_np, 0);
-	of_node_put(syscon_np);
-	if (!syscon)
-		return -ENOMEM;
-
-	tmp = readl(syscon + SC_RST_CPU_HOLD);
-	writel(0xab, syscon + SC_CRIT_WRITE_KEY);
-	tmp &= ~(1 << cpu);
-	writel(tmp, syscon + SC_RST_CPU_HOLD);
-
-	return 0;
-}
-
-static void __init axxia_smp_prepare_cpus(unsigned int max_cpus)
-{
-	int cpu_count = 0;
-	int cpu;
-
-	/*
-	 * Initialise the present map, which describes the set of CPUs actually
-	 * populated at the present time.
-	 */
-	for_each_possible_cpu(cpu) {
-		struct device_node *np;
-		u32 release_phys;
-
-		np = of_get_cpu_node(cpu, NULL);
-		if (!np)
-			continue;
-		if (of_property_read_u32(np, "cpu-release-addr", &release_phys))
-			continue;
-
-		if (cpu_count < max_cpus) {
-			set_cpu_present(cpu, true);
-			cpu_count++;
-		}
-
-		if (release_phys != 0)
-			write_release_addr(release_phys);
-	}
-}
-
-static const struct smp_operations axxia_smp_ops __initconst = {
-	.smp_prepare_cpus	= axxia_smp_prepare_cpus,
-	.smp_boot_secondary	= axxia_boot_secondary,
-};
-CPU_METHOD_OF_DECLARE(axxia_smp, "lsi,syscon-release", &axxia_smp_ops);
-- 
2.53.0


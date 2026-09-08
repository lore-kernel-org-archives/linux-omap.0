Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9B75581E8;
	Tue,  8 Sep 2026 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881441; cv=none; b=unQrPzBrSXPCsjSUvgS+IbYRGIrdVyL6VaRIwhuFCqovPO0MpDFDopJoifVEQO+bUl3VsQnOivOZSRZ29TqVRE/fnDjXc5OHmnGrMDtFcLnSdULuDLP5EVKTRms0bgEMkBdA2//alVrd05sRWFy6xkf7bQTg9WrH5UuiYJh2ATo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881441; c=relaxed/simple;
	bh=6x0RYShN7Qvq55G/ZiPtnTAONO+EoPkxaRKwh3lPRVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDkl+ZYNBdREBey70jPU3Wel2P1Ks1ZkaFZDduT77bcf9w76mdJ4MZVdEgfSnxJ7nnRf5vAv8aroLUOxOHlqFEOAE8Q8+RlWLONtJNbaM7m3sGnHad8qfNcI0Y8zJDwkiQ/rCCW/EPLAYotSW/G1A76yLlh0CGtW3z7ejUqA5x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQ6/5vjk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQ6/5vjk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E76D1F00A3D;
	Tue,  8 Sep 2026 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788881427;
	bh=6uQsElwtEAzpNfoEN+c/AniRleQq7HJPFuOxkkSunLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FQ6/5vjksR2EVs0RDEw/1iPtvW6SrHtllirxmVTifxrpti+/+VQe9+L9LPYsrmj/A
	 F0KxhmJqC0oH2e6ci4zUYciXySsi7YL4zNB3syFCTgipwnbX03kusY7LZPVYRgJ8RZ
	 wShNWLDVAr/X5qMqxNS1Ivk9hYnAlOl5bY2kI3QFuthXeodcGvdVZAK1jZj6EOT+is
	 rm/9uU4PO7S4kL53DmlpJS6AtZ+DScuFsBnnstHFUPTvKOLITXrIaRZpFL9dnlodT7
	 A10PWzxoAsCLXrZd1XiZ2itoq7sHCOKo4WHbb2g7u9mCnucKiGqCj8tZlYdAidMUpV
	 6tn/1zm5M2KhQ==
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
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org
Subject: [PATCH 11/13] ARM: versatile: remove mps2 support
Date: Tue,  8 Sep 2026 17:28:01 +0200
Message-ID: <20260908152808.3928630-12-arnd@kernel.org>
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

The Arm mps2 platform is the reference implementation for Arm
microcontrollers and is useful for testing but not expected to be used
as a production device.

With all the Cortex-M based products gone, there is no longer a need
for a reference platform either, so remove it as well.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-i2c@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                     |  14 --
 arch/arm/boot/dts/arm/Makefile       |   3 -
 arch/arm/boot/dts/arm/mps2-an385.dts |  92 -----------
 arch/arm/boot/dts/arm/mps2-an399.dts |  92 -----------
 arch/arm/boot/dts/arm/mps2.dtsi      | 220 ---------------------------
 arch/arm/configs/mps2_defconfig      | 102 -------------
 arch/arm/mach-versatile/Makefile     |   3 -
 arch/arm/mach-versatile/v2m-mps2.c   |  17 ---
 drivers/i2c/busses/Kconfig           |   2 +-
 9 files changed, 1 insertion(+), 544 deletions(-)
 delete mode 100644 arch/arm/boot/dts/arm/mps2-an385.dts
 delete mode 100644 arch/arm/boot/dts/arm/mps2-an399.dts
 delete mode 100644 arch/arm/boot/dts/arm/mps2.dtsi
 delete mode 100644 arch/arm/configs/mps2_defconfig
 delete mode 100644 arch/arm/mach-versatile/v2m-mps2.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 13b38be3353a..cf380b686867 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -443,20 +443,6 @@ source "arch/arm/mach-zte/Kconfig"
 
 source "arch/arm/mach-zynq/Kconfig"
 
-config ARCH_MPS2
-	bool "ARM MPS2 platform (DEPRECATED)"
-	depends on ARM_SINGLE_ARMV7M
-	select ARM_AMBA
-	select CLKSRC_MPS2
-	help
-	  Support for Cortex-M Prototyping System (or V2M-MPS2) which comes
-	  with a range of available cores like Cortex-M3/M4/M7.
-
-	  Please, note that depends which Application Note is used memory map
-	  for the platform may vary, so adjustment of RAM base might be needed.
-
-	  This platform is scheduled for removal in early 2027
-
 # Definitions to make life easier
 config PLAT_ORION
 	bool
diff --git a/arch/arm/boot/dts/arm/Makefile b/arch/arm/boot/dts/arm/Makefile
index 07ebb64e2cd0..c01593dd197d 100644
--- a/arch/arm/boot/dts/arm/Makefile
+++ b/arch/arm/boot/dts/arm/Makefile
@@ -3,9 +3,6 @@ dtb-$(CONFIG_ARCH_INTEGRATOR) += \
 	integratorap.dtb \
 	integratorap-im-pd1.dtb \
 	integratorcp.dtb
-dtb-$(CONFIG_ARCH_MPS2) += \
-	mps2-an385.dtb \
-	mps2-an399.dtb
 dtb-$(CONFIG_ARCH_REALVIEW) += \
 	arm-realview-pb1176.dtb \
 	arm-realview-pb11mp.dtb \
diff --git a/arch/arm/boot/dts/arm/mps2-an385.dts b/arch/arm/boot/dts/arm/mps2-an385.dts
deleted file mode 100644
index aebbebfc25d1..000000000000
--- a/arch/arm/boot/dts/arm/mps2-an385.dts
+++ /dev/null
@@ -1,92 +0,0 @@
-/*
- * Copyright (C) 2015 ARM Limited
- *
- * Author: Vladimir Murzin <vladimir.murzin@arm.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-/dts-v1/;
-
-#include "mps2.dtsi"
-
-/ {
-	model = "ARM MPS2 Application Note 385/386";
-	compatible = "arm,mps2";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		bootargs = "earlycon";
-		stdout-path = "serial0:9600n8";
-	};
-
-	memory@21000000 {
-		device_type = "memory";
-		reg = <0x21000000 0x1000000>;
-	};
-
-	smb {
-		ethernet@0,0 {
-			compatible = "smsc,lan9220", "smsc,lan9115";
-			reg = <0 0x0 0x10000>;
-			interrupts = <13>;
-			interrupt-parent = <&nvic>;
-			smsc,irq-active-high;
-		};
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
-
-&timer0 {
-	status = "okay";
-};
-
-&timer1 {
-	status = "okay";
-};
-
-&wdt {
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/arm/mps2-an399.dts b/arch/arm/boot/dts/arm/mps2-an399.dts
deleted file mode 100644
index 349abf70b2a5..000000000000
--- a/arch/arm/boot/dts/arm/mps2-an399.dts
+++ /dev/null
@@ -1,92 +0,0 @@
-/*
- * Copyright (C) 2015 ARM Limited
- *
- * Author: Vladimir Murzin <vladimir.murzin@arm.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-/dts-v1/;
-
-#include "mps2.dtsi"
-
-/ {
-	model = "ARM MPS2 Application Note 399/400";
-	compatible = "arm,mps2";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		bootargs = "earlycon";
-		stdout-path = "serial0:9600n8";
-	};
-
-	memory@60000000 {
-		device_type = "memory";
-		reg = <0x60000000 0x1000000>;
-	};
-
-	smb {
-		ethernet@1,0 {
-			compatible = "smsc,lan9220", "smsc,lan9115";
-			reg = <1 0x0 0x10000>;
-			interrupts = <13>;
-			interrupt-parent = <&nvic>;
-			smsc,irq-active-high;
-		};
-	};
-};
-
-&uart0 {
-	status = "okay";
-};
-
-&timer0 {
-	status = "okay";
-};
-
-&timer1 {
-	status = "okay";
-};
-
-&wdt {
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/arm/mps2.dtsi b/arch/arm/boot/dts/arm/mps2.dtsi
deleted file mode 100644
index e240bc8aa605..000000000000
--- a/arch/arm/boot/dts/arm/mps2.dtsi
+++ /dev/null
@@ -1,220 +0,0 @@
-/*
- * Copyright (C) 2015 ARM Limited
- *
- * Author: Vladimir Murzin <vladimir.murzin@arm.com>
- *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
- */
-
-#include "../armv7-m.dtsi"
-
-/ {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	oscclk0: clock-50000000 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <50000000>;
-	};
-
-	oscclk1: clock-24576000 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <24576000>;
-	};
-
-	oscclk2: clock-25000000 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <25000000>;
-	};
-
-	cfgclk: clock-5000000 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <5000000>;
-	};
-
-	spicfgclk: clock-75000000 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <75000000>;
-	};
-
-	sysclk: spiclcd: spicon: i2cclcd: i2caud: clock-sys {
-		compatible = "fixed-factor-clock";
-		clocks = <&oscclk0>;
-		#clock-cells = <0>;
-		clock-div = <2>;
-		clock-mult = <1>;
-	};
-
-	audmclk: clk-12388000 {
-		compatible = "fixed-factor-clock";
-		clocks = <&oscclk1>;
-		#clock-cells = <0>;
-		clock-div = <2>;
-		clock-mult = <1>;
-	};
-
-	audsclk: clk-3072000 {
-		compatible = "fixed-factor-clock";
-		clocks = <&oscclk1>;
-		#clock-cells = <0>;
-		clock-div = <8>;
-		clock-mult = <1>;
-	};
-
-	soc {
-		compatible = "simple-bus";
-		ranges;
-
-		apb@40000000 {
-			compatible = "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0x40000000 0x10000>;
-
-			timer0: mps2-timer0@0 {
-				compatible = "arm,mps2-timer";
-				reg = <0x0 0x1000>;
-				interrupts = <8>;
-				clocks = <&sysclk>;
-				status = "disabled";
-			};
-
-			timer1: mps2-timer1@1000 {
-				compatible = "arm,mps2-timer";
-				reg = <0x1000 0x1000>;
-				interrupts = <9>;
-				clocks = <&sysclk>;
-				status = "disabled";
-			};
-
-			timer2: dual-timer@2000 {
-				compatible = "arm,sp804", "arm,primecell";
-				reg = <0x2000 0x1000>;
-				clocks = <&sysclk>, <&sysclk>, <&sysclk>;
-				clock-names = "timer0clk", "timer1clk",
-					       "apb_pclk";
-				interrupts = <10>;
-				status = "disabled";
-			};
-
-			uart0: serial@4000 {
-				compatible = "arm,mps2-uart";
-				reg = <0x4000 0x1000>;
-				interrupts = <0>, <1>, <12>;
-				clocks = <&sysclk>;
-				status = "disabled";
-			};
-
-			uart1: serial@5000 {
-				compatible = "arm,mps2-uart";
-				reg = <0x5000 0x1000>;
-				interrupts = <2>, <3>, <12>;
-				clocks = <&sysclk>;
-				status = "disabled";
-			};
-
-			uart2: serial@6000 {
-				compatible = "arm,mps2-uart";
-				reg = <0x6000 0x1000>;
-				interrupts = <4>, <5>, <12>;
-				clocks = <&sysclk>;
-				status = "disabled";
-			};
-
-			wdt: watchdog@8000 {
-				compatible = "arm,sp805", "arm,primecell";
-				arm,primecell-periphid = <0x00141805>;
-				reg = <0x8000 0x1000>;
-				interrupts = <0>;
-				clocks = <&sysclk>, <&sysclk>;
-				clock-names = "wdog_clk", "apb_pclk";
-				status = "disabled";
-			};
-		};
-	};
-
-	fpga@40020000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0x40020000 0x10000>;
-
-		fpgaio@8000 {
-			compatible = "syscon", "simple-mfd";
-			reg = <0x8000 0x10>;
-
-			ranges = <0x0 0x8000 0x10>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			led@0,0 {
-				compatible = "register-bit-led";
-				reg = <0x00 0x04>;
-				offset = <0x0>;
-				mask = <0x01>;
-				label = "userled:0";
-				linux,default-trigger = "heartbeat";
-				default-state = "on";
-			};
-
-			led@0,1 {
-				compatible = "register-bit-led";
-				reg = <0x00 0x04>;
-				offset = <0x0>;
-				mask = <0x02>;
-				label = "userled:1";
-				linux,default-trigger = "usr";
-				default-state = "off";
-			};
-		};
-	};
-
-	smb {
-		compatible = "simple-bus";
-		#address-cells = <2>;
-		#size-cells = <1>;
-		ranges = <0 0 0x40200000 0x10000>,
-			 <1 0 0xa0000000 0x10000>;
-	};
-};
diff --git a/arch/arm/configs/mps2_defconfig b/arch/arm/configs/mps2_defconfig
deleted file mode 100644
index cacf3876f6e4..000000000000
--- a/arch/arm/configs/mps2_defconfig
+++ /dev/null
@@ -1,102 +0,0 @@
-CONFIG_NO_HZ_IDLE=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_PREEMPT_VOLUNTARY=y
-CONFIG_LOG_BUF_SHIFT=16
-CONFIG_CC_OPTIMIZE_FOR_SIZE=y
-CONFIG_EXPERT=y
-# CONFIG_UID16 is not set
-CONFIG_BASE_SMALL=y
-# CONFIG_FUTEX is not set
-# CONFIG_EPOLL is not set
-# CONFIG_SIGNALFD is not set
-# CONFIG_EVENTFD is not set
-# CONFIG_AIO is not set
-# CONFIG_MMU is not set
-CONFIG_ARCH_MPS2=y
-CONFIG_SET_MEM_PARAM=y
-CONFIG_DRAM_BASE=0x21000000
-CONFIG_DRAM_SIZE=0x1000000
-# CONFIG_SUSPEND is not set
-# CONFIG_BLOCK is not set
-CONFIG_BINFMT_FLAT=y
-# CONFIG_COREDUMP is not set
-# CONFIG_VM_EVENT_COUNTERS is not set
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_DIAG is not set
-# CONFIG_IPV6 is not set
-# CONFIG_WIRELESS is not set
-CONFIG_DEVTMPFS=y
-CONFIG_DEVTMPFS_MOUNT=y
-# CONFIG_FW_LOADER is not set
-CONFIG_NETDEVICES=y
-# CONFIG_NET_CORE is not set
-# CONFIG_NET_VENDOR_ARC is not set
-# CONFIG_NET_CADENCE is not set
-# CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_CIRRUS is not set
-# CONFIG_NET_VENDOR_EZCHIP is not set
-# CONFIG_NET_VENDOR_FARADAY is not set
-# CONFIG_NET_VENDOR_HISILICON is not set
-# CONFIG_NET_VENDOR_INTEL is not set
-# CONFIG_NET_VENDOR_MARVELL is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_NATSEMI is not set
-# CONFIG_NET_VENDOR_QUALCOMM is not set
-# CONFIG_NET_VENDOR_RENESAS is not set
-# CONFIG_NET_VENDOR_ROCKER is not set
-# CONFIG_NET_VENDOR_SAMSUNG is not set
-# CONFIG_NET_VENDOR_SEEQ is not set
-CONFIG_SMSC911X=y
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_NET_VENDOR_VIA is not set
-# CONFIG_NET_VENDOR_WIZNET is not set
-# CONFIG_WLAN is not set
-# CONFIG_INPUT is not set
-# CONFIG_SERIO is not set
-# CONFIG_VT is not set
-# CONFIG_LEGACY_PTYS is not set
-CONFIG_SERIAL_MPS2_UART_CONSOLE=y
-CONFIG_SERIAL_MPS2_UART=y
-CONFIG_SERIAL_NONSTANDARD=y
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
-CONFIG_WATCHDOG=y
-CONFIG_ARM_SP805_WATCHDOG=y
-CONFIG_MFD_SYSCON=y
-# CONFIG_USB_SUPPORT is not set
-CONFIG_NEW_LEDS=y
-CONFIG_LEDS_CLASS=y
-CONFIG_LEDS_SYSCON=y
-CONFIG_LEDS_TRIGGERS=y
-CONFIG_LEDS_TRIGGER_TIMER=y
-CONFIG_LEDS_TRIGGER_ONESHOT=y
-CONFIG_LEDS_TRIGGER_HEARTBEAT=y
-CONFIG_LEDS_TRIGGER_BACKLIGHT=y
-CONFIG_LEDS_TRIGGER_CPU=y
-CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
-CONFIG_ARM_TIMER_SP804=y
-# CONFIG_DNOTIFY is not set
-# CONFIG_INOTIFY_USER is not set
-# CONFIG_MISC_FILESYSTEMS is not set
-CONFIG_NFS_FS=y
-CONFIG_NFS_V4=y
-CONFIG_NFS_V4_1=y
-CONFIG_NFS_V4_2=y
-CONFIG_ROOT_NFS=y
-CONFIG_NLS=y
-CONFIG_PRINTK_TIME=y
-# CONFIG_ENABLE_MUST_CHECK is not set
-# CONFIG_DEBUG_BUGVERBOSE is not set
-CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
-CONFIG_DEBUG_FS=y
-# CONFIG_SLUB_DEBUG is not set
-# CONFIG_SCHED_DEBUG is not set
-CONFIG_MEMTEST=y
diff --git a/arch/arm/mach-versatile/Makefile b/arch/arm/mach-versatile/Makefile
index d819fb2fc450..07171ef1d6a7 100644
--- a/arch/arm/mach-versatile/Makefile
+++ b/arch/arm/mach-versatile/Makefile
@@ -22,9 +22,6 @@ obj-$(CONFIG_ARCH_VEXPRESS_TC2_PM)	+= tc2_pm.o
 CFLAGS_tc2_pm.o				+= -march=armv7-a
 CFLAGS_REMOVE_tc2_pm.o			= -pg
 
-# mps2
-obj-$(CONFIG_ARCH_MPS2)			+= v2m-mps2.o
-
 ifdef CONFIG_SMP
 obj-y					+= headsmp.o platsmp.o
 obj-$(CONFIG_ARCH_REALVIEW)		+= platsmp-realview.o
diff --git a/arch/arm/mach-versatile/v2m-mps2.c b/arch/arm/mach-versatile/v2m-mps2.c
deleted file mode 100644
index 5b50d8e95cd7..000000000000
--- a/arch/arm/mach-versatile/v2m-mps2.c
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2015 ARM Limited
- *
- * Author: Vladimir Murzin <vladimir.murzin@arm.com>
- */
-
-#include <asm/mach/arch.h>
-
-static const char *const mps2_compat[] __initconst = {
-	"arm,mps2",
-	NULL
-};
-
-DT_MACHINE_START(MPS2DT, "MPS2 (Device Tree Support)")
-	.dt_compat = mps2_compat,
-MACHINE_END
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index d7b89508311f..9d60d4b650ec 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1260,7 +1260,7 @@ config I2C_UNIPHIER_F
 
 config I2C_VERSATILE
 	tristate "ARM Versatile/Realview I2C bus support"
-	depends on ARCH_MPS2 || ARCH_VERSATILE || ARCH_REALVIEW || ARCH_VEXPRESS || COMPILE_TEST
+	depends on ARCH_VERSATILE || ARCH_REALVIEW || ARCH_VEXPRESS || COMPILE_TEST
 	select I2C_ALGOBIT
 	help
 	  Say yes if you want to support the I2C serial bus on ARMs Versatile
-- 
2.53.0


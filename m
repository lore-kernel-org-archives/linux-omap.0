Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923E4299959;
	Sat,  7 Mar 2026 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772886522; cv=none; b=MK/RJCpIJJHMMoAfREzi2x5HtqtDk1n3KEODuSGEcSI2S9oe93VcI9WL00Ww4hfdtbFc03wy4DJSK1QijOwr7lmkSjKK1X0GANONgSVFc05nlIT6eHG8ly4EG08kxV1svqpQeQtjxhXIHvWjwqRbu7IQpblsuOXiV8Qd1p7dLD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772886522; c=relaxed/simple;
	bh=LPRIazzZIfxpm7W+AMeFq/K6szh34FzU1F7O4yuEWg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cf4wDFvRQTy2WmagV3Okui+G/ComL6ZCywOcQy3OwAtZ3SnQYK6EwiiF6OkFuWWTbmIq8N7wZ0K2IIkavs5VseHP7nN0ZgEK6wN8RVp1gaIZUhoc83Rv+BYSNGl0TDzjG7bLzUhCC1cX2Wn/9b5jCYAFEfRO/fwJj3pE0ok/Jvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=eavrdTuj; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="eavrdTuj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VLisGpI9bU473iY8R1G6XN5hECPZkmgPzS0UYnsU8A4=; b=eavrdTujX5ErW3ejq6xDgwQrCd
	+pO8C1Rxm86gLNq7yqyiYP/k0boGfOyTrwThdydp6/I+hCqHJZHL8otlDadE3GjqbYWc8U5H/vZ1E
	74iENkif6cyA2eQYtn85X79J041wf7pcS6WL/IO1opM4592YH/TuHj6gD4hetETrXmHzPJDEjr6xG
	TNlWztZq5H20Thr8HWiZhStSofYghHbfqMXFdaG3jF/lQtZ2IOESGcnAzGUb9C3cly2zCLNpRRwtF
	SgAOYIeTpLTXdIfrifzaeElP6DEv2NohiJrAooQkViPXVFSKZosKZpD7YwuZxWCGXGvjQKcC4dq+F
	zHyFuSbg==;
Received: from [122.175.9.182] (port=64662 helo=cypher.couthit.local)
	by server.couthit.com with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1vyqlq-00000000pP7-3sOt;
	Sat, 07 Mar 2026 07:28:39 -0500
From: Parvathi Pudi <parvathi@couthit.com>
To: nm@ti.com,
	vigneshr@ti.com,
	afd@ti.com,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info
Cc: andrew@lunn.ch,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	danishanwar@ti.com,
	pratheesh@ti.com,
	j-rameshbabu@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	m-malladi@ti.com,
	krishna@couthit.com,
	mohan@couthit.com,
	pmohan@couthit.com,
	basharath@couthit.com,
	parvathi@couthit.com,
	Murali Karicheri <m-karicheri2@ti.com>
Subject: [PATCH v5 3/3] arm: dts: ti: Add device tree support for PRU-ICSS on AM335x
Date: Sat,  7 Mar 2026 17:53:57 +0530
Message-ID: <20260307122641.738450-4-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260307122641.738450-1-parvathi@couthit.com>
References: <20260307122641.738450-1-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Roger Quadros <rogerq@ti.com>

The TI Sitara AM335x ICE-V2 consists of single PRU-ICSS instance,
This patch adds the new device tree overlay file in-order to enable
PRU-ICSS instance, along with makefile changes.

PRU-ICSS instance consists of two PRU cores along with various
peripherals such as the Interrupt Controller (PRU_INTC), the Industrial
Ethernet Peripheral(IEP), the Real Time Media Independent Interface
controller (MII_RT), and the Enhanced Capture (eCAP) event module.

am33xx-l4.dtsi - Adds IEP and eCAP peripheral as child nodes
of the PRUSS subsystem node.

am335x-icev2-prueth.dtso - Adds PRU-ICSS instance node along with PRU
eth port information and corresponding port configuration. It includes
interrupt mapping for packet reception, HW timestamp collection, and PRU
Ethernet ports in MII mode,

GPIO configuration, boot strapping along with delay configuration for
individual PRU Ethernet port and other required nodes.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
 arch/arm/boot/dts/ti/omap/Makefile            |   5 +
 .../ti/omap/am335x-icev2-prueth-overlay.dtso  | 149 ++++++++++++++++++
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi      |  11 ++
 3 files changed, 165 insertions(+)
 create mode 100644 arch/arm/boot/dts/ti/omap/am335x-icev2-prueth-overlay.dtso

diff --git a/arch/arm/boot/dts/ti/omap/Makefile b/arch/arm/boot/dts/ti/omap/Makefile
index 4c577214f512..6fb58fe51648 100644
--- a/arch/arm/boot/dts/ti/omap/Makefile
+++ b/arch/arm/boot/dts/ti/omap/Makefile
@@ -84,6 +84,10 @@ dtb-$(CONFIG_ARCH_OMAP4) += \
 	omap4-samsung-espresso10.dtb \
 	omap4-xyboard-mz609.dtb \
 	omap4-xyboard-mz617.dtb
+
+am335x-icev2-prueth-dtbs := am335x-icev2.dtb \
+	am335x-icev2-prueth-overlay.dtbo
+
 dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-baltos-ir2110.dtb \
 	am335x-baltos-ir3220.dtb \
@@ -101,6 +105,7 @@ dtb-$(CONFIG_SOC_AM33XX) += \
 	am335x-evmsk.dtb \
 	am335x-guardian.dtb \
 	am335x-icev2.dtb \
+	am335x-icev2-prueth.dtb \
 	am335x-lxm.dtb \
 	am335x-mba335x.dtb \
 	am335x-moxa-uc-2101.dtb \
diff --git a/arch/arm/boot/dts/ti/omap/am335x-icev2-prueth-overlay.dtso b/arch/arm/boot/dts/ti/omap/am335x-icev2-prueth-overlay.dtso
new file mode 100644
index 000000000000..3b82cf719671
--- /dev/null
+++ b/arch/arm/boot/dts/ti/omap/am335x-icev2-prueth-overlay.dtso
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DT overlay for IDK AM335x
+ *
+ * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+/*
+ * AM335x ICE V2 board
+ * http://www.ti.com/tool/tmdsice3359
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/bus/ti-sysc.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/am33xx.h>
+#include <dt-bindings/clock/am3.h>
+
+&{/} {
+        /* Dual-MAC Ethernet application node on PRU-ICSS */
+        pruss_eth: pruss-eth {
+                compatible = "ti,am3359-prueth";
+                ti,prus = <&pru0>, <&pru1>;
+                sram = <&ocmcram>;
+                ti,mii-rt = <&pruss_mii_rt>;
+                ti,iep = <&pruss_iep>;
+                ti,ecap = <&pruss_ecap>;
+                interrupts = <20 2 2>, <21 3 3>;
+                interrupt-names = "rx_hp", "rx_lp";
+                interrupt-parent = <&pruss_intc>;
+
+                pinctrl-0 = <&pruss_eth_default>;
+                pinctrl-names = "default";
+
+                ethernet-ports {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+                        pruss_emac0: ethernet-port@0 {
+                                reg = <0>;
+                                phy-handle = <&pruss_eth0_phy>;
+                                phy-mode = "mii";
+                                interrupts = <20 2 2>, <26 6 6>, <23 6 6>;
+                                interrupt-names = "rx", "emac_ptp_tx",
+                                                  "hsr_ptp_tx";
+                                /* Filled in by bootloader */
+                                local-mac-address = [00 00 00 00 00 00];
+                        };
+
+                        pruss_emac1: ethernet-port@1 {
+                                reg = <1>;
+                                phy-handle = <&pruss_eth1_phy>;
+                                phy-mode = "mii";
+                                interrupts = <21 3 3>, <27 9 7>, <24 9 7>;
+                                interrupt-names = "rx", "emac_ptp_tx",
+                                                  "hsr_ptp_tx";
+                                /* Filled in by bootloader */
+                                local-mac-address = [00 00 00 00 00 00];
+                        };
+                };
+        };
+};
+
+&am33xx_pinmux {
+	/* MDIO node for PRU-ICSS */
+        pruss_mdio_default: pruss-mdio-default {
+                pinctrl-single,pins = <
+			AM33XX_IOPAD(0x88c, PIN_OUTPUT | MUX_MODE5) /* (V12) gpmc_clk.pr1_mdio_mdclk */
+			AM33XX_IOPAD(0x888, PIN_INPUT | MUX_MODE5) /* (T13) gpmc_csn3.pr1_mdio_data */
+                >;
+        };
+
+	/* Pinmux configuration for PRU-ICSS */
+        pruss_eth_default: pruss-eth-default {
+                pinctrl-single,pins = <
+			AM33XX_IOPAD(0x8a0, PIN_INPUT | MUX_MODE2) /* (R1) lcd_data0.pr1_mii_mt0_clk */
+			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE2) /* (T2) lcd_data5.pr1_mii0_txd0 */
+			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE2) /* (T1) lcd_data4.pr1_mii0_txd1 */
+			AM33XX_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE2) /* (R4) lcd_data3.pr1_mii0_txd2 */
+			AM33XX_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE2) /* (R3) lcd_data2.pr1_mii0_txd3 */
+			AM33XX_IOPAD(0x8cc, PIN_INPUT | MUX_MODE5) /* (U4) lcd_data11.pr1_mii0_rxd0 */
+			AM33XX_IOPAD(0x8c8, PIN_INPUT | MUX_MODE5) /* (U3) lcd_data10.pr1_mii0_rxd1 */
+			AM33XX_IOPAD(0x8c4, PIN_INPUT | MUX_MODE5) /* (U2) lcd_data9.pr1_mii0_rxd2 */
+			AM33XX_IOPAD(0x8c0, PIN_INPUT | MUX_MODE5) /* (U1) lcd_data8.pr1_mii0_rxd3 */
+			AM33XX_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE2) /* (R2) lcd_data1.pr1_mii0_txen */
+			AM33XX_IOPAD(0x8d8, PIN_INPUT | MUX_MODE5) /* (V4) lcd_data14.pr1_mii_mr0_clk */
+			AM33XX_IOPAD(0x8dc, PIN_INPUT | MUX_MODE5) /* (T5) lcd_data15.pr1_mii0_rxdv */
+			AM33XX_IOPAD(0x8d4, PIN_INPUT | MUX_MODE5) /* (V3) lcd_data13.pr1_mii0_rxer */
+			AM33XX_IOPAD(0x8d0, PIN_INPUT | MUX_MODE5) /* (V2) lcd_data12.pr1_mii0_rxlink */
+			AM33XX_IOPAD(0x8e8, PIN_INPUT | MUX_MODE2) /* (V5) lcd_pclk.pr1_mii0_crs */
+
+			AM33XX_IOPAD(0x840, PIN_INPUT | MUX_MODE5) /* (R13) gpmc_a0.pr1_mii_mt1_clk */
+			AM33XX_IOPAD(0x850, PIN_OUTPUT | MUX_MODE5) /* (R14) gpmc_a4.pr1_mii1_txd0 */
+			AM33XX_IOPAD(0x84c, PIN_OUTPUT | MUX_MODE5) /* (T14) gpmc_a3.pr1_mii1_txd1 */
+			AM33XX_IOPAD(0x848, PIN_OUTPUT | MUX_MODE5) /* (U14) gpmc_a2.pr1_mii1_txd2 */
+			AM33XX_IOPAD(0x844, PIN_OUTPUT | MUX_MODE5) /* (V14) gpmc_a1.pr1_mii1_txd3 */
+			AM33XX_IOPAD(0x860, PIN_INPUT | MUX_MODE5) /* (V16) gpmc_a8.pr1_mii1_rxd0 */
+			AM33XX_IOPAD(0x85c, PIN_INPUT | MUX_MODE5) /* (T15) gpmc_a7.pr1_mii1_rxd1 */
+			AM33XX_IOPAD(0x858, PIN_INPUT | MUX_MODE5) /* (U15) gpmc_a6.pr1_mii1_rxd2 */
+			AM33XX_IOPAD(0x854, PIN_INPUT | MUX_MODE5) /* (V15) gpmc_a5.pr1_mii1_rxd3 */
+			AM33XX_IOPAD(0x874, PIN_OUTPUT | MUX_MODE5) /* (U17) gpmc_wpn.pr1_mii1_txen */
+			AM33XX_IOPAD(0x864, PIN_INPUT | MUX_MODE5) /* (U16) gpmc_a9.pr1_mii_mr1_clk */
+			AM33XX_IOPAD(0x868, PIN_INPUT | MUX_MODE5) /* (T16) gpmc_a10.pr1_mii1_rxdv */
+			AM33XX_IOPAD(0x86c, PIN_INPUT | MUX_MODE5) /* (V17) gpmc_a11.pr1_mii1_rxer */
+			AM33XX_IOPAD(0x878, PIN_INPUT | MUX_MODE5) /* (U18) gpmc_be1n.pr1_mii1_rxlink */
+			AM33XX_IOPAD(0x8ec, PIN_INPUT | MUX_MODE2) /* (R6) lcd_ac_bias_en.pr1_mii1_crs */
+                >;
+        };
+};
+
+&gpio3 {
+        mux-mii-hog {
+                /* ETH1 mux: Low for MII-PRU, high for RMII-CPSW */
+                output-low;
+        };
+};
+
+/*
+ * Disable CPSW switch node and
+ * MDIO configuration to prevent
+ * conflict with PRU-ICSS
+ */
+&mac_sw {
+        status = "disable";
+};
+
+&davinci_mdio_sw {
+        status = "disable";
+};
+
+/* PRU-ICSS MDIO configuration */
+&pruss_mdio {
+        pinctrl-0 = <&pruss_mdio_default>;
+        pinctrl-names = "default";
+        reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
+        reset-delay-us = <2>; /* PHY datasheet states 1uS min */
+        status = "okay";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pruss_eth0_phy: ethernet-phy@1 {
+                 reg = <1>;
+        };
+
+        pruss_eth1_phy: ethernet-phy@3 {
+                 reg = <3>;
+        };
+};
diff --git a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
index 89d16fcc773e..a63ef307d918 100644
--- a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
@@ -896,6 +896,17 @@ pruss_mii_rt: mii-rt@32000 {
 					reg = <0x32000 0x58>;
 				};
 
+				pruss_iep: iep@2e000 {
+					compatible = "ti,am3356-icss-iep";
+					reg = <0x2e000 0x31c>;
+					clocks = <&pruss_iepclk_mux>;
+				};
+
+				pruss_ecap: ecap@30000 {
+					compatible = "ti,pruss-ecap";
+					reg = <0x30000 0x60>;
+				};
+
 				pruss_intc: interrupt-controller@20000 {
 					compatible = "ti,pruss-intc";
 					reg = <0x20000 0x2000>;
-- 
2.43.0


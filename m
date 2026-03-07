Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7D330B521;
	Sat,  7 Mar 2026 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772886507; cv=none; b=BoO7FxCaK3whTOIeDMycgZCg0eJe2jF2hRP7NFqMa+vZH83TAKeixNK47OImuKNMxPM6RJljvaB8ARVDJR+R7G6B1LxQr+D4l6D2BjTcFvtAOmJkJBeFXADmdYtNZ+lshu7iVXs3zPAYYw//nVVbECZ6Fk/X37aSZ3cZbpjJ8L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772886507; c=relaxed/simple;
	bh=W7ilk02hyl+Mv2soon0SSHO2IO4C6M8wTubz3KGrdEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F633THYNNW/fFHgwuwdLFIRxbbsEA0/WuUvbQk4IxZIURNvGMGaYVEBNQeqXkhGG+oXgzWpqfLYKqAsAn0f3p/hR8OKy2ooKg90eeuOsbRkwG4JV46cuNMisnBa3bApniz6WYc1j0PzR2vc3F2/qzGHolF9sgcEPPOA3W/DiR7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=m2L8ixxW; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="m2L8ixxW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vxuLWNnMvkbf4JAM0lrOHZN8p3uvM5PTtPl3RedypFc=; b=m2L8ixxWMU2yJkSv2lHvNLWXUo
	8YN65u9sebYE7Vxc9ovK0qwUPWPVjofSTaob3ANG9nw80YZMwQwtD0WctoSR2G+feGPqNckd0mQ9m
	Fs5SU75wFvW3T307woqOngH1keR7K9uojtErCt0P7FZQ33sRyFVOYlxhU4lUjk6KnK+OmzrHmZvUK
	sfeIeJgwFtRUdi18toFm3eaHWQlvEql/rcUopHO2XRbLmjV4fbcRu8NlTg/pfz+FV0t2h5wHFg7n3
	IValUaHANxMiJ1WFDoPC+el7ZozcyO/JjRNZWGctoclHJ6m++Moin50qrLmLVTkEOW24zrwaQ8LM0
	FNssFvYg==;
Received: from [122.175.9.182] (port=64662 helo=cypher.couthit.local)
	by server.couthit.com with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1vyqlb-00000000pP7-1RUE;
	Sat, 07 Mar 2026 07:28:23 -0500
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
Subject: [PATCH v5 2/3] arm: dts: ti: Add device tree support for PRU-ICSS on AM437x
Date: Sat,  7 Mar 2026 17:53:56 +0530
Message-ID: <20260307122641.738450-3-parvathi@couthit.com>
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

The TI Sitara AM437x series of devices consists of 2 PRU-ICSS instances
(PRU-ICSS0 and PRU-ICSS1). This patch adds the device tree nodes for the
PRU-ICSS1 instance to support DUAL-MAC mode of operation. Support for
Ethernet over PRU is available only for ICSS1 instance.

PRU-ICSS instance consists of two PRU cores along with various
peripherals such as the Interrupt Controller (PRU_INTC), the Industrial
Ethernet Peripheral(IEP), the Real Time Media Independent Interface
controller (MII_RT), and the Enhanced Capture (eCAP) event module.

am4372.dtsi - Adds IEP and eCAP peripheral as child nodes of the PRUSS
subsystem node.

am437x-idk-evm.dts - Adds PRU-ICSS instance node along with PRU eth port
information and corresponding port configuration. It includes interrupt
mapping for packet reception, HW timestamp collection, and PRU Ethernet
ports in MII mode,

GPIO configuration, boot strapping along with delay configuration for
individual PRU Ethernet port and other required nodes.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
---
 arch/arm/boot/dts/ti/omap/am4372.dtsi        |  11 ++
 arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts | 103 ++++++++++++++++++-
 2 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/am4372.dtsi b/arch/arm/boot/dts/ti/omap/am4372.dtsi
index 504fa6b57d39..494f251c8e6a 100644
--- a/arch/arm/boot/dts/ti/omap/am4372.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am4372.dtsi
@@ -476,6 +476,17 @@ pruss1_mii_rt: mii-rt@32000 {
 					reg = <0x32000 0x58>;
 				};
 
+				pruss1_iep: iep@2e000 {
+					compatible = "ti,am4376-icss-iep";
+					reg = <0x2e000 0x31c>;
+					clocks = <&pruss1_iepclk_mux>;
+				};
+
+				pruss1_ecap: ecap@30000 {
+					compatible = "ti,pruss-ecap";
+					reg = <0x30000 0x60>;
+				};
+
 				pruss1_intc: interrupt-controller@20000 {
 					compatible = "ti,pruss-intc";
 					reg = <0x20000 0x2000>;
diff --git a/arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts b/arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts
index 826f687c368a..aea00b21c68f 100644
--- a/arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts
@@ -168,6 +168,48 @@ led-out7 {
 			default-state = "off";
 		};
 	};
+
+	/* Dual-MAC Ethernet application node on PRU-ICSS1 */
+	pruss1_eth: pruss1-eth {
+		compatible = "ti,am4376-prueth";
+		ti,prus = <&pru1_0>, <&pru1_1>;
+		sram = <&ocmcram>;
+		ti,mii-rt = <&pruss1_mii_rt>;
+		ti,iep = <&pruss1_iep>;
+		ti,ecap = <&pruss1_ecap>;
+		interrupts = <20 2 2>, <21 3 3>;
+		interrupt-names = "rx_hp", "rx_lp";
+		interrupt-parent = <&pruss1_intc>;
+
+		pinctrl-0 = <&pruss1_eth_default>;
+		pinctrl-names = "default";
+
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pruss1_emac0: ethernet-port@0 {
+				reg = <0>;
+				phy-handle = <&pruss1_eth0_phy>;
+				phy-mode = "mii";
+				interrupts = <20 2 2>, <26 6 6>, <23 6 6>;
+				interrupt-names = "rx", "emac_ptp_tx",
+						  "hsr_ptp_tx";
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
+
+			pruss1_emac1: ethernet-port@1 {
+				reg = <1>;
+				phy-handle = <&pruss1_eth1_phy>;
+				phy-mode = "mii";
+				interrupts = <21 3 3>, <27 9 5>, <24 9 5>;
+				interrupt-names = "rx", "emac_ptp_tx",
+						  "hsr_ptp_tx";
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
+		};
+	};
 };
 
 &am43xx_pinmux {
@@ -303,6 +345,52 @@ AM4372_IOPAD(0x94c, PIN_INPUT_PULLDOWN | MUX_MODE7)
 		>;
 	};
 
+	pruss1_mdio_default: pruss1-mdio-default {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0x88c, PIN_OUTPUT | MUX_MODE5) /* (A12) gpmc_clk.pr1_mdio_mdclk */
+			AM4372_IOPAD(0xa70, PIN_INPUT | MUX_MODE8) /* (D24) xdma_event_intr0.pr1_mdio_data */
+			AM4372_IOPAD(0xa00, PIN_INPUT_PULLUP | MUX_MODE7) /* (AD23) cam1_data6.gpio4[20] */
+		>;
+	};
+
+	pruss1_eth_default: pruss1-eth-default {
+		pinctrl-single,pins = <
+			AM4372_IOPAD(0x8a0, PIN_INPUT | MUX_MODE2) /* (B22) dss_data0.pr1_mii_mt0_clk */
+			AM4372_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE2) /* (B20) dss_data5.pr1_mii0_txd0 */
+			AM4372_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE2) /* (A20) dss_data4.pr1_mii0_txd1 */
+			AM4372_IOPAD(0x8ac, PIN_OUTPUT | MUX_MODE2) /* (C21) dss_data3.pr1_mii0_txd2 */
+			AM4372_IOPAD(0x8a8, PIN_OUTPUT | MUX_MODE2) /* (B21) dss_data2.pr1_mii0_txd3 */
+			AM4372_IOPAD(0x8cc, PIN_INPUT | MUX_MODE5) /* (B18) dss_data11.pr1_mii0_rxd0 */
+			AM4372_IOPAD(0x8c8, PIN_INPUT | MUX_MODE5) /* (A18) dss_data10.pr1_mii0_rxd1 */
+			AM4372_IOPAD(0x8c4, PIN_INPUT | MUX_MODE5) /* (B19) dss_data9.pr1_mii0_rxd2 */
+			AM4372_IOPAD(0x8c0, PIN_INPUT | MUX_MODE5) /* (A19) dss_data8.pr1_mii0_rxd3 */
+			AM4372_IOPAD(0x8a4, PIN_OUTPUT | MUX_MODE2) /* (A21) dss_data1.pr1_mii0_txen */
+			AM4372_IOPAD(0x8d8, PIN_INPUT | MUX_MODE5) /* (C17) dss_data14.pr1_mii_mr0_clk */
+			AM4372_IOPAD(0x8dc, PIN_INPUT | MUX_MODE5) /* (D17) dss_data15.pr1_mii0_rxdv */
+			AM4372_IOPAD(0x8d4, PIN_INPUT | MUX_MODE5) /* (D19) dss_data13.pr1_mii0_rxer */
+			AM4372_IOPAD(0x8d0, PIN_INPUT | MUX_MODE5) /* (C19) dss_data12.pr1_mii0_rxlink */
+			AM4372_IOPAD(0xa40, PIN_INPUT | MUX_MODE5) /* (G20) gpio5_10.pr1_mii0_crs */
+			AM4372_IOPAD(0xa38, PIN_INPUT | MUX_MODE5) /* (D25) gpio5_8.pr1_mii0_col */
+
+			AM4372_IOPAD(0x858, PIN_INPUT | MUX_MODE5) /* (E8) gpmc_a6.pr1_mii_mt1_clk */
+			AM4372_IOPAD(0x854, PIN_OUTPUT | MUX_MODE5) /* (E7) gpmc_a5.pr1_mii1_txd0 */
+			AM4372_IOPAD(0x850, PIN_OUTPUT | MUX_MODE5) /* (D7) gpmc_a4.pr1_mii1_txd1 */
+			AM4372_IOPAD(0x84c, PIN_OUTPUT | MUX_MODE5) /* (A4) gpmc_a3.pr1_mii1_txd2 */
+			AM4372_IOPAD(0x848, PIN_OUTPUT | MUX_MODE5) /* (C6) gpmc_a2.pr1_mii1_txd3 */
+			AM4372_IOPAD(0x86c, PIN_INPUT | MUX_MODE5) /* (D8) gpmc_a11.pr1_mii1_rxd0 */
+			AM4372_IOPAD(0x868, PIN_INPUT | MUX_MODE5) /* (G8) gpmc_a10.pr1_mii1_rxd1 */
+			AM4372_IOPAD(0x864, PIN_INPUT | MUX_MODE5) /* (B4) gpmc_a9.pr1_mii1_rxd2 */
+			AM4372_IOPAD(0x860, PIN_INPUT | MUX_MODE5) /* (F7) gpmc_a8.pr1_mii1_rxd3 */
+			AM4372_IOPAD(0x840, PIN_OUTPUT | MUX_MODE5) /* (C3) gpmc_a0.pr1_mii1_txen */
+			AM4372_IOPAD(0x85c, PIN_INPUT | MUX_MODE5) /* (F6) gpmc_a7.pr1_mii_mr1_clk */
+			AM4372_IOPAD(0x844, PIN_INPUT | MUX_MODE5) /* (C5) gpmc_a1.pr1_mii1_rxdv */
+			AM4372_IOPAD(0x874, PIN_INPUT | MUX_MODE5) /* (B3) gpmc_wpn.pr1_mii1_rxer */
+			AM4372_IOPAD(0xa4c, PIN_INPUT | MUX_MODE5) /* (E24) gpio5_13.pr1_mii1_rxlink */
+			AM4372_IOPAD(0xa44, PIN_INPUT | MUX_MODE5) /* (F23) gpio5_11.pr1_mii1_crs */
+			AM4372_IOPAD(0x878, PIN_INPUT | MUX_MODE5) /* (A3) gpmc_be1n.pr1_mii1_col */
+		>;
+	};
+
 	qspi_pins_default: qspi-default-pins {
 		pinctrl-single,pins = <
 			AM4372_IOPAD(0x87c, PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpmc_csn0.qspi_csn */
@@ -539,5 +627,18 @@ opp-100-600000000 {
 };
 
 &pruss1_mdio {
-	status = "disabled";
+	pinctrl-0 = <&pruss1_mdio_default>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	reset-gpios = <&gpio4 20 GPIO_ACTIVE_LOW>;
+	reset-delay-us = <2>;	/* PHY datasheet states 1uS min */
+
+	pruss1_eth0_phy: ethernet-phy@0 {
+		reg = <0>;
+	};
+
+	pruss1_eth1_phy: ethernet-phy@1 {
+		reg = <1>;
+	};
 };
-- 
2.43.0


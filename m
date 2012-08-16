From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v3 3/4] arm/dts: AM33XX: Configure pinmuxs for D_CAN1 on AM335x-EVM
Date: Thu, 16 Aug 2012 17:50:09 +0530
Message-ID: <1345119610-5247-4-git-send-email-anilkumar@ti.com>
References: <1345119610-5247-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48751 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754190Ab2HPMU4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Aug 2012 08:20:56 -0400
In-Reply-To: <1345119610-5247-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>

Add D_CAN1 pinctrl node to am3358_pinmux master node to export
D_CAN functionality on AM335x EVM according to pinctrl-single
driver.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
Changes from v2:
	- Incorporated Vaibhav H's comments on v2
	  * Added dcan0 instances to am33xx.dtsi file

Changes from v1:
	- These two patches separated from c_can DT support
	  patch series.

 arch/arm/boot/dts/am335x-evm.dts |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 5dd8a6b..a64c30a 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -18,6 +18,18 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 
+	am3358_pinmux: pinmux@44E10800 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&d_can1_pins>;
+
+		d_can1_pins: pinmux_d_can_pins {
+			pinctrl-single,pins = <
+				0x168 0x2	/* uart0_ctsn.d_can1_tx, OUTPUT | MODE2 */
+				0x16C 0x32	/* uart0_rtsn.d_can1_rx, INPUT_PULLUP | MODE2 */
+			>;
+		};
+	};
+
 	ocp {
 		uart1: serial@44E09000 {
 			status = "okay";
-- 
1.7.9.5


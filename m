From: Archit Taneja <archit@ti.com>
Subject: [RFC v2 5/6] ARM: dts: Add dss_deshdcp clock node under dra7-ctrl-core
Date: Wed, 28 May 2014 16:20:54 +0530
Message-ID: <1401274255-16845-6-git-send-email-archit@ti.com>
References: <1397654063-8055-1-git-send-email-archit@ti.com>
 <1401274255-16845-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34477 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbaE1Kwf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2014 06:52:35 -0400
In-Reply-To: <1401274255-16845-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, t-kristo@ti.com, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The DESHDCP clock is required only by the DES-HDCP block within HDMI in DSS.
However, if the clock isn't set before DSS clock domian is enabled, the clock
domain never comes out of idle state.

The DESHDCP clock is enabled/disabled at the DSS boundary by the bit
DSS_DESHDCP_CLKEN in CTRL_CORE_CONTROL_IO_2.

Add dss_deshdcp gate-clock node under dra7-ctrl-core. There are separate bit
fields for enabling and disabling the clock. We just map the enable bit since
this clock doesn't cause any impact if left enabled.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index cfb8fc7..a1653ba 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -2007,6 +2007,16 @@
 	};
 };
 
+&ctrl_core_clocks {
+	dss_deshdcp_clk: dss_deshdcp_clk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&l3_iclk_div>;
+		ti,bit-shift = <0>;
+		reg = <0x0558>;
+	};
+};
+
 &cm_core_clockdomains {
 	coreaon_clkdm: coreaon_clkdm {
 		compatible = "ti,clockdomain";
-- 
1.8.3.2


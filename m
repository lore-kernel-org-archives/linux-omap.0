From: Sathya Prakash M R <sathyap@ti.com>
Subject: [PATCH V3 4/6] ARM: am43xx-clocks.dtsi: Set parent for disp_clk
Date: Mon, 24 Mar 2014 16:31:54 +0530
Message-ID: <1395658916-9032-5-git-send-email-sathyap@ti.com>
References: <1395658916-9032-1-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50590 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752980AbaCXLCI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Mar 2014 07:02:08 -0400
In-Reply-To: <1395658916-9032-1-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Sathya Prakash M R <sathyap@ti.com>

Choose a parent for the disp_clk.

Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
---
 arch/arm/boot/dts/am43xx-clocks.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/am43xx-clocks.dtsi b/arch/arm/boot/dts/am43xx-clocks.dtsi
index 85e7d4b..b20e192 100644
--- a/arch/arm/boot/dts/am43xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am43xx-clocks.dtsi
@@ -512,6 +512,8 @@ disp_clk: disp_clk@44df4244 {
 	compatible = "ti,mux-clock";
 	clocks = <&dpll_disp_m2_ck>, <&dpll_core_m5_ck>, <&dpll_per_m2_ck>;
 	reg = <0x44df4244 0x4>;
+	bit-mask = <0x3>;
+	set-rate-parent;
 };
 
 dpll_extdev_ck: dpll_extdev_ck@44df2e60 {
-- 
1.7.9.5


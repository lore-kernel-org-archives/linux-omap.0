From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 3/3] ARM: dts: Add OMAP5 counter node
Date: Thu, 1 Nov 2012 10:49:27 -0500
Message-ID: <1351784967-32520-4-git-send-email-jon-hunter@ti.com>
References: <1351784967-32520-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52610 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964821Ab2KAPuK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Nov 2012 11:50:10 -0400
In-Reply-To: <1351784967-32520-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Add the 32kHz counter node for OMAP5 devices.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index c8954f1..ead74c8 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -77,6 +77,12 @@
 		ranges;
 		ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
 
+		counter32k: counter@4ae04000 {
+			compatible = "ti,omap-counter32k";
+			reg = <0x4ae04000 0x40>;
+			ti,hwmods = "counter_32k";
+		};
+
 		omap5_pmx_core: pinmux@4a002840 {
 			compatible = "ti,omap4-padconf", "pinctrl-single";
 			reg = <0x4a002840 0x01b6>;
-- 
1.7.9.5


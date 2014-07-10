From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/3] ARM: DTS: omap5-uevm: Enable palmas clk32kgaudio clock
Date: Thu, 10 Jul 2014 14:24:01 +0300
Message-ID: <1404991443-14239-2-git-send-email-peter.ujfalusi@ti.com>
References: <1404991443-14239-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50611 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585AbaGJLYd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Jul 2014 07:24:33 -0400
In-Reply-To: <1404991443-14239-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

clk32kg-audio clock is needed for twl6040 codec.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap5-uevm.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 1e1b05768cec..9166d479ac1b 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -306,6 +306,11 @@
 			ti,wakeup;
 		};
 
+		clk32kgaudio: palmas_clk32k@1 {
+			compatible = "ti,palmas-clk32kgaudio";
+			#clock-cells = <0>;
+		};
+
 		palmas_pmic {
 			compatible = "ti,palmas-pmic";
 			interrupt-parent = <&palmas>;
-- 
2.0.0


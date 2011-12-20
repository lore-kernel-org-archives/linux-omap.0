From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 4/5] arm/dts: OMAP3: Add interrupt-controller bindings for INTC
Date: Tue, 20 Dec 2011 14:39:57 +0100
Message-ID: <1324388398-2683-5-git-send-email-b-cousson@ti.com>
References: <1324388398-2683-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41670 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751514Ab1LTNkd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Dec 2011 08:40:33 -0500
In-Reply-To: <1324388398-2683-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rob.herring@calxeda.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Update the DTS with the proper information required by the
INTC bindings.

- Add the number of interrupt lines
- Add the reg and the compatible entries.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/omap3.dtsi |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index d202bb5..6866dc7 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -54,10 +54,12 @@
 		ranges;
 		ti,hwmods = "l3_main";
 
-		intc: interrupt-controller@1 {
-			compatible = "ti,omap3-intc";
+		intc: interrupt-controller@48200000 {
+			compatible = "ti,omap2-intc";
 			interrupt-controller;
 			#interrupt-cells = <1>;
+			ti,intc-size = <96>;
+			reg = <0x48200000 0x1000>;
 		};
 	};
 };
-- 
1.7.0.4


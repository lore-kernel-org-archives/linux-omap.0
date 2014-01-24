From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/9] ARM: DTS: omap4-panda-common: No need to disable the unused audio nodes
Date: Fri, 24 Jan 2014 10:19:02 +0200
Message-ID: <1390551547-12406-5-git-send-email-peter.ujfalusi@ti.com>
References: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42014 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252AbaAXITm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jan 2014 03:19:42 -0500
In-Reply-To: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

All audio nodes has been set to disabled state in omap4.dtsi file.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 9067d4c0148d..f83dd4c365c7 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -387,18 +387,6 @@
 	status = "okay";
 };
 
-&mcbsp2 {
-	status = "disabled";
-};
-
-&mcbsp3 {
-	status = "disabled";
-};
-
-&dmic {
-	status = "disabled";
-};
-
 &mcpdm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcpdm_pins>;
-- 
1.8.5.3


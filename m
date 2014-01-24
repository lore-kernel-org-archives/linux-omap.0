From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 5/9] ARM: DTS: omap4-sdp: No need to disable mcbsp3 node
Date: Fri, 24 Jan 2014 10:19:03 +0200
Message-ID: <1390551547-12406-6-git-send-email-peter.ujfalusi@ti.com>
References: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43717 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115AbaAXITq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jan 2014 03:19:46 -0500
In-Reply-To: <1390551547-12406-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

All audio nodes has been set to disabled state in omap4.dtsi file.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 513b01774966..9bbbbec1d63d 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -548,10 +548,6 @@
 	status = "okay";
 };
 
-&mcbsp3 {
-	status = "disabled";
-};
-
 &dmic {
 	pinctrl-names = "default";
 	pinctrl-0 = <&dmic_pins>;
-- 
1.8.5.3


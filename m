From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 5/5] ARM: dts: omap4-sdp: Add support for pwm-backlight
Date: Fri, 18 Jan 2013 15:36:34 +0100
Message-ID: <1358519794-13214-6-git-send-email-peter.ujfalusi@ti.com>
References: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58283 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755196Ab3AROgt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Jan 2013 09:36:49 -0500
In-Reply-To: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Section to describe the backlight for the LCD panels.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 8101a94..c2dee41 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -95,6 +95,17 @@
 		};
 	};
 
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&twl_pwm 1 7812500>;
+		brightness-levels = <
+				0 10 20 30 40
+				50 60 70 80 90
+				100 110 120 127
+				>;
+		default-brightness-level = <13>;
+	};
+
 	sound {
 		compatible = "ti,abe-twl6040";
 		ti,model = "SDP4430";
-- 
1.8.1


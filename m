From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/5] ARM: dts: omap4-sdp: Add support for pwm-leds (keypad and charging LED)
Date: Fri, 18 Jan 2013 15:36:33 +0100
Message-ID: <1358519794-13214-5-git-send-email-peter.ujfalusi@ti.com>
References: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37656 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595Ab3AROgs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Jan 2013 09:36:48 -0500
In-Reply-To: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Sections to describe the pwm-leds in the system.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 43e5258..8101a94 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -80,6 +80,21 @@
 		};
 	};
 
+	pwmleds {
+		compatible = "pwm-leds";
+		kpad {
+			label = "omap4::keypad";
+			pwms = <&twl_pwm 0 7812500>;
+			max-brightness = <127>;
+		};
+
+		charging {
+			label = "omap4:green:chrg";
+			pwms = <&twl_pwmled 0 7812500>;
+			max-brightness = <255>;
+		};
+	};
+
 	sound {
 		compatible = "ti,abe-twl6040";
 		ti,model = "SDP4430";
-- 
1.8.1


From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/5] ARM: dts: twl6030: Add PWM support
Date: Fri, 18 Jan 2013 15:36:31 +0100
Message-ID: <1358519794-13214-3-git-send-email-peter.ujfalusi@ti.com>
References: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58277 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751595Ab3AROgp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Jan 2013 09:36:45 -0500
In-Reply-To: <1358519794-13214-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Enable support for the PWMs and LED as PWM drivers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/twl6030.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
index 9996cfc..d9b8b21 100644
--- a/arch/arm/boot/dts/twl6030.dtsi
+++ b/arch/arm/boot/dts/twl6030.dtsi
@@ -91,4 +91,16 @@
 		compatible = "ti,twl6030-usb";
 		interrupts = <4>, <10>;
 	};
+
+	twl_pwm: pwm {
+		/* provides two PWMs (id 0, 1 for PWM1 and PWM2) */
+		compatible = "ti,twl6030-pwm";
+		#pwm-cells = <2>;
+	};
+
+	twl_pwmled: pwmled {
+		/* provides one PWM (id 0 for Charing indicator LED) */
+		compatible = "ti,twl6030-pwmled";
+		#pwm-cells = <2>;
+	};
 };
-- 
1.8.1


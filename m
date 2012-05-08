From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 2/3] arm/dts: omap4-sdp: Add LEDs support
Date: Tue, 8 May 2012 18:37:26 +0200
Message-ID: <1336495047-5882-3-git-send-email-b-cousson@ti.com>
References: <1336495047-5882-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51343 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756022Ab2EHQiF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 12:38:05 -0400
In-Reply-To: <1336495047-5882-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Add the debug LEDs nodes for an OMAP4 SDP/Blaze.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts |   43 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 67b2e98..e5eeb6f 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -27,6 +27,49 @@
 		enable-active-high;
 		regulator-boot-on;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		debug0 {
+			label = "omap4:green:debug0";
+			gpios = <&gpio2 29 0>; /* 61 */
+		};
+
+		debug1 {
+			label = "omap4:green:debug1";
+			gpios = <&gpio1 30 0>; /* 30 */
+		};
+
+		debug2 {
+			label = "omap4:green:debug2";
+			gpios = <&gpio1 7 0>; /* 7 */
+		};
+
+		debug3 {
+			label = "omap4:green:debug3";
+			gpios = <&gpio1 8 0>; /* 8 */
+		};
+
+		debug4 {
+			label = "omap4:green:debug4";
+			gpios = <&gpio2 18 0>; /* 50 */
+		};
+
+		user1 {
+			label = "omap4:blue:user";
+			gpios = <&gpio6 9 0>; /* 169 */
+		};
+
+		user2 {
+			label = "omap4:red:user";
+			gpios = <&gpio6 10 0>; /* 170 */
+		};
+
+		user3 {
+			label = "omap4:green:user";
+			gpios = <&gpio5 11 0>; /* 139 */
+		};
+	};
 };
 
 &i2c1 {
-- 
1.7.0.4


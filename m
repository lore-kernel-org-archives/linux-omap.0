From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH] ARM: dts: am437x-gp-evm: Add vtt_fixed regulator
Date: Tue, 22 Apr 2014 13:52:19 -0500
Message-ID: <1398192739-8901-2-git-send-email-d-gerlach@ti.com>
References: <1398192739-8901-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54861 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbaDVSwu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2014 14:52:50 -0400
In-Reply-To: <1398192739-8901-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com, Sekhar Nori <nsekhar@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Dave Gerlach <d-gerlach@ti.com>

The VTT regulator for DDR3 termination on the am437x-gp-evm is
controlled by a gpio. It is configured by the bootloader so here we
define an always-on, fixed voltage regulator to hold the gpio.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index a055f7f..e68d12c 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -27,6 +27,17 @@
 		enable-active-high;
 	};
 
+	vtt_fixed: fixedregulator-vtt {
+		compatible = "regulator-fixed";
+		regulator-name = "vtt_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&gpio5 7 GPIO_ACTIVE_HIGH>;
+	};
+
 	backlight {
 		compatible = "pwm-backlight";
 		pwms = <&ecap0 0 50000 PWM_POLARITY_INVERTED>;
-- 
1.9.0


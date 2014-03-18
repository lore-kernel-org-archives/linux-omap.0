From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH] DTS: ARM: TWL4030: Add madc
Date: Wed, 19 Mar 2014 00:13:46 +0100
Message-ID: <1395184426-316-2-git-send-email-sre@debian.org>
References: <1395184426-316-1-git-send-email-sre@debian.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:44780 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755388AbaCRXOA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Mar 2014 19:14:00 -0400
In-Reply-To: <1395184426-316-1-git-send-email-sre@debian.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Sebastian Reichel <sre@debian.org>

Add madc node to twl4030, so that board DTS
files can simply reference the A/D converter.

Signed-off-by: Sebastian Reichel <sre@debian.org>
---
 arch/arm/boot/dts/twl4030.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index 86cfc7d..36ae916 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -152,4 +152,10 @@
 		keypad,num-rows = <8>;
 		keypad,num-columns = <8>;
 	};
+
+	twl_madc: madc {
+		compatible = "ti,twl4030-madc";
+		interrupts = <3>;
+		#io-channel-cells = <1>;
+	};
 };
-- 
1.9.0


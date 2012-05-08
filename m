From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 1/3] arm/dts: twl4030: Add twl4030-gpio node
Date: Tue, 8 May 2012 18:37:25 +0200
Message-ID: <1336495047-5882-2-git-send-email-b-cousson@ti.com>
References: <1336495047-5882-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51179 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756242Ab2EHQiF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 12:38:05 -0400
In-Reply-To: <1336495047-5882-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>

Add the twl-gpio node inside twl4030 definition.

Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/twl4030.dtsi |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index a94654c..22f4d13 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -36,4 +36,12 @@
 		regulator-min-microvolt = <1850000>;
 		regulator-max-microvolt = <3150000>;
 	};
+
+	twl_gpio: gpio {
+		compatible = "ti,twl4030-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
 };
-- 
1.7.0.4


From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 10/12] arm/dts: twl4030: Add twl4030-gpio node
Date: Fri, 2 Mar 2012 17:50:22 +0100
Message-ID: <1330707024-23730-11-git-send-email-b-cousson@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52340 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030381Ab2CBQvY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Mar 2012 11:51:24 -0500
In-Reply-To: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>

Add the twl-gpio node inside twl4030 definition.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/twl4030.dtsi |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index 8be5223..82a27f4 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -18,4 +18,12 @@
 		compatible = "ti,twl4030-rtc";
 		interrupts = <11>;
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


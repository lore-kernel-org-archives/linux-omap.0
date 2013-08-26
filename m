From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 2/2] ARM: dts: dra7-evm: Add mmc2 node for eMMC support
Date: Mon, 26 Aug 2013 19:23:38 +0530
Message-ID: <1377525218-7655-3-git-send-email-balajitk@ti.com>
References: <1377525218-7655-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42474 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006Ab3HZNyN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Aug 2013 09:54:13 -0400
In-Reply-To: <1377525218-7655-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, nm@ti.com, Balaji T K <balajitk@ti.com>

Add mmc2 dt node to dra7-evm board
and model eMMC vcc as fixed regulator.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index a59bbd0..2062724 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -17,6 +17,13 @@
 		device_type = "memory";
 		reg = <0x80000000 0x60000000>; /* 1536 MB */
 	};
+
+	mmc2_3v3: fixedregulator-mmc2 {
+		compatible = "regulator-fixed";
+		regulator-name = "mmc2_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &dra7_pmx_core {
@@ -257,3 +264,10 @@
 	vmmc-supply = <&ldo1_reg>;
 	bus-width = <4>;
 };
+
+&mmc2 {
+	status = "okay";
+	vmmc-supply = <&mmc2_3v3>;
+	bus-width = <8>;
+	ti,non-removable;
+};
-- 
1.7.5.4


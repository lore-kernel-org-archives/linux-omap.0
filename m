From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 1/1] arm: dts: dra7-evm: add sd/eMMC node
Date: Tue, 23 Jul 2013 22:47:47 +0530
Message-ID: <1374599867-13099-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49713 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756806Ab3GWRR4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jul 2013 13:17:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, benoit.cousson@linaro.org, tony@atomide.com
Cc: Balaji T K <balajitk@ti.com>, Rajendra Nayak <rnayak@ti.com>

Add micro SD card and eMMC support for dra7-evm

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index cb0703c..4656ab4 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -17,4 +17,22 @@
 		device_type = "memory";
 		reg = <0x80000000 0x60000000>; /* 1536 MB */
 	};
+
+	vmmc_fixed: fixedregulator-mmc {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc_fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&mmc1 {
+	vmmc-supply = <&vmmc_fixed>;
+	bus-width = <4>;
+};
+
+&mmc2 {
+	vmmc-supply = <&vmmc_fixed>;
+	bus-width = <8>;
+	ti,non-removable;
 };
-- 
1.7.5.4


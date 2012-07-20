From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 3/4] arm/dts: Add tps65910 regulator DT data to am335x-evm.dts
Date: Fri, 20 Jul 2012 12:16:28 +0530
Message-ID: <1342766789-28148-4-git-send-email-anilkumar@ti.com>
References: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57315 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab2GTGqv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jul 2012 02:46:51 -0400
In-Reply-To: <1342766789-28148-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, AnilKumar Ch <anilkumar@ti.com>

Adds tps65910 regulator device tree data, which adds I2C node
with I2C frequency and tps65910 PMIC I2C slave address.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index d6a97d9..15d03ba 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -18,3 +18,13 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 };
+
+&i2c1 {
+	clock-frequency = <400000>;
+
+	tps: tps@2D {
+		reg = <0x2D>;
+	};
+};
+
+/include/ "tps65910.dtsi"
-- 
1.7.0.4


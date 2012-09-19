From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH RESEND 5/5] ARM: dts: AM33XX: Add temperature sensor device tree data to am335x-evm
Date: Thu, 20 Sep 2012 02:49:30 +0530
Message-ID: <1348089570-16161-6-git-send-email-anilkumar@ti.com>
References: <1348089570-16161-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58145 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752001Ab2ISVUJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 17:20:09 -0400
In-Reply-To: <1348089570-16161-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, AnilKumar Ch <anilkumar@ti.com>

Add temperature sensor DT data to am335x-evm.dts. In AM335x EVM
tmp275 temperature sensor is connected to I2C2 bus. So this patch
adds child node inside i2c2 node with i2c slave address. This patch
is tested on AM335x EVM.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index d25d1b3..a5c4c62 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -69,6 +69,11 @@
 				st,max-limit-y = <550>;
 				st,max-limit-z = <750>;
 			};
+
+			tmp275: tmp275@48 {
+				compatible = "ti,tmp275";
+				reg = <0x48>;
+			};
 		};
 	};
 
-- 
1.7.9.5


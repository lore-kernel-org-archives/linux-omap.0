From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 1/3] ARM: dts: AM43x-EPOS-EVM: Fix DCDC3 voltage
Date: Thu, 6 Nov 2014 16:20:02 +0530
Message-ID: <1415271004-10935-2-git-send-email-j-keerthy@ti.com>
References: <1415271004-10935-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41671 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999AbaKFKxq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Nov 2014 05:53:46 -0500
In-Reply-To: <1415271004-10935-1-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, j-keerthy@ti.com, galak@codeaurora.org, mark.rutland@arm.com, pawel.moll@arm.com

DCDC3 supplies voltage to DDR. Fix DCDC3 volatge to 1.5V which is the reset
value. Programming to a non-reset value while executing from DDR will result
in random hangs.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index ac3e485..f7e9bba 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -358,8 +358,8 @@
 		dcdc3: regulator-dcdc3 {
 			compatible = "ti,tps65218-dcdc3";
 			regulator-name = "vdcdc3";
-			regulator-min-microvolt = <1350000>;
-			regulator-max-microvolt = <1350000>;
+			regulator-min-microvolt = <1500000>;
+			regulator-max-microvolt = <1500000>;
 			regulator-boot-on;
 			regulator-always-on;
 		};
-- 
1.7.9.5


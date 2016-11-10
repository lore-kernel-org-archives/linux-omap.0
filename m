From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2 4/5] arm: dts: am57xx-beagle-x15-common: Add overide powerhold property
Date: Thu, 10 Nov 2016 10:39:19 +0530
Message-ID: <1478754560-27923-5-git-send-email-j-keerthy@ti.com>
References: <1478754560-27923-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478754560-27923-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, lee.jones@linaro.org, robh+dt@kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, nm@ti.com, j-keerthy@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

The PMICs have POWERHOLD set by default which prevents PMIC shutdown
even on DEV_CTRL On bit set to 0 as the Powerhold has higher priority.
So to enable pmic power off this property lets one over ride the default
value and enable pmic power off.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index 6df7829..78bee26 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -204,6 +204,7 @@
 		interrupt-controller;
 
 		ti,system-power-controller;
+		ti,palmas-override-powerhold;
 
 		tps659038_pmic {
 			compatible = "ti,tps659038-pmic";
-- 
1.9.1

From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 3/5] ARM: dts: omap3: add missing unit name to PMU node
Date: Fri,  1 Apr 2016 16:20:20 -0400
Message-ID: <1459542022-17246-4-git-send-email-javier@osg.samsung.com>
References: <1459542022-17246-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459542022-17246-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the following DTC warnings:

"pmu has a reg or ranges property, but no unit name"

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/omap3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index cbddde5d1e4f..e31ea5efb163 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -43,7 +43,7 @@
 		};
 	};
 
-	pmu {
+	pmu@54000000 {
 		compatible = "arm,cortex-a8-pmu";
 		reg = <0x54000000 0x800000>;
 		interrupts = <3>;
-- 
2.5.0

From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 02/23] ARM: omap3: Add missing memory node in overo and torpedo boards
Date: Wed, 31 Aug 2016 12:35:16 +0200
Message-ID: <1472639737-17586-3-git-send-email-javier@osg.samsung.com>
References: <1472639737-17586-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472639737-17586-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

The skeleton.dtsi file was removed in ARM64 for different reasons as
explained in commit ("3ebee5a2e141 arm64: dts: kill skeleton.dtsi").

These also applies to ARM and it will also allow to get rid of the
following DTC warnings in the future:

"Node /memory has a reg or ranges property, but no unit name"

But these boards don't have a memory node defined, so removing the
skeleton.dtsi inclusion from omap3.dtsi will cause a change in the
compiled DTB. Add a dummy memory node so the compiled DTB doesn't
change if the skeleton.dtsi is removed from omap3.dtsi.

Eventually the correct starting addresses and sizes should be used
but I didn't find that information.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/logicpd-torpedo-som.dtsi | 5 +++++
 arch/arm/boot/dts/omap3-overo-base.dtsi    | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
index 1c2c74655416..5a63a8d8e177 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
@@ -13,6 +13,11 @@
 		};
 	};
 
+	memory {
+		device_type = "memory";
+		reg = <0 0>;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		user0 {
diff --git a/arch/arm/boot/dts/omap3-overo-base.dtsi b/arch/arm/boot/dts/omap3-overo-base.dtsi
index 3e946cac55f3..91b2e423c7c0 100644
--- a/arch/arm/boot/dts/omap3-overo-base.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-base.dtsi
@@ -11,6 +11,12 @@
  */
 
 / {
+
+	memory {
+		device_type = "memory";
+		reg = <0 0>;
+	};
+
 	pwmleds {
 		compatible = "pwm-leds";
 
-- 
2.7.4

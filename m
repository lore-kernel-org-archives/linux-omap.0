From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 11/23] ARM: dts: am4372: Remove skeleton.dtsi usage
Date: Wed, 31 Aug 2016 12:35:25 +0200
Message-ID: <1472639737-17586-12-git-send-email-javier@osg.samsung.com>
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

The disassembled DTB are almost the same besides an empty chosen
node being removed and nodes reordered, so it shouldn't have
functional changes.

Since no am4372 based board had a memory node defined, a dummy node
is added so the compiled DTB memory node is the same than before.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/am4372.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index d8689878d67b..dda607d254ae 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -11,12 +11,16 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-#include "skeleton.dtsi"
-
 / {
 	compatible = "ti,am4372", "ti,am43";
 	interrupt-parent = <&wakeupgen>;
+	#address-cells = <1>;
+	#size-cells = <1>;
 
+	memory {
+		device_type = "memory";
+		reg = <0 0>;
+	};
 
 	aliases {
 		i2c0 = &i2c0;
-- 
2.7.4

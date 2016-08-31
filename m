From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 08/23] ARM: dts: dm814x: Remove skeleton.dtsi usage
Date: Wed, 31 Aug 2016 12:35:22 +0200
Message-ID: <1472639737-17586-9-git-send-email-javier@osg.samsung.com>
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
node being removed and nodes reordered, so it should not have
functional changes.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/boot/dts/dm814x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index 68e412c9863c..ff90a6ce6bdc 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -7,11 +7,11 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/dm814x.h>
 
-#include "skeleton.dtsi"
-
 / {
 	compatible = "ti,dm814";
 	interrupt-parent = <&intc>;
+	#address-cells = <1>;
+	#size-cells = <1>;
 
 	aliases {
 		i2c0 = &i2c1;
-- 
2.7.4

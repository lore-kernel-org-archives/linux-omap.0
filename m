From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] ARM: dts: omap3-lilly-a83x: Don't use IRQ level flag for a GPIO
Date: Tue,  6 Oct 2015 11:22:59 +0200
Message-ID: <1444123379-1590-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Christoph Fritz <chf.fritz@googlemail.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

The card detect GPIO is using IRQ_TYPE_LEVEL_LOW in the GPIO flag cells
but this defined constant is meant to be used for a IRQ and not a GPIO.
So instead use GPIO_ACTIVE_LOW that seems to be the original intention.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/boot/dts/omap3-lilly-a83x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index 46f88f86a50b..57d7c93cc72b 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -284,7 +284,7 @@
 };
 
 &mmc1 {
-	cd-gpios = <&gpio4 30 IRQ_TYPE_LEVEL_LOW>;
+	cd-gpios = <&gpio4 30 GPIO_ACTIVE_LOW>;
 	cd-inverted;
 	vmmc-supply = <&vmmc1>;
 	bus-width = <4>;
-- 
2.4.3

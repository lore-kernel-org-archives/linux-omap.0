From: "Vishwanathrao Badarkhe, Manish" <manishv.b-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: omap2plus: remove interrupt-parent property
Date: Mon, 11 Mar 2013 15:30:02 +0530
Message-ID: <1362996002-15552-1-git-send-email-manishv.b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: manishv.b-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Removed interrupt-parent property from dts file as it is already
with root node in dtsi file.

Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b-l0cyMroinI0@public.gmane.org>
---
:100644 100644 f624dc8... 36e839a... M	arch/arm/boot/dts/omap3-beagle.dts
:100644 100644 e8ba1c2... a5375fd... M	arch/arm/boot/dts/omap3-evm.dts
:100644 100644 4122efe... 389c9c7... M	arch/arm/boot/dts/omap4-panda.dts
:100644 100644 43e5258... cdf5dfd... M	arch/arm/boot/dts/omap4-sdp.dts
:100644 100644 6601e6a... 1d4a9d4... M	arch/arm/boot/dts/omap4-var-som.dts
 arch/arm/boot/dts/omap3-beagle.dts  |    1 -
 arch/arm/boot/dts/omap3-evm.dts     |    1 -
 arch/arm/boot/dts/omap4-panda.dts   |    2 --
 arch/arm/boot/dts/omap4-sdp.dts     |    2 --
 arch/arm/boot/dts/omap4-var-som.dts |    1 -
 5 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index f624dc8..36e839a 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -46,7 +46,6 @@
 	twl: twl@48 {
 		reg = <0x48>;
 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
-		interrupt-parent = <&intc>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
index e8ba1c2..a5375fd 100644
--- a/arch/arm/boot/dts/omap3-evm.dts
+++ b/arch/arm/boot/dts/omap3-evm.dts
@@ -34,7 +34,6 @@
 	twl: twl@48 {
 		reg = <0x48>;
 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
-		interrupt-parent = <&intc>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 4122efe..389c9c7 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -119,7 +119,6 @@
 		reg = <0x48>;
 		/* SPI = 0, IRQ# = 7, 4 = active high level-sensitive */
 		interrupts = <0 7 4>; /* IRQ_SYS_1N cascaded to gic */
-		interrupt-parent = <&gic>;
 	};
 
 	twl6040: twl@4b {
@@ -127,7 +126,6 @@
 		reg = <0x4b>;
 		/* SPI = 0, IRQ# = 119, 4 = active high level-sensitive */
 		interrupts = <0 119 4>; /* IRQ_SYS_2N cascaded to gic */
-		interrupt-parent = <&gic>;
 		ti,audpwron-gpio = <&gpio4 31 0>;  /* gpio line 127 */
 
 		vio-supply = <&v1v8>;
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 43e5258..cdf5dfd 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -221,7 +221,6 @@
 		reg = <0x48>;
 		/* SPI = 0, IRQ# = 7, 4 = active high level-sensitive */
 		interrupts = <0 7 4>; /* IRQ_SYS_1N cascaded to gic */
-		interrupt-parent = <&gic>;
 	};
 
 	twl6040: twl@4b {
@@ -229,7 +228,6 @@
 		reg = <0x4b>;
 		/* SPI = 0, IRQ# = 119, 4 = active high level-sensitive */
 		interrupts = <0 119 4>; /* IRQ_SYS_2N cascaded to gic */
-		interrupt-parent = <&gic>;
 		ti,audpwron-gpio = <&gpio4 31 0>;  /* gpio line 127 */
 
 		vio-supply = <&v1v8>;
diff --git a/arch/arm/boot/dts/omap4-var-som.dts b/arch/arm/boot/dts/omap4-var-som.dts
index 6601e6a..1d4a9d4 100644
--- a/arch/arm/boot/dts/omap4-var-som.dts
+++ b/arch/arm/boot/dts/omap4-var-som.dts
@@ -35,7 +35,6 @@
 		reg = <0x48>;
 		/* SPI = 0, IRQ# = 7, 4 = active high level-sensitive */
 		interrupts = <0 7 4>; /* IRQ_SYS_1N cascaded to gic */
-		interrupt-parent = <&gic>;
 	};
 };
 
-- 
1.7.4.1

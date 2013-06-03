From: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
Subject: [PATCH v2 1/4] ARM: dts: AM3XXX: Use #include for all device trees
Date: Mon,  3 Jun 2013 16:12:22 +0200
Message-ID: <1370268745-15860-2-git-send-email-florian.vaussard@epfl.ch>
References: <1370268745-15860-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1370268745-15860-1-git-send-email-florian.vaussard-p8DiymsW2f8@public.gmane.org>
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
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Replace /include/ by #include for AM33XX and AM35XX device tree
files, in order to use the C pre-processor, making use of #define
features possible.

Signed-off-by: Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
---
 arch/arm/boot/dts/am335x-bone.dts       |    2 +-
 arch/arm/boot/dts/am335x-evm.dts        |    4 ++--
 arch/arm/boot/dts/am335x-evmsk.dts      |    4 ++--
 arch/arm/boot/dts/am33xx.dtsi           |    2 +-
 arch/arm/boot/dts/am3517-evm.dts        |    2 +-
 arch/arm/boot/dts/am3517_mt_ventoux.dts |    2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 74bfcc6..0365e56 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-/include/ "am33xx.dtsi"
+#include "am33xx.dtsi"
 
 / {
 	model = "TI AM335x BeagleBone";
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 4dc46fa..9302773 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-/include/ "am33xx.dtsi"
+#include "am33xx.dtsi"
 
 / {
 	model = "TI AM335x EVM";
@@ -301,7 +301,7 @@
 	};
 };
 
-/include/ "tps65910.dtsi"
+#include "tps65910.dtsi"
 
 &tps {
 	vcc1-supply = <&vbat>;
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 4d81dbc..83ded8e 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -13,7 +13,7 @@
 
 /dts-v1/;
 
-/include/ "am33xx.dtsi"
+#include "am33xx.dtsi"
 
 / {
 	model = "TI AM335x EVM-SK";
@@ -201,7 +201,7 @@
 	};
 };
 
-/include/ "tps65910.dtsi"
+#include "tps65910.dtsi"
 
 &tps {
 	vcc1-supply = <&vbat>;
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 7818bf4..f6a0117 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -8,7 +8,7 @@
  * kind, whether express or implied.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	compatible = "ti,am33xx";
diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
index e9b5bda..e99dfaf 100644
--- a/arch/arm/boot/dts/am3517-evm.dts
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-/include/ "omap34xx.dtsi"
+#include "omap34xx.dtsi"
 
 / {
 	model = "TI AM3517 EVM (AM3517/05)";
diff --git a/arch/arm/boot/dts/am3517_mt_ventoux.dts b/arch/arm/boot/dts/am3517_mt_ventoux.dts
index 5568683..fdf5ce6 100644
--- a/arch/arm/boot/dts/am3517_mt_ventoux.dts
+++ b/arch/arm/boot/dts/am3517_mt_ventoux.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-/include/ "omap34xx.dtsi"
+#include "omap34xx.dtsi"
 
 / {
 	model = "TeeJet Mt.Ventoux";
-- 
1.7.5.4

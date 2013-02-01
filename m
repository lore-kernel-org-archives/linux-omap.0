From: Philip Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: AM33XX: Corrects typo in interrupt field in SPI node
Date: Fri, 1 Feb 2013 11:07:27 +0530
Message-ID: <1359697047-1816-1-git-send-email-avinashphilip@ti.com>
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
To: b-cousson-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vaibhav.bedia-l0cyMroinI0@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, Philip Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

DT field of "interrupts" was mentioned wrongly as "interrupt" in SPI
node. This went unnoticed as spi-omap2 driver not making use of
interrupt. Fixes the typo.

Signed-off-by: Philip Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am33xx.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index fbcb90b..cece3ad 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -309,7 +309,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x48030000 0x400>;
-			interrupt = <65>;
+			interrupts = <65>;
 			ti,spi-num-cs = <2>;
 			ti,hwmods = "spi0";
 			status = "disabled";
@@ -320,7 +320,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x481a0000 0x400>;
-			interrupt = <125>;
+			interrupts = <125>;
 			ti,spi-num-cs = <2>;
 			ti,hwmods = "spi1";
 			status = "disabled";
-- 
1.7.9.5

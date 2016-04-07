From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 12/13] ARM: dts: am335x: Provide NAND ready pin
Date: Thu, 7 Apr 2016 13:25:39 +0300
Message-ID: <1460024740-19716-13-git-send-email-rogerq@ti.com>
References: <1460024740-19716-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460024740-19716-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>, Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Rostislav Lisovy <lisovy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Enric Balletbo i Serra <eballetbo-VIneJrwqLopBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On these boards NAND ready pin status is avilable over
GPMC_WAIT0 pin.

For NAND we don't use GPMC wait pin monitoring but
get the NAND Ready/Busy# status using GPIOlib.
GPMC driver provides the WAIT0 pin status over GPIOlib.

Read speed increases from 7869 KiB/ to 8875 KiB/s
and write speed was unchanged at 5100 KiB/s.

Measured using mtd_speedtest.ko on am335x-evm.

Cc: Teresa Remmet <t.remmet-guT5V/WYfQezQB+pC5nmwQ@public.gmane.org>
Cc: Ilya Ledvich <ilya-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Rostislav Lisovy <lisovy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Enric Balletbo i Serra <eballetbo-VIneJrwqLopBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am335x-baltos-ir5221.dts | 1 +
 arch/arm/boot/dts/am335x-chilisom.dtsi     | 1 +
 arch/arm/boot/dts/am335x-cm-t335.dts       | 1 +
 arch/arm/boot/dts/am335x-evm.dts           | 1 +
 arch/arm/boot/dts/am335x-igep0033.dtsi     | 1 +
 arch/arm/boot/dts/am335x-phycore-som.dtsi  | 1 +
 6 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-baltos-ir5221.dts b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
index 6c667fb..17e92e8 100644
--- a/arch/arm/boot/dts/am335x-baltos-ir5221.dts
+++ b/arch/arm/boot/dts/am335x-baltos-ir5221.dts
@@ -241,6 +241,7 @@
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
 		nand-bus-width = <8>;
 		ti,nand-ecc-opt = "bch8";
 		ti,nand-xfer-type = "polled";
diff --git a/arch/arm/boot/dts/am335x-chilisom.dtsi b/arch/arm/boot/dts/am335x-chilisom.dtsi
index 95461a2..e48c282 100644
--- a/arch/arm/boot/dts/am335x-chilisom.dtsi
+++ b/arch/arm/boot/dts/am335x-chilisom.dtsi
@@ -214,6 +214,7 @@
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index e835644..817b1de 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -411,6 +411,7 @@ status = "okay";
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 28b9162..516673b 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -524,6 +524,7 @@
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
 		ti,nand-ecc-opt = "bch8";
 		ti,elm-id = <&elm>;
 		nand-bus-width = <8>;
diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts/am335x-igep0033.dtsi
index 6c3a9bf..df63484 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -135,6 +135,7 @@
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
 		nand-bus-width = <8>;
 		ti,nand-ecc-opt = "bch8";
 		gpmc,device-width = <1>;
diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index d4b7f3b..86f7731 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -171,6 +171,7 @@
 		interrupt-parent = <&gpmc>;
 		interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
 			     <1 IRQ_TYPE_NONE>;	/* termcount */
+		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>; /* gpmc_wait0 */
 		nand-bus-width = <8>;
 		ti,nand-ecc-opt = "bch8";
 		gpmc,device-nand = "true";
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

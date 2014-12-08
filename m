From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/5] irqchip: kill the GIC routable domain
Date: Mon, 8 Dec 2014 16:41:17 -0600
Message-ID: <20141208224116.GA2538@kahuna>
References: <1417873576-10463-1-git-send-email-marc.zyngier@arm.com>
 <20141207171646.GA12049@kahuna>
 <20141207180322.GA15688@kahuna>
 <54856B21.6070104@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42510 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbaLHWmH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Dec 2014 17:42:07 -0500
Content-Disposition: inline
In-Reply-To: <54856B21.6070104@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stefan Agner <stefan@agner.ch>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 09:10-20141208, Marc Zyngier wrote:
> On 07/12/14 18:03, Nishanth Menon wrote:
[..]
> > dra7xx-evm(3.18-rc7):  Boot PASS: http://slexy.org/raw/s2PXWFB47A
> > dra7xx-evm(irq branch):  Boot FAIL: http://slexy.org/raw/s2xMgD4zkP
> > 
> > Would you want me to debug more - dts changes perhaps?
> 
> Yes, it would be useful to find out. One thing that strikes me is that
> the kernel boots all the way, so I assume IRQs are actually up and running.

Nope, we dont usually need peripheral interrupts untill we use them..
mmc is the first to use it, followed by serial port of course :)..
> 
> One thing though. The "irq" branch shows this:
> [   15.359025] pbias_mmc_omap5: disabling
> 
> and the MMC subsystem never initializes. I'm pretty sure this is
> related. Config option?
nope. just the request mmc card was never detected (crossbar was
misconfigured)

Anyways.. The following diff[1] on top of your branch makes DRA7 work - I
assume you will squash as needed and repost with linux-omap mailing list
in CC.

I increased the scope of testing knowing that WUGEN is present in many
A9 based TI platforms as well.. and at least OMAP4 showed flakiness in
my testing.. Also a few notes:

Stuff like: am437x is a bit questionable (interrupt-parent probably should be wugen?)
175:          0       GIC  39  tps65218 

OMAP5: (should be wugen?)
308:       4323          0       GIC 106  OMAP UART2
411:          0          0       GIC 151  twl6040
405:          1          0       GIC  39  palmas

OMAP4 serial port is flaky -> not sure if it is due to routing of GIC to UART2 and not via WUGEN
IRQ branch: with my fix applied:
---------------------------------
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2aN42JkKi
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s21w2OG3hL
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s21Tlp6ZLq
 4:  am37x-evm:  Boot PASS: http://slexy.org/raw/s21Vqp6P1B
 5:  am437x-sk:  Boot PASS: http://slexy.org/raw/s2UhY45mJc
 6: am43xx-epos:  Boot PASS: http://slexy.org/raw/s20l5l2fj4
 7: am43xx-gpevm:  Boot PASS: http://slexy.org/raw/s2aRwhAtau
 8: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s2GbGmM7xU
 9: beagleboard-vanilla:  Boot PASS: http://slexy.org/raw/s209bMoHPd
10: beaglebone-black:  Boot PASS: http://slexy.org/raw/s2IzmRPyVI
11: beaglebone:  Boot PASS: http://slexy.org/raw/s2053lNp5G
12: craneboard:  Boot PASS: http://slexy.org/raw/s2kKkEoR4A
13: dra72x-evm:  Boot FAIL: http://slexy.org/raw/s21jb0oCBm (this one is known -> mmc node is missing)
14: dra7xx-evm:  Boot PASS: http://slexy.org/raw/s2ho2KH2rh
15: OMAP3430-Labrador(LDP):  Boot PASS: http://slexy.org/raw/s21U4McCJp
16:       n900:  Boot PASS: http://slexy.org/raw/s2Np9wQrYd
17:  omap5-evm:  Boot PASS: http://slexy.org/raw/s21Dd4tS2M
18: pandaboard-es:  Boot FAIL: http://slexy.org/raw/s20ty0Z6i5 (not expected)
19: pandaboard-vanilla:  Boot FAIL: http://slexy.org/raw/s20BYfaMd2 (not expected)
20:    sdp2430:  Boot PASS: http://slexy.org/raw/s21AygxGRg
21:    sdp3430:  Boot PASS: http://slexy.org/raw/s207290wN9
TOTAL = 21 boards, Booted Boards = 18, No Boot boards = 3

comparitive reference v3.18-rc7:
--------------------------------
 1: am335x-evm:  Boot PASS: http://slexy.org/raw/s2ASdqrwQx
 2:  am335x-sk:  Boot PASS: http://slexy.org/raw/s208zUIeql
 3: am3517-evm:  Boot PASS: http://slexy.org/raw/s20dx70o4a
 4:  am37x-evm:  Boot FAIL: http://slexy.org/raw/s20qKJVqIQ (ignore this: board farm issue/PMIC power script issue - unrelated and known).
 5:  am437x-sk:  Boot PASS: http://slexy.org/raw/s20K8unGsM
 6: am43xx-epos:  Boot PASS: http://slexy.org/raw/s21hPfz6DC
 7: am43xx-gpevm:  Boot PASS: http://slexy.org/raw/s2voHleSYO
 8: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s208GPH7nx
 9: beagleboard-vanilla:  Boot PASS: http://slexy.org/raw/s20jOW13Ig
10: beaglebone-black:  Boot PASS: http://slexy.org/raw/s2I60jGnCI
11: beaglebone:  Boot PASS: http://slexy.org/raw/s29u4NiShX
12: craneboard:  Boot PASS: http://slexy.org/raw/s2T7etBuGm
13: dra72x-evm:  Boot FAIL: http://slexy.org/raw/s21dmHgoXn (known issue - mmc node is missing)
14: dra7xx-evm:  Boot PASS: http://slexy.org/raw/s21cFgrB0f
15: OMAP3430-Labrador(LDP):  Boot PASS: http://slexy.org/raw/s2FBPPQ3ML
16:       n900:  Boot PASS: http://slexy.org/raw/s2RmlkVWvN
17:  omap5-evm:  Boot PASS: http://slexy.org/raw/s2YKl1szpz
18: pandaboard-es:  Boot PASS: http://slexy.org/raw/s2hvXLDMoS
19: pandaboard-vanilla:  Boot PASS: http://slexy.org/raw/s2056IOHsT
20:    sdp2430:  Boot PASS: http://slexy.org/raw/s2PYPNr7jm
21:    sdp3430:  Boot PASS: http://slexy.org/raw/s2Iyc9K8I6
TOTAL = 21 boards, Booted Boards = 19, No Boot boards = 2

I suggest skipping 3.19 if possible and giving it a more detailed time
in linux-next with omap4 etc being more thoroughly being tested before
letting it through, if possible.

[1] ------------- diff ------------
 arch/arm/boot/dts/dra7-evm.dts |    2 +-
 arch/arm/boot/dts/dra7.dtsi    |   23 +++++++++++++----------
 drivers/irqchip/irq-crossbar.c |    4 ++--
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index c6ce625..d024429 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -323,7 +323,7 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pins>;
-	interrupts-extended = <&gic GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
+	interrupts-extended = <&crossbar_mpu GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
 			      <&dra7_pmx_core 0x3e0>;
 };
 
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 43509e9..a7aa7c4 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -94,6 +94,8 @@
 		interrupts-extended = <&crossbar_mpu GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
 				      <&wakeupgen GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 
+		interrupt-parent = <&crossbar_mpu>;
+
 		prm: prm@4ae06000 {
 			compatible = "ti,dra7-prm";
 			reg = <0x4ae06000 0x3000>;
@@ -339,7 +341,7 @@
 		uart1: serial@4806a000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x4806a000 0x100>;
-			interrupts-extended = <&gic GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&crossbar_mpu GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
 			status = "disabled";
@@ -348,7 +350,7 @@
 		uart2: serial@4806c000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x4806c000 0x100>;
-			interrupts-extended = <&gic GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&crossbar_mpu GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
 			status = "disabled";
@@ -357,7 +359,7 @@
 		uart3: serial@48020000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x48020000 0x100>;
-			interrupts-extended = <&gic GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&crossbar_mpu GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 			status = "disabled";
@@ -366,7 +368,7 @@
 		uart4: serial@4806e000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x4806e000 0x100>;
-			interrupts-extended = <&gic GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&crossbar_mpu GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
                         status = "disabled";
@@ -375,7 +377,7 @@
 		uart5: serial@48066000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x48066000 0x100>;
-			interrupts-extended = <&gic GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&crossbar_mpu GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart5";
 			clock-frequency = <48000000>;
 			status = "disabled";
@@ -384,7 +386,7 @@
 		uart6: serial@48068000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x48068000 0x100>;
-			interrupts-extended = <&gic GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&crossbar_mpu GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart6";
 			clock-frequency = <48000000>;
 			status = "disabled";
@@ -393,7 +395,7 @@
 		uart7: serial@48420000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x48420000 0x100>;
-			interrupts-extended = <&gic GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&crossbar_mpu GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart7";
 			clock-frequency = <48000000>;
 			status = "disabled";
@@ -402,7 +404,7 @@
 		uart8: serial@48422000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x48422000 0x100>;
-			interrupts-extended = <&gic GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&crossbar_mpu GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart8";
 			clock-frequency = <48000000>;
 			status = "disabled";
@@ -411,7 +413,7 @@
 		uart9: serial@48424000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x48424000 0x100>;
-			interrupts-extended = <&gic GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&crossbar_mpu GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart9";
 			clock-frequency = <48000000>;
 			status = "disabled";
@@ -420,7 +422,7 @@
 		uart10: serial@4ae2b000 {
 			compatible = "ti,omap4-uart";
 			reg = <0x4ae2b000 0x100>;
-			interrupts-extended = <&gic GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&crossbar_mpu GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart10";
 			clock-frequency = <48000000>;
 			status = "disabled";
@@ -1268,6 +1270,7 @@
 			reg = <0x4a002a48 0x130>;
 			interrupt-controller;
 			interrupt-parent = <&wakeupgen>;
+			#interrupt-cells = <3>;
 			ti,max-irqs = <160>;
 			ti,max-crossbar-sources = <MAX_SOURCES>;
 			ti,reg-size = <2>;
diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index b44915a..f7daff0 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -99,7 +99,7 @@ static int allocate_gic_irq(struct irq_domain *domain, unsigned virq,
 	if (err)
 		cb->irq_map[i] = IRQ_FREE;
 	else
-		cb->write(hwirq, i);
+		cb->write(i, hwirq);
 
 	return err;
 }
@@ -353,4 +353,4 @@ static int __init irqcrossbar_init(struct device_node *node,
 	return 0;
 }
 
-IRQCHIP_DECLARE(ti_irqcrossbar, "ti,irqcrossbar", irqcrossbar_init);
+IRQCHIP_DECLARE(ti_irqcrossbar, "ti,irq-crossbar", irqcrossbar_init);
-- 
1.7.9.5

-- 
Regards,
Nishanth Menon

From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 0/5] irqchip: kill the GIC routable domain
Date: Tue, 9 Dec 2014 12:17:20 -0600
Message-ID: <20141209181719.GA2569@kahuna>
References: <1417873576-10463-1-git-send-email-marc.zyngier@arm.com>
 <20141207171646.GA12049@kahuna>
 <20141207180322.GA15688@kahuna>
 <54856B21.6070104@arm.com>
 <20141208224116.GA2538@kahuna>
 <5486C6A6.8060702@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34088 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752005AbaLISSE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Dec 2014 13:18:04 -0500
Content-Disposition: inline
In-Reply-To: <5486C6A6.8060702@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stefan Agner <stefan@agner.ch>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 09:53-20141209, Marc Zyngier wrote:
> On 08/12/14 22:41, Nishanth Menon wrote:
> 
> > Anyways.. The following diff[1] on top of your branch makes DRA7 work - I
> > assume you will squash as needed and repost with linux-omap mailing list
> > in CC.
> 
> Brilliant. I'll squash that into my tree and repost at some point.

K, it will be nice to have a reflow of the series based on v3.19-rc1
since there are dts dependencies and we dont want folks to have
regressions on their platforms of choice..

Obviously, my tests are basic boot tests and should get a few weeks(as
you already mentioned) on linux-next to get properly soaked

> 
> > I increased the scope of testing knowing that WUGEN is present in many
> > A9 based TI platforms as well.. and at least OMAP4 showed flakiness in
> > my testing.. Also a few notes:
> > 
> > Stuff like: am437x is a bit questionable (interrupt-parent probably should be wugen?)
> > 175:          0       GIC  39  tps65218 
> > 
> > OMAP5: (should be wugen?)
> > 308:       4323          0       GIC 106  OMAP UART2
> > 411:          0          0       GIC 151  twl6040
> > 405:          1          0       GIC  39  palmas
> 
> Well, I can't really tell. Someone with access to the documentation
> should be able to find out.

AM437x: http://www.ti.com/lit/pdf/spruhl7
OMAP5: http://www.ti.com/lit/pdf/swpu249

yeah, we should be able to do them as well - trivially since they follow
the same structure as other SoCs without crossbar.

> 
> > OMAP4 serial port is flaky -> not sure if it is due to routing of GIC to UART2 and not via WUGEN
> > IRQ branch: with my fix applied:
> > ---------------------------------
> 
> [...]
> 
> > 18: pandaboard-es:  Boot FAIL: http://slexy.org/raw/s20ty0Z6i5 (not expected)
> > 19: pandaboard-vanilla:  Boot FAIL: http://slexy.org/raw/s20BYfaMd2 (not expected)
> 
> If I read the log correctly, the serial port stops responding after a while?

yeah - dug at the omap4 ones a bit, obviously once the deeper c states
are hit, we'd like wakeupgen to wakeup CPU else we will be "sluggish" in
the sense that the event is detected when some other wakeupgen enabled
interrupt takes place.

Adding the following makes my panda work fine.
1: pandaboard-es:  Boot PASS: http://slexy.org/raw/s20o8DaBvh
2: pandaboard-vanilla:  Boot PASS: http://slexy.org/raw/s222JndDdh


diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 1505135..8b6d50e 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -371,8 +371,8 @@
 	twl: twl@48 {
 		reg = <0x48>;
 		/* IRQ# = 7 */
-		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
-		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to wakeupgen to gic */
+		interrupt-parent = <&wakeupgen>;
 	};
 
 	twl6040: twl@4b {
@@ -383,8 +383,8 @@
 		pinctrl-0 = <&twl6040_pins>;
 
 		/* IRQ# = 119 */
-		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_2N cascaded to gic */
-		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_2N cascaded to wakeupgen to gic */
+		interrupt-parent = <&wakeupgen>;
 		ti,audpwron-gpio = <&gpio4 31 GPIO_ACTIVE_HIGH>;  /* gpio line 127 */
 
 		vio-supply = <&v1v8>;
@@ -479,17 +479,17 @@
 };
 
 &uart2 {
-	interrupts-extended = <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH
+	interrupts-extended = <&wakeupgen GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core OMAP4_UART2_RX>;
 };
 
 &uart3 {
-	interrupts-extended = <&gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
+	interrupts-extended = <&wakeupgen GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core OMAP4_UART3_RX>;
 };
 
 &uart4 {
-	interrupts-extended = <&gic GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH
+	interrupts-extended = <&wakeupgen GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH
 			       &omap4_pmx_core OMAP4_UART4_RX>;
 };
 
-- 
Regards,
Nishanth Menon

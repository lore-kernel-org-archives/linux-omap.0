From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/10] ARM: dts: Add GPMC timings for omap zoom serial port
Date: Wed, 29 Oct 2014 17:29:02 -0700
Message-ID: <1414628948-30702-5-git-send-email-tony@atomide.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:52225 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756446AbaJ3Aad (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2014 20:30:33 -0400
In-Reply-To: <1414628948-30702-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>

The four port serial port on the zoom debug board uses a TL16CP754C
with a single interrupt and GPMC chip select. The serial ports each
use a 8 bytes for IO registers, and are 256 bytes apart on the GPMC
line.

Let's add timings for all four ports so we can remove the GPMC
workarounds for using bootloader timings.

Not caused by this patch, but looks like u-boot only properly
initializes the fifo on the first serial port. Currently the other
ports produce garbage at least with my version of u-boot. I suspect
that TL16CP754C needs non-standard initialization added to 8250
driver to properly fix this issue.

Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap-zoom-common.dtsi | 58 +++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/omap-zoom-common.dtsi b/arch/arm/boot/dts/omap-zoom-common.dtsi
index 2889b50..46ef3e4 100644
--- a/arch/arm/boot/dts/omap-zoom-common.dtsi
+++ b/arch/arm/boot/dts/omap-zoom-common.dtsi
@@ -23,6 +23,64 @@
 		interrupts = <6 IRQ_TYPE_EDGE_RISING>;	/* gpio102 */
 		clock-frequency = <1843200>;
 		current-speed = <115200>;
+		gpmc,mux-add-data = <0>;
+		gpmc,device-width = <1>;
+		gpmc,wait-pin = <1>;
+		gpmc,cycle2cycle-samecsen = <1>;
+		gpmc,cycle2cycle-diffcsen = <1>;
+		gpmc,cs-on-ns = <5>;
+		gpmc,cs-rd-off-ns = <155>;
+		gpmc,cs-wr-off-ns = <155>;
+		gpmc,adv-on-ns = <15>;
+		gpmc,adv-rd-off-ns = <40>;
+		gpmc,adv-wr-off-ns = <40>;
+		gpmc,oe-on-ns = <45>;
+		gpmc,oe-off-ns = <145>;
+		gpmc,we-on-ns = <45>;
+		gpmc,we-off-ns = <145>;
+		gpmc,rd-cycle-ns = <155>;
+		gpmc,wr-cycle-ns = <155>;
+		gpmc,access-ns = <145>;
+		gpmc,page-burst-access-ns = <20>;
+		gpmc,bus-turnaround-ns = <20>;
+		gpmc,cycle2cycle-delay-ns = <20>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wr-data-mux-bus-ns = <45>;
+		gpmc,wr-access-ns = <145>;
+	};
+	uart@3,1 {
+		compatible = "ns16550a";
+		reg = <3 0x100 8>;	/* CS3, offset 0x100, IO size 8 */
+		bank-width = <2>;
+		reg-shift = <1>;
+		reg-io-width = <1>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <6 IRQ_TYPE_EDGE_RISING>;	/* gpio102 */
+		clock-frequency = <1843200>;
+		current-speed = <115200>;
+	};
+	uart@3,2 {
+		compatible = "ns16550a";
+		reg = <3 0x200 8>;	/* CS3, offset 0x200, IO size 8 */
+		bank-width = <2>;
+		reg-shift = <1>;
+		reg-io-width = <1>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <6 IRQ_TYPE_EDGE_RISING>;	/* gpio102 */
+		clock-frequency = <1843200>;
+		current-speed = <115200>;
+	};
+	uart@3,3 {
+		compatible = "ns16550a";
+		reg = <3 0x300 8>;	/* CS3, offset 0x300, IO size 8 */
+		bank-width = <2>;
+		reg-shift = <1>;
+		reg-io-width = <1>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <6 IRQ_TYPE_EDGE_RISING>;	/* gpio102 */
+		clock-frequency = <1843200>;
+		current-speed = <115200>;
 	};
 
 	ethernet@gpmc {
-- 
2.1.1


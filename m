From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V4 1/5] ARM: dts: OMAP: Add timer nodes
Date: Fri, 19 Oct 2012 09:59:00 -0500
Message-ID: <1350658744-13509-2-git-send-email-jon-hunter@ti.com>
References: <1350658744-13509-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51477 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535Ab2JSO7Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Oct 2012 10:59:24 -0400
In-Reply-To: <1350658744-13509-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Vaibhav Hiremath <hvaibhav@ti.com>, Jon Hunter <jon-hunter@ti.com>

Add the 12 GP timers nodes present in OMAP2.
Add the 12 GP timers nodes present in OMAP3.
Add the 11 GP timers nodes present in OMAP4.
Add the 7 GP timers nodes present in AM33xx.

Add documentation for timer properties specific to OMAP.

Thanks to Vaibhav Hiremath for creating the AM33xx timer nodes. I have modified
Vaibhav's original nodes adding information on which timers support a PWM
output.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 .../devicetree/bindings/arm/omap/timer.txt         |   34 +++++++
 arch/arm/boot/dts/am33xx.dtsi                      |   61 +++++++++++
 arch/arm/boot/dts/omap2.dtsi                       |   96 ++++++++++++++++++
 arch/arm/boot/dts/omap2420.dtsi                    |    9 ++
 arch/arm/boot/dts/omap2430.dtsi                    |    9 ++
 arch/arm/boot/dts/omap3.dtsi                       |  107 ++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |   97 ++++++++++++++++++
 7 files changed, 413 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/timer.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/timer.txt b/Documentation/devicetree/bindings/arm/omap/timer.txt
new file mode 100644
index 0000000..f31d803
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/timer.txt
@@ -0,0 +1,34 @@
+OMAP Timer bindings
+
+Required properties:
+- compatible:		Must be "ti,omap2-timer" for OMAP2+ controllers.
+- reg:			Contains timer register address range (base address and
+			length).
+- interrupts: 		Contains the interrupt information for the timer. The
+			format is being dependent on which interrupt controller
+			the OMAP device uses.
+- interrupt-parent	The phandle for the interrupt controller that services
+			interrupts for this device.
+- ti,hwmods:		Name of the hwmod associated to the timer, "timer<X>",
+			where <X> is the instance number of the timer from the
+			HW spec.
+
+Optional properties:
+- ti,timer-alwon:	Indicates the timer is in an alway-on power domain.
+- ti,timer-dsp:		Indicates the timer can interrupt the on-chip DSP in
+			addition to the ARM CPU.
+- ti,timer-pwm: 	Indicates the timer can generate a PWM output.
+- ti,timer-secure: 	Indicates the timer is reserved on a secure OMAP device
+			and therefore cannot be used by the kernel.
+
+Example:
+
+timer12: timer@48304000 {
+	compatible = "ti,omap2-timer";
+	reg = <0x48304000 0xfff>;
+	interrupts = <95>;
+	interrupt-parent = <&intc>;
+	ti,hwmods = "timer12"
+	ti,timer-alwon;
+	ti,timer-secure;
+};
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index bb31bff..fd5074c 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -210,5 +210,66 @@
 			interrupt-parent = <&intc>;
 			interrupts = <91>;
 		};
+
+		timer1: timer@44e31000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x44e31000 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <67>;
+			ti,hwmods = "timer1";
+			ti,timer-alwon;
+		};
+
+		timer2: timer@48040000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48040000 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <68>;
+			ti,hwmods = "timer2";
+		};
+
+		timer3: timer@48042000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48042000 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <69>;
+			ti,hwmods = "timer3";
+		};
+
+		timer4: timer@48044000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48044000 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <92>;
+			ti,hwmods = "timer4";
+			ti,timer-pwm;
+		};
+
+		timer5: timer@48046000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48046000 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <93>;
+			ti,hwmods = "timer5";
+			ti,timer-pwm;
+		};
+
+		timer6: timer@48048000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48048000 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <94>;
+			ti,hwmods = "timer6";
+			ti,timer-pwm;
+		};
+
+		timer7: timer@4804a000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x4804a000 0x1000>;
+			interrupt-parent = <&intc>;
+			interrupts = <95>;
+			ti,hwmods = "timer7";
+			ti,timer-pwm;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index 581cb08..4e57138 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -65,5 +65,101 @@
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 		};
+
+		timer2: timer@4802a000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x4802a000 0xfff>;
+			interrupts = <38>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer2";
+		};
+
+		timer3: timer@48078000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48078000 0xfff>;
+			interrupts = <39>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer3";
+		};
+
+		timer4: timer@4807a000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x4807a000 0xfff>;
+			interrupts = <40>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer4";
+		};
+
+		timer5: timer@4807c000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x4807c000 0xfff>;
+			interrupts = <41>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer5";
+			ti,timer-dsp;
+		};
+
+		timer6: timer@4807e000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x4807e000 0xfff>;
+			interrupts = <42>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer6";
+			ti,timer-dsp;
+		};
+
+		timer7: timer@48080000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48080000 0xfff>;
+			interrupts = <43>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer7";
+			ti,timer-dsp;
+		};
+
+		timer8: timer@48082000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48082000 0xfff>;
+			interrupts = <44>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer8";
+			ti,timer-dsp;
+		};
+
+		timer9: timer@48084000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48084000 0xfff>;
+			interrupts = <45>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer9";
+			ti,timer-pwm;
+		};
+
+		timer10: timer@48086000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48086000 0xfff>;
+			interrupts = <46>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer10";
+			ti,timer-pwm;
+		};
+
+		timer11: timer@48088000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48088000 0xfff>;
+			interrupts = <47>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer11";
+			ti,timer-pwm;
+		};
+
+		timer12: timer@4808a000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x4808a000 0xfff>;
+			interrupts = <48>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer12";
+			ti,timer-pwm;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index bfd76b4..13cfa2c 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -44,5 +44,14 @@
 			interrupt-parent = <&intc>;
 			ti,hwmods = "mcbsp2";
 		};
+
+		timer1: timer@48028000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48028000 0xfff>;
+			interrupts = <37>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer1";
+			ti,timer-alwon;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index 4565d97..886b825 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -88,5 +88,14 @@
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp5";
 		};
+
+		timer1: timer@49018000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x49018000 0xfff>;
+			interrupts = <37>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer1";
+			ti,timer-alwon;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index f38ea87..1fba998 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -300,5 +300,112 @@
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp5";
 		};
+
+		timer1: timer@48318000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48318000 0xfff>;
+			interrupts = <37>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer1";
+			ti,timer-alwon;
+		};
+
+		timer2: timer@49032000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x49032000 0xfff>;
+			interrupts = <38>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer2";
+		};
+
+		timer3: timer@49034000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x49034000 0xfff>;
+			interrupts = <39>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer3";
+		};
+
+		timer4: timer@49036000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x49036000 0xfff>;
+			interrupts = <40>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer4";
+		};
+
+		timer5: timer@49038000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x49038000 0xfff>;
+			interrupts = <41>;
+			ti,hwmods = "timer5";
+			interrupt-parent = <&intc>;
+			ti,timer-dsp;
+		};
+
+		timer6: timer@4903a000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x4903a000 0xfff>;
+			interrupts = <42>;
+			ti,hwmods = "timer6";
+			interrupt-parent = <&intc>;
+			ti,timer-dsp;
+		};
+
+		timer7: timer@4903c000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x4903c000 0xfff>;
+			interrupts = <43>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer7";
+			ti,timer-dsp;
+		};
+
+		timer8: timer@4903e000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x4903e000 0xfff>;
+			interrupts = <44>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer8";
+			ti,timer-pwm;
+			ti,timer-dsp;
+		};
+
+		timer9: timer@49040000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x49040000 0xfff>;
+			interrupts = <45>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer9";
+			ti,timer-pwm;
+		};
+
+		timer10: timer@48086000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48086000 0xfff>;
+			interrupts = <46>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer10";
+			ti,timer-pwm;
+		};
+
+		timer11: timer@48088000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48088000 0xfff>;
+			interrupts = <47>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer11";
+			ti,timer-pwm;
+		};
+
+		timer12: timer@48304000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48304000 0xfff>;
+			interrupts = <95>;
+			interrupt-parent = <&intc>;
+			ti,hwmods = "timer12";
+			ti,timer-alwon;
+			ti,timer-secure;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 3883f94..f9572bf 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -438,5 +438,102 @@
 			ranges;
 			ti,hwmods = "ocp2scp_usb_phy";
 		};
+
+		timer1: timer@4a318000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x4a318000 0x7f>;
+			interrupts = <0 37 0x4>;
+			interrupt-parent = <&gic>;
+			ti,hwmods = "timer1";
+			ti,timer-alwon;
+		};
+
+		timer2: timer@48032000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48032000 0x7f>;
+			interrupts = <0 38 0x4>;
+			interrupt-parent = <&gic>;
+			ti,hwmods = "timer2";
+		};
+
+		timer3: timer@48034000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48034000 0x7f>;
+			interrupts = <0 39 0x4>;
+			interrupt-parent = <&gic>;
+			ti,hwmods = "timer3";
+		};
+
+		timer4: timer@48036000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48036000 0x7f>;
+			interrupts = <0 40 0x4>;
+			interrupt-parent = <&gic>;
+			ti,hwmods = "timer4";
+		};
+
+		timer5: timer@49038000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x49038000 0x7f>;
+			interrupts = <0 41 0x4>;
+			interrupt-parent = <&gic>;
+			ti,hwmods = "timer5";
+			ti,timer-dsp;
+		};
+
+		timer6: timer@4903a000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x4903a000 0x7f>;
+			interrupts = <0 42 0x4>;
+			interrupt-parent = <&gic>;
+			ti,hwmods = "timer6";
+			ti,timer-dsp;
+		};
+
+		timer7: timer@4903c000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x4903c000 0x7f>;
+			interrupts = <0 43 0x4>;
+			interrupt-parent = <&gic>;
+			ti,hwmods = "timer7";
+			ti,timer-dsp;
+		};
+
+		timer8: timer@4903e000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x4903e000 0x7f>;
+			interrupts = <0 44 0x4>;
+			interrupt-parent = <&gic>;
+			ti,hwmods = "timer8";
+			ti,timer-pwm;
+			ti,timer-dsp;
+		};
+
+		timer9: timer@4803e000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x4803e000 0x7f>;
+			interrupts = <0 45 0x4>;
+			interrupt-parent = <&gic>;
+			ti,hwmods = "timer9";
+			ti,timer-pwm;
+		};
+
+		timer10: timer@48086000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48086000 0x7f>;
+			interrupts = <0 46 0x4>;
+			interrupt-parent = <&gic>;
+			ti,hwmods = "timer10";
+			ti,timer-pwm;
+		};
+
+		timer11: timer@48088000 {
+			compatible = "ti,omap2-timer";
+			reg = <0x48088000 0x7f>;
+			interrupts = <0 47 0x4>;
+			interrupt-parent = <&gic>;
+			ti,hwmods = "timer11";
+			ti,timer-pwm;
+		};
 	};
 };
-- 
1.7.9.5


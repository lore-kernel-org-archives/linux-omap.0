From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: [RFC 1/4] arm/dts: OMAP: Add genernal purpose timer nodes
Date: Fri, 13 Jul 2012 17:19:31 -0500
Message-ID: <1342217976-29802-2-git-send-email-jon-hunter@ti.com>
References: <1342217976-29802-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1342217976-29802-1-git-send-email-jon-hunter-l0cyMroinI0@public.gmane.org>
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
To: Tarun Kanti DebBarma <tarun.kanti-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add the 12 GP timers nodes present in OMAP3.
Add the 11 GP timers nodes present in OMAP4.

Add documentation for timer properties specific to OMAP.

For each timer an alias is being added. The purpose for doing this is because
the OMAP dmtimer driver uses an ID to distinguish between the different timer
instances. For example, a timer can be requested by its ID. By adding an alias
for each timer we can then use the function of_alias_get_id() to extract the
ID for each timer from the alias name. The same method is used for the TTY
serial devices. If it is preferred that such an alias is not added and there
is a better way to pass an ID from device-tree let me know.

Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/arm/omap/timer.txt         |   34 +++++++
 arch/arm/boot/dts/omap3.dtsi                       |  104 ++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |   93 +++++++++++++++++
 3 files changed, 231 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/timer.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/timer.txt b/Documentation/devicetree/bindings/arm/omap/timer.txt
new file mode 100644
index 0000000..dcbb451
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/timer.txt
@@ -0,0 +1,34 @@
+OMAP Timer controller bindings
+
+Required properties:
+- compatible:
+  - "ti,omap3-timer" for OMAP3+ controllers
+- reg: Contains timer register address range (base address and length)
+- interrupts: Contains the interrupt information for the timer. The format is
+  being dependent on which interrupt controller the OMAP device uses.
+
+OMAP specific properties:
+- ti,hwmods: Name of the hwmod associated to the timer:
+  "timer<X>", <X> being the 1-based instance number from the HW spec
+- ti,timer-alwon: Indicates the timer is in an alway-on power domain.
+- ti,timer-pwm: Indicates the timer supports can generate PWM output.
+- ti,timer-secure: Indicates the timer is reserved on a secure OMAP device and
+  therefore cannot be used by the kernel.
+
+Note: Each timer should have an alias correctly numbered in "aliases" node. The
+      alias is used to identify the timer instance in the driver.
+
+Example:
+
+aliases {
+	timer12 = &timer12;
+};
+
+timer12: timer@48304000 {
+	compatible = "ti,omap3-timer";
+	reg = <0x48304000 0xfff>;
+	interrupts = <95>;
+	ti,hwmods = "timer12"
+	ti,timer-alwon;
+	ti,timer-secure;
+};
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 8109471..f309f2a 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -12,12 +12,25 @@
 
 / {
 	compatible = "ti,omap3430", "ti,omap3";
+	interrupt-parent = <&intc>;
 
 	aliases {
 		serial0 = &uart1;
 		serial1 = &uart2;
 		serial2 = &uart3;
 		serial3 = &uart4;
+		timer1 = &timer1;
+		timer2 = &timer2;
+		timer3 = &timer3;
+		timer4 = &timer4;
+		timer5 = &timer5;
+		timer6 = &timer6;
+		timer7 = &timer7;
+		timer8 = &timer8;
+		timer9 = &timer9;
+		timer10 = &timer10;
+		timer11 = &timer11;
+		timer12 = &timer12;
 	};
 
 	cpus {
@@ -220,5 +233,96 @@
 			compatible = "ti,omap3-wdt";
 			ti,hwmods = "wd_timer2";
 		};
+
+		timer1: timer@48318000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x48318000 0xfff>;
+			interrupts = <37>;
+			ti,hwmods = "timer1";
+			ti,timer-alwon;
+		};
+
+		timer2: timer@49032000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x49032000 0xfff>;
+			interrupts = <38>;
+			ti,hwmods = "timer2";
+		};
+
+		timer3: timer@49034000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x49034000 0xfff>;
+			interrupts = <39>;
+			ti,hwmods = "timer3";
+		};
+
+		timer4: timer@49036000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x49036000 0xfff>;
+			interrupts = <40>;
+			ti,hwmods = "timer4";
+		};
+
+		timer5: timer@49038000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x49038000 0xfff>;
+			interrupts = <41>;
+			ti,hwmods = "timer5";
+		};
+
+		timer6: timer@4903a000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x4903a000 0xfff>;
+			interrupts = <42>;
+			ti,hwmods = "timer6";
+		};
+
+		timer7: timer@4903c000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x4903c000 0xfff>;
+			interrupts = <43>;
+			ti,hwmods = "timer7";
+		};
+
+		timer8: timer@4903e000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x4903e000 0xfff>;
+			interrupts = <44>;
+			ti,hwmods = "timer8";
+			ti,timer-pwm;
+		};
+
+		timer9: timer@49040000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x49040000 0xfff>;
+			interrupts = <45>;
+			ti,hwmods = "timer9";
+			ti,timer-pwm;
+		};
+
+		timer10: timer@48086000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x48086000 0xfff>;
+			interrupts = <46>;
+			ti,hwmods = "timer10";
+			ti,timer-pwm;
+		};
+
+		timer11: timer@48088000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x48088000 0xfff>;
+			interrupts = <47>;
+			ti,hwmods = "timer11";
+			ti,timer-pwm;
+		};
+
+		timer12: timer@48304000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x48304000 0xfff>;
+			interrupts = <95>;
+			ti,hwmods = "timer12";
+			ti,timer-alwon;
+			ti,timer-secure;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 04cbbcb..39716c5 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -25,6 +25,17 @@
 		serial1 = &uart2;
 		serial2 = &uart3;
 		serial3 = &uart4;
+		timer1 = &timer1;
+		timer2 = &timer2;
+		timer3 = &timer3;
+		timer4 = &timer4;
+		timer5 = &timer5;
+		timer6 = &timer6;
+		timer7 = &timer7;
+		timer8 = &timer8;
+		timer9 = &timer9;
+		timer10 = &timer10;
+		timer11 = &timer11;
 	};
 
 	cpus {
@@ -295,5 +306,87 @@
 			interrupt-parent = <&gic>;
 			ti,hwmods = "dmic";
 		};
+
+		timer1: timer@4a318000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x4a318000 0x7f>;
+			interrupts = <0 37 0x4>;
+			ti,hwmods = "timer1";
+			ti,timer-alwon;
+		};
+
+		timer2: timer@48032000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x48032000 0x7f>;
+			interrupts = <0 38 0x4>;
+			ti,hwmods = "timer2";
+		};
+
+		timer3: timer@48034000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x48034000 0x7f>;
+			interrupts = <0 39 0x4>;
+			ti,hwmods = "timer3";
+		};
+
+		timer4: timer@48036000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x48036000 0x7f>;
+			interrupts = <0 40 0x4>;
+			ti,hwmods = "timer4";
+		};
+
+		timer5: timer@49038000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x49038000 0x7f>;
+			interrupts = <0 41 0x4>;
+			ti,hwmods = "timer5";
+		};
+
+		timer6: timer@4903a000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x4903a000 0x7f>;
+			interrupts = <0 42 0x4>;
+			ti,hwmods = "timer6";
+		};
+
+		timer7: timer@4903c000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x4903c000 0x7f>;
+			interrupts = <0 43 0x4>;
+			ti,hwmods = "timer7";
+		};
+
+		timer8: timer@4903e000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x4903e000 0x7f>;
+			interrupts = <0 44 0x4>;
+			ti,hwmods = "timer8";
+			ti,timer-pwm;
+		};
+
+		timer9: timer@4803e000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x4803e000 0x7f>;
+			interrupts = <0 45 0x4>;
+			ti,hwmods = "timer9";
+			ti,timer-pwm;
+		};
+
+		timer10: timer@48086000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x48086000 0x7f>;
+			interrupts = <0 46 0x4>;
+			ti,hwmods = "timer10";
+			ti,timer-pwm;
+		};
+
+		timer11: timer@48088000 {
+			compatible = "ti,omap3-timer";
+			reg = <0x48088000 0x7f>;
+			interrupts = <0 47 0x4>;
+			ti,hwmods = "timer11";
+			ti,timer-pwm;
+		};
 	};
 };
-- 
1.7.9.5

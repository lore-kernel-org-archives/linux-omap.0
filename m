From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 4/4] ARM: omap: pass minimal SoC/board data for UART
 from dt
Date: Thu, 15 Dec 2011 13:13:21 -0800
Message-ID: <20111215211320.GU32251@atomide.com>
References: <1323863746-18145-1-git-send-email-rnayak@ti.com>
 <1323863746-18145-5-git-send-email-rnayak@ti.com>
 <20111214192509.GH32251@atomide.com>
 <4EE99923.4030902@ti.com>
 <4EE9C697.4010604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:31499 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab1LOVN0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Dec 2011 16:13:26 -0500
Content-Disposition: inline
In-Reply-To: <4EE9C697.4010604@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, khilman@ti.com, govindraj.raja@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, robherring2@gmail.com

* Cousson, Benoit <b-cousson@ti.com> [111215 01:34]:
> Hi Tony,
> 
> On 12/15/2011 7:52 AM, Rajendra Nayak wrote:
> >On Thursday 15 December 2011 12:55 AM, Tony Lindgren wrote:
> >>* Rajendra Nayak<rnayak@ti.com> [111214 03:24]:
> >>>Pass minimal data needed for console boot, from dt, for
> >>>OMAP4 panda/sdp and OMAP3 beagle boards, and get rid of the
> >>>static initialization from generic board file.
> >>>
> >>>Acked-by: Rob Herring<rob.herring@calxeda.com>
> >>>Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> >>
> >>This we can't merge because this breaks serial console for
> >>omap2 because you're not adding the omap2 specific dtsi
> >>entries for omap2..
> >
> >But we never had omap2 working with DT, because we never added
> >a .dtsi file for omap2 or a .dts file for any omap2 board variants.
> >
> >Until now the DT support on OMAP has been limited to OMAP3 and OMAP4
> >with boards limited to omap3beagle/omap4Panda and omap4sdp.
> >
> >So when we do add base support for omap2, we could update those
> >with the serial entries.
> 
> I'm quite confused as well... Have you tried the current 3.2 kernel
> on an OMAP2 board?
> 
> So far I've been taking care of keeping the OMAP2 support into the
> board-generic.c file, but I've never added any omap2.dtsi or
> omap2-board.dts file to support it.

Yeah adding it is trivial, so let's just add it :)

How about we just add the following patch before the last patch
in this series?

I don't have iva there as that's different between 2420 and 2430.
But omap2.dtsi can be included later on into omap2420.dtsi and
omap2430.dtsi.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Thu, 15 Dec 2011 12:48:43 -0800
Subject: [PATCH] arm/dts: Add minimal device tree support for omap2420 and omap2430

Add minimal device tree support for omap2420 and omap2430

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- /dev/null
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -0,0 +1,67 @@
+/*
+ * Device Tree Source for OMAP2 SoC
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "ti,omap2430", "ti,omap2420", "ti,omap2";
+
+	aliases {
+		serial0 = &uart1;
+		serial1 = &uart2;
+		serial2 = &uart3;
+	};
+
+	cpus {
+		cpu@0 {
+			compatible = "arm,arm1136jf-s";
+		};
+	};
+
+	soc {
+		compatible = "ti,omap-infra";
+		mpu {
+			compatible = "ti,omap2-mpu";
+			ti,hwmods = "mpu";
+		};
+	};
+
+	ocp {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		ti,hwmods = "l3_main";
+
+		intc: interrupt-controller@1 {
+			compatible = "ti,omap2-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		uart1: serial@0x4806a000 {
+			compatible = "ti,omap2-uart";
+			ti,hwmods = "uart1";
+			clock-frequency = <48000000>;
+		};
+
+		uart2: serial@0x4806c000 {
+			compatible = "ti,omap2-uart";
+			ti,hwmods = "uart2";
+			clock-frequency = <48000000>;
+		};
+
+		uart3: serial@0x4806e000 {
+			compatible = "ti,omap2-uart";
+			ti,hwmods = "uart3";
+			clock-frequency = <48000000>;
+		};
+	};
+};

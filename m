From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Fix few omap gpmc regressions when booted with
 device tree
Date: Tue, 22 Apr 2014 08:23:48 -0700
Message-ID: <20140422152347.GB19317@atomide.com>
References: <1398128080-18903-1-git-send-email-tony@atomide.com>
 <CABxcv=nDAp=iDXxVrajELJzEG=hEV3ceMJkUaiFOpe79za+LKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10382 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756223AbaDVPXz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2014 11:23:55 -0400
Content-Disposition: inline
In-Reply-To: <CABxcv=nDAp=iDXxVrajELJzEG=hEV3ceMJkUaiFOpe79za+LKA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pekon Gupta <pekon@ti.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>

* Javier Martinez Canillas <javier@dowhile0.org> [140421 23:55]:
> On Tue, Apr 22, 2014 at 2:54 AM, Tony Lindgren <tony@atomide.com> wrote:
> >
> > 2. There seems to be some timing issues with smc911x where
> >    rsync of larger files and apt-get dist-upgrade can produce
> >    strange errors. This seems to work reliably when booted in
> >    legacy mode.
> >
> 
> In what board are you having this issue? The smsc911x driver supports
> both SMSC's LAN911x and LAN921x families and I see that we have two
> .dtsi files with different timings
> (arm/boot/dts/omap-gpmc-smsc{911x,9221}.dtsi).
> 
> This is only a wild guess, but maybe your board has a smsc LAN921x
> chip but is including omap-gpmc-smsc911x.dtsi on its DTS?

Yes it seems to have two LAN9220s, so this could be the reason.
I don't think we had the omap-gpmc-smsc9221.dtsi when I added the
timings initially.

This is on a sbc-t3730 that I'm using as a gateway that was behaving
reliably before I upgraded it to DT based booting. It's currently
at v3.13-rc3 something, but I don't think we've much GPMC changes
since then.

I'll try upgrading the kernel today and running some tests with
rsync. Looks like we can also remove quite a bit of duplicate
timing data by using omap-gpmc-smsc9221.dtsi, I'll try something
like the patch below.

In any case, I suggest others run some tests on their GPMC Ethernet
too.

Regards,

Tony

8< ----------------------
--- a/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x30.dtsi
@@ -10,18 +10,6 @@
 			cpu0-supply = <&vcc>;
 		};
 	};
-
-	vddvario: regulator-vddvario {
-		compatible = "regulator-fixed";
-		regulator-name = "vddvario";
-		regulator-always-on;
-	};
-
-	vdd33a: regulator-vdd33a {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd33a";
-		regulator-always-on;
-	};
 };
 
 &omap3_pmx_core {
@@ -51,42 +39,18 @@
 	};
 };
 
+#include "omap-gpmc-smsc9221.dtsi"
+
 &gpmc {
 	ranges = <5 0 0x2c000000 0x01000000>;
 
-	smsc1: ethernet@5,0 {
+	smsc1: ethernet@gpmc {
 		compatible = "smsc,lan9221", "smsc,lan9115";
 		pinctrl-names = "default";
 		pinctrl-0 = <&smsc1_pins>;
 		interrupt-parent = <&gpio6>;
 		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 		reg = <5 0 0xff>;
-		bank-width = <2>;
-		gpmc,mux-add-data;
-		gpmc,cs-on-ns = <0>;
-		gpmc,cs-rd-off-ns = <186>;
-		gpmc,cs-wr-off-ns = <186>;
-		gpmc,adv-on-ns = <12>;
-		gpmc,adv-rd-off-ns = <48>;
-		gpmc,adv-wr-off-ns = <48>;
-		gpmc,oe-on-ns = <54>;
-		gpmc,oe-off-ns = <168>;
-		gpmc,we-on-ns = <54>;
-		gpmc,we-off-ns = <168>;
-		gpmc,rd-cycle-ns = <186>;
-		gpmc,wr-cycle-ns = <186>;
-		gpmc,access-ns = <114>;
-		gpmc,page-burst-access-ns = <6>;
-		gpmc,bus-turnaround-ns = <12>;
-		gpmc,cycle2cycle-delay-ns = <18>;
-		gpmc,wr-data-mux-bus-ns = <90>;
-		gpmc,wr-access-ns = <186>;
-		gpmc,cycle2cycle-samecsen;
-		gpmc,cycle2cycle-diffcsen;
-		vddvario-supply = <&vddvario>;
-		vdd33a-supply = <&vdd33a>;
-		reg-io-width = <4>;
-		smsc,save-mac-address;
 	};
 };
 
--- a/arch/arm/boot/dts/omap3-sb-t35.dtsi
+++ b/arch/arm/boot/dts/omap3-sb-t35.dtsi
@@ -2,20 +2,6 @@
  * Common support for CompuLab SB-T35 used on SBC-T3530, SBC-T3517 and SBC-T3730
  */
 
-/ {
-	vddvario_sb_t35: regulator-vddvario-sb-t35 {
-		compatible = "regulator-fixed";
-		regulator-name = "vddvario";
-		regulator-always-on;
-	};
-
-	vdd33a_sb_t35: regulator-vdd33a-sb-t35 {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd33a";
-		regulator-always-on;
-	};
-};
-
 &omap3_pmx_core {
 	smsc2_pins: pinmux_smsc2_pins {
 		pinctrl-single,pins = <
@@ -38,27 +24,28 @@
 		bank-width = <2>;
 		gpmc,mux-add-data;
 		gpmc,cs-on-ns = <0>;
-		gpmc,cs-rd-off-ns = <186>;
-		gpmc,cs-wr-off-ns = <186>;
-		gpmc,adv-on-ns = <12>;
-		gpmc,adv-rd-off-ns = <48>;
-		gpmc,adv-wr-off-ns = <48>;
-		gpmc,oe-on-ns = <54>;
-		gpmc,oe-off-ns = <168>;
-		gpmc,we-on-ns = <54>;
-		gpmc,we-off-ns = <168>;
-		gpmc,rd-cycle-ns = <186>;
-		gpmc,wr-cycle-ns = <186>;
-		gpmc,access-ns = <114>;
-		gpmc,page-burst-access-ns = <6>;
-		gpmc,bus-turnaround-ns = <12>;
-		gpmc,cycle2cycle-delay-ns = <18>;
-		gpmc,wr-data-mux-bus-ns = <90>;
-		gpmc,wr-access-ns = <186>;
+		gpmc,cs-rd-off-ns = <42>;
+		gpmc,cs-wr-off-ns = <36>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <12>;
+		gpmc,adv-wr-off-ns = <12>;
+		gpmc,oe-on-ns = <0>;
+		gpmc,oe-off-ns = <42>;
+		gpmc,we-on-ns = <0>;
+		gpmc,we-off-ns = <36>;
+		gpmc,rd-cycle-ns = <60>;
+		gpmc,wr-cycle-ns = <54>;
+		gpmc,access-ns = <36>;
+		gpmc,page-burst-access-ns = <0>;
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,wr-data-mux-bus-ns = <18>;
+		gpmc,wr-access-ns = <42>;
 		gpmc,cycle2cycle-samecsen;
 		gpmc,cycle2cycle-diffcsen;
-		vddvario-supply = <&vddvario_sb_t35>;
-		vdd33a-supply = <&vdd33a_sb_t35>;
+
+		vddvario-supply = <&vddvario>;
+		vdd33a-supply = <&vdd33a>;
 		reg-io-width = <4>;
 		smsc,save-mac-address;
 	};
--- a/arch/arm/boot/dts/omap3-sbc-t3517.dts
+++ b/arch/arm/boot/dts/omap3-sbc-t3517.dts
@@ -8,6 +8,19 @@
 / {
 	model = "CompuLab SBC-T3517 with CM-T3517";
 	compatible = "compulab,omap3-sbc-t3517", "compulab,omap3-cm-t3517", "ti,am3517", "ti,omap3";
+
+	/* Only one GPMC smsc9220 on SBC-T3517, CM-T3517 uses am35x Ethernet */
+	vddvario: regulator-vddvario-sb-t35 {
+		compatible = "regulator-fixed";
+		regulator-name = "vddvario";
+		regulator-always-on;
+	};
+
+	vdd33a: regulator-vdd33a-sb-t35 {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd33a";
+		regulator-always-on;
+	};
 };
 
 &omap3_pmx_core {

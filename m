From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 25/33] ARM: dts: am33xx: add syscon support to scrm node
Date: Fri, 13 Feb 2015 10:29:24 -0800
Message-ID: <20150213182923.GP2531@atomide.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
 <1423843973-6050-23-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta2.delivery3.ore.mailhop.org ([54.213.22.21]:59966 "EHLO
	pmta2.delivery3.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753132AbbBMSeK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 13:34:10 -0500
Received: from smtp4.ore.mailhop.org (172.31.36.112) by pmta2.delivery1.ore.mailhop.org id hrp1qk20u505 for <linux-omap@vger.kernel.org>; Fri, 13 Feb 2015 18:34:17 +0000 (envelope-from <tony@atomide.com>)
Content-Disposition: inline
In-Reply-To: <1423843973-6050-23-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tomi.valkeinen@ti.com, nm@ti.com, linux-arm-kernel@lists.infradead.org

Hi Tero,

* Tero Kristo <t-kristo@ti.com> [150213 08:17]:
> Control module will be converted to use syscon, thus add compatible
> string for this. Also, remove the existing duplicate syscon entries
> at the same time, and change the users of these to use the real
> control module syscon.

We should not set the whole SCM as syscon, let's just map the
scm_conf areas. Those are the only ones that need to be shared
by various Linux generic framework implementing drivers. Those
need to be shared for regulators, clocks, PHYs and so on. For the
areas where we have a clearly separate area that can be ioremapped
by a framework implementing driver let's use that.

The reason is that I'd like to set up things so we can have standard
loadable Linux kernel modules working with just plaform_get_resource()
or of_ioremap() to take advantage of them protecting access with
request_mem_region(). We are already doing that but in an
uncoordinated fashion. See the example for dm816x below that has
things moved around to start standardizing things for the SCM
access.

> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -83,11 +83,6 @@
>  		};
>  	};
>  
> -	am33xx_control_module: control_module@4a002000 {
> -		compatible = "syscon";
> -		reg = <0x44e10000 0x7fc>;
> -	};
> -
>  	am33xx_pinmux: pinmux@44e10800 {
>  		compatible = "pinctrl-single";
>  		reg = <0x44e10800 0x0238>;

BTW, I have just this part as a separate fix in my series along
with few other fixes dts fixes for ranges, will post those around
-rc1.

Then back to making the SCM behave, we already have an example
with dm816x. the current Linux next plus a pending fix for
"[PATCH] ARM: dts: Fix USB dts configuration for dm816x" makes the
SCM look as below. I have also similar patches in works for omap3,
am33xx, am437x, and omap4.

Note that here we have already various framework implementing
drivers behaving in a standard way using request_mem_region() and
of_ioremap() with help of ranges.

We should still have a core SCM/bus driver take care of managing
the SCM clock, and trigger the save and restore of SCM registers
for PM.

Regards,

Tony

8<---------------
		scrm: scrm@48140000 {
			compatible = "ti,dm816-scrm", "simple-bus";
			reg = <0x48140000 0x21000>;
			#address-cells = <1>;
			#size-cells = <1>;
			ranges = <0 0x48140000 0x21000>;

			dm816x_pinmux: pinmux@800 {
				compatible = "pinctrl-single";
				reg = <0x800 0x50a>;
				#address-cells = <1>;
				#size-cells = <0>;
				pinctrl-single,register-width = <16>;
				pinctrl-single,function-mask = <0xf>;
			};

			/* Device Configuration Registers */
			scm_conf: syscon@600 {
				compatible = "syscon", "simple-bus";
				reg = <0x600 0x110>;
				#address-cells = <1>;
				#size-cells = <1>;
				ranges = <0 0x600 0x110>;

				usb_phy0: usb-phy@20 {
					compatible = "ti,dm8168-usb-phy";
					reg = <0x20 0x8>;
					reg-names = "phy";
					clocks = <&main_fapll 6>;
					clock-names = "refclk";
					#phy-cells = <0>;
					syscon = <&scm_conf>;
				};

				usb_phy1: usb-phy@28 {
					compatible = "ti,dm8168-usb-phy";
					reg = <0x28 0x8>;
					reg-names = "phy";
					clocks = <&main_fapll 6>;
					clock-names = "refclk";
					#phy-cells = <0>;
					syscon = <&scm_conf>;
				};
			};

			scrm_clocks: clocks {
				#address-cells = <1>;
				#size-cells = <0>;
			};

			scrm_clockdomains: clockdomains {
			};
		};

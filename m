From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH V4 1/5] ARM: dts: OMAP: Add timer nodes
Date: Thu, 25 Oct 2012 12:05:37 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB4A738@DBDE01.ent.ti.com>
References: <1350658744-13509-1-git-send-email-jon-hunter@ti.com>
 <1350658744-13509-2-git-send-email-jon-hunter@ti.com>
 <50880C19.2090508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34218 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939Ab2JYMFz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 08:05:55 -0400
In-Reply-To: <50880C19.2090508@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, "Hunter, Jon" <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Wed, Oct 24, 2012 at 21:11:13, Cousson, Benoit wrote:
> Hi Jon,
> 
> On 10/19/2012 04:59 PM, Jon Hunter wrote:
> > Add the 12 GP timers nodes present in OMAP2.
> > Add the 12 GP timers nodes present in OMAP3.
> > Add the 11 GP timers nodes present in OMAP4.
> > Add the 7 GP timers nodes present in AM33xx.
> > 
> > Add documentation for timer properties specific to OMAP.
> > 
> > Thanks to Vaibhav Hiremath for creating the AM33xx timer nodes. I have modified
> > Vaibhav's original nodes adding information on which timers support a PWM
> > output.
> > 
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> 
> I updated the patch to remove the interrupt-parent from the DTS nodes and the documentation, as discussed on the list in the context of OMAP5 DTS for GPIO.
> 
> If you are OK with that version, I'll push it to Tony along with the others DTS patches.
> 
> Regards,
> Benoit
> 
> ---
> From 531cc8142ecd6da7929628772c4035dcf7996fef Mon Sep 17 00:00:00 2001
> From: Jon Hunter <jon-hunter@ti.com>
> Date: Fri, 19 Oct 2012 09:59:00 -0500
> Subject: [PATCH] ARM: dts: OMAP: Add timer nodes
> 
> Add the 12 GP timers nodes present in OMAP2.
> Add the 12 GP timers nodes present in OMAP3.
> Add the 11 GP timers nodes present in OMAP4.
> Add the 7 GP timers nodes present in AM33xx.
> 
> Add documentation for timer properties specific to OMAP.
> 
> Thanks to Vaibhav Hiremath for creating the AM33xx timer nodes. I have modified
> Vaibhav's original nodes adding information on which timers support a PWM
> output.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> [b-cousson@ti.com: Remove the interrupt-parent from nodes]
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> ---
>  .../devicetree/bindings/arm/omap/timer.txt         |   31 +++++++
>  arch/arm/boot/dts/am33xx.dtsi                      |   54 +++++++++++
>  arch/arm/boot/dts/omap2.dtsi                       |   85 +++++++++++++++++
>  arch/arm/boot/dts/omap2420.dtsi                    |    8 ++
>  arch/arm/boot/dts/omap2430.dtsi                    |    8 ++
>  arch/arm/boot/dts/omap3.dtsi                       |   95 ++++++++++++++++++++
>  arch/arm/boot/dts/omap4.dtsi                       |   86 ++++++++++++++++++
>  7 files changed, 367 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/timer.txt
> 

Benoit,

I have boot tested this on BeagleBone, so,

Tested-By: Vaibhav Hiremath <hvaibhav@ti.com>

Thanks,
Vaibhav


> diff --git a/Documentation/devicetree/bindings/arm/omap/timer.txt b/Documentation/devicetree/bindings/arm/omap/timer.txt
> new file mode 100644
> index 0000000..b073d89
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/omap/timer.txt
> @@ -0,0 +1,31 @@
> +OMAP Timer bindings
> +
> +Required properties:
> +- compatible:		Must be "ti,omap2-timer" for OMAP2+ controllers.
> +- reg:			Contains timer register address range (base address and
> +			length).
> +- interrupts: 		Contains the interrupt information for the timer. The
> +			format is being dependent on which interrupt controller
> +			the OMAP device uses.
> +- ti,hwmods:		Name of the hwmod associated to the timer, "timer<X>",
> +			where <X> is the instance number of the timer from the
> +			HW spec.
> +
> +Optional properties:
> +- ti,timer-alwon:	Indicates the timer is in an alway-on power domain.
> +- ti,timer-dsp:		Indicates the timer can interrupt the on-chip DSP in
> +			addition to the ARM CPU.
> +- ti,timer-pwm: 	Indicates the timer can generate a PWM output.
> +- ti,timer-secure: 	Indicates the timer is reserved on a secure OMAP device
> +			and therefore cannot be used by the kernel.
> +
> +Example:
> +
> +timer12: timer@48304000 {
> +	compatible = "ti,omap2-timer";
> +	reg = <0x48304000 0xfff>;
> +	interrupts = <95>;
> +	ti,hwmods = "timer12"
> +	ti,timer-alwon;
> +	ti,timer-secure;
> +};
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 4709269..7522e16 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -237,5 +237,59 @@
>  			interrupts = <55>;
>  			status = "disabled";
>  		};
> +
> +		timer1: timer@44e31000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x44e31000 0x1000>;
> +			interrupts = <67>;
> +			ti,hwmods = "timer1";
> +			ti,timer-alwon;
> +		};
> +
> +		timer2: timer@48040000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x48040000 0x1000>;
> +			interrupts = <68>;
> +			ti,hwmods = "timer2";
> +		};
> +
> +		timer3: timer@48042000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x48042000 0x1000>;
> +			interrupts = <69>;
> +			ti,hwmods = "timer3";
> +		};
> +
> +		timer4: timer@48044000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x48044000 0x1000>;
> +			interrupts = <92>;
> +			ti,hwmods = "timer4";
> +			ti,timer-pwm;
> +		};
> +
> +		timer5: timer@48046000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x48046000 0x1000>;
> +			interrupts = <93>;
> +			ti,hwmods = "timer5";
> +			ti,timer-pwm;
> +		};
> +
> +		timer6: timer@48048000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x48048000 0x1000>;
> +			interrupts = <94>;
> +			ti,hwmods = "timer6";
> +			ti,timer-pwm;
> +		};
> +
> +		timer7: timer@4804a000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x4804a000 0x1000>;
> +			interrupts = <95>;
> +			ti,hwmods = "timer7";
> +			ti,timer-pwm;
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
> index f366482..731de55 100644
> --- a/arch/arm/boot/dts/omap2.dtsi
> +++ b/arch/arm/boot/dts/omap2.dtsi
> @@ -66,5 +66,90 @@
>  			ti,hwmods = "uart3";
>  			clock-frequency = <48000000>;
>  		};
> +
> +		timer2: timer@4802a000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x4802a000 0xfff>;
> +			interrupts = <38>;
> +			ti,hwmods = "timer2";
> +		};
> +
> +		timer3: timer@48078000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x48078000 0xfff>;
> +			interrupts = <39>;
> +			ti,hwmods = "timer3";
> +		};
> +
> +		timer4: timer@4807a000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x4807a000 0xfff>;
> +			interrupts = <40>;
> +			ti,hwmods = "timer4";
> +		};
> +
> +		timer5: timer@4807c000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x4807c000 0xfff>;
> +			interrupts = <41>;
> +			ti,hwmods = "timer5";
> +			ti,timer-dsp;
> +		};
> +
> +		timer6: timer@4807e000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x4807e000 0xfff>;
> +			interrupts = <42>;
> +			ti,hwmods = "timer6";
> +			ti,timer-dsp;
> +		};
> +
> +		timer7: timer@48080000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x48080000 0xfff>;
> +			interrupts = <43>;
> +			ti,hwmods = "timer7";
> +			ti,timer-dsp;
> +		};
> +
> +		timer8: timer@48082000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x48082000 0xfff>;
> +			interrupts = <44>;
> +			ti,hwmods = "timer8";
> +			ti,timer-dsp;
> +		};
> +
> +		timer9: timer@48084000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x48084000 0xfff>;
> +			interrupts = <45>;
> +			ti,hwmods = "timer9";
> +			ti,timer-pwm;
> +		};
> +
> +		timer10: timer@48086000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x48086000 0xfff>;
> +			interrupts = <46>;
> +			ti,hwmods = "timer10";
> +			ti,timer-pwm;
> +		};
> +
> +		timer11: timer@48088000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x48088000 0xfff>;
> +			interrupts = <47>;
> +			ti,hwmods = "timer11";
> +			ti,timer-pwm;
> +		};
> +
> +		timer12: timer@4808a000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x4808a000 0xfff>;
> +			interrupts = <48>;
> +			ti,hwmods = "timer12";
> +			ti,timer-pwm;
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
> index 4d5ce91..eee3778 100644
> --- a/arch/arm/boot/dts/omap2420.dtsi
> +++ b/arch/arm/boot/dts/omap2420.dtsi
> @@ -42,5 +42,13 @@
>  			interrupt-names = "tx", "rx";
>  			ti,hwmods = "mcbsp2";
>  		};
> +
> +		timer1: timer@48028000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x48028000 0xfff>;
> +			interrupts = <37>;
> +			ti,hwmods = "timer1";
> +			ti,timer-alwon;
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
> index fa84532..eea5b8e 100644
> --- a/arch/arm/boot/dts/omap2430.dtsi
> +++ b/arch/arm/boot/dts/omap2430.dtsi
> @@ -83,5 +83,13 @@
>  			ti,buffer-size = <128>;
>  			ti,hwmods = "mcbsp5";
>  		};
> +
> +		timer1: timer@49018000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x49018000 0xfff>;
> +			interrupts = <37>;
> +			ti,hwmods = "timer1";
> +			ti,timer-alwon;
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index 955cbdc..904c07e 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -296,5 +296,100 @@
>  			ti,buffer-size = <128>;
>  			ti,hwmods = "mcbsp5";
>  		};
> +
> +		timer1: timer@48318000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x48318000 0xfff>;
> +			interrupts = <37>;
> +			ti,hwmods = "timer1";
> +			ti,timer-alwon;
> +		};
> +
> +		timer2: timer@49032000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x49032000 0xfff>;
> +			interrupts = <38>;
> +			ti,hwmods = "timer2";
> +		};
> +
> +		timer3: timer@49034000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x49034000 0xfff>;
> +			interrupts = <39>;
> +			ti,hwmods = "timer3";
> +		};
> +
> +		timer4: timer@49036000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x49036000 0xfff>;
> +			interrupts = <40>;
> +			ti,hwmods = "timer4";
> +		};
> +
> +		timer5: timer@49038000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x49038000 0xfff>;
> +			interrupts = <41>;
> +			ti,hwmods = "timer5";
> +			ti,timer-dsp;
> +		};
> +
> +		timer6: timer@4903a000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x4903a000 0xfff>;
> +			interrupts = <42>;
> +			ti,hwmods = "timer6";
> +			ti,timer-dsp;
> +		};
> +
> +		timer7: timer@4903c000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x4903c000 0xfff>;
> +			interrupts = <43>;
> +			ti,hwmods = "timer7";
> +			ti,timer-dsp;
> +		};
> +
> +		timer8: timer@4903e000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x4903e000 0xfff>;
> +			interrupts = <44>;
> +			ti,hwmods = "timer8";
> +			ti,timer-pwm;
> +			ti,timer-dsp;
> +		};
> +
> +		timer9: timer@49040000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x49040000 0xfff>;
> +			interrupts = <45>;
> +			ti,hwmods = "timer9";
> +			ti,timer-pwm;
> +		};
> +
> +		timer10: timer@48086000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x48086000 0xfff>;
> +			interrupts = <46>;
> +			ti,hwmods = "timer10";
> +			ti,timer-pwm;
> +		};
> +
> +		timer11: timer@48088000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x48088000 0xfff>;
> +			interrupts = <47>;
> +			ti,hwmods = "timer11";
> +			ti,timer-pwm;
> +		};
> +
> +		timer12: timer@48304000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x48304000 0xfff>;
> +			interrupts = <95>;
> +			ti,hwmods = "timer12";
> +			ti,timer-alwon;
> +			ti,timer-secure;
> +		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 2ab6e68..77f9cc9 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -433,5 +433,91 @@
>  			ranges;
>  			ti,hwmods = "ocp2scp_usb_phy";
>  		};
> +
> +		timer1: timer@4a318000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x4a318000 0x7f>;
> +			interrupts = <0 37 0x4>;
> +			ti,hwmods = "timer1";
> +			ti,timer-alwon;
> +		};
> +
> +		timer2: timer@48032000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x48032000 0x7f>;
> +			interrupts = <0 38 0x4>;
> +			ti,hwmods = "timer2";
> +		};
> +
> +		timer3: timer@48034000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x48034000 0x7f>;
> +			interrupts = <0 39 0x4>;
> +			ti,hwmods = "timer3";
> +		};
> +
> +		timer4: timer@48036000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x48036000 0x7f>;
> +			interrupts = <0 40 0x4>;
> +			ti,hwmods = "timer4";
> +		};
> +
> +		timer5: timer@49038000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x49038000 0x7f>;
> +			interrupts = <0 41 0x4>;
> +			ti,hwmods = "timer5";
> +			ti,timer-dsp;
> +		};
> +
> +		timer6: timer@4903a000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x4903a000 0x7f>;
> +			interrupts = <0 42 0x4>;
> +			ti,hwmods = "timer6";
> +			ti,timer-dsp;
> +		};
> +
> +		timer7: timer@4903c000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x4903c000 0x7f>;
> +			interrupts = <0 43 0x4>;
> +			ti,hwmods = "timer7";
> +			ti,timer-dsp;
> +		};
> +
> +		timer8: timer@4903e000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x4903e000 0x7f>;
> +			interrupts = <0 44 0x4>;
> +			ti,hwmods = "timer8";
> +			ti,timer-pwm;
> +			ti,timer-dsp;
> +		};
> +
> +		timer9: timer@4803e000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x4803e000 0x7f>;
> +			interrupts = <0 45 0x4>;
> +			ti,hwmods = "timer9";
> +			ti,timer-pwm;
> +		};
> +
> +		timer10: timer@48086000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x48086000 0x7f>;
> +			interrupts = <0 46 0x4>;
> +			ti,hwmods = "timer10";
> +			ti,timer-pwm;
> +		};
> +
> +		timer11: timer@48088000 {
> +			compatible = "ti,omap2-timer";
> +			reg = <0x48088000 0x7f>;
> +			interrupts = <0 47 0x4>;
> +			ti,hwmods = "timer11";
> +			ti,timer-pwm;
> +		};
>  	};
>  };
> -- 
> 1.7.0.4
> 
> 
> 
> 


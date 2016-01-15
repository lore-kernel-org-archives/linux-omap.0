From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging of backup battery
Date: Fri, 15 Jan 2016 15:33:00 +0100
Message-ID: <D8D33064-B36E-41C9-AA08-353FF8A64367@goldelico.com>
References: <5696896F.4090309@ti.com> <20160113180006.GJ12777@atomide.com> <2B99611A-5D2E-4D17-A17D-0150516109FD@goldelico.com> <56969800.5010206@ti.com> <D6479E92-4226-4B07-95F3-C0DF092B827C@goldelico.com> <5696A002.6050402@ti.com> <20160113194032.GL12777@atomide.com> <5696D097.3040208@gmail.com> <56977211.8070206@ti.com> <5697DD4C.8010701@ti.com> <20160114183510.GP12777@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160114183510.GP12777@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>, Keerthy <a0393675@ti.com>, Nishanth Menon <menon.nishanth@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas@gmail.com>, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org


Am 14.01.2016 um 19:35 schrieb Tony Lindgren <tony@atomide.com>:

> * Nishanth Menon <nm@ti.com> [160114 09:40]:
>> On 01/14/2016 04:01 AM, Keerthy wrote:
>>> 
>>> IIRC without configuring the mux mode of gpio234 to msecure mode we were 
>>> unable to write to the rtc registers. Hence configured it one time at boot.
>>> 
>> Looks like you missed the code section that shows that the u-boot
>> configuration was overridden by kernel as GPIO for the very same reason.!
>> 
>> http://git.omapzoom.org/?p=kernel/omap.git;a=blob;f=arch/arm/mach-omap2/board-omap5panda.c;h=6113bc0e04625a1bd794b3f169581c67ad3b42ff;hb=refs/heads/p-linux-omap-3.4#l816
> 
> OK so let's use the GPIO hog for the msecure pin then.
> Here's an
> updated patch, please retest that hwclock -w works properly with
> the RTC patch in this thread.

I tried and it works.

But then I found that you did set MUX_MODE7. Which is safe-mode.

And in safe-mode the gpio8_234/msecure ball should be "L".

Then I experimented a little and it appears that you can remove
the gpio-hog entry:

root@letux:~# devmem2 0x4A002980
/dev/mem opened.
Memory mapped at address 0xb6f48000.
Value at address 0x4A002980 (0xb6f48980): 0x1080006
root@letux:~# hwclock
Fri Jan 15 13:32:52 2016  -0.726651 seconds
root@letux:~# 

Or even mux the gpio to PIN_INPUT_PULLDOWN | MUX_MODE6:

root@letux:~# devmem2 0x4A002980
/dev/mem opened.
Memory mapped at address 0xb6f35000.
Value at address 0x4A002980 (0xb6f35980): 0x108010E
root@letux:~# hwclock
Fri Jan 15 14:30:05 2016  -1.155714 seconds
root@letux:~# 

So I now wonder if the twl6037 variant on the OMAP5432EVM really has
the gpio7 enabled as msecure input (there is some mention of OTP variants
in the Palmas docs I have, but I don't have the one of the exact chip variant used
on the EVM).

If it were disabled by OTP (and then I assume it is automatically write-unprotected),
then we would simply have a useless connection from gpio8_234 to Palmas...

So the outcome might depend on the Palmas chip version that is used on any
board that includes the omap5-board-common.dtsi.

And the main difference between hwclock not-working and working on the omap5evm
should be the nirq1 part of your patch!

Please can someone else confirm that hwclock works without any init for
the msecure line and that I did not have a false positive by some other reason?

BR,
Nikolaus

> 
> Regards,
> 
> Tony
> 
> 8<--------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Mon, 11 Jan 2016 14:35:24 -0800
> Subject: [PATCH] ARM: dts: Fix omap5 PMIC control lines for RTC writes
> 
> The palmas PMIC has two control lines that need to be muxed properly
> for things to work. The sys_nirq pin is used for interrupts, and msecure
> pin is used for enabling writes to some PMIC registers.
> 
> Without these pins configured properly things can fail in mysterious
> ways. For example, we can't update the RTC registers on palmas PMIC
> unless the msecure pin is configured. And this is probably the reason
> why we had RTC missing from the omap5 dts file.
> 
> According to "OMAP5430 ES2.0 Data Manual [Public] VErsion A (Rev. F)"
> swps052f.pdf, mux mode 1 is for sys_drm_msecure so there's no need to
> configure it as a GPIO pin.
> 
> However, it seems there are some reliability issues using the msecure
> mux mode. The TI trees configure the msecure pin as GPIO out high
> instead.
> 
> As the PMIC only cares that the msecure line is high to allow access
> to the RTC registers, let's use a GPIO hog as suggested by Nishanth
> Menon <nm@ti.com>. Also the use of the internal pull was considered
> but supposedly that may not be capable of driving the line in a noisy
> environment.
> 
> If we ever see high security omap5 products in the mainline tree,
> those need to skip the msecure pin muxing and ignore setting the GPIO
> hog. Chances are the related pin mux registers are locked in that case
> and the msecure pin is managed by whatever software may be running in
> the ARM TrustZone.
> 
> Who knows what the original intention of the msecure pin was. Maybe
> it was supposed to prevent the system time to be set back for some
> game demo modes to time out? Anyways, it seems that later PMICs like
> tps659037 have recycled this pin for "powerhold" and devices like
> beagle-x15 do not need changes to the msecure pin configuration.
> 
> To avoid further confusion with TWL variant PMICs, beagle-x15 does
> not have a back-up battery for RTC palmas. Instead the mcp79410 RTC
> is used with rtc-ds1307 driver. There is a "powerhold" jumper j5
> holes near the palmas PMIC, and shorting it seems to power up
> beagle-x15 automatically. It is unknown if it also has other side
> effects to the beagle-x15 power up sequence.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> --- a/arch/arm/boot/dts/omap5-board-common.dtsi
> +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
> @@ -130,6 +130,16 @@
> 	};
> };
> 
> +&gpio8 {
> +	/* TI trees use GPIO instead of msecure, see also muxing */
> +	p234 {
> +		gpio-hog;
> +		gpios = <10 GPIO_ACTIVE_HIGH>;
> +		output-high;
> +		line-name = "gpio8_234/msecure";
> +	};
> +};
> +
> &omap5_pmx_core {
> 	pinctrl-names = "default";
> 	pinctrl-0 = <
> @@ -213,6 +223,13 @@
> 		>;
> 	};
> 
> +	/* TI trees use GPIO mode; msecure mode does not work reliably? */
> +	palmas_msecure_pins: palmas_msecure_pins {
> +		pinctrl-single,pins = <
> +			OMAP5_IOPAD(0x180, PIN_OUTPUT | MUX_MODE7) /* gpio8_234 */

s/MUX_MODE7/MUX_MODE0/

or

s/MUX_MODE7/MUX_MODE6/

> +		>;
> +	};
> +
> 	usbhost_pins: pinmux_usbhost_pins {
> 		pinctrl-single,pins = <
> 			0x84 (PIN_INPUT | MUX_MODE0) /* usbb2_hsic_strobe */
> @@ -278,6 +295,12 @@
> 			&usbhost_wkup_pins
> 	>;
> 
> +	palmas_sys_nirq_pins: pinmux_palmas_sys_nirq_pins {
> +		pinctrl-single,pins = <
> +			OMAP5_IOPAD(0x068, PIN_INPUT_PULLUP | MUX_MODE0) /* sys_nirq1 */
> +		>;
> +	};
> +
> 	usbhost_wkup_pins: pinmux_usbhost_wkup_pins {
> 		pinctrl-single,pins = <
> 			0x1A (PIN_OUTPUT | MUX_MODE0) /* fref_clk1_out, USB hub clk */
> @@ -345,6 +368,8 @@
> 		interrupt-controller;
> 		#interrupt-cells = <2>;
> 		ti,system-power-controller;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&palmas_sys_nirq_pins &palmas_msecure_pins>;
> 
> 		extcon_usb3: palmas_usb {
> 			compatible = "ti,palmas-usb-vid";

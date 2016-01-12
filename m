From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging of backup battery
Date: Tue, 12 Jan 2016 22:27:00 +0100
Message-ID: <E4C8F6CA-37C1-406F-9804-46055253BED9@goldelico.com>
References: <8FE6954B-6411-4593-9CE5-717A469A6AA8@goldelico.com> <20160106164136.GI12777@atomide.com> <2AC46952-3758-458A-B0A5-1794C207BD4C@goldelico.com> <20160106170925.GK12777@atomide.com> <66F37918-EA7F-4D83-8B5F-A6B5C0CD7623@goldelico.com> <20160108181551.GX12777@atomide.com> <832803EE-E4CB-46B1-BF39-2DC0BB695A5D@goldelico.com> <20160108190457.GY12777@atomide.com> <CCB763BE-5D1F-4A53-BF9A-C12C08A6EFC4@goldelico.com> <20160111202421.GA12777@atomide.com> <20160112000917.GC12777@atomide.com> <417BBA32-A7DC-40CD-8A6B-EA910B1C9C13@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <417BBA32-A7DC-40CD-8A6B-EA910B1C9C13@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>, Nishanth Menon <nm@ti.com>, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Am 12.01.2016 um 14:30 schrieb H. Nikolaus Schaller <hns@goldelico.com>:

> Hi Tony,
> 
> Am 12.01.2016 um 01:09 schrieb Tony Lindgren <tony@atomide.com>:
> 
>> * Tony Lindgren <tony@atomide.com> [160111 12:27]:
>>> 
>>> OK so the issue is that the twl msecure pin should be high to enable
>>> the RTC registers. We used to have that code with platform_data, but
>>> no longer have it with device tree based booting. I'll send a patch
>>> for that.
>>> 
>>> Curiously setting jumper j5 on beagle-x15 that controls what used to
>>> be the msecure and now is powerhold, does the opposite.. The
>>> device boots automatically but RTC is stopped?
>> 
>> And here's a fix the issue for omap5. Beagle-x15 needs to be
>> investigated more.
>> 
>> Care to test it with your RTC enabling patch?
> 
> yes, I will test asap.
> 
> Reminds me on some issues we did have with msecure and twl4030 rtc some years ago.

Ok, works for me on OMAP5432EVM.

Thanks for spotting the issue.

> 
> BR,
> Nikolaus
> 
>> 
>> Regards,
>> 
>> Tony
>> 
>> 8< ---------------
>> From: Tony Lindgren <tony@atomide.com>
>> Date: Mon, 11 Jan 2016 14:35:24 -0800
>> Subject: [PATCH] ARM: dts: Fix omap5 PMIC control lines for RTC writes
>> 
>> The palmas PMIC has some control lines that need to be muxed properly
>> for things to work. The sys_nirq pin is used for interrupts, and msecure
>> pin is used for enabling writes to some PMIC registers.
>> 
>> Without these pins configured properly things can fail in mysterious
>> ways. For example, we can't update the RTC registers on palmas PMIC
>> unless the msecure pin is configured. And this is probably the reason
>> why we had RTC missing from the omap5 dts file.
>> 
>> According to "OMAP5430 ES2.0 Data Manual [Public] VErsion A (Rev. F)"
>> swps052f.pdf, mux mode 1 is for sys_drm_msecure so there's no need to
>> configure it as a GPIO pin.
>> 
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> 
>> --- a/arch/arm/boot/dts/omap5-board-common.dtsi
>> +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
>> @@ -213,6 +213,12 @@
>> 		>;
>> 	};
>> 
>> +	palmas_msecure_pins: palmas_msecure_pins {
>> +		pinctrl-single,pins = <
>> +			OMAP5_IOPAD(0x180, PIN_OUTPUT | MUX_MODE1) /* gpio8_234.sys_drm_msecure */
>> +		>;
>> +	};
>> +
>> 	usbhost_pins: pinmux_usbhost_pins {
>> 		pinctrl-single,pins = <
>> 			0x84 (PIN_INPUT | MUX_MODE0) /* usbb2_hsic_strobe */
>> @@ -278,6 +284,12 @@
>> 			&usbhost_wkup_pins
>> 	>;
>> 
>> +	palmas_sys_nirq_pins: pinmux_palmas_sys_nirq_pins {
>> +		pinctrl-single,pins = <
>> +			OMAP5_IOPAD(0x068, PIN_INPUT_PULLUP | MUX_MODE0) /* sys_nirq1 */
>> +		>;
>> +	};
>> +
>> 	usbhost_wkup_pins: pinmux_usbhost_wkup_pins {
>> 		pinctrl-single,pins = <
>> 			0x1A (PIN_OUTPUT | MUX_MODE0) /* fref_clk1_out, USB hub clk */
>> @@ -345,6 +357,8 @@
>> 		interrupt-controller;
>> 		#interrupt-cells = <2>;
>> 		ti,system-power-controller;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&palmas_sys_nirq_pins &palmas_msecure_pins>;
>> 
>> 		extcon_usb3: palmas_usb {
>> 			compatible = "ti,palmas-usb-vid";
> 

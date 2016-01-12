From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging of backup battery
Date: Tue, 12 Jan 2016 14:30:27 +0100
Message-ID: <417BBA32-A7DC-40CD-8A6B-EA910B1C9C13@goldelico.com>
References: <8FE6954B-6411-4593-9CE5-717A469A6AA8@goldelico.com> <20160106164136.GI12777@atomide.com> <2AC46952-3758-458A-B0A5-1794C207BD4C@goldelico.com> <20160106170925.GK12777@atomide.com> <66F37918-EA7F-4D83-8B5F-A6B5C0CD7623@goldelico.com> <20160108181551.GX12777@atomide.com> <832803EE-E4CB-46B1-BF39-2DC0BB695A5D@goldelico.com> <20160108190457.GY12777@atomide.com> <CCB763BE-5D1F-4A53-BF9A-C12C08A6EFC4@goldelico.com> <20160111202421.GA12777@atomide.com> <20160112000917.GC12777@atomide.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160112000917.GC12777-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Am 12.01.2016 um 01:09 schrieb Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>:

> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [160111 12:27]:
>> 
>> OK so the issue is that the twl msecure pin should be high to enable
>> the RTC registers. We used to have that code with platform_data, but
>> no longer have it with device tree based booting. I'll send a patch
>> for that.
>> 
>> Curiously setting jumper j5 on beagle-x15 that controls what used to
>> be the msecure and now is powerhold, does the opposite.. The
>> device boots automatically but RTC is stopped?
> 
> And here's a fix the issue for omap5. Beagle-x15 needs to be
> investigated more.
> 
> Care to test it with your RTC enabling patch?

yes, I will test asap.

Reminds me on some issues we did have with msecure and twl4030 rtc some years ago.

BR,
Nikolaus

> 
> Regards,
> 
> Tony
> 
> 8< ---------------
> From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Date: Mon, 11 Jan 2016 14:35:24 -0800
> Subject: [PATCH] ARM: dts: Fix omap5 PMIC control lines for RTC writes
> 
> The palmas PMIC has some control lines that need to be muxed properly
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
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> 
> --- a/arch/arm/boot/dts/omap5-board-common.dtsi
> +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
> @@ -213,6 +213,12 @@
> 		>;
> 	};
> 
> +	palmas_msecure_pins: palmas_msecure_pins {
> +		pinctrl-single,pins = <
> +			OMAP5_IOPAD(0x180, PIN_OUTPUT | MUX_MODE1) /* gpio8_234.sys_drm_msecure */
> +		>;
> +	};
> +
> 	usbhost_pins: pinmux_usbhost_pins {
> 		pinctrl-single,pins = <
> 			0x84 (PIN_INPUT | MUX_MODE0) /* usbb2_hsic_strobe */
> @@ -278,6 +284,12 @@
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
> @@ -345,6 +357,8 @@
> 		interrupt-controller;
> 		#interrupt-cells = <2>;
> 		ti,system-power-controller;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&palmas_sys_nirq_pins &palmas_msecure_pins>;
> 
> 		extcon_usb3: palmas_usb {
> 			compatible = "ti,palmas-usb-vid";

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

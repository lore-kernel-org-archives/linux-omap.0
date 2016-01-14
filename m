From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and
 charging of backup battery
Date: Thu, 14 Jan 2016 10:35:10 -0800
Message-ID: <20160114183510.GP12777@atomide.com>
References: <5696896F.4090309@ti.com>
 <20160113180006.GJ12777@atomide.com>
 <2B99611A-5D2E-4D17-A17D-0150516109FD@goldelico.com>
 <56969800.5010206@ti.com>
 <D6479E92-4226-4B07-95F3-C0DF092B827C@goldelico.com>
 <5696A002.6050402@ti.com>
 <20160113194032.GL12777@atomide.com>
 <5696D097.3040208@gmail.com>
 <56977211.8070206@ti.com>
 <5697DD4C.8010701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5697DD4C.8010701-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>, Nishanth Menon <menon.nishanth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, =?utf-8?Q?Gra=C5=BEvydas?= Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [160114 09:40]:
> On 01/14/2016 04:01 AM, Keerthy wrote:
> > 
> > IIRC without configuring the mux mode of gpio234 to msecure mode we were 
> > unable to write to the rtc registers. Hence configured it one time at boot.
> > 
> Looks like you missed the code section that shows that the u-boot
> configuration was overridden by kernel as GPIO for the very same reason.!
> 
> http://git.omapzoom.org/?p=kernel/omap.git;a=blob;f=arch/arm/mach-omap2/board-omap5panda.c;h=6113bc0e04625a1bd794b3f169581c67ad3b42ff;hb=refs/heads/p-linux-omap-3.4#l816

OK so let's use the GPIO hog for the msecure pin then. Here's an
updated patch, please retest that hwclock -w works properly with
the RTC patch in this thread.

Regards,

Tony

8<--------------------
From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date: Mon, 11 Jan 2016 14:35:24 -0800
Subject: [PATCH] ARM: dts: Fix omap5 PMIC control lines for RTC writes

The palmas PMIC has two control lines that need to be muxed properly
for things to work. The sys_nirq pin is used for interrupts, and msecure
pin is used for enabling writes to some PMIC registers.

Without these pins configured properly things can fail in mysterious
ways. For example, we can't update the RTC registers on palmas PMIC
unless the msecure pin is configured. And this is probably the reason
why we had RTC missing from the omap5 dts file.

According to "OMAP5430 ES2.0 Data Manual [Public] VErsion A (Rev. F)"
swps052f.pdf, mux mode 1 is for sys_drm_msecure so there's no need to
configure it as a GPIO pin.

However, it seems there are some reliability issues using the msecure
mux mode. The TI trees configure the msecure pin as GPIO out high
instead.

As the PMIC only cares that the msecure line is high to allow access
to the RTC registers, let's use a GPIO hog as suggested by Nishanth
Menon <nm-l0cyMroinI0@public.gmane.org>. Also the use of the internal pull was considered
but supposedly that may not be capable of driving the line in a noisy
environment.

If we ever see high security omap5 products in the mainline tree,
those need to skip the msecure pin muxing and ignore setting the GPIO
hog. Chances are the related pin mux registers are locked in that case
and the msecure pin is managed by whatever software may be running in
the ARM TrustZone.

Who knows what the original intention of the msecure pin was. Maybe
it was supposed to prevent the system time to be set back for some
game demo modes to time out? Anyways, it seems that later PMICs like
tps659037 have recycled this pin for "powerhold" and devices like
beagle-x15 do not need changes to the msecure pin configuration.

To avoid further confusion with TWL variant PMICs, beagle-x15 does
not have a back-up battery for RTC palmas. Instead the mcp79410 RTC
is used with rtc-ds1307 driver. There is a "powerhold" jumper j5
holes near the palmas PMIC, and shorting it seems to power up
beagle-x15 automatically. It is unknown if it also has other side
effects to the beagle-x15 power up sequence.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -130,6 +130,16 @@
 	};
 };
 
+&gpio8 {
+	/* TI trees use GPIO instead of msecure, see also muxing */
+	p234 {
+		gpio-hog;
+		gpios = <10 GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "gpio8_234/msecure";
+	};
+};
+
 &omap5_pmx_core {
 	pinctrl-names = "default";
 	pinctrl-0 = <
@@ -213,6 +223,13 @@
 		>;
 	};
 
+	/* TI trees use GPIO mode; msecure mode does not work reliably? */
+	palmas_msecure_pins: palmas_msecure_pins {
+		pinctrl-single,pins = <
+			OMAP5_IOPAD(0x180, PIN_OUTPUT | MUX_MODE7) /* gpio8_234 */
+		>;
+	};
+
 	usbhost_pins: pinmux_usbhost_pins {
 		pinctrl-single,pins = <
 			0x84 (PIN_INPUT | MUX_MODE0) /* usbb2_hsic_strobe */
@@ -278,6 +295,12 @@
 			&usbhost_wkup_pins
 	>;
 
+	palmas_sys_nirq_pins: pinmux_palmas_sys_nirq_pins {
+		pinctrl-single,pins = <
+			OMAP5_IOPAD(0x068, PIN_INPUT_PULLUP | MUX_MODE0) /* sys_nirq1 */
+		>;
+	};
+
 	usbhost_wkup_pins: pinmux_usbhost_wkup_pins {
 		pinctrl-single,pins = <
 			0x1A (PIN_OUTPUT | MUX_MODE0) /* fref_clk1_out, USB hub clk */
@@ -345,6 +368,8 @@
 		interrupt-controller;
 		#interrupt-cells = <2>;
 		ti,system-power-controller;
+		pinctrl-names = "default";
+		pinctrl-0 = <&palmas_sys_nirq_pins &palmas_msecure_pins>;
 
 		extcon_usb3: palmas_usb {
 			compatible = "ti,palmas-usb-vid";
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

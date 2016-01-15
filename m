From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and
 charging of backup battery
Date: Fri, 15 Jan 2016 09:10:20 -0800
Message-ID: <20160115171019.GC3904@atomide.com>
References: <56969800.5010206@ti.com>
 <D6479E92-4226-4B07-95F3-C0DF092B827C@goldelico.com>
 <5696A002.6050402@ti.com>
 <20160113194032.GL12777@atomide.com>
 <5696D097.3040208@gmail.com>
 <56977211.8070206@ti.com>
 <5697DD4C.8010701@ti.com>
 <20160114183510.GP12777@atomide.com>
 <D8D33064-B36E-41C9-AA08-353FF8A64367@goldelico.com>
 <20160115154645.GA3904@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160115154645.GA3904-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Keerthy <a0393675-l0cyMroinI0@public.gmane.org>, Nishanth Menon <menon.nishanth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, =?utf-8?Q?Gra=C5=BEvydas?= Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [160115 07:48]:
> * H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [160115 06:34]:
> > I tried and it works.
> > 
> > But then I found that you did set MUX_MODE7. Which is safe-mode.
> 
> Oops, that's a typo, sorry!
> 
> > And in safe-mode the gpio8_234/msecure ball should be "L".
> > 
> > Then I experimented a little and it appears that you can remove
> > the gpio-hog entry:
> > 
> > root@letux:~# devmem2 0x4A002980
> > /dev/mem opened.
> > Memory mapped at address 0xb6f48000.
> > Value at address 0x4A002980 (0xb6f48980): 0x1080006
> > root@letux:~# hwclock
> > Fri Jan 15 13:32:52 2016  -0.726651 seconds
> > root@letux:~# 
> > 
> > Or even mux the gpio to PIN_INPUT_PULLDOWN | MUX_MODE6:
> 
> Hmm interesting. Have to test here too. FYI, it might be also worth
> draining the back-up battery with a small resistor while testing
> to make sure there's no initial state in the PMIC.

Looks like the bootloader has mux mode 0x118 here for me. That does
not work for hwclock -w. Also commenting out the GPIO hog makes the
hwclock -w stop working for me. So looks like I need both the mux
and GPIO hog for hwclock -w to work.

I've also retested the patch I sent yesterday with MUX_MODE7 typo,
and hwclock -w does not work with that one. I must have fat fingered
that somehow yesterday and not retested. I have not retested the
msecure muxing but presumably that alone works too still for me.

> > So the outcome might depend on the Palmas chip version that is used on any
> > board that includes the omap5-board-common.dtsi.
> 
> Could be different version yeah.

This could be still the case though. Or you did not test with
hwclock -w? Or there's some persistent state in the PMIC that
is only cleared after draining the back-up battery.

Anyways, updated patch below with the mux mode fixed. I also updated
the comments a bit.

Regards,

Tony

8< ---------------------
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
swps052f.pdf, mux mode 1 is for sys_drm_msecure so in theory there's
should be no need to configure it as a GPIO pin.

However, it seems there are some reliability issues using the msecure
mux mode. And the TI trees configure the msecure pin as GPIO out high
instead.

As the PMIC only cares that the msecure line is high to allow access
to the RTC registers, let's use a GPIO hog as suggested by Nishanth
Menon <nm-l0cyMroinI0@public.gmane.org>. Also the use of the internal pull was considered
but supposedly that may not be capable of keeping the line high in
a noisy environment.

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

Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # v4.4
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
+			OMAP5_IOPAD(0x180, PIN_OUTPUT | MUX_MODE6) /* gpio8_234 */
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

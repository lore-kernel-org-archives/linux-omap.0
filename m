From: Tony Lindgren <tony@atomide.com>
Subject: Re: N900 sleep mode (in 4.5-rc0, if that matters)
Date: Mon, 25 Jan 2016 14:50:20 -0800
Message-ID: <20160125225019.GY19432@atomide.com>
References: <20160123121022.GB12497@amd>
 <20160125163332.GT19432@atomide.com>
 <20160125222317.GA7059@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160125222317.GA7059@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [160125 14:24]:
> Hi!
> 
> First, thanks for the help!
> 
> > > So far, the LEDs stubbornly stay on :-(. Machine is booted off
> > > sd-card, and I'm connected to it over wifi. GSM is active, X is
> > > running.
> > 
> > If LEDs stay on, you're not entering deeper idle states.
> 
> Yes... Strange thing is, I'm not entering deeper idle states, and it still breaks my wifi ;-).
> 
> > > 64 bytes from 192.168.43.15: icmp_seq=427 ttl=64 time=178 ms
> > 
> > Latencies of several hundred ms are expected when hitting off
> > mode during idle as the latency for power off the system during
> > idle is long. It could also be that there's a wakeirq config
> > missing somewhere. Does the WLAN have a separate GPIO irq?
> 
> Fair enough.
> 
>         wl1251_pins: pinmux_wl1251 {
> 		     		   pinctrl-single,pins = < 0x0ce (PIN_OUTPUT | MUX_MODE4)
> 		     		   /* gpio 87 => w\ l1251 enable */
> 				                           0x05a (PIN_INPUT | MUX_MODE4)
> 		     		   /* gpio 42 => w\ l1251 irq */
> 				                   >;
>  };
> 
> Aha. wl1251 is on the spi bus, too.
> 
> &mcspi4 {
>         pinctrl-names = "default";
> 	        pinctrl-0 = <&mcspi4_pins>;
> 
>         wl1251@0 {
> 	...
> 	                interrupt-parent = <&gpio2>;
> 			                interrupts = <10 IRQ_TYPE_NONE>; /* gpio line 42 */
>         };
> 
> And yes, it has a GPIO irq -- irq 42. What should be configured to
> make gpio 42 wake the system from deep idle?

We should do dev_pm_set_dedicated_wake_irq() on the pin related
to gpio42 in the WLAN driver. That way the pinctrl interrupt will
wake up the system and the GPIO interrupt should show up as it
presumably is a level interrupt. The interrupt probably should be
requested by wlcore as the SDIO chips also can have a GPIO interrupt.
That's the interrupts-extended entries we already have for 8250 and
MMC etc.

> > The workaround for now is to mux those pins permanently with
> > PIN_INPUT_PULLUP | MUX_MODE7 to keep them high using the
> > internal pull. So in this case, maybe give a try for adding
> > a pinctrl entry for tsc2005 for gpio104 to have it always
> > in PIN_INPUT_PULLUP | MUX_MODE7.
> 
> So the glitches on the GPIOs reset the tsc2005, even when it should be
> operational? That would explain stuff.

Yeah.

> I'll try to figure out the pinmux stuff. ... but I guess touchscreen
> is not really usable with screen off.

Could still wake up the system I guess if configured.

> > Typically you need at least USB disconnected and LCD blanked
> > to start hitting the deeper idle states :)
> 
> Right. So I was able to get SD-card to work, so USB was disconnected,
> but I was watching power consumption figures in a GTK window... on a
> LCD. Ok. I guess I can monitor the power consumption over the wlan.

Yeah in the long run initramfs + ssh over WLAN is probably the best
to develop with if you don't have a serial console wired up. That
allows hitting idle states with mosh at least working OK as long as
the WLAN wakeirq works properly.

Regards,

Tony

From: Pavel Machek <pavel@ucw.cz>
Subject: Re: N900 sleep mode (in 4.5-rc0, if that matters)
Date: Mon, 25 Jan 2016 23:23:17 +0100
Message-ID: <20160125222317.GA7059@amd>
References: <20160123121022.GB12497@amd>
 <20160125163332.GT19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160125163332.GT19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi!

First, thanks for the help!

> > So far, the LEDs stubbornly stay on :-(. Machine is booted off
> > sd-card, and I'm connected to it over wifi. GSM is active, X is
> > running.
> 
> If LEDs stay on, you're not entering deeper idle states.

Yes... Strange thing is, I'm not entering deeper idle states, and it still breaks my wifi ;-).

> > 64 bytes from 192.168.43.15: icmp_seq=427 ttl=64 time=178 ms
> 
> Latencies of several hundred ms are expected when hitting off
> mode during idle as the latency for power off the system during
> idle is long. It could also be that there's a wakeirq config
> missing somewhere. Does the WLAN have a separate GPIO irq?

Fair enough.

        wl1251_pins: pinmux_wl1251 {
		     		   pinctrl-single,pins = < 0x0ce (PIN_OUTPUT | MUX_MODE4)
		     		   /* gpio 87 => w\ l1251 enable */
				                           0x05a (PIN_INPUT | MUX_MODE4)
		     		   /* gpio 42 => w\ l1251 irq */
				                   >;
 };

Aha. wl1251 is on the spi bus, too.

&mcspi4 {
        pinctrl-names = "default";
	        pinctrl-0 = <&mcspi4_pins>;

        wl1251@0 {
	...
	                interrupt-parent = <&gpio2>;
			                interrupts = <10 IRQ_TYPE_NONE>; /* gpio line 42 */
        };

And yes, it has a GPIO irq -- irq 42. What should be configured to
make gpio 42 wake the system from deep idle?

> > and touchscreen stops working:
> > 
> > [99480.564910] tsc2005 spi1.0: TSC200X not responding - resetting
...
> This could be because we're still lacking i2c-omap + pinctrl
> handling for erratum 1.158. Without that, any GPIO pins not in
> GPIO bank 1 used for enabling devices may have glitches during
> off-mode.
> 
> The workaround for now is to mux those pins permanently with
> PIN_INPUT_PULLUP | MUX_MODE7 to keep them high using the
> internal pull. So in this case, maybe give a try for adding
> a pinctrl entry for tsc2005 for gpio104 to have it always
> in PIN_INPUT_PULLUP | MUX_MODE7.

So the glitches on the GPIOs reset the tsc2005, even when it should be
operational? That would explain stuff.

I'll try to figure out the pinmux stuff. ... but I guess touchscreen
is not really usable with screen off.

> The long term solution is to do this dynamically for each GPIO
> pin.. I do have some WIP patches for that but those still need
> work before I dare to post them.

No patch is too ugly for testing :-).

> Yes you can dump the idlest regs during idle and see the blockers.
> Below is a hack patch I've been using, that could potentially
> be turned into something we could actually merge. Needs to have
> separate hooks for various SoCs though, this works only on omap3..

Thanks, wil try.

> > Power consumption seems to be in 500mA range, regardless of
> > off_mode. That would mean about 2 hours of battery life, AFAICT.
> 
> Sounds like you have USB connected and charging? You can
> get into just few mW range with the mainline kernel for sure
> on omap3. It's just a quetion of fixing whatever few drivers
> that are still causing issues on n900.
> 
> Typically you need at least USB disconnected and LCD blanked
> to start hitting the deeper idle states :)

Right. So I was able to get SD-card to work, so USB was disconnected,
but I was watching power consumption figures in a GTK window... on a
LCD. Ok. I guess I can monitor the power consumption over the wlan.

Thanks!
								Pavel
								
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

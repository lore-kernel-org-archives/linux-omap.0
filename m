From: Tony Lindgren <tony@atomide.com>
Subject: Re: n900 in 4.2-rc0: repeating oopses
Date: Mon, 27 Jul 2015 23:01:43 -0700
Message-ID: <20150728060143.GK16878@atomide.com>
References: <20150416093234.GA17423@amd>
 <20150629091146.GA5103@amd>
 <20150630092404.GA19285@amd>
 <20150630095310.GF27720@pali>
 <20150701065932.GS4156@atomide.com>
 <20150701072255.GA17577@pali>
 <20150701095954.GD7969@amd>
 <20150701103421.GV4156@atomide.com>
 <20150726092615.GA6824@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150726092615.GA6824@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [150726 02:29]:
> Hi!
> 
> > > > So, Pavel can you re-test? Maybe there can be problem with some driver
> > > > which Tony did not compiled into zImage? Just speculation...
> > > 
> > > I re-tested with today's git, and it seems to boot. Thanks for help...
> > 
> > OK good to hear.
> >  
> > > Now. "echo mem > /sys/power/state" is broken, as in "returns
> > > immediately in about 50% cases". The messages are
> > > 
> > > Powerdomain (per_pwrdm) didn't enter target state 1
> > > Powerdomain (core_pwerdm) didn't enter target state 1
> > > 
> > > Any ideas? Thanks,
> > 
> > Works for me after enabling the idle timeouts with the following
> > script and blanking the screen and disconnecting USB:
> > 
> > Also both keyboard LEDs should start blinking after the idle
> > timeout with screen blanked and USB disconnected. If not, you
> > have some module loaded that blocks the deeper idle states.
> 
> Ok, tried that, I had to do:
> 
>  cd /sys/class/gpio
>  echo 162 > export
>  cd gpio162
>  echo out > direction
>  echo 1 > value
> 
> to get the debug lights to work. But I could not get those leds to
> blink.

I think that's the GPIO override for them? And in that case the
PMIC sys_clkreq and sys_off_mode signals are not cutting off the
LEDs I believe.

Also not that any driver blocking the deeper idle states will
also cause the LEDs to stay on. And USB cable being plugged in
too at least for core off.. So you if you're using NFSroot over
USB Ethernet, you probably can only see the left LED ever go off.
 
> > modprobe leds-gpio
> > modprobe ledtrig-default-on
> 
> Is this actually neccessary/relevant?

Yes at least with omap2plus_defconfig.
 
> > echo 255 > /sys/class/backlight/acx565akm/brightness
> 
> And this?

It used to be the backlight did not come on initially as modules
or something.. May not be needed any longer.

Regards,

Tony

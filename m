From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Thu, 21 Jan 2016 11:21:13 -0800
Message-ID: <20160121192113.GM19432@atomide.com>
References: <201601091616.04193@pali>
 <2300247.VhtcKLq8UC@saturn>
 <20160121174146.GK19432@atomide.com>
 <3690314.8jDXSUDcRZ@saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3690314.8jDXSUDcRZ@saturn>
Sender: linux-kernel-owner@vger.kernel.org
To: joerg Reisenweber <joerg@openmoko.org>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

* joerg Reisenweber <joerg@openmoko.org> [160121 10:45]:
> On Thu 21 January 2016 09:41:46 Tony Lindgren wrote:
> > Then for supporting the USB host mode.. We should add regulator support
> > to the USB PHY driver so if the ID pin is grounded, the PHY driver enables
> > the VBUS regulator. That too seems to need some coordination between the
> > drivers/phy/phy-twl4030-usb.c and 1707 driver if the ID pin interrupt is
> > only detected in drivers/phy/phy-twl4030-usb.c.
> 
> Note that, while this is probably a good thing to do, it needs to be 
> sufficiently loose coupling to allow user to 'intercept' this VBOOS regulator 
> enabling and instead allow device charging while in externally powered 
> hostmode. There's even a spec for this in USB-docs-foo iirc, something along a 
> certain resistor value on ID to GND - alas I guess the twl4030 is not capable 
> to detect such sophisticated signaling, and anyway it's always desirable to 
> allow user to manually override the VBOOST and enable VBUS-charging while in 
> hostmode.

OK, I think this is what's happening with the Motorola LapDock BTW. It
always feeds the VBUS, well most of the time. Do you have some pointer
to the "certain resistor value on ID to GND" spec? Is it maybe part of
the carkit related parts of the USB spec?

> On N900 the situation is even more complex since the 1707 doesn't support 
> genuine ID detection, neither does it support emulated ID grounding. And 
> there's no other method than a ID=GND message from PHY to musb core to make 
> the musb core state engine transfer into proper hostmode. Thus my H-E-N 
> hostmode botch abuses debug flags to force the musb core into a "emulated" 
> hostmode and this mode doesn't support USB speed detection. Thus speed 
> settings are forced onto musb core and PHY by software, and the musb core 
> speed bits are only effective before session enabled. 
> Bottom line: you need VBUS to try and negotiate speed with the attached device 
> in hostmode, but to actually set this speed you detected by software means, 
> you need to disable and discharge VBUS again, or musb core won't care about 
> the speed you set. To be utterly clear: unconditional enabling of VBUS in 
> ID=GND won't work.
>
> This is quite complex and it's questionable if it could get handled reasonably  
> in kernel space. *Very* N900 specific niche solution, I'd not think it's suited 
> for upstreaming.

Yeah OK. I think we should be able to support the aux VBUS regulator part
with mainline kernel though.

Regards,

Tony

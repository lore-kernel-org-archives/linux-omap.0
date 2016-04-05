From: Pavel Machek <pavel@ucw.cz>
Subject: 4.4: camera and unlock buttons produce tons of interrupts (was Re:
 N900 sleep mode)
Date: Tue, 5 Apr 2016 16:22:50 +0200
Message-ID: <20160405142250.GA6429@amd>
References: <20160130221509.GA28644@amd>
 <20160201181316.GM19432@atomide.com>
 <20160201211736.GA11283@amd>
 <20160201221111.GP19432@atomide.com>
 <20160207212316.GA6147@amd>
 <20160209172403.GK19432@atomide.com>
 <20160323123801.GC32031@amd>
 <20160330191208.GW9329@atomide.com>
 <20160404213056.GA25912@amd>
 <20160404220748.GA16484@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160404220748.GA16484@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

Hi!

> * Pavel Machek <pavel@ucw.cz> [160404 14:31]:
> > 
> > Display off, on wifi:
> > 
> > 00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
> > f7de7ebd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00218042
> > 0000000d 48004a28 (fa004a28) cm_idlest3_core
> > 
> > 00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
> > ffde7ebd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00218042
> > 
> > 00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
> > ffdffebd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00200042
> > 
> > ..so I believe gadget bits are still set.
> 
> Nope, you got PM working now for the USB as it's now ending with 0x42
> instead of 0x62 :) You still have bit 21 blocking, sorry don't
> remember what that one is, but that's in the TRM for idlest1
> register.

Ok, I realized that _something_ set up my keyboard on console, too, so
I'm able to do "init 1" and still interact with the console.

cm_idlest1_core blocking bits are now 0x42 pretty consistently. But
they stay 0x42, even when screen is on (and screen on prevents low
power, right?) so I guess they are not the whole story.

I'm able to get down to 50mA power consumption with screen off. I was
getting 90mA with X, wifi in powersave and screen off.

Head proximity sensor is still on in this configuration. But I guess
that should not keep the system busy...?

Ok, wait a moment, I'm getting "Camera Focus", "Camera Capture" and
"Lock button" interrupts ... at something like 20/second. Without
touching anything. Hmm. Also "pm_wkup", but that might be
expected. Plus, 49052000.gpio and 49054000.gpio are rather
active. Might be related to the above. Also "gp_timer" and
48070000.i2c are active, perhaps also related. I don't think I have
the camera working...

"Lock button" interrupt stops increasing as long as I hold the lock
button in the "unlock" position. "Camera Focus" and "Camera Capture"
will stop increasing when I hold down the Camera button.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

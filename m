From: Pavel Machek <pavel@ucw.cz>
Subject: Re: N900 sleep mode (in 4.5-rc0, if that matters)
Date: Tue, 5 Apr 2016 12:09:32 +0200
Message-ID: <20160405100932.GB23282@amd>
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

On Mon 2016-04-04 15:07:49, Tony Lindgren wrote:
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

Aha... I thought the "0x42" was the problem, not "0x30". That was
going on and off for me for a long while. Actually, I don't think I
did anything special with USB gadget in this boot, and it is still
0x42.

Bit 21 is wifi, AFAICT. With right sleeps between reading the debug
file and talking to wifi, I now get:

Battery 4.16V 4.18V 4.14V 95% 93% 100% 1569/1569 mAh Charging
49/650/1800 mA
fffffebd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00000042
Battery 4.16V 4.18V 4.14V 95% 93% 100% 1569/1569 mAh Charging
48/650/1800 mA
fffffebd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00000042

0x02 seems to be SDRC.
0x40 seems to be OMAPCTRL

I get

0x18000 randomly, too. That should be I2C1, and I2C2. But even when
idlest1_blocking_bits are 0x42, the left and right backlight on
keyboard is lit constantly -- not blinking -- indicating that it is
still not sleeping.

Full debug is:

Battery 4.15V 4.18V 4.13V 94% 93% 100% 1569/1569 mAh Charging
29/650/1800 mA
usbhost_pwrdm
(ON),OFF:12183,RET:277831,INA:0,ON:290015,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
sgx_pwrdm
(OFF),OFF:1,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
core_pwrdm
(ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
per_pwrdm
(ON),OFF:12183,RET:0,INA:0,ON:12184,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
dss_pwrdm
(ON),OFF:12183,RET:267009,INA:0,ON:279193,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
cam_pwrdm
(ON),OFF:12183,RET:277826,INA:2,ON:290012,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
neon_pwrdm (ON),OFF:12183,RET:277832,INA:0,ON:290016,RET-LOGIC-OFF:0
mpu_pwrdm
(ON),OFF:12183,RET:277830,INA:0,ON:290014,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
iva2_pwrdm
(OFF),OFF:1,RET:1,INA:0,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
usbhost_clkdm->usbhost_pwrdm (1)
sgx_clkdm->sgx_pwrdm (0)
per_clkdm->per_pwrdm (19)
cam_clkdm->cam_pwrdm (1)
dss_clkdm->dss_pwrdm (1)
d2d_clkdm->core_pwrdm (0)
iva2_clkdm->iva2_pwrdm (0)
mpu_clkdm->mpu_pwrdm (0)
core_l4_clkdm->core_pwrdm (19)
core_l3_clkdm->core_pwrdm (1)
neon_clkdm->neon_pwrdm (0)
00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
fffffebd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00000042
0000000d 48004a28 (fa004a28) cm_idlest3_core
^CTraceback (most recent call last):
  File "./sleepmond", line 24, in <module>
      time.sleep(5)
      KeyboardInterrupt


Anything else I should look at?

Thanks and best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

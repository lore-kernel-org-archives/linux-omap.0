From: David Rivshin <drivshin@awxrd.com>
Subject: Re: [PATCH] ARM: dts: omap3-gta04: reduce panel backlight PWM
 frequency to 83Hz
Date: Mon, 12 Sep 2016 10:41:55 -0400
Message-ID: <20160912104155.267876a2.drivshin@awxrd.com>
References: <954d43b570092fe92b8b49cf8f475c027d3d8342.1473066997.git.hns@goldelico.com>
        <20160910031736.xwnepaoifpedqfbr@squirrel.local>
        <57D40F2C.7000805@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57D40F2C.7000805@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, =?UTF-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, marek@goldelico.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

On Sat, 10 Sep 2016 15:48:28 +0200
Neil Armstrong <narmstrong@baylibre.com> wrote:

> Le 10/09/2016 05:17, Matthijs van Duin a écrit :
> > On Mon, Sep 05, 2016 at 11:16:38AM +0200, H. Nikolaus Schaller wrote:  
> >> This helps to get 100% intensity closer to "always on".
> >>
> >> It compensates for an effect of dmtimer which at 100% still emits short
> >> "off" impulses and the startup-time of the DC/DC converter makes
> >> backlight intensity not reach full scale. The lower the PWM frequency
> >> is, the smaller is this effect.  
> > 
> > Sounds to me like you're working around something that should be fixed
> > in the pwm-omap-dmtimer driver instead?
> > 
> > Looking at the (baremetal) dmtimer pwm code I wrote ages ago, which
> > supports fully off to fully on, I do seem to be handling both endpoints
> > in a special way.  A rough conversion of my code into C:
> > 
> > // period in timer cycles
> > void pwm_init( volatile struct dmtimer *timer, u32 period, bool invert )
> > {
> > 	assert( period >= 2 );
> > 	timer->if_ctrl = 2;  // reset timer, configure as non-posted
> > 	timer->reload = -period;
> > 	timer->trigger = 0;
> > 	timer->config = 0x1043 | invert << 7;  // pwm initially disabled
> > }
> > 
> > // value in timer cycles, 0 <= value <= period
> > void pwm_set( volatile struct dmtimer *timer, u32 value )
> > {
> > 	if( value == 0 ) {
> > 		timer->config &= ~0x800;  // disable pwm
> > 		return;
> > 	}
> > 	u32 period = -timer->reload;
> > 	if( value >= period )
> > 		timer->match = 0;
> > 	else
> > 		timer->match = value - period - 1;
> > 	timer->config |= 0x800;  // enable pwm
> > }
> > 
> > At the time I used a scope to check the exact behaviour of dmtimer pwm
> > on a dm814x.  My notes mention (when pwm enabled):
> > 	match < reload	output on continuous
> > 	match == reload	output on 1 cycle, off period-1 cycles
> > 	match == -2	output on period-1 cycles, off 1 cycle
> > 	match == -1	output freezes
> > 
> > Hope this helps  
> 
> Hi,
> 
> I think these corner cases should definitely be handled in the dmtimer driver.

Do you mean to modify the dmtimer driver itself, or the pwm-omap-dmtimer 
driver?

IIRC from the last time I was in the pwm-omap-dmtimer driver, it seemed to 
me that the 0% and 100% cases could/should be handled as simple special 
cases there. I think the dmtimer driver itself has the necessary API to the 
HW, but I'd need to re-familiarize myself with it to remember the details 
of what I was thinking. 

Actually, I did mention some thoughts on this a previous thread where
Adam Ford was using pwm-omap-dmtimer for a backlight:
 http://www.spinics.net/lists/linux-omap/msg126006.html
So it may be as simple as using PWM_OMAP_DMTIMER_TRIGGER_NONE and passing 
def_on according to whether 0 or 100% duty were requested (and polarity).


> 
> I'll try to post a fix to handle these, thanks for the original code dump.
> 
> > 
> > Matthijs
> >   
> 
> Neil
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

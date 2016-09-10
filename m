From: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: omap3-gta04: reduce panel backlight PWM frequency
 to 83Hz
Date: Sat, 10 Sep 2016 15:48:28 +0200
Message-ID: <57D40F2C.7000805@baylibre.com>
References: <954d43b570092fe92b8b49cf8f475c027d3d8342.1473066997.git.hns@goldelico.com> <20160910031736.xwnepaoifpedqfbr@squirrel.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160910031736.xwnepaoifpedqfbr-2pNSKKP3PSK44ywRPIzf9A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, David Rivshin <drivshin-5fOYsn7Fw8lBDgjK7y7TUQ@public.gmane.org>
Cc: =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org



Le 10/09/2016 05:17, Matthijs van Duin a écrit :
> On Mon, Sep 05, 2016 at 11:16:38AM +0200, H. Nikolaus Schaller wrote:
>> This helps to get 100% intensity closer to "always on".
>>
>> It compensates for an effect of dmtimer which at 100% still emits short
>> "off" impulses and the startup-time of the DC/DC converter makes
>> backlight intensity not reach full scale. The lower the PWM frequency
>> is, the smaller is this effect.
> 
> Sounds to me like you're working around something that should be fixed
> in the pwm-omap-dmtimer driver instead?
> 
> Looking at the (baremetal) dmtimer pwm code I wrote ages ago, which
> supports fully off to fully on, I do seem to be handling both endpoints
> in a special way.  A rough conversion of my code into C:
> 
> // period in timer cycles
> void pwm_init( volatile struct dmtimer *timer, u32 period, bool invert )
> {
> 	assert( period >= 2 );
> 	timer->if_ctrl = 2;  // reset timer, configure as non-posted
> 	timer->reload = -period;
> 	timer->trigger = 0;
> 	timer->config = 0x1043 | invert << 7;  // pwm initially disabled
> }
> 
> // value in timer cycles, 0 <= value <= period
> void pwm_set( volatile struct dmtimer *timer, u32 value )
> {
> 	if( value == 0 ) {
> 		timer->config &= ~0x800;  // disable pwm
> 		return;
> 	}
> 	u32 period = -timer->reload;
> 	if( value >= period )
> 		timer->match = 0;
> 	else
> 		timer->match = value - period - 1;
> 	timer->config |= 0x800;  // enable pwm
> }
> 
> At the time I used a scope to check the exact behaviour of dmtimer pwm
> on a dm814x.  My notes mention (when pwm enabled):
> 	match < reload	output on continuous
> 	match == reload	output on 1 cycle, off period-1 cycles
> 	match == -2	output on period-1 cycles, off 1 cycle
> 	match == -1	output freezes
> 
> Hope this helps

Hi,

I think these corner cases should definitely be handled in the dmtimer driver.

I'll try to post a fix to handle these, thanks for the original code dump.

> 
> Matthijs
> 

Neil
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Matthijs van Duin <matthijsvanduin@gmail.com>
Subject: Re: [PATCH] ARM: dts: omap3-gta04: reduce panel backlight PWM
 frequency to 83Hz
Date: Sat, 10 Sep 2016 05:17:36 +0200
Message-ID: <20160910031736.xwnepaoifpedqfbr@squirrel.local>
References: <954d43b570092fe92b8b49cf8f475c027d3d8342.1473066997.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <954d43b570092fe92b8b49cf8f475c027d3d8342.1473066997.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, David Rivshin <drivshin@allworx.com>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, marek@goldelico.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, Neil Armstrong <narmstrong@baylibre.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 05, 2016 at 11:16:38AM +0200, H. Nikolaus Schaller wrote:
> This helps to get 100% intensity closer to "always on".
> 
> It compensates for an effect of dmtimer which at 100% still emits short
> "off" impulses and the startup-time of the DC/DC converter makes
> backlight intensity not reach full scale. The lower the PWM frequency
> is, the smaller is this effect.

Sounds to me like you're working around something that should be fixed
in the pwm-omap-dmtimer driver instead?

Looking at the (baremetal) dmtimer pwm code I wrote ages ago, which
supports fully off to fully on, I do seem to be handling both endpoints
in a special way.  A rough conversion of my code into C:

// period in timer cycles
void pwm_init( volatile struct dmtimer *timer, u32 period, bool invert )
{
	assert( period >= 2 );
	timer->if_ctrl = 2;  // reset timer, configure as non-posted
	timer->reload = -period;
	timer->trigger = 0;
	timer->config = 0x1043 | invert << 7;  // pwm initially disabled
}

// value in timer cycles, 0 <= value <= period
void pwm_set( volatile struct dmtimer *timer, u32 value )
{
	if( value == 0 ) {
		timer->config &= ~0x800;  // disable pwm
		return;
	}
	u32 period = -timer->reload;
	if( value >= period )
		timer->match = 0;
	else
		timer->match = value - period - 1;
	timer->config |= 0x800;  // enable pwm
}

At the time I used a scope to check the exact behaviour of dmtimer pwm
on a dm814x.  My notes mention (when pwm enabled):
	match < reload	output on continuous
	match == reload	output on 1 cycle, off period-1 cycles
	match == -2	output on period-1 cycles, off 1 cycle
	match == -1	output freezes

Hope this helps

Matthijs

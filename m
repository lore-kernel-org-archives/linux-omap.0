From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] ARM: dts: omap3-gta04: reduce panel backlight PWM frequency to 83Hz
Date: Sat, 10 Sep 2016 09:08:05 +0200
Message-ID: <3188F52F-1372-4D59-B790-C15E584A44F2@goldelico.com>
References: <954d43b570092fe92b8b49cf8f475c027d3d8342.1473066997.git.hns@goldelico.com> <20160910031736.xwnepaoifpedqfbr@squirrel.local>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160910031736.xwnepaoifpedqfbr@squirrel.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: David Rivshin <drivshin@allworx.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, marek@goldelico.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, Neil Armstrong <narmstrong@baylibre.com>
List-Id: linux-omap@vger.kernel.org

Hi,

> Am 10.09.2016 um 05:17 schrieb Matthijs van Duin =
<matthijsvanduin@gmail.com>:
>=20
> On Mon, Sep 05, 2016 at 11:16:38AM +0200, H. Nikolaus Schaller wrote:
>> This helps to get 100% intensity closer to "always on".
>>=20
>> It compensates for an effect of dmtimer which at 100% still emits =
short
>> "off" impulses and the startup-time of the DC/DC converter makes
>> backlight intensity not reach full scale. The lower the PWM frequency
>> is, the smaller is this effect.
>=20
> Sounds to me like you're working around something that should be fixed

Yes and no.

Reducing the PWM frequency is good by itself since it should not be =
unnecessarily
fast and helps to make the PWM to "average current" translation more =
linear.

The non-linear effect is that the PWM controlled DC/DC converter reacts =
almost
immediately to a 1->0 control transition but needs some time (ca. 0.5ms) =
to recover
on a 0->1 transition. So if you run PWM @ 500Hz and 100% there is 1ms 1 =
and 1 ms 0.
But this translates to 1.5 ms no power and 0.5ms power which is 50% of =
the intended
current.

This gives some "reduction" factor to all PWM duty cycle values, but the =
100%
case is the most noticeable one.

If we just fix the PWM generator to output a steady 1 signal at 100%, we =
have a
very significant change if we switch to 99%, depending on PWM frequency.

This effect becomes smaller if the PWM frequency is reduced and 83Hz =
seems more
reasonable (although still a little arbitrary) than the current value. =
(BTW: for
the Pyra we already use 83Hz).

> in the pwm-omap-dmtimer driver instead?

Yes, it probably should be fixed as well but it does not completely =
solve
the backlight control issue due to the DC/DC converter's behaviour.

>=20
> Looking at the (baremetal) dmtimer pwm code I wrote ages ago, which
> supports fully off to fully on, I do seem to be handling both =
endpoints
> in a special way.  A rough conversion of my code into C:
>=20
> // period in timer cycles
> void pwm_init( volatile struct dmtimer *timer, u32 period, bool invert =
)
> {
> 	assert( period >=3D 2 );
> 	timer->if_ctrl =3D 2;  // reset timer, configure as non-posted
> 	timer->reload =3D -period;
> 	timer->trigger =3D 0;
> 	timer->config =3D 0x1043 | invert << 7;  // pwm initially =
disabled
> }
>=20
> // value in timer cycles, 0 <=3D value <=3D period
> void pwm_set( volatile struct dmtimer *timer, u32 value )
> {
> 	if( value =3D=3D 0 ) {
> 		timer->config &=3D ~0x800;  // disable pwm
> 		return;
> 	}
> 	u32 period =3D -timer->reload;
> 	if( value >=3D period )
> 		timer->match =3D 0;
> 	else
> 		timer->match =3D value - period - 1;
> 	timer->config |=3D 0x800;  // enable pwm
> }
>=20
> At the time I used a scope to check the exact behaviour of dmtimer pwm
> on a dm814x.  My notes mention (when pwm enabled):
> 	match < reload	output on continuous
> 	match =3D=3D reload	output on 1 cycle, off period-1 cycles
> 	match =3D=3D -2	output on period-1 cycles, off 1 cycle
> 	match =3D=3D -1	output freezes
>=20
> Hope this helps
>=20
> Matthijs

BR,
Nikolaus

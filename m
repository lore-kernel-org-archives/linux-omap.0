From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [Letux-kernel] [PATCH] ARM: dts: omap3-gta04: reduce panel backlight PWM frequency to 83Hz
Date: Sat, 10 Sep 2016 09:14:07 +0200
Message-ID: <86A33A32-13DE-4270-91B5-8A7EC95F39D3@goldelico.com>
References: <954d43b570092fe92b8b49cf8f475c027d3d8342.1473066997.git.hns@goldelico.com> <20160910031736.xwnepaoifpedqfbr@squirrel.local> <3188F52F-1372-4D59-B790-C15E584A44F2@goldelico.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3188F52F-1372-4D59-B790-C15E584A44F2-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Discussions about the Letux Kernel <letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org>
Cc: Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Rivshin <drivshin-5fOYsn7Fw8lBDgjK7y7TUQ@public.gmane.org>, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


> Am 10.09.2016 um 09:08 schrieb H. Nikolaus Schaller =
<hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>:
>=20
> Hi,
>=20
>> Am 10.09.2016 um 05:17 schrieb Matthijs van Duin =
<matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>>=20
>> On Mon, Sep 05, 2016 at 11:16:38AM +0200, H. Nikolaus Schaller wrote:
>>> This helps to get 100% intensity closer to "always on".
>>>=20
>>> It compensates for an effect of dmtimer which at 100% still emits =
short
>>> "off" impulses and the startup-time of the DC/DC converter makes
>>> backlight intensity not reach full scale. The lower the PWM =
frequency
>>> is, the smaller is this effect.
>>=20
>> Sounds to me like you're working around something that should be =
fixed
>=20
> Yes and no.
>=20
> Reducing the PWM frequency is good by itself since it should not be =
unnecessarily
> fast and helps to make the PWM to "average current" translation more =
linear.
>=20
> The non-linear effect is that the PWM controlled DC/DC converter =
reacts almost
> immediately to a 1->0 control transition but needs some time (ca. =
0.5ms) to recover
> on a 0->1 transition. So if you run PWM @ 500Hz and 100% there is 1ms =
1 and 1 ms 0.

was too early in the morning: should be PWM @ 500Hz and 50%.

> But this translates to 1.5 ms no power and 0.5ms power which is 50% of =
the intended
> current.

At PWM at 100% with the current PWM driver we still get a DC/DC control =
of 1.95ms 1
and 0.05ms 0 which translates into 0.55ms no power and 1.45 ms power =
which is only 75%
of the desired maximum.

>=20
> This gives some "reduction" factor to all PWM duty cycle values, but =
the 100%
> case is the most noticeable one.
>=20
> If we just fix the PWM generator to output a steady 1 signal at 100%, =
we have a
> very significant change if we switch to 99%, depending on PWM =
frequency.
>=20
> This effect becomes smaller if the PWM frequency is reduced and 83Hz =
seems more
> reasonable (although still a little arbitrary) than the current value. =
(BTW: for
> the Pyra we already use 83Hz).
>=20
>> in the pwm-omap-dmtimer driver instead?
>=20
> Yes, it probably should be fixed as well but it does not completely =
solve
> the backlight control issue due to the DC/DC converter's behaviour.
>=20
>>=20
>> Looking at the (baremetal) dmtimer pwm code I wrote ages ago, which
>> supports fully off to fully on, I do seem to be handling both =
endpoints
>> in a special way.  A rough conversion of my code into C:
>>=20
>> // period in timer cycles
>> void pwm_init( volatile struct dmtimer *timer, u32 period, bool =
invert )
>> {
>> 	assert( period >=3D 2 );
>> 	timer->if_ctrl =3D 2;  // reset timer, configure as non-posted
>> 	timer->reload =3D -period;
>> 	timer->trigger =3D 0;
>> 	timer->config =3D 0x1043 | invert << 7;  // pwm initially =
disabled
>> }
>>=20
>> // value in timer cycles, 0 <=3D value <=3D period
>> void pwm_set( volatile struct dmtimer *timer, u32 value )
>> {
>> 	if( value =3D=3D 0 ) {
>> 		timer->config &=3D ~0x800;  // disable pwm
>> 		return;
>> 	}
>> 	u32 period =3D -timer->reload;
>> 	if( value >=3D period )
>> 		timer->match =3D 0;
>> 	else
>> 		timer->match =3D value - period - 1;
>> 	timer->config |=3D 0x800;  // enable pwm
>> }
>>=20
>> At the time I used a scope to check the exact behaviour of dmtimer =
pwm
>> on a dm814x.  My notes mention (when pwm enabled):
>> 	match < reload	output on continuous
>> 	match =3D=3D reload	output on 1 cycle, off period-1 cycles
>> 	match =3D=3D -2	output on period-1 cycles, off 1 cycle
>> 	match =3D=3D -1	output freezes
>>=20
>> Hope this helps
>>=20
>> Matthijs
>=20
> BR,
> Nikolaus
>=20
> _______________________________________________
> http://projects.goldelico.com/p/gta04-kernel/
> Letux-kernel mailing list
> Letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org
> http://lists.goldelico.com/mailman/listinfo.cgi/letux-kernel

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

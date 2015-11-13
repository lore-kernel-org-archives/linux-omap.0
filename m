From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] clocksource: arm_global_timer: fix suspend resume
Date: Fri, 13 Nov 2015 11:40:47 -0600
Message-ID: <87y4e1ol0g.fsf@saruman.tx.rr.com>
References: <1447431951-23713-1-git-send-email-grygorii.strashko@ti.com> <87a8qhq284.fsf@saruman.tx.rr.com> <56461688.1090809@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56461688.1090809@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, linux@arm.linux.org.uk, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Grygorii Strashko <grygorii.strashko@ti.com> writes:
> On 11/13/2015 06:43 PM, Felipe Balbi wrote:
>>=20
>> Hi,
>>=20
>> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>>> Now the System stall is observed on TI AM437x based board
>>> (am437x-gp-evm) during resuming from System suspend when ARM Global
>>> timer is selected as clocksource device - SysRq are working, but
>>> nothing else. The reason of stall is that ARM Global timer loses its
>>> contexts.
>>>
>>> The reason of stall is that ARM Global timer loses its contexts during
>>> System suspend:
>>>     GT_CONTROL.TIMER_ENABLE =3D 0 (unbanked)
>>>     GT_COUNTERx =3D 0
>>>
>>> Hence, update ARM Global timer driver to reflect above behaviour
>>> - save GT_CONTROL.TIMER_ENABLE during suspend and restore on resume;
>>> - ensure clocksource and clockevent devices have coresponding flags
>>>    (CLOCK_SOURCE_SUSPEND_NONSTOP and CLOCK_EVT_FEAT_C3STOP) set
>>>    depending on presence of "always-on" DT property.
>>>
>>> CC: Arnd Bergmann <arnd@arndb.de>
>>> Cc: John Stultz <john.stultz@linaro.org>
>>> Cc: Felipe Balbi <balbi@ti.com>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>> ---
>>>   drivers/clocksource/arm_global_timer.c | 23 +++++++++++++++++++++++
>>>   1 file changed, 23 insertions(+)
>>>
>>> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksour=
ce/arm_global_timer.c
>>> index a2cb6fa..1bbaf64 100644
>>> --- a/drivers/clocksource/arm_global_timer.c
>>> +++ b/drivers/clocksource/arm_global_timer.c
>>> @@ -51,6 +51,8 @@ static void __iomem *gt_base;
>>>   static unsigned long gt_clk_rate;
>>>   static int gt_ppi;
>>>   static struct clock_event_device __percpu *gt_evt;
>>> +static bool gt_always_on;
>>> +static u32 gt_control;
>>>=20=20=20
>>>   /*
>>>    * To get the value from the Global Timer Counter register proceed as=
 follows:
>>> @@ -168,6 +170,9 @@ static int gt_clockevents_init(struct clock_event_d=
evice *clk)
>>>   {
>>>   	int cpu =3D smp_processor_id();
>>>=20=20=20
>>> +	if (!gt_always_on)
>>> +		clk->features |=3D CLOCK_EVT_FEAT_C3STOP;
>>> +
>>>   	clk->name =3D "arm_global_timer";
>>>   	clk->features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
>>>   		CLOCK_EVT_FEAT_PERCPU;
>>> @@ -195,12 +200,25 @@ static cycle_t gt_clocksource_read(struct clockso=
urce *cs)
>>>   	return gt_counter_read();
>>>   }
>>>=20=20=20
>>> +static void gt_suspend(struct clocksource *cs)
>>> +{
>>> +	gt_control =3D readl(gt_base + GT_CONTROL);
>>> +}
>>> +
>>> +static void gt_resume(struct clocksource *cs)
>>> +{
>>> +	/* enables timer on all the cores */
>>> +	writel(gt_control & GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
>>=20
>> do you really need to save context if all you restore is TIMER_ENABLE
>> bit ? seems like you could skip gt_suspend altogether. Is there really a
>> situation where this driver is running and GT isn't enabled ?
>
> Now It's not. It's always enabled. I did it because .suspend() is called =
for
> all registered clock sources regardless of their usage. So, potentially
> in the future, at the moment when .suspend() is called it might be disabl=
ed
> (for example, .enable/disable() callbacks can be added and, if ARM Global=
 timer
> will not be registered as sched_clock, it will be possible to keep it dis=
abled=20
> if not used now).
>
> But It's not essentially now - I can update it and drop save restore.=20
> Pls, confirm.

I think it's best to skip suspend completely. You're not restoring
anything you saved during suspend, unless you meant | where you used &.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWRiCgAAoJEIaOsuA1yqREqaEP/00UQgZpM+YuIRM581N8nuI7
FeYlM3Oslk61JMHbDCO/lEAqK9iISkbbPGOv8E/EUGuCfkwmMRLgeWCXv3g5TLDa
bAUwbWwaJ4rnc09P1IjGB5XmJeEEsGuF6/J8C2ShVCiNyOEUikGzxJ2jOLrDe0Ko
UWtGaMcN2QYASRTqUgDLOFDmIRvxfX7cMsHtiOLoidzTFI3GUqZshizPBVFiHzvJ
veaKX9knK/gEHd0fBqRzRzoPX2tec9xnzUlQE4uq21JXqeaup0pgGgd7LE5B/wwX
ofJwHbxj9Ns2chrrpKNyN0sqU784L+bQno5ipeS7OTh6cncZVLHxT9b+/sSza0dS
5CKKVHq9XaBrgWd5l1TK0BzX66t/xfNX12bMAN47tB2LXOAov6muNm3xS6YUiSX9
WjAPFvtuQcXb9lhwQf1L1fwNNexFGzhN/qvOMVCf+NFyoE8x2Qnbi6PomCf2DGlV
njK078FsZm3EufImB7s/1wn1a9kv7ScnC8AntMdd0ctaasYiuqQjfNseExUK7c2m
4fYqZ74df+HuHiHeZy7m+vgvFBbP3TTxkq0C2RWo93BF2BQlTlhpoXKIMNtasszZ
6UQr96N4vZIP/wn2UM6hJdYTB/hJVnVPEwD+x5mjANTFMUHJtgJoYkmtjTvewM7P
gIS4d+h6D5uYvJIn8Y9Y
=ul/3
-----END PGP SIGNATURE-----
--=-=-=--

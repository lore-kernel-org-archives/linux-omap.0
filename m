From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] clocksource: arm_global_timer: fix suspend resume
Date: Fri, 13 Nov 2015 12:32:12 -0600
Message-ID: <87mvuhoimr.fsf@saruman.tx.rr.com>
References: <1447431951-23713-1-git-send-email-grygorii.strashko@ti.com> <87a8qhq284.fsf@saruman.tx.rr.com> <56461688.1090809@ti.com> <87y4e1ol0g.fsf@saruman.tx.rr.com> <56462742.3020300@ti.com> <87si49ojed.fsf@saruman.tx.rr.com> <56462C0A.6070802@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56462C0A.6070802@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, linux@arm.linux.org.uk, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, John Stultz <john.stultz@linaro.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Grygorii Strashko <grygorii.strashko@ti.com> writes:
> On 11/13/2015 08:15 PM, Felipe Balbi wrote:
>>
>> Hi,
>>
>> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>>> On 11/13/2015 07:40 PM, Felipe Balbi wrote:
>>>>
>>>> Hi,
>>>>
>>>> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>>>>> On 11/13/2015 06:43 PM, Felipe Balbi wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>>>>>>> Now the System stall is observed on TI AM437x based board
>>>>>>> (am437x-gp-evm) during resuming from System suspend when ARM Global
>>>>>>> timer is selected as clocksource device - SysRq are working, but
>>>>>>> nothing else. The reason of stall is that ARM Global timer loses its
>>>>>>> contexts.
>>>>>>>
>>>>>>> The reason of stall is that ARM Global timer loses its contexts dur=
ing
>>>>>>> System suspend:
>>>>>>>       GT_CONTROL.TIMER_ENABLE =3D 0 (unbanked)
>>>>>>>       GT_COUNTERx =3D 0
>>>>>>>
>>>>>>> Hence, update ARM Global timer driver to reflect above behaviour
>>>>>>> - save GT_CONTROL.TIMER_ENABLE during suspend and restore on resume;
>>>>>>> - ensure clocksource and clockevent devices have coresponding flags
>>>>>>>      (CLOCK_SOURCE_SUSPEND_NONSTOP and CLOCK_EVT_FEAT_C3STOP) set
>>>>>>>      depending on presence of "always-on" DT property.
>>>>>>>
>>>>>>> CC: Arnd Bergmann <arnd@arndb.de>
>>>>>>> Cc: John Stultz <john.stultz@linaro.org>
>>>>>>> Cc: Felipe Balbi <balbi@ti.com>
>>>>>>> Cc: Tony Lindgren <tony@atomide.com>
>>>>>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>>>>>> ---
>>>>>>>     drivers/clocksource/arm_global_timer.c | 23 +++++++++++++++++++=
++++
>>>>>>>     1 file changed, 23 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clock=
source/arm_global_timer.c
>>>>>>> index a2cb6fa..1bbaf64 100644
>>>>>>> --- a/drivers/clocksource/arm_global_timer.c
>>>>>>> +++ b/drivers/clocksource/arm_global_timer.c
>>>>>>> @@ -51,6 +51,8 @@ static void __iomem *gt_base;
>>>>>>>     static unsigned long gt_clk_rate;
>>>>>>>     static int gt_ppi;
>>>>>>>     static struct clock_event_device __percpu *gt_evt;
>>>>>>> +static bool gt_always_on;
>>>>>>> +static u32 gt_control;
>>>>>>>
>>>>>>>     /*
>>>>>>>      * To get the value from the Global Timer Counter register proc=
eed as follows:
>>>>>>> @@ -168,6 +170,9 @@ static int gt_clockevents_init(struct clock_eve=
nt_device *clk)
>>>>>>>     {
>>>>>>>     	int cpu =3D smp_processor_id();
>>>>>>>
>>>>>>> +	if (!gt_always_on)
>>>>>>> +		clk->features |=3D CLOCK_EVT_FEAT_C3STOP;
>>>>>>> +
>>>>>>>     	clk->name =3D "arm_global_timer";
>>>>>>>     	clk->features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONE=
SHOT |
>>>>>>>     		CLOCK_EVT_FEAT_PERCPU;
>>>>>>> @@ -195,12 +200,25 @@ static cycle_t gt_clocksource_read(struct clo=
cksource *cs)
>>>>>>>     	return gt_counter_read();
>>>>>>>     }
>>>>>>>
>>>>>>> +static void gt_suspend(struct clocksource *cs)
>>>>>>> +{
>>>>>>> +	gt_control =3D readl(gt_base + GT_CONTROL);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void gt_resume(struct clocksource *cs)
>>>>>>> +{
>>>>>>> +	/* enables timer on all the cores */
>>>>>>> +	writel(gt_control & GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL=
);
>>>>>>
>>>>>> do you really need to save context if all you restore is TIMER_ENABLE
>>>>>> bit ? seems like you could skip gt_suspend altogether. Is there real=
ly a
>>>>>> situation where this driver is running and GT isn't enabled ?
>>>>>
>>>>> Now It's not. It's always enabled. I did it because .suspend() is cal=
led for
>>>>> all registered clock sources regardless of their usage. So, potential=
ly
>>>>> in the future, at the moment when .suspend() is called it might be di=
sabled
>>>>> (for example, .enable/disable() callbacks can be added and, if ARM Gl=
obal timer
>>>>> will not be registered as sched_clock, it will be possible to keep it=
 disabled
>>>>> if not used now).
>>>>>
>>>>> But It's not essentially now - I can update it and drop save restore.
>>>>> Pls, confirm.
>>>>
>>>> I think it's best to skip suspend completely. You're not restoring
>>>> anything you saved during suspend, unless you meant | where you used &.
>>>>
>>>
>>> I didn't get it - I'm restoring one bit(0) only.
>>
>> that's the point, if you know you're restoring only that bit. Why save
>> anything at all ?
>>
>
> i think there are difference between "restoring" and "re-enabling".
> "restoring" - assume saving smth.. then restore saving value.
> I'm saving & restoring one bit here.

with your current suspend/resume, they are the same thing. You save
GT_CONTROL contents, timer goes off and looses context, you set ENABLE
bit. No difference what so ever.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWRiytAAoJEIaOsuA1yqREQKkP/R6set2PNg1NAq6D6CNBU/7r
+eQXNpBlN9pxtzVgcgRCfevOv1qacEaYggIQTyPQwT1S5wR+G1K3nfyWdE2e30pt
IVd7skS76lLKICkiTyv6qBgcz9j/TyKx3GBeb5PHgdB7yXQnpaJT5BDzvE7JkeR4
/bTcRlpPR3N2+FsfI4uwhCKkcufDCPDCsLL5ux1YI4D5ekOiBsLPHjti/U6RdxTR
217MMBuW9mZVNawCcqPRNNiwM0pwBXiYwnXzhQ3X0ed33CcmA3aEYiNEsVj0ksgq
8hVmW0qkQindn06dV1PSvhU68cmMLcKfZQS1RfsI6o0oHw4ntPMpfU+aWLS505nQ
cDS6zEnE1l0n9IhkZFzz2v3QYZHCPbFoX/1K3fjksNekB6hKODZy6kU/duujcXgI
JQqvwVc6Sew1c14mevzg3h87PBXbTdVbrcJ0JafyeSVJB+T59KFACDAtr4ax9bZK
VcpWIpU9ioxA+omQCx6VkEcjCv0p52Odc+TU8zeOXOwYvZZna1o6a4pDOnK40La1
NaYgURQNXY8vkwPxB5XeUniUtywv19wobQJZz17wc2A7DKgAitoFCWEDf807ac+x
AiUqGyGpMPZevr8GsXRKVGinBMmM7pCVymXP7e+mVJCAqcX50Zxm0ueUyuC11oi9
2xbJRvzCHTacxW1QSF2m
=Ba9t
-----END PGP SIGNATURE-----
--=-=-=--

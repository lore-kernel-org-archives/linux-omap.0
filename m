From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] clocksource: arm_global_timer: fix suspend resume
Date: Fri, 13 Nov 2015 12:15:38 -0600
Message-ID: <87si49ojed.fsf@saruman.tx.rr.com>
References: <1447431951-23713-1-git-send-email-grygorii.strashko@ti.com>
 <87a8qhq284.fsf@saruman.tx.rr.com> <56461688.1090809@ti.com>
 <87y4e1ol0g.fsf@saruman.tx.rr.com> <56462742.3020300@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5921963621644954230=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <56462742.3020300@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, linux@arm.linux.org.uk, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>
Cc: kernel@stlinux.com, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============5921963621644954230==
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Grygorii Strashko <grygorii.strashko@ti.com> writes:
> On 11/13/2015 07:40 PM, Felipe Balbi wrote:
>>
>> Hi,
>>
>> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>>> On 11/13/2015 06:43 PM, Felipe Balbi wrote:
>>>>
>>>> Hi,
>>>>
>>>> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>>>>> Now the System stall is observed on TI AM437x based board
>>>>> (am437x-gp-evm) during resuming from System suspend when ARM Global
>>>>> timer is selected as clocksource device - SysRq are working, but
>>>>> nothing else. The reason of stall is that ARM Global timer loses its
>>>>> contexts.
>>>>>
>>>>> The reason of stall is that ARM Global timer loses its contexts during
>>>>> System suspend:
>>>>>      GT_CONTROL.TIMER_ENABLE =3D 0 (unbanked)
>>>>>      GT_COUNTERx =3D 0
>>>>>
>>>>> Hence, update ARM Global timer driver to reflect above behaviour
>>>>> - save GT_CONTROL.TIMER_ENABLE during suspend and restore on resume;
>>>>> - ensure clocksource and clockevent devices have coresponding flags
>>>>>     (CLOCK_SOURCE_SUSPEND_NONSTOP and CLOCK_EVT_FEAT_C3STOP) set
>>>>>     depending on presence of "always-on" DT property.
>>>>>
>>>>> CC: Arnd Bergmann <arnd@arndb.de>
>>>>> Cc: John Stultz <john.stultz@linaro.org>
>>>>> Cc: Felipe Balbi <balbi@ti.com>
>>>>> Cc: Tony Lindgren <tony@atomide.com>
>>>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>>>> ---
>>>>>    drivers/clocksource/arm_global_timer.c | 23 +++++++++++++++++++++++
>>>>>    1 file changed, 23 insertions(+)
>>>>>
>>>>> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clockso=
urce/arm_global_timer.c
>>>>> index a2cb6fa..1bbaf64 100644
>>>>> --- a/drivers/clocksource/arm_global_timer.c
>>>>> +++ b/drivers/clocksource/arm_global_timer.c
>>>>> @@ -51,6 +51,8 @@ static void __iomem *gt_base;
>>>>>    static unsigned long gt_clk_rate;
>>>>>    static int gt_ppi;
>>>>>    static struct clock_event_device __percpu *gt_evt;
>>>>> +static bool gt_always_on;
>>>>> +static u32 gt_control;
>>>>>
>>>>>    /*
>>>>>     * To get the value from the Global Timer Counter register proceed=
 as follows:
>>>>> @@ -168,6 +170,9 @@ static int gt_clockevents_init(struct clock_event=
_device *clk)
>>>>>    {
>>>>>    	int cpu =3D smp_processor_id();
>>>>>
>>>>> +	if (!gt_always_on)
>>>>> +		clk->features |=3D CLOCK_EVT_FEAT_C3STOP;
>>>>> +
>>>>>    	clk->name =3D "arm_global_timer";
>>>>>    	clk->features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHO=
T |
>>>>>    		CLOCK_EVT_FEAT_PERCPU;
>>>>> @@ -195,12 +200,25 @@ static cycle_t gt_clocksource_read(struct clock=
source *cs)
>>>>>    	return gt_counter_read();
>>>>>    }
>>>>>
>>>>> +static void gt_suspend(struct clocksource *cs)
>>>>> +{
>>>>> +	gt_control =3D readl(gt_base + GT_CONTROL);
>>>>> +}
>>>>> +
>>>>> +static void gt_resume(struct clocksource *cs)
>>>>> +{
>>>>> +	/* enables timer on all the cores */
>>>>> +	writel(gt_control & GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
>>>>
>>>> do you really need to save context if all you restore is TIMER_ENABLE
>>>> bit ? seems like you could skip gt_suspend altogether. Is there really=
 a
>>>> situation where this driver is running and GT isn't enabled ?
>>>
>>> Now It's not. It's always enabled. I did it because .suspend() is calle=
d for
>>> all registered clock sources regardless of their usage. So, potentially
>>> in the future, at the moment when .suspend() is called it might be disa=
bled
>>> (for example, .enable/disable() callbacks can be added and, if ARM Glob=
al timer
>>> will not be registered as sched_clock, it will be possible to keep it d=
isabled
>>> if not used now).
>>>
>>> But It's not essentially now - I can update it and drop save restore.
>>> Pls, confirm.
>>
>> I think it's best to skip suspend completely. You're not restoring
>> anything you saved during suspend, unless you meant | where you used &.
>>
>
> I didn't get it - I'm restoring one bit(0) only.

that's the point, if you know you're restoring only that bit. Why save
anything at all ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWRijKAAoJEIaOsuA1yqRENesP/AtJDmkfJQOYnpEQrl7tuL4+
RstmLBN0aReLrAPu09R8yPKYWMhz9KHDJP8TqRR66fyqMj7oy1lfYDGfGABXEQgv
jSAfrQCdigeRZxugzWB03jQ1xKuxmK2GogeqLPrITTKZyZpF3v8joJUo+5zOnLA0
gn8nRy9crTWFLUHdC+J90HhfrmWs5zA9UKotdYVm9SQ1KYzrJ5NQyqJWpgwFLdHM
MDz3crf2NtZKAJug9uixVAxacZwJ9LJJEkHuHWXR0eeZXLyRa0JXpB8X5ovFGW1Y
AhJbNX8MooQA9YtGQMfe01c391EEGSFihWuEH4Hg99vBFg8FIwT5G4OKYHmctd13
LP3vZEtFip9tn89VtrQdfaYG3VqEOxiswoM2a+rbsiRUgOoxuTGJ8yfpaqs4p9M9
mSTYm8wRt5sjIIcX3Bb6ATHIJtPSA1K9SA5RDyVDAYCZjk5Z4d383la+sL0Usaf+
R1/gauwG/avqirGquPlwurWIvx0rqP5qx/+mMpm/eWIM3u/q06awoKRVz9cj5/wW
zbowbtE5A5RSnizxt6iukEcA0qdv//dpTV46KZLPwVLo9DqDvlphMFmOa6nAQenm
j2iZlbCE+B9/zTumrLwM7U9GYB6lWQs9rCm7prkQGiLvu68GG0Jesvj5T9qevsZZ
vbC/pydX7uSF4ghX3TvH
=a4hl
-----END PGP SIGNATURE-----
--=-=-=--


--===============5921963621644954230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5921963621644954230==--

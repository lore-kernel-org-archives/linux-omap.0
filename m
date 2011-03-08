From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 5/5] OMAP: GPIO: use PM runtime framework
Date: Tue, 08 Mar 2011 10:23:18 -0800
Message-ID: <8739mxsc89.fsf@ti.com>
References: <1298890670-5481-1-git-send-email-charu@ti.com>
	<1298890670-5481-6-git-send-email-charu@ti.com>
	<87mxlabih5.fsf@ti.com>
	<AANLkTi=Sd0zJwnx1DHCCOr9ncHv1ZP1EworoJex7NLEK@mail.gmail.com>
	<87vczu7ocb.fsf@ti.com>
	<AANLkTikecqDALXQYd=oLJrFstQZaEG0wH1txzUUyGc-m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:38583 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753315Ab1CHSXW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 13:23:22 -0500
Received: by mail-pz0-f51.google.com with SMTP id 34so1141216pzk.38
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 10:23:21 -0800 (PST)
In-Reply-To: <AANLkTikecqDALXQYd=oLJrFstQZaEG0wH1txzUUyGc-m@mail.gmail.com>
	(Charulatha Varadarajan's message of "Tue, 8 Mar 2011 20:35:24 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, Tarun Kanti DebBarma <tarun.kanti@ti.com>

"Varadarajan, Charulatha" <charu@ti.com> writes:

> Kevin,
>
> On Tue, Mar 8, 2011 at 00:25, Kevin Hilman <khilman@ti.com> wrote:
>> "Varadarajan, Charulatha" <charu@ti.com> writes:
>>
>> [...]
>>
>>>>> GPIO driver is modified to use dev_pm_ops instead of sysdev_class=
=2E
>>>>> With this approach, gpio_bank_suspend() & gpio_bank_resume()
>>>>> are not part of sys_dev_class.
>>>>>
>>>>> Usage of PM runtime get/put APIs in GPIO driver is as given below=
:
>>>>> pm_runtime_get_sync():
>>>>> * In the probe before accessing the GPIO registers
>>>>> * at the beginning of omap_gpio_request()
>>>>> =C2=A0 =C2=A0 =C2=A0 -only when one of the gpios is requested on =
a bank, in which,
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0no other gpio is being used (when mod_=
usage becomes non-zero).
>>>>
>>>> When using runtime PM, bank->mod_usage acutally becomes redundant =
with
>>>> usage counting already done at the runtime PM level. =C2=A0IOW, ch=
ecking
>>>> bank->mod_usage is he equivalent of checking pm_runtime_suspended(=
), so
>>>> I think you can totally get rid of bank->mod_usage.
>>>
>>> I wish to differ here. bank->mod_usage is filled for each GPIO pin =
in a bank.
>>> Hence during request/free if pm_runtime_get_sync() is called for ea=
ch GPIO
>>> pin, then the count gets increased for each GPIO pin in a bank. But
>>> gpio_prepare_for_idle/suspend calls pm_runtime_put() only once for
>>> each bank. Hence there will be a count mismatch and hence this will=
 lead
>>> to problems and never a bank will get suspended.
>>>
>>> IMO it is required to have bank->mod_usage checks. Please correct
>>> me if I am wrong.
>>
>> You're right, I see what you're saying now. =C2=A0Thanks for clarify=
ing.
>
> Okay.
>
>>
>> In that case, keeping bank->mod_usage should be OK for now.
>
> Okay.
>
>>
>> That being said, as I'm looking at the idle prepare/resume hooks
>> something else came to mind.
>>
>> Most of what the idle prepare/resume mehods do should actually be do=
ne
>> in the ->runtime_suspend() and ->runtime_resume() hooks (e.g. deboun=
ce
>> clock disable, edge-detect stuff, context save/restore). =C2=A0IOW, =
that
>> stuff does not need to be done until the bank is actually
>> disabled/enabled. =C2=A0For example, prepare_for_idle itself could b=
e a
>> relatively simple check for bank->mod_usage and a call to
>> pm_runtime_put_sync().
>>
>> What do you think?
>
> I also thought about this and my very old implementation with hwmod
> series was like this. But,
> a. prepare_for_idle has an Erratum 1.101 handling, debounce clock dis=
able,
>    context save based on offmode flag
> b. omap_gpio_suspend has wkup related code handling in it along
>    with context save w/o any flag

Don't forget that the suspend path also calls prepare_for_idle (and
resume path calls resume_from_idle) so that (b) actually includes (a).
In fact, looking closer at the code, it appears we save context twice o=
n
a static suspend.

> c. gpio_free need not do any of the above mentioned stuff.

But it would be harmless if the ->runtime_suspend/resume methods were
called.  If bank->mod_usage were zero, these hooks would just return.

> Similar for resume_after_idle, gpio_request, omap_resume.
>
> But the runtime_suspend/resume hooks would be called for all the abov=
e.
>
> Hence I thought that it might not be correct to move all the code fro=
m
> prepare_for_idle() to runtime_suspend hook of GPIO. Similar for
> resume_after_idle()
> and runtime_resume hook.

You're right, there are currently different paths for the 3 different
users of the runtime PM API (your a, b & c above), but to me that leads
to serious readability problems.   (NOTE: this isn't your fault, the
current code suffers from this already, I'm just hoping we can clean it
up with the runtime PM conversion.)

I think this could be much cleaner if everything was moved to the
->runtime_suspend/resume hooks and a couple checks were added.  For
example, the runtime_suspend would look like:

 for each bank:

    /* this handles the gpio_free case */
    if (!bank->mod_usage)
       continue;   =20

    /* debounce clock disable */
=20
    /* off-mode: remove triggering */

    /* save context */

    /* Extra stuff for static suspend */
    if (bank->is_suspending)
      /* set wakeup bits */      =20

> Also, from implementation point of view it needs to be taken care to
> pass off_mode flag to runtime_suspend hook and use it only for
> prepare_for idle and not for other cases
> (omap_gpio_suspend/gpio_free).

Actually, I'm not a big fan of the off_mode flag passed from the PM
core.

Here's what would be much nicer.  Each bank can get it's pwrdm from its
hwmod.  So the ->runtime_suspend method should just read the next_state
of its powerdomain to see if it's going off, and save context (and do
errata workarounds) accordingly.  In addition, it will
_get_context_loss_count() and store the counter.  The resume method the=
n
does _get_context_loss_count() again and compare to see if context need=
s
to be restored.

> Do you still think that it is appropriate to do this code movement  f=
rom
> prepare_for_idle() to GPIO's runtime_suspend?

Based on the above suggestions, yes.

>>
>> [...]
>>
>>>>> @@ -1058,22 +1079,7 @@ static int omap_gpio_request(struct gpio_c=
hip *chip, unsigned offset)
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __raw_writel(__r=
aw_readl(reg) | (1 << offset), reg);
>>>>> =C2=A0 =C2=A0 =C2=A0 }
>>>>> =C2=A0#endif
>>>>> - =C2=A0 =C2=A0 if (!cpu_class_is_omap1()) {
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!bank->mod_usage)=
 {
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 void __iomem *reg =3D bank->base;
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 u32 ctrl;
>>>>> -
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (cpu_is_omap24xx() || cpu_is_omap34xx())
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg +=3D OMAP24XX_GPIO_CTRL;
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 else if (cpu_is_omap44xx())
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg +=3D OMAP4_GPIO_CTRL;
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ctrl =3D __raw_readl(reg);
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* Module is enabled, clocks are not gated */
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ctrl &=3D 0xFFFFFFFE;
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 __raw_writel(ctrl, reg);
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bank->mod_usage |=3D =
1 << offset;
>>>>> - =C2=A0 =C2=A0 }
>>>>
>>>> Where did this code go? =C2=A0I expected it to be moved, but not r=
emoved completely.
>>>
>>> It is only moved and not removed.
>>> bank->mod_usage |=3D 1 << offset; is done above and the rest is don=
e below.
>>
>> I found the set of bank->mod_usage, but I do not see the clock un-ga=
ting
>> in the resulting code. =C2=A0Can you please share the line number in=
 the
>> resulting code where this is done? =C2=A0 I just grep'd for 'Module =
is
>> enabled' and the 'ctrl &=3D 0xFFFFFFFE' line and could not find them=
=2E
>
> This is done as part of omap_gpio_mod_init() (which writes zero into
> ctrl register)
> and it is called from omap_gpio_request().

OK, I see it now.  Guess I grep'd for the wrong things.

Thanks for pointing it out.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

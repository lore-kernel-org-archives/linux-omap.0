From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 5/5] OMAP: GPIO: use PM runtime framework
Date: Tue, 8 Mar 2011 20:24:22 -0500
Message-ID: <AANLkTi=S4L7yGwCuxtZnR0N-+DDN7yQYHqeFF+TXK0ZR@mail.gmail.com>
References: <1298890670-5481-1-git-send-email-charu@ti.com>
 <1298890670-5481-6-git-send-email-charu@ti.com> <87mxlabih5.fsf@ti.com>
 <AANLkTi=Sd0zJwnx1DHCCOr9ncHv1ZP1EworoJex7NLEK@mail.gmail.com>
 <87vczu7ocb.fsf@ti.com> <AANLkTikecqDALXQYd=oLJrFstQZaEG0wH1txzUUyGc-m@mail.gmail.com>
 <8739mxsc89.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:58616 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754855Ab1CIBZF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 20:25:05 -0500
Received: by fxm2 with SMTP id 2so47387fxm.21
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 17:25:02 -0800 (PST)
In-Reply-To: <8739mxsc89.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Kevin,

On Tue, Mar 8, 2011 at 13:23, Kevin Hilman <khilman@ti.com> wrote:
> "Varadarajan, Charulatha" <charu@ti.com> writes:
>
>> Kevin,
>>
>> On Tue, Mar 8, 2011 at 00:25, Kevin Hilman <khilman@ti.com> wrote:
>>> "Varadarajan, Charulatha" <charu@ti.com> writes:
>>>
>>> [...]
>>>
>>>>>> GPIO driver is modified to use dev_pm_ops instead of sysdev_clas=
s.
>>>>>> With this approach, gpio_bank_suspend() & gpio_bank_resume()
>>>>>> are not part of sys_dev_class.
>>>>>>
>>>>>> Usage of PM runtime get/put APIs in GPIO driver is as given belo=
w:
>>>>>> pm_runtime_get_sync():
>>>>>> * In the probe before accessing the GPIO registers
>>>>>> * at the beginning of omap_gpio_request()
>>>>>> =A0 =A0 =A0 -only when one of the gpios is requested on a bank, =
in which,
>>>>>> =A0 =A0 =A0 =A0no other gpio is being used (when mod_usage becom=
es non-zero).
>>>>>
>>>>> When using runtime PM, bank->mod_usage acutally becomes redundant=
 with
>>>>> usage counting already done at the runtime PM level. =A0IOW, chec=
king
>>>>> bank->mod_usage is he equivalent of checking pm_runtime_suspended=
(), so
>>>>> I think you can totally get rid of bank->mod_usage.
>>>>
>>>> I wish to differ here. bank->mod_usage is filled for each GPIO pin=
 in a bank.
>>>> Hence during request/free if pm_runtime_get_sync() is called for e=
ach GPIO
>>>> pin, then the count gets increased for each GPIO pin in a bank. Bu=
t
>>>> gpio_prepare_for_idle/suspend calls pm_runtime_put() only once for
>>>> each bank. Hence there will be a count mismatch and hence this wil=
l lead
>>>> to problems and never a bank will get suspended.
>>>>
>>>> IMO it is required to have bank->mod_usage checks. Please correct
>>>> me if I am wrong.
>>>
>>> You're right, I see what you're saying now. =A0Thanks for clarifyin=
g.
>>
>> Okay.
>>
>>>
>>> In that case, keeping bank->mod_usage should be OK for now.
>>
>> Okay.
>>
>>>
>>> That being said, as I'm looking at the idle prepare/resume hooks
>>> something else came to mind.
>>>
>>> Most of what the idle prepare/resume mehods do should actually be d=
one
>>> in the ->runtime_suspend() and ->runtime_resume() hooks (e.g. debou=
nce
>>> clock disable, edge-detect stuff, context save/restore). =A0IOW, th=
at
>>> stuff does not need to be done until the bank is actually
>>> disabled/enabled. =A0For example, prepare_for_idle itself could be =
a
>>> relatively simple check for bank->mod_usage and a call to
>>> pm_runtime_put_sync().
>>>
>>> What do you think?
>>
>> I also thought about this and my very old implementation with hwmod
>> series was like this. But,
>> a. prepare_for_idle has an Erratum 1.101 handling, debounce clock di=
sable,
>> =A0 =A0context save based on offmode flag
>> b. omap_gpio_suspend has wkup related code handling in it along
>> =A0 =A0with context save w/o any flag
>
> Don't forget that the suspend path also calls prepare_for_idle (and
> resume path calls resume_from_idle) so that (b) actually includes (a)=
=2E
> In fact, looking closer at the code, it appears we save context twice=
 on
> a static suspend.

Yes. You are right. Will modify this.

>
>> c. gpio_free need not do any of the above mentioned stuff.
>
> But it would be harmless if the ->runtime_suspend/resume methods were
> called. =A0If bank->mod_usage were zero, these hooks would just retur=
n.
>
>> Similar for resume_after_idle, gpio_request, omap_resume.
>>
>> But the runtime_suspend/resume hooks would be called for all the abo=
ve.
>>
>> Hence I thought that it might not be correct to move all the code fr=
om
>> prepare_for_idle() to runtime_suspend hook of GPIO. Similar for
>> resume_after_idle()
>> and runtime_resume hook.
>
> You're right, there are currently different paths for the 3 different
> users of the runtime PM API (your a, b & c above), but to me that lea=
ds
> to serious readability problems. =A0 (NOTE: this isn't your fault, th=
e
> current code suffers from this already, I'm just hoping we can clean =
it
> up with the runtime PM conversion.)
>
> I think this could be much cleaner if everything was moved to the
> ->runtime_suspend/resume hooks and a couple checks were added. =A0For
> example, the runtime_suspend would look like:
>
> =A0for each bank:
>
> =A0 =A0/* this handles the gpio_free case */
> =A0 =A0if (!bank->mod_usage)
> =A0 =A0 =A0 continue;
>
> =A0 =A0/* debounce clock disable */
>
> =A0 =A0/* off-mode: remove triggering */
>
> =A0 =A0/* save context */
>
> =A0 =A0/* Extra stuff for static suspend */
> =A0 =A0if (bank->is_suspending)
> =A0 =A0 =A0/* set wakeup bits */

Okay. But I felt that adding more flags to manage this might look
ugly. But yes, this is better in terms of readability. Will do the
needful.

>
>> Also, from implementation point of view it needs to be taken care to
>> pass off_mode flag to runtime_suspend hook and use it only for
>> prepare_for idle and not for other cases
>> (omap_gpio_suspend/gpio_free).
>
> Actually, I'm not a big fan of the off_mode flag passed from the PM
> core.
>
> Here's what would be much nicer. =A0Each bank can get it's pwrdm from=
 its
> hwmod. =A0So the ->runtime_suspend method should just read the next_s=
tate
> of its powerdomain to see if it's going off, and save context (and do
> errata workarounds) accordingly.

Ok. I will modify the GPIO driver to access these APIs directly
from runtime_suspend hook of GPIO to read the next_state
of its powerdomain.

> In addition, it will
> _get_context_loss_count() and store the counter. =A0The resume method=
 then
> does _get_context_loss_count() again and compare to see if context ne=
eds
> to be restored.

Okay.

>
>> Do you still think that it is appropriate to do this code movement =A0=
from
>> prepare_for_idle() to GPIO's runtime_suspend?
>
> Based on the above suggestions, yes.

Thanks,
V Charulatha

<<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

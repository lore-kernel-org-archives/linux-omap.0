From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 5/5] OMAP: GPIO: use PM runtime framework
Date: Tue, 8 Mar 2011 20:35:24 +0530
Message-ID: <AANLkTikecqDALXQYd=oLJrFstQZaEG0wH1txzUUyGc-m@mail.gmail.com>
References: <1298890670-5481-1-git-send-email-charu@ti.com>
 <1298890670-5481-6-git-send-email-charu@ti.com> <87mxlabih5.fsf@ti.com>
 <AANLkTi=Sd0zJwnx1DHCCOr9ncHv1ZP1EworoJex7NLEK@mail.gmail.com> <87vczu7ocb.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:59758 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754904Ab1CHPGG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 10:06:06 -0500
Received: by mail-fx0-f46.google.com with SMTP id 17so5185178fxm.19
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 07:06:04 -0800 (PST)
In-Reply-To: <87vczu7ocb.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Kevin,

On Tue, Mar 8, 2011 at 00:25, Kevin Hilman <khilman@ti.com> wrote:
> "Varadarajan, Charulatha" <charu@ti.com> writes:
>
> [...]
>
>>>> GPIO driver is modified to use dev_pm_ops instead of sysdev_class.
>>>> With this approach, gpio_bank_suspend() & gpio_bank_resume()
>>>> are not part of sys_dev_class.
>>>>
>>>> Usage of PM runtime get/put APIs in GPIO driver is as given below:
>>>> pm_runtime_get_sync():
>>>> * In the probe before accessing the GPIO registers
>>>> * at the beginning of omap_gpio_request()
>>>> =A0 =A0 =A0 -only when one of the gpios is requested on a bank, in=
 which,
>>>> =A0 =A0 =A0 =A0no other gpio is being used (when mod_usage becomes=
 non-zero).
>>>
>>> When using runtime PM, bank->mod_usage acutally becomes redundant w=
ith
>>> usage counting already done at the runtime PM level. =A0IOW, checki=
ng
>>> bank->mod_usage is he equivalent of checking pm_runtime_suspended()=
, so
>>> I think you can totally get rid of bank->mod_usage.
>>
>> I wish to differ here. bank->mod_usage is filled for each GPIO pin i=
n a bank.
>> Hence during request/free if pm_runtime_get_sync() is called for eac=
h GPIO
>> pin, then the count gets increased for each GPIO pin in a bank. But
>> gpio_prepare_for_idle/suspend calls pm_runtime_put() only once for
>> each bank. Hence there will be a count mismatch and hence this will =
lead
>> to problems and never a bank will get suspended.
>>
>> IMO it is required to have bank->mod_usage checks. Please correct
>> me if I am wrong.
>
> You're right, I see what you're saying now. =A0Thanks for clarifying.

Okay.

>
> In that case, keeping bank->mod_usage should be OK for now.

Okay.

>
> That being said, as I'm looking at the idle prepare/resume hooks
> something else came to mind.
>
> Most of what the idle prepare/resume mehods do should actually be don=
e
> in the ->runtime_suspend() and ->runtime_resume() hooks (e.g. debounc=
e
> clock disable, edge-detect stuff, context save/restore). =A0IOW, that
> stuff does not need to be done until the bank is actually
> disabled/enabled. =A0For example, prepare_for_idle itself could be a
> relatively simple check for bank->mod_usage and a call to
> pm_runtime_put_sync().
>
> What do you think?

I also thought about this and my very old implementation with hwmod
series was like this. But,
a. prepare_for_idle has an Erratum 1.101 handling, debounce clock disab=
le,
   context save based on offmode flag
b. omap_gpio_suspend has wkup related code handling in it along
   with context save w/o any flag
c. gpio_free need not do any of the above mentioned stuff.

Similar for resume_after_idle, gpio_request, omap_resume.

But the runtime_suspend/resume hooks would be called for all the above.
Hence I thought that it might not be correct to move all the code from
prepare_for_idle() to runtime_suspend hook of GPIO. Similar for
resume_after_idle()
and runtime_resume hook.

Also, from implementation point of view it needs to be taken care to
pass off_mode
flag to runtime_suspend hook and use it only for prepare_for idle and
not for other
cases (omap_gpio_suspend/gpio_free).

Do you still think that it is appropriate to do this code movement  fro=
m
prepare_for_idle() to GPIO's runtime_suspend?

>
> [...]
>
>>>> @@ -1058,22 +1079,7 @@ static int omap_gpio_request(struct gpio_ch=
ip *chip, unsigned offset)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(__raw_readl(reg) | (1 << =
offset), reg);
>>>> =A0 =A0 =A0 }
>>>> =A0#endif
>>>> - =A0 =A0 if (!cpu_class_is_omap1()) {
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 if (!bank->mod_usage) {
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void __iomem *reg =3D ba=
nk->base;
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 ctrl;
>>>> -
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap24xx() ||=
 cpu_is_omap34xx())
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D=
 OMAP24XX_GPIO_CTRL;
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (cpu_is_omap44xx=
())
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg +=3D=
 OMAP4_GPIO_CTRL;
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D __raw_readl(reg=
);
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Module is enabled, cl=
ocks are not gated */
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D 0xFFFFFFFE;
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(ctrl, reg);
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 bank->mod_usage |=3D 1 << offset;
>>>> - =A0 =A0 }
>>>
>>> Where did this code go? =A0I expected it to be moved, but not remov=
ed completely.
>>
>> It is only moved and not removed.
>> bank->mod_usage |=3D 1 << offset; is done above and the rest is done=
 below.
>
> I found the set of bank->mod_usage, but I do not see the clock un-gat=
ing
> in the resulting code. =A0Can you please share the line number in the
> resulting code where this is done? =A0 I just grep'd for 'Module is
> enabled' and the 'ctrl &=3D 0xFFFFFFFE' line and could not find them.

This is done as part of omap_gpio_mod_init() (which writes zero into
ctrl register)
and it is called from omap_gpio_request().

-V Charulatha

>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 5/5] OMAP: GPIO: use PM runtime framework
Date: Mon, 07 Mar 2011 10:55:00 -0800
Message-ID: <87vczu7ocb.fsf@ti.com>
References: <1298890670-5481-1-git-send-email-charu@ti.com>
	<1298890670-5481-6-git-send-email-charu@ti.com>
	<87mxlabih5.fsf@ti.com>
	<AANLkTi=Sd0zJwnx1DHCCOr9ncHv1ZP1EworoJex7NLEK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:48469 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755192Ab1CGSzH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Mar 2011 13:55:07 -0500
Received: by yie30 with SMTP id 30so2193680yie.37
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 10:55:04 -0800 (PST)
In-Reply-To: <AANLkTi=Sd0zJwnx1DHCCOr9ncHv1ZP1EworoJex7NLEK@mail.gmail.com>
	(Charulatha Varadarajan's message of "Sat, 5 Mar 2011 09:40:12 +0430")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, Tarun Kanti DebBarma <tarun.kanti@ti.com>

"Varadarajan, Charulatha" <charu@ti.com> writes:

[...]

>>> GPIO driver is modified to use dev_pm_ops instead of sysdev_class.
>>> With this approach, gpio_bank_suspend() & gpio_bank_resume()
>>> are not part of sys_dev_class.
>>>
>>> Usage of PM runtime get/put APIs in GPIO driver is as given below:
>>> pm_runtime_get_sync():
>>> * In the probe before accessing the GPIO registers
>>> * at the beginning of omap_gpio_request()
>>> =C2=A0 =C2=A0 =C2=A0 -only when one of the gpios is requested on a =
bank, in which,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0no other gpio is being used (when mod_us=
age becomes non-zero).
>>
>> When using runtime PM, bank->mod_usage acutally becomes redundant wi=
th
>> usage counting already done at the runtime PM level. =C2=A0IOW, chec=
king
>> bank->mod_usage is he equivalent of checking pm_runtime_suspended(),=
 so
>> I think you can totally get rid of bank->mod_usage.
>
> I wish to differ here. bank->mod_usage is filled for each GPIO pin in=
 a bank.
> Hence during request/free if pm_runtime_get_sync() is called for each=
 GPIO
> pin, then the count gets increased for each GPIO pin in a bank. But
> gpio_prepare_for_idle/suspend calls pm_runtime_put() only once for
> each bank. Hence there will be a count mismatch and hence this will l=
ead
> to problems and never a bank will get suspended.
>
> IMO it is required to have bank->mod_usage checks. Please correct
> me if I am wrong.

You're right, I see what you're saying now.  Thanks for clarifying.

In that case, keeping bank->mod_usage should be OK for now.

That being said, as I'm looking at the idle prepare/resume hooks
something else came to mind.

Most of what the idle prepare/resume mehods do should actually be done
in the ->runtime_suspend() and ->runtime_resume() hooks (e.g. debounce
clock disable, edge-detect stuff, context save/restore).  IOW, that
stuff does not need to be done until the bank is actually
disabled/enabled.  For example, prepare_for_idle itself could be a
relatively simple check for bank->mod_usage and a call to
pm_runtime_put_sync().

What do you think?

[...]

>>> @@ -1058,22 +1079,7 @@ static int omap_gpio_request(struct gpio_chi=
p *chip, unsigned offset)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __raw_writel(__raw=
_readl(reg) | (1 << offset), reg);
>>> =C2=A0 =C2=A0 =C2=A0 }
>>> =C2=A0#endif
>>> - =C2=A0 =C2=A0 if (!cpu_class_is_omap1()) {
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!bank->mod_usage) {
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 void __iomem *reg =3D bank->base;
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 u32 ctrl;
>>> -
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (cpu_is_omap24xx() || cpu_is_omap34xx())
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg +=3D OMAP24XX_GPIO_CTRL;
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 else if (cpu_is_omap44xx())
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg +=3D OMAP4_GPIO_CTRL;
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ctrl =3D __raw_readl(reg);
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* Module is enabled, clocks are not gated */
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ctrl &=3D 0xFFFFFFFE;
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 __raw_writel(ctrl, reg);
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bank->mod_usage |=3D 1 =
<< offset;
>>> - =C2=A0 =C2=A0 }
>>
>> Where did this code go? =C2=A0I expected it to be moved, but not rem=
oved completely.
>
> It is only moved and not removed.
> bank->mod_usage |=3D 1 << offset; is done above and the rest is done =
below.

I found the set of bank->mod_usage, but I do not see the clock un-gatin=
g
in the resulting code.  Can you please share the line number in the
resulting code where this is done?   I just grep'd for 'Module is
enabled' and the 'ctrl &=3D 0xFFFFFFFE' line and could not find them.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

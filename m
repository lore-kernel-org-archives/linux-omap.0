From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v6 19/25] gpio/omap: cleanup prepare_for_idle and resume_after_idle
Date: Wed, 7 Sep 2011 10:47:20 +0530
Message-ID: <CAC83Zv+zAve-fNGYR9BTZ7nPXpz5HDWzyX=gdwS92OouVVo14Q@mail.gmail.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-20-git-send-email-tarun.kanti@ti.com>
	<874o0pxm77.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:51116 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753753Ab1IGFRV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Sep 2011 01:17:21 -0400
Received: by mail-bw0-f45.google.com with SMTP id zv3so6252003bkb.4
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 22:17:20 -0700 (PDT)
In-Reply-To: <874o0pxm77.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Wed, Sep 7, 2011 at 5:23 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> Cleanup =A0omap2_gpio_prepare_for_idle() and omap2_gpio_resume_after=
_idle()
>> by moving most of the stuff to *_runtime_suspend() and *_runtime_res=
ume().
>
> Why?
>
> (I know the answer, but it should be in the changelog.)
Ok.

>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> Signed-off-by: Charulatha V <charu@ti.com>
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Also, as pointed out in an earlier patch, now that this is moved out =
of
> the idle path, where interrupts were known to be disabled, the regist=
er
> accesses in the runtime PM callbacks need to be protected by the
> spinlock just like they are in other parts of the driver.
Ok.

>
> [...]
>
>> @@ -1305,9 +1316,14 @@ static void omap_gpio_restore_context(struct =
gpio_bank *bank)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank->ba=
se + bank->regs->fallingdetect);
>> =A0 =A0 =A0 __raw_writel(bank->context.dataout, bank->base + bank->r=
egs->dataout);
>> =A0}
>> +#else
>> +#define omap_gpio_runtime_suspend NULL
>> +#define omap_gpio_runtime_resume NULL
>> =A0#endif
>>
>> =A0static const struct dev_pm_ops gpio_pm_ops =3D {
>> + =A0 =A0 .runtime_suspend =A0 =A0 =A0 =A0=3D omap_gpio_runtime_susp=
end,
>> + =A0 =A0 .runtime_resume =A0 =A0 =A0 =A0 =3D omap_gpio_runtime_resu=
me,
>
> Please use SET_RUNTIME_PM_OPS() (see <linux/pm.h.)
Sure.

>
>> =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D omap_gpio_su=
spend,
>> =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D omap_gpio_re=
sume,
>> =A0};
>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

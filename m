From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v6 17/25] gpio/omap: use pm-runtime framework
Date: Sat, 10 Sep 2011 00:25:46 +0530
Message-ID: <CAC83Zv+=gbt=KTx0ZsxRfL1k4=R7c0CLSCRQ_D+PrNQOso3q-g@mail.gmail.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-18-git-send-email-tarun.kanti@ti.com>
	<87ehztxmcg.fsf@ti.com>
	<CAC83ZvL3Y-4f+nAvFb023JTPcBb-joG8JonujCMJCNUmYrSZaA@mail.gmail.com>
	<87pqj9y4mi.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:53248 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758646Ab1IISzs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Sep 2011 14:55:48 -0400
Received: by mail-bw0-f50.google.com with SMTP id c12so1628005bkb.9
        for <linux-omap@vger.kernel.org>; Fri, 09 Sep 2011 11:55:47 -0700 (PDT)
In-Reply-To: <87pqj9y4mi.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

On Fri, Sep 9, 2011 at 11:34 PM, Kevin Hilman <khilman@ti.com> wrote:
> "DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:
>
>> [...]
>>>>
>>>> +static const struct dev_pm_ops gpio_pm_ops =3D {
>>>> + =A0 =A0 .suspend =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D omap_gpio_su=
spend,
>>>> + =A0 =A0 .resume =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D omap_gpio_re=
sume,
>>>> +};
>>>
>>> Please use SET_SYSTEM_SLEEP_PM_OPS(). =A0See <linux/pm.h>
>> We can use following macro to initialize .suspend and .resume callba=
cks.
>> But how do we initialize .runtime_suspend and .runtime_resume callba=
cks?
>>
>> #define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
>> const struct dev_pm_ops name =3D { \
>> =A0 =A0 =A0 =A0 SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
>> }
>>
>> Do we have something similar to following where we can assign separa=
te
>> pair of callbacks?
>
> SET_RUNTIME_PM_OPS()
Yes, I have done this way:

static const struct dev_pm_ops gpio_pm_ops =3D {
        SET_SYSTEM_SLEEP_PM_OPS(omap_gpio_suspend, omap_gpio_resume)
        SET_RUNTIME_PM_OPS(omap_gpio_runtime_suspend, omap_gpio_runtime=
_resume,
                                                                       =
 NULL)
};

--
Tarun
>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

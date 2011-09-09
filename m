From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v6 17/25] gpio/omap: use pm-runtime framework
Date: Fri, 9 Sep 2011 18:02:33 +0530
Message-ID: <CAC83ZvL3Y-4f+nAvFb023JTPcBb-joG8JonujCMJCNUmYrSZaA@mail.gmail.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-18-git-send-email-tarun.kanti@ti.com>
	<87ehztxmcg.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:33370 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933544Ab1IIMcg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Sep 2011 08:32:36 -0400
Received: by mail-bw0-f53.google.com with SMTP id zs8so2045036bkb.40
        for <linux-omap@vger.kernel.org>; Fri, 09 Sep 2011 05:32:34 -0700 (PDT)
In-Reply-To: <87ehztxmcg.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

[...]
>>
>> +static const struct dev_pm_ops gpio_pm_ops =3D {
>> + =A0 =A0 .suspend =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D omap_gpio_susp=
end,
>> + =A0 =A0 .resume =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D omap_gpio_resu=
me,
>> +};
>
> Please use SET_SYSTEM_SLEEP_PM_OPS(). =A0See <linux/pm.h>
We can use following macro to initialize .suspend and .resume callbacks=
=2E
But how do we initialize .runtime_suspend and .runtime_resume callbacks=
?

#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
const struct dev_pm_ops name =3D { \
        SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
}

Do we have something similar to following where we can assign separate
pair of callbacks?
The following macro on the other hand assigns the same set of
callbacks to both and this not what I want!!!

#define UNIVERSAL_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
const struct dev_pm_ops name =3D { \
        SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
        SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
}
--
Tarun

>
>> =A0static struct platform_driver omap_gpio_driver =3D {
>> =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D omap_gpio_probe,
>> =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "omap_gpio",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D &gpio_pm_ops,
>> =A0 =A0 =A0 },
>> =A0};
[...]
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

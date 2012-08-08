From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/2] cpufreq: OMAP: Handle missing frequency table on SMP systems
Date: Wed, 08 Aug 2012 10:28:50 -0700
Message-ID: <87wr19uwbx.fsf@ti.com>
References: <1344423254-3475-1-git-send-email-rnayak@ti.com>
	<1344423254-3475-2-git-send-email-rnayak@ti.com>
	<CAMQu2gyooQ4x=ZGDZFg5BuBaEkgQx2kTAvtiGLEjXwOYvF_wMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:37243 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758973Ab2HHR2u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 13:28:50 -0400
Received: by yenl1 with SMTP id l1so20728yen.14
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 10:28:48 -0700 (PDT)
In-Reply-To: <CAMQu2gyooQ4x=ZGDZFg5BuBaEkgQx2kTAvtiGLEjXwOYvF_wMQ@mail.gmail.com>
	(Santosh Shilimkar's message of "Wed, 8 Aug 2012 17:00:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

"Shilimkar, Santosh" <santosh.shilimkar@ti.com> writes:

> On Wed, Aug 8, 2012 at 4:24 PM, Rajendra Nayak <rnayak@ti.com> wrote:
>>
>> On OMAP4, if the first CPU fails to get a valid frequency table (this
>> could happen if the platform does not register any OPP table), the
>> subsequent CPU instances end up dealing with a NULL freq_table and
>> crash. Add a check for a NULL freq_table to help error the rest
>> of the CPU instances out.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Cc: <linux-pm@vger.kernel.org>
>> ---
>>  drivers/cpufreq/omap-cpufreq.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/omap-cpufreq.c
>> b/drivers/cpufreq/omap-cpufreq.c
>> index 17fa04d..0ee824c 100644
>> --- a/drivers/cpufreq/omap-cpufreq.c
>> +++ b/drivers/cpufreq/omap-cpufreq.c
>> @@ -221,7 +221,7 @@ static int __cpuinit omap_cpu_init(struct
>> cpufreq_policy *policy)
>>         if (atomic_inc_return(&freq_table_users) == 1)
>>                 result = opp_init_cpufreq_table(mpu_dev, &freq_table);
>>
>> -       if (result) {
>> +       if (result || !freq_table) {
>>                 dev_err(mpu_dev, "%s: cpu%d: failed creating freq
>> table[%d]\n",
>>                                 __func__, policy->cpu, result);
>>                 goto fail_ck;
>
> The freq_table use count seems to be buggy in that case.
> Something like below should fix the issue.
> Feel free to update your patch with below if you agree.
>
> diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
> index 17fa04d..fd97c3d 100644
> --- a/drivers/cpufreq/omap-cpufreq.c
> +++ b/drivers/cpufreq/omap-cpufreq.c
> @@ -218,7 +218,7 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *po
>
>         policy->cur = policy->min = policy->max = omap_getspeed(policy->cpu);
>
> -       if (atomic_inc_return(&freq_table_users) == 1)
> +       if (freq_table)

I think you meant 'if (!freq_table)' ?

Kevin

>                 result = opp_init_cpufreq_table(mpu_dev, &freq_table);
>
>         if (result) {
> @@ -227,6 +227,7 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *po
>                 goto fail_ck;
>         }
>
> +       atomic_inc_return(&freq_table_users);
>         result = cpufreq_frequency_table_cpuinfo(policy, freq_table);
>         if (result)
>                 goto fail_table;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
